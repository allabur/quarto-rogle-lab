# quarto-rogle-lab

Plantilla y extensión Quarto reutilizable para enunciados de **prácticas, notas
técnicas y proyectos** en asignaturas de la UPV. Es la plantilla por defecto
para nuevos enunciados.

Entrega un PDF y un HTML con portada UPV, metadatos de asignatura (código, nº
de práctica, curso, grupo, titulación), cabecera con logos y pie con licencia
/ autoría / paginación.

## Creación de una práctica nueva

Usa este repositorio como punto de partida de un proyecto nuevo:

```bash
quarto use template allabur/quarto-rogle-lab
```

Esto crea una carpeta con la extensión `rogle-lab` ya instalada en
`_extensions/` y un `template.qmd` listo para editar como primera práctica.

## Instalación en un proyecto existente

Si ya tienes un proyecto Quarto y solo quieres añadir el formato:

```bash
cd /ruta/a/tu/proyecto
quarto add allabur/quarto-rogle-lab
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

## Uso

Los formatos disponibles son `rogle-lab-pdf` y `rogle-lab-html`:

```bash
quarto render mi-practica.qmd --to rogle-lab-pdf
quarto render mi-practica.qmd --to rogle-lab-html
```

Un archivo `.qmd` por práctica, en la raíz del proyecto (junto a
`_extensions/`):

```bash
cp template.qmd lab-04-nombre.qmd
# edita la YAML: subject, title, author, license…
```

O renderiza todo el proyecto (incluidos los ejemplos de `example/`):

```bash
quarto render
```

## Estructura del repositorio

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
├── .quartoignore                   # Archivos que no se copian con `quarto use template`
└── README.md
```

## Metadatos soportados en la YAML

| Bloque | Campo | Descripción |
|--------|-------|-------------|
| raíz | `title`, `subtitle`, `abstract`, `keywords`, `date`, `lang` | Metadatos Pandoc estándar |
| `course` | `subject`, `code`, `lab-number`, `lab-type`, `degree`, `group`, `academic-year`, `semester`, `duration` | Contexto académico — aparece en la portada |
| `author` / `affiliations` | Quarto estándar (`name.given`, `name.family`, `email`, `orcid`, `affiliations`) | Autores del enunciado |
| `license` | `name` (`CC BY`, `CC BY-NC-SA`, `CC BY-NC-ND`, `CC0`…), `version`, `url` | Licencia del documento |
| `copyright` | `holder`, `year` | Copyright del enunciado |
| `upv-footer` | `content`: `license` \| `citation` \| `copyright` | Qué se muestra a la izquierda del pie (no confundir con la opción `footer`, reservada por Quarto) |
| `citation` | CSL — `container-title`, `issued.year`, `volume`, `doi`… | Cita tipo CSL, útil para notas técnicas |

## Formato "caso docente" (uso interno PDI, no para alumnos)

Además del enunciado de práctica de arriba, el repo incluye una segunda
extensión, `rogle-lab-case` (`_extensions/rogle-lab-case/`), con portada tipo
artículo de congreso: logo ROGLE + bloque de metadatos académicos, autores
con afiliaciones numeradas y ORCID, caja "Cómo citar" y licencia — pensada
para que el PDI del lab redacte casos docentes / notas técnicas
**depositables** (p. ej. en la colección
[ROGLE. Materiales docentes](https://riunet.upv.es/handle/10251/18261) de
RiUNET) y no para que un alumno la use como plantilla de práctica.

```bash
quarto render mi-caso.qmd --to rogle-lab-case-pdf
```

Ejemplo completo: `example/caso-drof.qmd` (transcripción del "Caso Premontaje
DROF", ROGLE-UPV 2019). Campos propios de este formato, además de los de la
tabla de metadatos de abajo:

| Campo | Descripción |
|-------|-------------|
| `course.institution` | Institución, arriba a la derecha (por defecto "Universitat Politècnica de València") |
| `course.degree` | Titulación/grado-máster |
| `course.type` | Tipo de documento, p. ej. "Caso docente", "Nota técnica" |
| `course.code` | Código del documento, p. ej. `CD-19-DROF` |
| `course.academic-year`, `course.semester` | Curso académico / semestre |
| `citation.url` | Enlace persistente genérico (p. ej. el Handle de RiUNET) — a diferencia de `citation.doi`, no asume formato `doi.org` |

## Requisitos

- **Quarto** ≥ 1.4
- **TeX Live** con `xelatex` (para PDF) — incluido en cualquier instalación estándar de TeX Live o MacTeX
- Paquetes LaTeX: `scrlayer-scrpage`, `geometry`, `fontspec`, `graphicx`, `xcolor`, `framed`, `lastpage` (todos estándar en TeX Live)

## Personalización rápida

| Quiero cambiar… | Edita… |
|-----------------|--------|
| Paleta de colores | `_extensions/rogle-lab/includes/colors.tex` |
| Tipografías | `_extensions/rogle-lab/includes/fonts.tex` |
| Márgenes, interlineado | `_extensions/rogle-lab/includes/layout.tex` |
| Logos de cabecera | Reemplaza los PNG en `_extensions/rogle-lab/resources/logos/` |
| Portada (qué aparece, en qué orden) | `_extensions/rogle-lab/partials/before-body.tex` |
| Qué se muestra en el pie | Cambia `footer.content` en la YAML del documento |
| Estilos HTML | `_extensions/rogle-lab/styles/rogle-lab.scss` |

## Versionado

Este repositorio sigue [SemVer](https://semver.org/). Cada release se marca
con un tag `vX.Y.Z`; `quarto add`/`quarto use template` sin especificar tag
instalan la última release. Estado actual: **v0.1.0** (primera versión
estable de la plantilla).

## Licencia

Código bajo **MIT** (ver `LICENSE`). Documentos generados: la licencia la
define cada documento (por defecto CC BY-NC-SA 4.0).
