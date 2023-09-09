%%
%% This is file `snu-ece-bsc-thesis.cls'.
%%
%% -----------------------------------------------------------------
%% The snu-ece-bsc-thesis class --- A class for SNU ECE BSc theses
%% Maintained by Jay Lee
%% E-mail: jaeho.lee@snu.ac.kr
%% Released under the MIT License.
%% -----------------------------------------------------------------
%%
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{expl3}
\ProvidesExplClass
  {snu-ece-bsc-thesis}
  {2023/09/08}
  {0.1}
  {A class for SNU ECE BSc theses}


%%%%%%%%%%%%%%%%%%%%%%%%%
% Options for the class %
%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareKeys {
  en .code = { \bool_set_true:N \l_snu_ece_bsc_thesis_en_bool },
  ko .code = { \bool_set_false:N \l_snu_ece_bsc_thesis_en_bool },
}
\SetKeys { ko }
\ProcessKeyOptions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XeLaTeX or LuaLaTeX required %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{iftex}
\ifXeTeX\else\ifLuaTeX\else
  \ClassError {snu-ece-bsc-thesis}
    { This~class~only~supports~XeLaTeX~and~LuaLaTeX. }
    { Please~use~either~XeLaTeX~or~LuaLaTeX. }
\fi\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language-specific settings %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tl_const:Nn \l_snu_ece_bsc_thesis_abstractname_ko { 초~록 }
\tl_const:Nn \l_snu_ece_bsc_thesis_contentsname_ko { 목~차 }
\tl_const:Nn \l_snu_ece_bsc_thesis_listtablename_ko { 표~목차 }
\tl_const:Nn \l_snu_ece_bsc_thesis_listfigurename_ko { 그림~목차 }
\tl_const:Nn \l_snu_ece_bsc_thesis_abstractname_en { Abstract }
\tl_const:Nn \l_snu_ece_bsc_thesis_contentsname_en { Contents }
\tl_const:Nn \l_snu_ece_bsc_thesis_listtablename_en { List~of~Tables }
\tl_const:Nn \l_snu_ece_bsc_thesis_listfigurename_en { List~of~Figures }

\bool_if:NTF \l_snu_ece_bsc_thesis_en_bool
  { % English main
    \LoadClass[11pt, a4paper]{report}
    \RequirePackage{kotex}

    \RequirePackage{caption}
    \captionsetup[table]{font={stretch=1.3}}
    \captionsetup[figure]{font={stretch=1.3}}

    \RenewDocumentCommand \abstractname {}
      { \l_snu_ece_bsc_thesis_abstractname_en }
    \RenewDocumentCommand \contentsname {}
      { \l_snu_ece_bsc_thesis_contentsname_en }
    \RenewDocumentCommand \listtablename {}
      { \l_snu_ece_bsc_thesis_listtablename_en }
    \RenewDocumentCommand \listfigurename {}
      { \l_snu_ece_bsc_thesis_listfigurename_en }
  }
  { % Korean main
    \LoadClass[10pt, a4paper]{report}
    \RequirePackage[hangul]{kotex}

    \RequirePackage[list=off, bi-separator=smallskip]{bicaption}
    \bicaptionsetup[table]{name=표}{name=Table}
    \bicaptionsetup[figure]{name=그림}{name=Figure}

    \RenewDocumentCommand \abstractname {}
      { \l_snu_ece_bsc_thesis_abstractname_ko }
    \RenewDocumentCommand \contentsname {}
      { \l_snu_ece_bsc_thesis_contentsname_ko }
    \RenewDocumentCommand \listtablename {}
      { \l_snu_ece_bsc_thesis_listtablename_ko }
    \RenewDocumentCommand \listfigurename {}
      { \l_snu_ece_bsc_thesis_listfigurename_ko }
  }


%%%%%%%%%%%%%%%%%%%%%%%%
% Package dependencies %
%%%%%%%%%%%%%%%%%%%%%%%%
% Subfigures
\RequirePackage{subcaption}

% Images
\RequirePackage{graphicx}

% Tables
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}

% Math
\RequirePackage{amssymb,amsmath,mathtools} % Before unicode-math
% \RequirePackage[math-style=TeX,bold-style=TeX]{unicode-math}

% Bibliography
\RequirePackage[style=ieee]{biblatex}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page layout configuration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addtolength{\hoffset}{-1in}
\addtolength{\voffset}{-1in}
\setlength{\topmargin}{30mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\marginparwidth}{0mm}
\setlength{\marginparsep}{0mm}
\setlength{\oddsidemargin}{25mm}
\setlength{\textwidth}{160mm}
\setlength{\textheight}{227mm}
\setlength{\footskip}{20mm}
\linespread{1.6} % double spacing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document metadata fields %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\clist_new:N \l_snu_ece_bsc_thesis_keywords_ko_clist
\clist_new:N \l_snu_ece_bsc_thesis_keywords_en_clist

\newcommand\authorspaced{
  \tl_map_inline:Nn { \@author } { ##1~ }
}

\NewDocumentCommand \advisor { m }
  { \newcommand*\@advisor{#1} }
\NewDocumentCommand \koreankeywords { m }
  {
    \clist_set:Nn \l_snu_ece_bsc_thesis_keywords_ko_clist { #1 }
  }
\NewDocumentCommand \englishkeywords { m }
  {
    \clist_set:Nn \l_snu_ece_bsc_thesis_keywords_en_clist { #1 }
  }

% https://github.com/latex3/hyperref/issues/242#issuecomment-1149845979
\AddToHook {begindocument/before} {
  \usepackage[
    pdfauthor = \@author,
    pdftitle = \@title,
    pdfsubject = {공학~학사~학위논문},
    pdfkeywords = {
      \clist_use:Nnnn \l_snu_ece_bsc_thesis_keywords_en_clist { , } { , } { , },
      \clist_use:Nnnn \l_snu_ece_bsc_thesis_keywords_ko_clist { , } { , } { , }
    },
  ]{hyperref}
}

% Redefine \maketitle
\AtBeginDocument {
  % hyperref package redefines \@maketitle
  \def\HyOrg@maketitle{
    \newpage
    \null

    % 외표지
    \thispagestyle{empty}
    \begin{center}
      \fontsize{16pt}{19pt}\selectfont
      공학~학사~학위논문 \\
      \vspace{2cm}
      \fontsize{21pt}{25pt}\selectfont
      \@title \\
      \vfill
      \fontsize{16pt}{19pt}\selectfont
      \@date \\
      \vspace{4cm}
      서울대학교~공과대학 \\
      \vspace{1cm}
      전기·정보공학부 \\
      \vspace{1cm}
      \authorspaced
    \end{center}
    \newpage

    % 인준지
    \thispagestyle{empty}
    \begin{center}
      \fontsize{21pt}{25pt}\selectfont
      \@title \\
      \vspace{1cm}
      \fontsize{16pt}{19pt}\selectfont
      지도교수~\@advisor \\
      \vspace{1cm}
      이~논문을~공학~학사학위~논문으로~제출함. \\
      \vfill
      서울대학교~공과대학 \\
      \vspace{1cm}
      전기·정보공학부 \\
      \authorspaced \\
      \vspace{1cm}
      \@author 의~학사~학위~논문을~인준함. \\
      \vspace{1cm}
      20\hphantom{23}년~\hphantom{09}월~\hphantom{08}일 \\
      \vspace{1cm}
      지도교수 \hspace{6cm}(인)
    \end{center}
    \newpage
  }
}

% Redefine \baselinestretch for ToCs
\let\@starttoc@orig\@starttoc
\def\@starttoc#1{
  \begingroup
  \linespread{1.3}\selectfont
  \@starttoc@orig{#1}
  \endgroup
}

\AddToHook {env/figure/begin} {
  \linespread{1.3}\selectfont
}
\AddToHook {env/table/begin} {
  \linespread{1.3}\selectfont
}

\RenewDocumentEnvironment { abstract } { o }
  {
    \IfValueTF { #1 }
      {
        \tl_if_eq:nnTF { #1 } { ko }
          { % Korean abstract
            \chapter*{\l_snu_ece_bsc_thesis_abstractname_ko}
            \addcontentsline{toc}{chapter}
              {\text_purify:n\l_snu_ece_bsc_thesis_abstractname_ko}
          }
          {
            \tl_if_eq:nnTF { #1 } { en }
              { % English abstract
                \chapter*{\l_snu_ece_bsc_thesis_abstractname_en}
                \addcontentsline{toc}{chapter}
                  {\text_purify:n\l_snu_ece_bsc_thesis_abstractname_en}
              }
              { % Unrecognized language
                \ClassError { snu-ece-bsc-thesis }
                  { Unrecognized~language:~`#1' }
                  { Please~use~either~`ko'~or~`en' }

                \chapter*{\abstractname}
                \addcontentsline{toc}{chapter}{\text_purify:n\abstractname}
              }
          }
      }
      { % No language specified
        \chapter*{\abstractname}
        \addcontentsline{toc}{chapter}{\text_purify:n\abstractname}
      }
  }
  {
    \vfill
    \IfValueTF { #1 }
      {
        \tl_if_eq:nnTF { #1 } { ko }
          { % Korean abstract
            \noindent 주요어: \clist_use:Nnnn \l_snu_ece_bsc_thesis_keywords_ko_clist { ,~ } { ,~ } { ,~ }
          }
          {
            \tl_if_eq:nnTF { #1 } { en }
              { % English abstract
              \noindent Keywords:~\clist_use:Nnnn \l_snu_ece_bsc_thesis_keywords_en_clist { ,~ } { ,~ } { ,~ }
              }
              { % Unrecognized language
                \noindent 주요어:~\clist_use:Nnnn \l_snu_ece_bsc_thesis_keywords_ko_clist { ,~ } { ,~ } { ,~ }
              }
          }
      }
      { % No language specified
        \bool_if:NTF \l_snu_ece_bsc_thesis_en_bool
          { % English main
            \noindent Keywords:~\clist_use:Nnnn
              \l_snu_ece_bsc_thesis_keywords_en_clist { ,~ } { ,~ } { ,~ }
          }
          { % Korean main
            \noindent 주요어:~\clist_use:Nnnn
              \l_snu_ece_bsc_thesis_keywords_ko_clist { ,~ } { ,~ } { ,~ }
          }
      }
  }
