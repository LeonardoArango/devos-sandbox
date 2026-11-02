# Plantilla Playwright (ajústala al stack)
Instalar (yo lo corro; requiere red): `npm i -D @playwright/test @axe-core/playwright && npx playwright install --with-deps chromium`
Docs: https://playwright.dev/docs/intro · https://playwright.dev/docs/accessibility-testing · https://playwright.dev/docs/test-snapshots

## playwright.config.ts
```ts
import { defineConfig, devices } from '@playwright/test';
const PORT = Number(process.env.PORT ?? 3000);
export default defineConfig({
  testDir: 'e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 1 : 0,          // flaky = bug, no se tapa con reintentos
  reporter: [['list'], ['html', { open: 'never' }]],
  use: {
    baseURL: `http://localhost:${PORT}`,
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
    locale: 'es-CO', timezoneId: 'America/Bogota',
  },
  expect: { toHaveScreenshot: { maxDiffPixelRatio: 0.01, animations: 'disabled' } },
  projects: [
    { name: 'escritorio', use: { ...devices['Desktop Chrome'], viewport: { width: 1280, height: 800 } } },
    { name: 'movil', use: { ...devices['Pixel 7'] } },
  ],
  webServer: { command: 'npm run dev', url: `http://localhost:${PORT}`, reuseExistingServer: !process.env.CI },
});
```

## e2e/<id>.spec.ts
```ts
import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

async function sinViolaciones(page) {
  const r = await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa', 'wcag22aa']).analyze();
  expect(r.violations, JSON.stringify(r.violations.map(v => [v.id, v.nodes.length]))).toEqual([]);
}

test.describe('<id> · <pantalla>', () => {
  test('CA1: camino feliz', async ({ page }) => {
    await page.goto('/ruta');
    await page.getByLabel('Correo').fill('ana@example.com');
    await page.getByRole('button', { name: 'Guardar cambios' }).click();
    await expect(page.getByRole('status')).toContainText('Guardado');
    await sinViolaciones(page);
    await expect(page).toHaveScreenshot('exito.png', { fullPage: true });
  });

  test('estado vacío', async ({ page }) => {
    await page.route('**/api/items*', r => r.fulfill({ json: [] }));
    await page.goto('/ruta');
    await expect(page.getByText('Aún no tienes')).toBeVisible();
    await sinViolaciones(page);
  });

  test('estado error conserva lo escrito', async ({ page }) => {
    await page.route('**/api/items', r => r.fulfill({ status: 500 }));
    await page.goto('/ruta');
    await page.getByLabel('Nombre').fill('Sucursal Norte');
    await page.getByRole('button', { name: 'Guardar cambios' }).click();
    await expect(page.getByRole('alert')).toContainText('No pudimos guardar');
    await expect(page.getByLabel('Nombre')).toHaveValue('Sucursal Norte');
  });

  test('teclado: flujo principal sin ratón', async ({ page }) => {
    await page.goto('/ruta');
    await page.keyboard.press('Tab');
    await expect(page.locator(':focus')).toBeVisible();
  });
});
```
Estado "cargando": retrasa la ruta (`await new Promise(r => setTimeout(r, 1500))` dentro de `route`) y asegura que el esqueleto o el texto de carga se ve.
Comandos: `npx playwright test` · `--project=movil` · `-g "CA1"` · `--update-snapshots` (solo con mi OK) · `npx playwright show-report` · `npx playwright show-trace <zip>`.
Python: `pip install pytest-playwright` y `axe-playwright-python` son equivalentes; ajusta `DEVOS_E2E_CMD="pytest e2e"`.

## e2e/medidas.spec.ts (medidas visuales; idea adaptada del inspector de Taste, MIT)
Ajusta `PAGINAS`. Usa `expect.soft` para ver todos los fallos de una vez. Excepción justificada → anótala en la Spec 6.1, no borres el assert.
```ts
import { test, expect } from '@playwright/test';
// Medidas visuales sobre el render real (idea adaptada de Taste, MIT). Corre en cada proyecto (escritorio y móvil).
const PAGINAS = ['/', '/ruta'];
for (const ruta of PAGINAS) {
  test(`medidas visuales ${ruta}`, async ({ page }) => {
    await page.goto(ruta);
    await page.evaluate(() => document.fonts.ready);
    const m = await page.evaluate(() => {
      const vis = (e: Element) => { const r = e.getBoundingClientRect(), s = getComputedStyle(e); return r.width > 0 && r.height > 0 && s.visibility !== 'hidden' && s.display !== 'none'; };
      const h1 = [...document.querySelectorAll('h1')].find(vis);
      let h1Lineas = 0, h1Top = Infinity;
      if (h1) { const r = h1.getBoundingClientRect(); const lh = parseFloat(getComputedStyle(h1).lineHeight) || parseFloat(getComputedStyle(h1).fontSize) * 1.2; h1Lineas = Math.round(r.height / lh); h1Top = r.top + scrollY; }
      const textos = [...document.querySelectorAll('p, li, a, button, label, span, td, th, input, small')].filter(e => vis(e) && (e.textContent ?? '').trim().length > 1);
      const pequenos = textos.filter(e => parseFloat(getComputedStyle(e).fontSize) < 12).map(e => (e.textContent ?? '').trim().slice(0, 30));
      const ps = [...document.querySelectorAll('main p, article p, p')].filter(vis);
      const cuerpo = ps.length ? parseFloat(getComputedStyle(ps[0]).fontSize) : 16;
      const familias = new Set(textos.concat([...document.querySelectorAll('h1,h2,h3')].filter(vis)).map(e => getComputedStyle(e).fontFamily.split(',')[0].trim().replace(/["']/g, '').toLowerCase()));
      const rotas = [...document.images].filter(i => i.complete && i.naturalWidth === 0).map(i => i.currentSrc || i.src);
      return { h1Lineas, h1Top, altoVentana: innerHeight, desborde: document.documentElement.scrollWidth - innerWidth, pequenos, cuerpo, familias: [...familias], rotas };
    });
    expect.soft(m.h1Lineas, 'h1 visible en ≤2 líneas').toBeGreaterThan(0);
    expect.soft(m.h1Lineas, 'h1 en ≤2 líneas').toBeLessThanOrEqual(2);
    expect.soft(m.h1Top, 'h1 en la primera pantalla').toBeLessThan(m.altoVentana);
    expect.soft(m.desborde, 'sin scroll horizontal').toBeLessThanOrEqual(0);
    expect.soft(m.pequenos, 'texto legible ≥12 px').toEqual([]);
    expect.soft(m.cuerpo, 'cuerpo ≥15 px (ideal 16–20)').toBeGreaterThanOrEqual(15);
    expect.soft(m.familias.length, `máx. 2 tipografías: ${m.familias}`).toBeLessThanOrEqual(2);
    expect.soft(m.rotas, 'sin imágenes rotas').toEqual([]);
  });
}
```
