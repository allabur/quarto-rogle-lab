# quarto-rogle-lab

Plantilla Quarto reutilizable para enunciados de **prácticas, notas técnicas y casos de estudio** en asignaturas de la UPV.

Entrega un PDF y un HTML con portada UPV, metadatos de asignatura (código, nº de práctica, curso, grupo, titulación), cabecera con logos y pie con licencia / autoría / paginación.

---

## 1 · Estructura del repositorio

```
article/
├── _extensions/rogle-lab/          # La extensión Quarto (formato rogle-lab-pdf / rogle-lab-html)
│   ├── _extension.yml
│   ├── partials/                   # title.tex, before-title.tex (fancyhdr + citation callout)
│   ├── includes/                   # packages.tex, colors.tex, citation-callout.tex
│   ├── resources/                  # Logos UPV/ROGLE e iconos Creative Commons (PNG)
│   └── styles/rogle-lab.scss       # Estilos HTML
├── example/
│   ├── lab-3-stochastic-inventory.qmd   # Ejemplo: práctica de inventario
│   └── article-supply-chain.qmd         # Ejemplo: nota técnica
├── template.qmd                    # Punto de partida: duplica por cada práctica
├── _quarto.yml                     # Proyecto Quarto
├── pre-render.sh                   # Copia recursos al renderizar desde example/
└── README.md
```

## 2 · Uso

### Opción A · Proyecto local

Los archivos `.qmd` deben estar en la **raíz del proyecto** (junto a `_extensions/`).

```bash
cd article/
cp template.qmd lab-04-nombre.qmd        # un archivo por práctica
# edita la YAML: subject, title, author, license…
quarto render lab-04-nombre.qmd --to rogle-lab-pdf
quarto render lab-04-nombre.qmd --to rogle-lab-html
```

O renderiza todo el proyecto (incluidos los ejemplos de `example/`):

```bash
quarto render
```

### Opción B · Instalar la extensión en otro proyecto

```bash
cd /ruta/a/otro/proyecto
quarto add allabur/quarto-rogle-lab        # cuando lo publiques en GitHub
# o, usando una ruta local mientras se desarrolla:
quarto add /ruta/a/templates/article
```

Después, en tu `.qmd`:

```yaml
---
title: "Mi práctica"
format: rogle-lab-pdf
course:
  subject: "Gestión de la cadena de suministro"
  lab-number: "2"
---
```

### Opción C · `quarto use template`

Para que alumnos o colaboradores arranquen desde cero un repo basado en la plantilla:

```bash
quarto use template allabur/quarto-rogle-lab
```

Esto crea una carpeta nueva con `template.qmd` y `_extensions/rogle-lab/` ya configurados.

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
| Paleta de colores | `_extensions/rogle-lab/includes/colors.tex` |
| Tipografías | `_extensions/rogle-lab/includes/fonts.tex` |
| Márgenes, interlineado | `_extensions/rogle-lab/includes/layout.tex` |
| Logos de cabecera | Reemplaza los PNG en `_extensions/rogle-lab/resources/logos/` |
| Portada (qué aparece, en qué orden) | `_extensions/rogle-lab/partials/before-body.tex` |
| Qué se muestra en el pie | Cambia `footer.content` en la YAML del documento |
| Estilos HTML | `_extensions/rogle-lab/styles/rogle-lab.scss` |

## 6 · Publicar como template

Cuando la extensión esté estable, súbela a GitHub como `allabur/quarto-rogle-lab` con un tag de versión (`v1.0.0`). A partir de ahí, cualquiera puede instalarla con `quarto add` o `quarto use template`.

## Licencia

Código bajo **MIT**. Documentos generados: la licencia la define cada documento (por defecto CC BY-NC-SA 4.0).
