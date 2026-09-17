% rogle-case-upv.cls — Clase editorial para casos docentes / notas técnicas
% del PDI de ROGLE (Universitat Politècnica de València) pensados para
% depositar (RiUNET, Zenodo...).
%
% Formaliza como clase LaTeX propia lo que antes vivía disperso en
% partials/before-title.tex, siguiendo el patrón de citym-upv.cls: portada
% tipo artículo, tema intercambiable (rogle-case-theme-<nombre>.tex), y una
% traducción fina YAML → macros en partials/title.tex, que no se escribe a
% mano en el manuscrito.
%
% v0.1 — extracción inicial desde rogle-lab-case 0.1.0 (portada, licencia,
% "Cómo citar", cabecera/pie fancyhdr), sin cambios de diseño respecto a esa
% versión.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rogle-case-upv}[2026/09/17 v0.1 ROGLE Case/Informe UPV]
\LoadClass[11pt]{article}

\RequirePackage[a4paper,top=25mm,left=25mm,right=25mm,bottom=35mm]{geometry}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage[table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{fontawesome5}
\RequirePackage{iflang}
\RequirePackage{orcidlink}
\RequirePackage{authblk}

% ============================================================================
% COLORES UPV
% ============================================================================
\definecolor{upvGrey}{HTML}{424A50}
\definecolor{upvGreyLight}{HTML}{5C6368}
\definecolor{upvGreyDark}{HTML}{3F4444}
\definecolor{greySeparator}{HTML}{6D6E71}
\definecolor{greyMedium}{HTML}{CFCFCF}
\definecolor{greyLight}{HTML}{F1F1F1}
\definecolor{upvRed}{HTML}{E5554F}
\definecolor{upvYellow}{HTML}{FFD100}
\definecolor{upvBlue}{HTML}{59CBE8}
\definecolor{upvBlueDark}{HTML}{338FC2}

% ============================================================================
% TEMA — hooks de estilo, redefinibles por rogle-case-theme-<nombre>.tex.
% Un tema solo redefine los hooks que cambia; el resto sigue saliendo de aquí.
% ============================================================================
\newcommand{\rogleAuthorFont}{\bfseries}
\newcommand{\rogleAffilFont}{\normalfont\small}
\newcommand{\rogleHowToCiteFont}{\footnotesize}
\newcommand{\rogleCourseInfoFont}{\footnotesize}

\newcommand{\rogleUsePreset}[1]{%
  \InputIfFileExists{rogle-case-theme-#1.tex}{}{%
    \ClassWarning{rogle-case-upv}{Tema desconocido: #1}%
  }%
}
% `rogle-case-preset.tex` (una línea, `\rogleUsePreset{<nombre>}`) permite a
% un proyecto fijar un tema sin editar la clase; en su ausencia se carga el
% tema por omisión, que reproduce este mismo diseño.
\InputIfFileExists{rogle-case-preset.tex}{}{\rogleUsePreset{default}}

\renewcommand\Authfont{\rogleAuthorFont}
\renewcommand\Affilfont{\rogleAffilFont}
\setlength{\affilsep}{0.5em}

% ============================================================================
% RECURSOS (logos/iconos) — la ruta la fija partials/title.tex a partir de
% $rogle-lab-resources-dir$; esta clase no ve variables de Pandoc.
% ============================================================================
\newcommand{\rogleResourcesDirValue}{}
\newcommand{\rogleResourcesDir}[1]{\renewcommand{\rogleResourcesDirValue}{#1}}

% ============================================================================
% METADATOS ACADÉMICOS — bloque de portada, arriba a la derecha
% ============================================================================
\newcommand{\rogleInstitutionValue}{Universitat Politècnica de València}
\newcommand{\rogleInstitution}[1]{\renewcommand{\rogleInstitutionValue}{#1}}
\newcommand{\rogleDegreeValue}{}
\newcommand{\rogleDegree}[1]{\renewcommand{\rogleDegreeValue}{#1}}
\newcommand{\rogleCourseSubjectValue}{}
\newcommand{\rogleCourseSubject}[1]{\renewcommand{\rogleCourseSubjectValue}{#1}}
\newcommand{\rogleAcademicYearValue}{}
\newcommand{\rogleAcademicYear}[1]{\renewcommand{\rogleAcademicYearValue}{#1}}
\newcommand{\rogleSemesterValue}{}
\newcommand{\rogleSemester}[1]{\renewcommand{\rogleSemesterValue}{#1}}
\newcommand{\rogleDocTypeValue}{}
\newcommand{\rogleDocType}[1]{\renewcommand{\rogleDocTypeValue}{#1}}
\newcommand{\rogleDocCodeValue}{}
\newcommand{\rogleDocCode}[1]{\renewcommand{\rogleDocCodeValue}{#1}}

% Título "plano" (sin la decoración de \rogleCaseHeaderBlock) para la
% cabecera de página — \@title ya lleva el bloque logo+metadatos prepended.
\newcommand{\rogleDocTitleValue}{}
\newcommand{\rogleDocTitle}[1]{\renewcommand{\rogleDocTitleValue}{#1}}

\newcommand{\rogleCaseHeaderBlock}{%
  {\normalfont\mdseries
  \noindent
  \begin{minipage}[t]{0.45\textwidth}
    \IfFileExists{\rogleResourcesDirValue logos/rogle-logo.png}{%
      \includegraphics[height=1.4cm]{\rogleResourcesDirValue logos/rogle-logo.png}%
    }{}
  \end{minipage}%
  \hfill
  \begin{minipage}[t]{0.5\textwidth}
    \raggedleft\rogleCourseInfoFont
    \rogleInstitutionValue\\
    \ifthenelse{\equal{\rogleDegreeValue}{}}{}{\rogleDegreeValue\\}%
    \ifthenelse{\equal{\rogleCourseSubjectValue}{}}{}{\rogleCourseSubjectValue\\}%
    \ifthenelse{\equal{\rogleAcademicYearValue}{}}{}{%
      Curso \rogleAcademicYearValue
      \ifthenelse{\equal{\rogleSemesterValue}{}}{}{ · \rogleSemesterValue}%
      \\%
    }%
    \ifthenelse{\equal{\rogleDocTypeValue}{}}{}{%
      \textbf{\rogleDocTypeValue}%
      \ifthenelse{\equal{\rogleDocCodeValue}{}}{}{ -- \rogleDocCodeValue}%
    }%
  \end{minipage}
  \par\vspace{1.2em}}%
}

% \@title ya está definido por \LoadClass{article}; en un .cls (a diferencia
% de un documento) el catcode de @ ya es de letra, así que no hace falta
% \makeatletter/\makeatother aquí.
\pretocmd{\@title}{\rogleCaseHeaderBlock}{}{}
\newcommand{\subtitle}[1]{\apptocmd{\@title}{\par {\large #1 \par}}{}{}}

% ============================================================================
% LICENCIA Y COPYRIGHT (pie de página)
% ============================================================================
\newboolean{rogleLicenseSet}\setboolean{rogleLicenseSet}{false}
\newcommand{\quartoLicenseName}{}
\newcommand{\quartoLicenseLogoPath}{}
\newcommand{\quartoLicenseUrl}{}
\newcommand{\quartoLicenseTextFallback}{%
  License: \ifthenelse{\equal{\quartoLicenseUrl}{}}{\quartoLicenseName}{\href{\quartoLicenseUrl}{\quartoLicenseName}} \ | %
}
\newcommand{\rogleCopyrightYearValue}{}
\newcommand{\rogleCopyrightHolderValue}{}
\newcommand{\rogleCopyright}[2]{%
  \renewcommand{\rogleCopyrightYearValue}{#1}%
  \renewcommand{\rogleCopyrightHolderValue}{#2}%
}

\newcommand{\rogleLicense}[2]{%
  \setboolean{rogleLicenseSet}{true}%
  \renewcommand{\quartoLicenseName}{#1}%
  \ifthenelse{\equal{#2}{}}{}{\renewcommand{\quartoLicenseUrl}{#2}}%
  \ifthenelse{\equal{\quartoLicenseName}{CC BY}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc-by.png}}{}%
  \ifthenelse{\equal{\quartoLicenseName}{CC BY-SA}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc-by-sa.png}}{}%
  \ifthenelse{\equal{\quartoLicenseName}{CC BY-ND}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc-by-nd.png}}{}%
  \ifthenelse{\equal{\quartoLicenseName}{CC BY-NC}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc-by-nc.png}}{}%
  \ifthenelse{\equal{\quartoLicenseName}{CC BY-NC-SA}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc-by-nc-sa.png}}{}%
  \ifthenelse{\equal{\quartoLicenseName}{CC BY-NC-ND}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc-by-nc-nd.png}}{}%
  \ifthenelse{\equal{\quartoLicenseName}{CC0}}{\renewcommand{\quartoLicenseLogoPath}{\rogleResourcesDirValue cc-icons/cc0.png}}{}%
  \ifthenelse{\equal{\quartoLicenseUrl}{}}{%
    \ifthenelse{\equal{\quartoLicenseName}{CC BY}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/licenses/by/4.0/}}{}%
    \ifthenelse{\equal{\quartoLicenseName}{CC BY-SA}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/licenses/by-sa/4.0/}}{}%
    \ifthenelse{\equal{\quartoLicenseName}{CC BY-ND}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/licenses/by-nd/4.0/}}{}%
    \ifthenelse{\equal{\quartoLicenseName}{CC BY-NC}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/licenses/by-nc/4.0/}}{}%
    \ifthenelse{\equal{\quartoLicenseName}{CC BY-NC-SA}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/licenses/by-nc-sa/4.0/}}{}%
    \ifthenelse{\equal{\quartoLicenseName}{CC BY-NC-ND}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/licenses/by-nc-nd/4.0/}}{}%
    \ifthenelse{\equal{\quartoLicenseName}{CC0}}{\renewcommand{\quartoLicenseUrl}{https://creativecommons.org/publicdomain/zero/1.0/}}{}%
  }{}%
}

\newcommand{\rogleFooterLeft}{%
  \small
  \ifthenelse{\boolean{rogleLicenseSet}}{%
    \ifthenelse{\equal{\quartoLicenseLogoPath}{}}{%
      \quartoLicenseTextFallback%
    }{%
      \IfFileExists{\quartoLicenseLogoPath}{%
        \ifthenelse{\equal{\quartoLicenseUrl}{}}{%
          \raisebox{-0.3\height}{\includegraphics[height=1.2em]{\quartoLicenseLogoPath}}%
        }{%
          \href{\quartoLicenseUrl}{\raisebox{-0.3\height}{\includegraphics[height=1.2em]{\quartoLicenseLogoPath}}}%
        }\hspace{0.5em}%
      }{%
        \quartoLicenseTextFallback%
      }%
    }%
  }{}%
  \ifthenelse{\equal{\rogleCopyrightYearValue}{}}{}{\textcopyright\ \rogleCopyrightYearValue\ \rogleCopyrightHolderValue}%
}

% ============================================================================
% "CÓMO CITAR"
% ============================================================================
\newboolean{rogleCitationSet}\setboolean{rogleCitationSet}{false}
\newcommand{\rogleCiteAuthorsValue}{}
\newcommand{\rogleCiteYearValue}{}
\newcommand{\rogleCiteTitleValue}{}
\newcommand{\rogleCiteSubjectValue}{}
\newcommand{\rogleCiteContainerValue}{}
\newcommand{\rogleCiteVolumeValue}{}
\newcommand{\rogleCiteIssueValue}{}
\newcommand{\rogleCiteDOIValue}{}
\newcommand{\rogleCiteURLValue}{}

\newcommand{\rogleCiteAuthors}[1]{\setboolean{rogleCitationSet}{true}\renewcommand{\rogleCiteAuthorsValue}{#1}}
\newcommand{\rogleCiteYear}[1]{\renewcommand{\rogleCiteYearValue}{#1}}
\newcommand{\rogleCiteTitle}[1]{\renewcommand{\rogleCiteTitleValue}{#1}}
\newcommand{\rogleCiteSubject}[1]{\renewcommand{\rogleCiteSubjectValue}{#1}}
\newcommand{\rogleCiteContainer}[1]{\renewcommand{\rogleCiteContainerValue}{#1}}
\newcommand{\rogleCiteVolume}[1]{\renewcommand{\rogleCiteVolumeValue}{#1}}
\newcommand{\rogleCiteIssue}[1]{\renewcommand{\rogleCiteIssueValue}{#1}}
\newcommand{\rogleCiteDOI}[1]{\renewcommand{\rogleCiteDOIValue}{#1}}
\newcommand{\rogleCiteURL}[1]{\renewcommand{\rogleCiteURLValue}{#1}}

\providecolor{quarto-callout-cite-color}{HTML}{6c757d}
\providecolor{quarto-callout-cite-color-frame}{HTML}{6c757d}

\newcommand{\citationcallout}{%
  \ifthenelse{\boolean{rogleCitationSet}}{%
  \begin{tcolorbox}[
      enhanced jigsaw,
      colframe=quarto-callout-cite-color-frame,
      colback=white,
      colbacktitle=quarto-callout-cite-color!10!white,
      coltitle=black,
      titlerule=0mm,
      opacitybacktitle=0.6,
      opacityback=0,
      leftrule=.75mm,
      rightrule=.15mm,
      toprule=.15mm,
      bottomrule=.15mm,
      left=2mm,
      top=1.5mm,
      bottom=1.5mm,
      arc=.35mm,
      toptitle=1mm,
      bottomtitle=1mm,
      title={\textcolor{quarto-callout-cite-color}{\footnotesize \faQuoteLeft}\hspace{0.5em}{\footnotesize \iflanguage{spanish}{Cómo citar}{How to cite}}}
    ]
    \rogleHowToCiteFont
    \rogleCiteAuthorsValue\ (\rogleCiteYearValue).\ \rogleCiteTitleValue.%
    \ifthenelse{\equal{\rogleCiteSubjectValue}{}}{}{\ \textit{\rogleCiteSubjectValue}.}%
    \ifthenelse{\equal{\rogleCiteContainerValue}{}}{}{\ \textit{\rogleCiteContainerValue}}%
    \ifthenelse{\equal{\rogleCiteVolumeValue}{}}{}{, \textit{\rogleCiteVolumeValue}\ifthenelse{\equal{\rogleCiteIssueValue}{}}{}{(\rogleCiteIssueValue)}}%
    \ifthenelse{\equal{\rogleCiteDOIValue}{}}{}{. \href{https://doi.org/\rogleCiteDOIValue}{https://doi.org/\rogleCiteDOIValue}}%
    \ifthenelse{\equal{\rogleCiteURLValue}{}}{}{. \url{\rogleCiteURLValue}}%
  \end{tcolorbox}%
  }{}%
}

% ============================================================================
% CABECERA / PIE (fancyhdr)
% ============================================================================
\setlength{\footskip}{15mm}
\setlength{\headheight}{32pt}
\setlength{\headsep}{10mm}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\newcommand{\rogleHeaderContent}{%
  \lhead{%
    \begin{tabular}[b]{l}
      \ifthenelse{\equal{\rogleCourseSubjectValue}{}}{}{\textbf{\small \rogleCourseSubjectValue} \\}%
      \small \rogleDocTitleValue
    \end{tabular}
  }%
  \IfFileExists{\rogleResourcesDirValue logos/rogle-logo.png}{%
    \rhead{\includegraphics[height=0.5cm]{\rogleResourcesDirValue logos/rogle-logo.png}}%
  }{}%
  \lfoot{\rogleFooterLeft}%
  \rfoot{\small \thepage\ / \pageref{LastPage}}%
}
\AtBeginDocument{\rogleHeaderContent}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0.4pt}%
  \renewcommand{\footrulewidth}{0.4pt}%
  \rogleHeaderContent
}
