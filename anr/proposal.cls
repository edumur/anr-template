%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Unofficial example of ANR Project proposal
%%
%% v1.4   - 04/12/2024: adapte the template to lualatex engine
%% v1.3   - 27/03/2023: adapte the template to xetex engine
%% Fork by etienne.dumur@cea.fr
%% https://github.com/edumur/anr-template
%%
%% v1.2.3 - 08/09/2021: adjusted footer and header, thanks to Adel Noureddine.
%% v1.2.2 - 21/11/2020: adjusted to allow lists in notes, thanks to Christophe Gravier.
%% v1.2.1 - 25/02/2020: modification to fit the changes in packages pgfgantt, thanks to Nicolas Marchand.
%% v1.2   - 02/03/2019: minor adjustments to match the 2019 version of the template.
%% v1.1   -    04/2018: minor adjustments in the class.
%% v1     -    03/2018: first draft.
%% vincent.labatut@univ-avignon.fr
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% init class

\ProvidesClass{anr/proposal}
\LoadClass[a4paper,11pt,final]{article}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% encoding and stuff

\RequirePackage[english]{babel}				% language package
% When using babel or polyglossia with biblatex, loading csquotes is recommended
% to ensure that quoted texts are typeset according to the rules of your main language.
\RequirePackage{csquotes}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% font settings

% For the text
\RequirePackage[math-style=TeX]{unicode-math}
\RequirePackage{fontspec}
\setmainfont[
    Ligatures=TeX]{calibri}[
    Path = fonts/,
    Extension = .ttf,
    UprightFont = *r,
    ItalicFont=*i,
    BoldFont=*b,
    BoldItalicFont=*z,
    ]
\defaultfontfeatures{Scale=MatchUppercase}

% For the math
\setmathfont{XITS Math}
\setmathfont[range=\mathup]{calibri}[
    Path = fonts/,
    Extension = .ttf,
    ]
\setmathfont[range=\mathit]{calibrii}[
    Path = fonts/,
    Extension = .ttf,
    ]
\newfontfamily\partnerFont{calibril}[
    Path = fonts/,
    Extension = .ttf,
    ]

% Add protusion through microtype
\RequirePackage[protrusion=true]{microtype}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% image settings

% improves \includegraphics
\RequirePackage{graphicx}
% graphics wrap around text
\RequirePackage{wrapfig}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% general layout

% changes document margins
% 2cm margins, as specified in the official MS Word template
\RequirePackage[
    top=2cm,
	bottom=3cm,
    left=2cm,
    right=2cm]{geometry}

% controls spacing between lines
% Used to make the bibliography smaller
\RequirePackage{setspace}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% header/footer settings

% gives the total number of pages
\RequirePackage{lastpage}

% Use to change headers and setters
\RequirePackage{fancyhdr}

% set header vertical size (must be here, I do not know why)
\setlength{\headheight}{50.80pt}

% macro initializing the headers and footers
\newcommand{\setHeaders}{
	\pagestyle{fancy}
	\fancyhf{}

    % Here start the header
	\chead{
        \begin{tblr}{
            width=\linewidth,
            hlines={1pt,white},
            vlines={1pt,white},
            row{1-3}={bg=headerbackground},
            colspec={
                X[0.18\linewidth]
                X[0.36\linewidth]
                X[0.18\linewidth]
                X[0.175\linewidth]}}

        {\textbf{\textcolor{aapgcolor}{AAPG\myacyear}}} &
        \SetCell[c=2]{l}{\large\textbf{\textcolor{black}{\myacronym}}} &
            &
        \textcolor{black}{\myinstrument} \\

        \textcolor{aapgcolor}{Coordinated by: } &
        \textcolor{black}{\myinvestigator} &
        \textcolor{black}{\myduration} &
        \textcolor{black}{\myfunding} \\

        \SetCell[c=4]{l}{\textcolor{black}{\mycommittee}} \\

        \end{tblr}
    }


    % Here start the footer
	\cfoot{\raggedleft \textcolor{nbpage}{\thepage/\pageref*{LastPage}}}
    \renewcommand\headrule{}
	\renewcommand\footrule{\kern 1mm}}
