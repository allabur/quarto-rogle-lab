# quarto-upv-lab

Plantilla Quarto reutilizable para enunciados de **prácticas, notas técnicas y casos de estudio** en asignaturas de la UPV.

Entrega un PDF y un HTML con portada UPV, metadatos de asignatura (código, nº de práctica, curso, grupo, titulación), cabecera con logos y pie con licencia / autoría / paginación.

---

## 1 · Estructura del repositorio

```
article/
├── _extensions/upv-lab/            # La extensión Quarto (formato custom upv-lab-pdf / upv-lab-html)
│   ├── _extension.yml
│   ├── partials/before-title.tex   # Cabecera/pie fancyhdr + citation callout
│   ├── includes/                   # packages.tex, colors.tex, citation-callout.tex
│   ├── resources/                  # Logos UPV/ROGLE y iconos Creative Commons (PNG)
│   └── styles/upv-lab.scss         # Estilos HTML
├── template.qmd                    # Punto de partida: duplica este por cada práctica
├── lab-3-stochastic-inventory.qmd  # Ejemplo: práctica real de inventario
├── article-supply-chain.qmd        # Ejemplo: nota técnica
├── _quarto.yml                     # Proyecto Quarto
├── _brand.yml, _authors.yml        # Marca UPV y autores habituales
├── assets/                         # Logos SVG/PNG sueltos
└── archives/                       # Versiones anteriores (no usar)
```

## 2 · Uso

### Opción A · Proyecto local

Los archivos `.qmd` deben estar en la **raíz del proyecto** (junto a `_extensions/`).

```bash
cd article/
cp template.qmd lab-04-nombre.qmd        # un archivo por práctica
# edita la YAML del archivo: subject, title, author, license…
quarto render lab-04-nombre.qmd --to upv-lab-pdf
quarto render lab-04-nombre.qmd --to upv-lab-html
```

O bien renderiza todo el proyecto de una vez:

```bash
quarto render
```

### Opción B · Instalar la extensión en otro proyecto

```bash
cd /ruta/a/otro/proyecto
quarto add allabur/quarto-upv-lab        # cuando lo publiques en GitHub
# o, usando una ruta local mientras se desarrolla:
quarto add /ruta/a/templates/article
```

Después, en tu `.qmd`:

```yaml
---
title: "Mi práctica"
format: upv-lab-pdf
course:
  subject: "Gestión de la cadena de suministro"
  lab-number: "2"
---
```

### Opción C · `quarto use template`

Para que alumnos o colaboradores arranquen desde cero un repo basado en la plantilla:

```bash
quarto use template allabur/quarto-upv-lab
```

Esto crea una carpeta nueva con `template.qmd` y `_extensions/upv-lab/` ya configurados.

## 3 · Metadatos soportados en la YAML

| Bloque | Campo | Descripción |
|--------|-------|-------------|
| raíz | `title`, `subtitle`, `abstract`, `keywords`, `date`, `lang` | Metadatos Pandoc estándar |
| `course` | `subject`, `code`, `lab-number`, `lab-type`, `degree`, `group`, `academic-year`, `semester`, `duration` | Contexto académico — aparece en la portada |
| `author` / `affiliations` | Quarto estándar (`name.given`, `name.family`, `email`, `orcid`, `affiliations`) | Autores del enunciado |
| `license` | `name` (`CC BY`, `CC BY-NC-SA`, `CC BY-NC-ND`, `CC0`…), `version`, `url` | Licencia del documento |
| `copyright` | `holder`, `year` | Copyright del enunciado |
| `upv-footer` | `content`: `license` \| `citation` \| `copyright` | Qué se muestra a la izquierda del pie |
| `upv-footer` | (clave del documento, no confundir con la opción `footer` reservada por Quarto) | |
| `citation` | CSL — `container-title`, `issued.year`, `volume`, `doi`… | Cita tipo CSL, útil para notas técnicas |

## 4 · Requisitos

- **Quarto** ≥ 1.4
- **TeX Live** con `xelatex` (para PDF) — incluido en cualquier instalación estándar de TeX Live o MacTeX
- Paquetes LaTeX: `scrlayer-scrpage`, `geometry`, `fontspec`, `graphicx`, `xcolor`, `framed`, `lastpage` (todos estándar en TeX Live)

## 5 · Personalización rápida

| Quiero cambiar… | Edita… |
|-----------------|--------|
| Paleta de colores | `_extensions/upv-lab/includes/colors.tex` |
| Tipografías | `_extensions/upv-lab/includes/fonts.tex` |
| Márgenes, interlineado | `_extensions/upv-lab/includes/layout.tex` |
| Logos de cabecera | Reemplaza los PNG en `_extensions/upv-lab/resources/logos/` |
| Portada (qué aparece, en qué orden) | `_extensions/upv-lab/partials/before-body.tex` |
| Qué se muestra en el pie | Cambia `footer.content` en la YAML del documento |
| Estilos HTML | `_extensions/upv-lab/styles/upv-lab.scss` |

## 6 · Publicar como template

Cuando la extensión esté estable, súbela a GitHub como `allabur/quarto-upv-lab` con un tag de versión (`v1.0.0`). A partir de ahí, cualquiera puede instalarla con `quarto add` o `quarto use template`.

## Licencia

Código bajo **MIT**. Documentos generados: la licencia la define cada documento (por defecto CC BY-NC-SA 4.0).
