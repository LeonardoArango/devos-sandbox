# Pruebas SEO automáticas (Playwright) — obligatorias en sitios públicos
Archivo: `e2e/seo.spec.ts`. Corre con el resto de pruebas (`DEVOS_E2E_CMD`, por defecto `npx --no-install playwright test`). Usa el `playwright.config.ts` de `pruebas-usuario/plantilla-e2e.md` (`baseURL` local). Plantilla validada con @playwright/test 1.64.1 contra un sitio de prueba: pasa en verde y falla con dos `h1`, JSON-LD inválido y descripciones repetidas.
Qué comprueba: estado 200 y sin `noindex`; title/h1/canonical en el **HTML inicial** (detecta SPA sin SSR); title 10–65 y description 50–170 caracteres, únicos entre páginas; una canonical absoluta; `html[lang]`; un solo `h1`; Open Graph; imágenes con `alt`; JSON-LD que parsea con `@context` schema.org; privadas con `noindex` o login; `robots.txt` con `Sitemap:` y sin bloquear todo; `sitemap.xml` con las públicas; 404 real.
```ts
import { test, expect } from '@playwright/test';

// Páginas públicas indexables (de la Spec 6.2). Las privadas van en PRIVADAS y deben tener noindex o login.
const PUBLICAS = ['/', '/ruta'];
const PRIVADAS: string[] = [];

test.describe('SEO técnico + AEO', () => {
  test.skip(({ isMobile }) => isMobile, 'el HTML es el mismo; basta un proyecto');

  for (const ruta of PUBLICAS) {
    test(`SEO ${ruta}`, async ({ page, request }) => {
      // 1) HTML inicial (sin JS): el contenido clave debe venir del servidor (SSR/SSG/prerender)
      const crudo = await request.get(ruta);
      expect(crudo.status(), 'estado HTTP').toBe(200);
      expect(crudo.headers()['x-robots-tag'] ?? '', 'X-Robots-Tag').not.toMatch(/noindex/i);
      const html = await crudo.text();
      expect(html, 'title en HTML inicial').toMatch(/<title>[^<]{10,}<\/title>/i);
      expect(html, 'h1 en HTML inicial').toMatch(/<h1[\s>]/i);
      expect(html, 'canonical en HTML inicial').toMatch(/rel=["']canonical["']/i);

      // 2) DOM renderizado (expect.soft: reporta todos los fallos de la página a la vez)
      await page.goto(ruta);
      const titulo = await page.title();
      expect.soft(titulo.length, `title "${titulo}"`).toBeGreaterThanOrEqual(10);
      expect.soft(titulo.length, `title "${titulo}"`).toBeLessThanOrEqual(65);
      const desc = await page.locator('meta[name="description"]').getAttribute('content');
      expect.soft(desc?.length ?? 0, 'meta description').toBeGreaterThanOrEqual(50);
      expect.soft(desc!.length, 'meta description').toBeLessThanOrEqual(170);

      const canon = page.locator('link[rel="canonical"]');
      await expect.soft(canon, 'una sola canonical').toHaveCount(1);
      expect.soft(await canon.getAttribute('href'), 'canonical absoluta').toMatch(/^https:\/\//);
      expect.soft(await page.locator('html').getAttribute('lang'), 'html[lang]').toMatch(/^[a-z]{2}(-[A-Z]{2})?$/);
      await expect.soft(page.locator('h1'), 'exactamente un h1').toHaveCount(1);
      await expect.soft(page.locator('meta[name="robots"][content*="noindex" i]'), 'noindex en pública').toHaveCount(0);
      await expect.soft(page.locator('meta[property="og:title"]')).toHaveCount(1);
      await expect.soft(page.locator('meta[property="og:image"]')).toHaveCount(1);
      await expect.soft(page.locator('img:not([alt])'), 'imágenes sin alt').toHaveCount(0);

      // 3) JSON-LD: parsea y tiene @context schema.org + @type/@graph
      const bloques = await page.locator('script[type="application/ld+json"]').allTextContents();
      expect(bloques.length, 'al menos un JSON-LD').toBeGreaterThan(0);
      for (const b of bloques) {
        const d = JSON.parse(b);                       // falla si el JSON es inválido
        for (const n of Array.isArray(d) ? d : [d]) {
          expect(String(n['@context']), '@context').toMatch(/schema\.org/);
          expect(n['@type'] ?? n['@graph'], '@type o @graph').toBeTruthy();
        }
      }
    });
  }

  for (const ruta of PRIVADAS) {
    test(`privada no indexable ${ruta}`, async ({ page }) => {
      const r = await page.goto(ruta);
      const noindex = (await page.locator('meta[name="robots"][content*="noindex" i]').count()) > 0
        || /noindex/i.test(r?.headers()['x-robots-tag'] ?? '');
      expect(noindex || page.url().includes('login'), 'privada sin noindex ni login').toBeTruthy();
    });
  }

  test('title y description únicos entre páginas', async ({ request }) => {
    const t = new Map<string, string>(), d = new Map<string, string>();
    for (const ruta of PUBLICAS) {
      const html = await (await request.get(ruta)).text();
      const ti = html.match(/<title>([^<]*)<\/title>/i)?.[1] ?? '';
      const de = html.match(/<meta[^>]+name=["']description["'][^>]+content=["']([^"']*)/i)?.[1] ?? '';
      expect(t.get(ti), `title repetido en ${ruta}`).toBeUndefined();
      expect(d.get(de), `description repetida en ${ruta}`).toBeUndefined();
      t.set(ti, ruta); d.set(de, ruta);
    }
  });

  test('robots.txt, sitemap.xml y 404 real', async ({ request }) => {
    const robots = await request.get('/robots.txt');
    expect(robots.status()).toBe(200);
    const txt = await robots.text();
    expect(txt, 'robots con Sitemap:').toMatch(/^Sitemap:\s*https?:\/\//im);
    expect(txt, 'no bloquear todo el sitio').not.toMatch(/User-agent:\s*\*\s*\n\s*Disallow:\s*\/\s*$/im);
    const sm = await request.get('/sitemap.xml');
    expect(sm.status()).toBe(200);
    const xml = await sm.text();
    expect(xml).toMatch(/<(urlset|sitemapindex)\b/);
    for (const ruta of PUBLICAS) expect(xml, `sitemap incluye ${ruta}`).toContain(`${ruta === '/' ? '/' : ruta}</loc>`);
    const nf = await request.get('/esta-ruta-no-existe-' + Date.now());
    expect(nf.status(), 'soft 404').toBe(404);
  });
});
```
Ajusta `PUBLICAS`/`PRIVADAS` desde la Spec 6.2. Para docs/blog grandes, genera `PUBLICAS` leyendo el `sitemap.xml` local. Si un límite no aplica (p. ej. título de marca corto), cámbialo en la Spec, no lo borres.

## Lighthouse SEO (opcional, local)
Solo si `lighthouse` ya está en devDependencies (lo instalo yo: `npm i -D lighthouse`). Umbral en la Spec (por defecto 90). Con el servidor local arriba:
```bash
npx --no-install lighthouse http://localhost:3000/ --only-categories=seo,accessibility,best-practices,performance \
  --output=json --output-path=test-results/lh.json --quiet --chrome-flags="--headless=new"
node -e 'const r=require("./test-results/lh.json").categories;const m=+(process.env.DEVOS_LH_MIN||90);
for(const k of ["seo","accessibility"]){const s=Math.round(r[k].score*100);console.log(k,s);if(s<m)process.exitCode=1}'
```
Validado con lighthouse 13.6.0 (Apache-2.0). Si no encuentra Chrome, usa el de Playwright: `CHROME_PATH=$(ls -d ~/.cache/ms-playwright/chromium-*/chrome-linux*/chrome | head -1)`.
Para que el hook lo exija: `DEVOS_E2E_CMD="npx --no-install playwright test && bash scripts/lighthouse.sh"`. Rendimiento en laboratorio no es dato de campo: los CWV reales salen de Search Console/CrUX después de publicar.