\setlength{\footskip}{20pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% color settings

% defines custom colors
\RequirePackage[table]{xcolor}
% to change the color of the table lines
\RequirePackage{colortbl}
% aapg color
\definecolor{aapgcolor}{RGB}{33,88,104}
% header background
\definecolor{headerbackground}{RGB}{182,221,232}
% color for section headers
\definecolor{headcolor}{RGB}{46,116,181}
% color for subection
\definecolor{subsectioncolor}{RGB}{46,116,181}
% color for subsubection
\definecolor{subsubsectioncolor}{RGB}{46,116,181}
% color for page number
\definecolor{nbpage}{RGB}{68, 114, 196}
% color for citation
\definecolor{citecolor}{RGB}{127,158,64}
% color for figure and table reference
\definecolor{refcolor}{RGB}{137,168,74}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hyperlinks settings

% enables hyperlinks
\RequirePackage[
    bookmarks=true,
    bookmarksnumbered=true,
    bookmarksopen=true,
    unicode=true,
    colorlinks=true,
    linktoc=all,
    % figure and table ref color
    linkcolor=refcolor,
    % citation and table ref color
    citecolor=citecolor,
    filecolor=headcolor
    urlcolor=headcolor,
    pdfstartview=FitH
]{hyperref}

% properly displays urls
\RequirePackage{url}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% table settings
\RequirePackage{tabularray}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bibliographic settings

% displays DOIs in the bibliography
\usepackage{doi}
\usepackage[
    % Style for reference list
    style=ieee,
    % Style for the citation in the text
    citestyle=chem-angew,
    maxbibnames=3,
    minbibnames=3,
    maxcitenames=3,
    mincitenames=3,
    % includes a page backlink in the reference list
    backref=true,
    % uses biber to compile (instead of bibtex)
    backend=biber]
    % uses biblatex (instead of bibtex)
{biblatex}
% font size of the bibliographical section text
\renewcommand*{\bibfont}{\footnotesize}

% Get the reference numbered colored and with square bracket
\DeclareFieldFormat{labelnumberwidth}{\textcolor{citecolor}{\mkbibbrackets{#1}}}

%This part is to colorize the brackets
\DeclareCiteCommand{\cite}[\color{citecolor}\mkbibbrackets]
  {\usebibmacro{cite:init}%
   \usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \usebibmacro{cite:comp}}
  {}
  {\usebibmacro{cite:dump}%
   \usebibmacro{postnote}}

\newrobustcmd{\mkbibcoloursuperscript}[2]{%
  \unspace\allowhyphens\textsuperscript{%
    \begingroup
    \protected\long\def\mkbibsuperscript##1{%
      \blx@warning{Nested superscript}%
      \mkbibbrackets{##1}}%
    \color{#1}%
    #2\endgroup}}

%This part is to put brackets around the supercitation%
\DeclareCiteCommand{\supercite}[\mkbibcoloursuperscript{citecolor}]
  {\usebibmacro{cite:init}%
   \let\multicitedelim=\supercitedelim
   \iffieldundef{prenote}
     {}
     {\BibliographyWarning{Ignoring prenote argument}}%
   \iffieldundef{postnote}
     {}
     {\BibliographyWarning{Ignoring postnote argument}}%
  \bibopenbracket}%
  {\usebibmacro{citeindex}%
   \usebibmacro{cite:comp}}
  {}
  {\usebibmacro{cite:dump}\bibclosebracket}

% Make the DOI start on a new line
\DeclareFieldFormat{doi}{%
  \newline
  \mkbibacro{DOI}\addcolon\space
    \ifhyperref
      {\href{http://dx.doi.org/#1}{\nolinkurl{#1}}}
      {\nolinkurl{#1}}}

% Make the URL start on a new line
\DeclareFieldFormat{url}{%
  \newline
  \mkbibacro{URL}\addcolon\space
    \ifhyperref
      {\href{#1}{\nolinkurl{#1}}}
      {\nolinkurl{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% caption settings

\RequirePackage{caption}
\captionsetup{
    % font(sf), color, bold, size of the caption label
	labelfont={color=headcolor, bf, small},
    % font(sf) and size of the caption text itself
    textfont={small},
    % separator between label and text
    labelsep=period,
    % left/right margins
    % margin=10mm
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% custom equations

% change equation numbers
\def\tagform@#1{\maketag@@@{(\color{headcolor}\textbf{#1}\normalcolor)\@@italiccorr}}


%%%%%%%%%%%%%%%%%%%%%%%%%
%% bullet list

% gives more control over lists
\RequirePackage{enumitem}
% changes spacing between list items
\setlist{nolistsep}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom section headers
\renewcommand\thesection{\Roman{section}.}	% sets the weird section numbering of the official template
\renewcommand\thesubsection{\alph{subsection}.}
\renewcommand\thesubsubsection{\alph{subsubsection}.}
\RequirePackage{titlesec}
\titleformat{\section}
	{\color{headcolor}\Large\bfseries}
    {\thesection}
    {1em}
    {}
% \titlespacing{\section}{0pt}{1.2mm}{1.2mm}
\titleformat{\subsection}
	{\color{subsectioncolor}\normalfont\large\bfseries}
    {\thesubsection}
    {1em}
    {}
% \titlespacing{\subsection}{\parindent}{1.2mm}{1.2mm}

\titleformat{\subsubsection}
	{\color{subsubsectioncolor}\normalfont\normalsize\bfseries}
    {\thesubsubsection}
    {1em}
    {}
% \titlespacing{\subsubsection}{30pt}{0.8mm}{0.8mm}

\newcommand{\sectionn}[1]{
	\phantomsection
	\addcontentsline{toc}{section}{#1}
	\section*{#1}
    }
\newcommand{\subsectionn}[1]{
	\phantomsection
	\addcontentsline{toc}{subsection}{#1}
	\subsection*{#1}
    }
\newcommand{\subsubsectionn}[1]{
	\phantomsection
	\addcontentsline{toc}{subsubsection}{#1}
	\subsubsection*{#1}
    }
\setcounter{secnumdepth}{3}			% numbers subsubsections
\setcounter{tocdepth}{5}			% and includes them in the TOC


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% work packages and tasks
\newcounter{CntWP}					% WP counter
\setcounter{CntWP}{-1}				% NOTE: comment this line to number WPs starting from 1
\newcounter{CntT}[CntWP]			% task counter
\newcommand{\wpdef}[2]{				% defines new WPs
	\refstepcounter{CntWP}\label{#1}
    \par\vspace{0.5cm}
	\phantomsection
	\addcontentsline{toc}{subsubsection}{WP~\arabic{CntWP}.~#2}
    \noindent
    {\normalfont\normalsize\bfseries\textcolor{headcolor}{Work Package~\arabic{CntWP}:~#2}}\newline}
\newcommand{\tdef}[2]{				% defines new tasks
	\refstepcounter{CntT}\label{#1}
    \par\vspace{0.25cm}
	\phantomsection
	\addcontentsline{toc}{paragraph}{Task~\arabic{CntWP}.\arabic{CntT}.~#2}
    \noindent\hspace{0.5cm}
    {\normalfont\normalsize\bfseries\itshape\textcolor{headcolor}{Task~\arabic{CntWP}.\arabic{CntT}:~#2}}\newline}
\renewcommand*\theCntT{\theCntWP.\arabic{CntT}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maketitle macro
\renewcommand{\maketitle}
{	\setHeaders									% sets up the headers and footers
	\hypersetup{pdftitle={\mytitle}}			% adds title to PDF properties
    \begin{center}
    	\vspace*{-1cm}						% adds a bit of space before the title
        \huge\textbf{\textcolor{black}{\mytitle}}				    % places the title
        \ifdefined\mysubtitle
            \\\Large\textbf{\mysubtitle}		% places the subtitle
        \fi%
    \end{center}
    \global\@topnum\z@							% prevents floats from going above the title
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Units

\RequirePackage{siunitx}
\sisetup{per-symbol=.}
\sisetup{inter-unit-product=.}
\sisetup{per-mode=reciprocal}
% \sisetup{binary-units=true}
\sisetup{separate-uncertainty=true}
\sisetup{separate-uncertainty-units=single}

% Use a text format percent symbol
\DeclareSIUnit\percent{\text{\%}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% text box

\RequirePackage{tcolorbox}

\hypersetup{
  colorlinks=true,
  citecolor={citecolor},
  citebordercolor={citecolor},
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% macros used to set the project details

% full title of the project
\def\title#1{\gdef\@title{#1}\gdef\mytitle{#1}}
% subtitle of the project (optional)
\def\subtitle#1{\gdef\mysubtitle{#1}}
% acronym of the project
\def\acronym#1{\gdef\myacronym{#1}}
% scientific evaluation committee
\def\committee#1{\gdef\mycommittee{#1}}
% funding instrument
\def\instrument#1{\gdef\myinstrument{#1}}
% year of the call
\def\acyear#1{\gdef\myacyear{#1}}
% principal investigator
\def\investigator#1{\gdef\myinvestigator{#1}}
% duration of the project
\def\duration#1{\gdef\myduration{#1}}
% requested funding
\def\funding#1{\gdef\myfunding{#1}}

% Define title for ressource
\newcommand{\ressourceTitle}[1]{
\vspace{2mm}
\noindent \textcolor{headcolor}{\underline{#1}}
\vspace{2mm}
}

% Define bold anr style section
\newcommand{\smallSection}[1]{
\vspace*{0.1cm}
\noindent \large{\textbf{\;\;\;#1}}
\vspace*{0.1cm}
}

% Define title for partner
\newcommand{\partnerTitle}[1]{
\vspace{2mm}
\noindent {\partnerFont\fontsize{13}{0}\selectfont \textcolor{headcolor}{\textbf{#1}}}
\vspace{2mm}
}
