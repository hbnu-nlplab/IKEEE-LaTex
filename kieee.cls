%%
%% kieee.cls
%% 한국전기전자학회 논문지 (j.inst.Korean.electr.electron.eng, Journal of IKEEE) LaTeX 클래스
%% 논문 투고 규정(2021.5.21. 개정) 및 학회 논문 양식(HWP) 기준
%%
%% 사용법:
%%   \documentclass{kieee}           % 게재용 최종 논문 (기본값)
%%   \documentclass[review]{kieee}   % 심사용 논문 — 저자명·1면 각주·저자소개 자동 삭제 (규정 11조)
%%   \documentclass[short]{kieee}    % 단편논문 — 최대 4면, 저자소개 생략 (규정 9·20조)
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kieee}[2026/08/16 v1.0 Journal of IKEEE (Han-guk Jeongi Jeonja Hakhoe) class]

\newif\if@review
\@reviewfalse
\newif\if@shortpaper
\@shortpaperfalse

\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption{review}{\@reviewtrue}
\DeclareOption{regular}{\@shortpaperfalse}   % 일반논문(기본값)
\DeclareOption{short}{\@shortpapertrue}      % 단편논문
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% A4 2단 편집 (규정 8·9조)
\LoadClass[10pt,a4paper,twocolumn,twoside]{article}

% 여백 (학회 HWP 양식 근사)
\usepackage[a4paper, top=30mm, bottom=25mm, left=20mm, right=20mm,
            headheight=12pt, headsep=8mm, footskip=10mm]{geometry}
\setlength{\columnsep}{6mm}

% 기본 폰트 및 한글 패키지
\usepackage{times}
\usepackage{dhucs-cmap}
\usepackage[hangul,nonfrench,finemath]{kotex}

% 줄간격
\usepackage[hangul]{dhucs-setspace}
\SetHangulspace{1.3}{1.1}

\setlength{\parindent}{1em}
\setlength{\parskip}{0pt}

\RequirePackage{graphicx}
\RequirePackage{amssymb}   % \bigstar (교신저자 표시 ★)
\RequirePackage{stfloats} % 양단 전체 폭 블록을 페이지 하단에 배치

% 인용: 본문 우측 대괄호 속에 번호를 차례로 기재 [1], [2,5], [3-5] (규정 16조)
\RequirePackage{cite}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 장/절/항 번호 체계 (학회 양식)
%  장: 로마자(Ⅰ, Ⅱ, Ⅲ, ...) / 절: 아라비아자(1, 2, 3, ...) / 항: 가, 나, ... / (1), (2), ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*{\kieee@gana}[1]{\ifcase#1\or 가\or 나\or 다\or 라\or 마\or 바\or
  사\or 아\or 자\or 차\or 카\or 타\or 파\or 하\fi}

% "제 1 절" 형식 대신 영문식 번호만 사용
\usepackage[ensec]{dhucs-sectsty}

\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\arabic{subsection}}
\renewcommand{\thesubsubsection}{\kieee@gana{\value{subsubsection}}}
\renewcommand{\theparagraph}{\arabic{paragraph}}
\setcounter{secnumdepth}{4}   % (1) 수준까지 번호 표기

% 장 제목: 가운데 정렬 진하게 / 절 제목: 왼쪽 진하게 / 항 제목: 왼쪽
\sectionfont{\centering\fontsize{11}{14}\bfseries\selectfont}
\subsectionfont{\fontsize{10.5}{13.5}\bfseries\selectfont}
\subsubsectionfont{\fontsize{10}{13}\mdseries\selectfont}

% (1), (2) 항: 문단 제목을 별행 제목으로 사용
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {2.5ex \@plus .5ex \@minus .2ex}{1ex \@plus .2ex}%
  {\fontsize{10}{13}\mdseries\selectfont}}

% 번호 뒤 마침표: "I. 서론", "2.1. 절", "가. 항", "(1) 항"
\def\@seccntformat#1{%
  \@ifundefined{#1@cntformat}%
  {\csname the#1\endcsname.\ }%
  {\csname #1@cntformat\endcsname}}
% kotex(kosections-utf)의 \@sect는 \@seccntformat 대신 \dhucs@seccntformat을 사용
\@ifundefined{dhucs@seccntformat}{}{%
  \def\dhucs@seccntformat#1#2{%
    \ifcsname #1@cntformat\endcsname
      \csname #1@cntformat\endcsname
    \else
      \csname the#1\endcsname.\ %
    \fi}}
% 장 제목(\ks@sect)은 pre/post@sectioncnt를 직접 사용하므로 마침표를 post에 부착
\kscntformat{section}{}{.}
\def\paragraph@cntformat{(\theparagraph)\ }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 머리말: 홀수쪽 = 권호 정보, 짝수쪽 = 논문 제목(영문) / 쪽번호는 바깥쪽
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[RO]{\fontsize{9}{11}\selectfont\thepage}
\fancyhead[LE]{\fontsize{9}{11}\selectfont\thepage}
\fancyhead[CO]{\fontsize{9}{11}\selectfont\@journalinfo}
\fancyhead[CE]{\fontsize{9}{11}\selectfont\@runningtitle}
\pagestyle{fancy}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 변수 정의
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\engtitle#1{\gdef\@engtitle{#1}}
\def\engauthor#1{\gdef\@engauthor{#1}}
\long\def\abstract#1{\long\gdef\@abstract{#1}}
\long\def\engabstract#1{\long\gdef\@engabstract{#1}}
\def\keywords#1{\gdef\@keywords{#1}}
\def\journalinfo#1{\gdef\@journalinfo{#1}}
\def\runningtitle#1{\gdef\@runningtitle{#1}}
\long\def\acknowledgment#1{\long\gdef\@acknowledgment{#1}}
\long\def\affiliation#1{\long\gdef\@affiliation{#1}}
\def\corresponding#1{\gdef\@corresponding{#1}}
\def\received#1{\gdef\@received{#1}}
\def\revised#1{\gdef\@revised{#1}}
\def\accepted#1{\gdef\@accepted{#1}}
\long\def\openaccess#1{\long\gdef\@openaccess{#1}}

% 기본값 (게재 확정 시 학회에서 부여하는 항목은 ** 그대로 둠)
\journalinfo{j.inst.Korean.electr.electron.eng. Vol.**, No.**, **\textasciitilde**, Month 20**}
\def\@runningtitle{\@engtitle}
\def\@acknowledgment{}
\def\@affiliation{}
\def\@corresponding{}
\def\@received{}
\def\@revised{}
\def\@accepted{}
% Open-Access 문구 (학회 양식 고정 문구; 필요 시 \openaccess{...}로 교체)
\def\@openaccess{This is an Open-Access article distributed under the terms of
  the Creative Commons Attribution Non-Commercial License
  (http://creativecommons.org/licenses/by-nc/3.0) which permits unrestricted
  non-commercial use, distribution, and reproduction in any medium, provided
  the original work is properly cited.}

% 저자 표시: 소속 * / 교신저자 ★ (학회 양식)
\newcommand{\affmark}{\textsuperscript{*}}
\newcommand{\corrmark}{\textsuperscript{\ensuremath{\bigstar}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 제목부 (1면): 국문제목, 영문제목, 국문저자, 영문저자,
%               Abstract(영문초록) → 요약(국문초록) → Key words (규정 5·12조)
%  일반논문: 양단 폭에 걸쳐 배치 / 단편논문(short): 1단 폭 안에 배치
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\maketitle}{%
  \if@shortpaper
    \kieee@maketitle@short
  \else
    \kieee@maketitle@full
  \fi
}

\newcommand{\kieee@maketitle@full}{%
  \twocolumn[%
    \begin{center}%
      {\fontsize{20}{25}\selectfont \@title\par}%
      \vspace{3mm}%
      {\fontsize{18}{22}\selectfont \@engtitle\par}%
      \vspace{6mm}%
      \if@review
        \vspace{14mm}%   % 심사용: 저자명 자동 삭제 (규정 11조)
      \else
        {\fontsize{12}{15}\selectfont \@author\par}%
        \vspace{3mm}%
        {\fontsize{12}{15}\selectfont \@engauthor\par}%
      \fi
      \vspace{7mm}%
      {\fontsize{11}{13}\selectfont\bfseries Abstract\par}%
      \vspace{2mm}%
      \parbox{15cm}{\fontsize{9}{13}\selectfont\quad\@engabstract}\par
      \vspace{4mm}%
      {\fontsize{11}{13}\selectfont\bfseries 요\hspace{1.5em}약\par}%
      \vspace{2mm}%
      \parbox{15cm}{\fontsize{9}{13}\selectfont\quad\@abstract}\par
      \vspace{4mm}%
      \parbox{15cm}{\fontsize{9}{12.5}\selectfont
        {\itshape Key words}\,:\ \@keywords}\par
      \vspace{3mm}%
    \end{center}%
  ]%
  \if@review\else\kieee@titlefootnote\fi
}

\newcommand{\kieee@maketitle@short}{%
  \begin{center}%
    {\fontsize{16}{21}\selectfont \@title\par}%
    \vspace{2.5mm}%
    {\fontsize{14}{18}\selectfont \@engtitle\par}%
    \vspace{4mm}%
    \if@review
      \vspace{10mm}%
    \else
      {\fontsize{12}{15}\selectfont \@author\par}%
      \vspace{2mm}%
      {\fontsize{12}{15}\selectfont \@engauthor\par}%
    \fi
    \vspace{4mm}%
    {\fontsize{11}{13}\selectfont\bfseries Abstract\par}%
  \end{center}%
  {\fontsize{9}{13}\selectfont\noindent\quad\@engabstract\par}%
  \vspace{3mm}%
  {\centering\fontsize{11}{13}\selectfont\bfseries 요\hspace{1.5em}약\par}%
  \vspace{2mm}%
  {\fontsize{9}{13}\selectfont\noindent\quad\@abstract\par}%
  \vspace{2.5mm}%
  {\fontsize{9}{12.5}\selectfont\noindent{\itshape Key words}\,:\ \@keywords\par}%
  \if@review\else\kieee@titlefootnote\fi
}

% 1면 하단 각주: 모든 정보를 영문으로 기재 (규정 18·19조)
%  * 소속(직위 포함) / ★ Corresponding author 연락처 / ※ Acknowledgment /
%  Manuscript received; revised; accepted / Open-Access 문구
\newcommand{\kieee@titlefootnote}{%
  \begin{figure*}[!b]
    \begingroup

    % 하단 정보 위 구분선
    \noindent\rule{\textwidth}{0.4pt}\par
    \vspace{1.5mm}

    \fontsize{8}{11}\selectfont

    \if\relax\detokenize\expandafter{\@affiliation}\relax\else
      \noindent\@affiliation\par
    \fi

    \if\relax\detokenize\expandafter{\@corresponding}\relax\else
      \noindent\ensuremath{\bigstar}\,Corresponding author\par
      \noindent\hspace*{0.9em}\@corresponding\par
    \fi

    \if\relax\detokenize\expandafter{\@acknowledgment}\relax\else
      \noindent ※\ Acknowledgment\par
      \noindent\hspace*{0.9em}\@acknowledgment\par
    \fi

    \if\relax\detokenize\expandafter{\@received}\relax\else
      \noindent Manuscript received \@received; revised \@revised;
      accepted \@accepted\par
    \fi

    \noindent\@openaccess\par
    \endgroup
  \end{figure*}%
}

% 1단
% \newcommand{\kieee@titlefootnote}{%
%   \begingroup
%   \renewcommand{\thefootnote}{}%
%   \long\def\@makefntext##1{\noindent ##1}%
%   \footnotetext{\fontsize{8}{11}\selectfont
%     \if\relax\detokenize\expandafter{\@affiliation}\relax\else
%       \@affiliation\par\fi
%     \if\relax\detokenize\expandafter{\@corresponding}\relax\else
%       \ensuremath{\bigstar}\,Corresponding author\par
%       \hspace*{0.9em}\@corresponding\par\fi
%     \if\relax\detokenize\expandafter{\@acknowledgment}\relax\else
%       ※\ Acknowledgment\par
%       \hspace*{0.9em}\@acknowledgment\par\fi
%     \if\relax\detokenize\expandafter{\@received}\relax\else
%       Manuscript received \@received; revised \@revised;
%       accepted \@accepted\par\fi
%     \@openaccess}%
%   \endgroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 그림/표 제목 (규정 14조)
%  그림·표 내용은 영문으로만 기재 / 그림 제목은 하단, 표 제목은 상단
%  영문 제목(Fig. n. / Table n.) 먼저, 국문 제목(그림 n. / 표 n.) 병기
%  국문 제목 끝에는 마침표를 붙이지 않음 (학회 양식: 마침표 삭제)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{caption}
\renewcommand{\figurename}{Fig.}
\renewcommand{\tablename}{Table}
\DeclareCaptionFont{kieeecaption}{\fontsize{9}{12}\selectfont}
\captionsetup{labelsep=period, justification=raggedright,
              singlelinecheck=false, font=kieeecaption, skip=3pt}

% \bicaption{English title.}{국문 제목} — 같은 번호로 영문(먼저)·국문 제목을 병기
\newcommand{\bicaption}[2]{%
  \caption{#1}%
  \begingroup
    \def\figurename{그림}\def\tablename{표}%
    \addtocounter{\@captype}{-1}%
    \caption{#2}%
  \endgroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 참고문헌: References, 반드시 영문, 본문 인용 순서대로 (규정 15조)
%  저널명·도서명·컨퍼런스명은 이탤릭체 / DOI는 부여된 경우에만 표기
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References 제목은 12pt (장 제목 서체보다 크게)
\renewcommand{\refname}{\fontsize{12}{15}\selectfont References}
% 긴 URL의 하이픈 위치 줄바꿈 허용 (website 항목이 단 폭을 넘지 않도록)
\AtBeginDocument{%
  \@ifundefined{UrlBreaks}{}{\g@addto@macro\UrlBreaks{\do\-}}%
  \@ifundefined{Urlmuskip}{}{\Urlmuskip=0mu plus 1mu\relax}}
\newcommand{\kieeebibliographyfontsize}{\fontsize{10}{13}\selectfont}
\let\kieee@thebibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \kieee@thebibliography{#1}%
  \kieeebibliographyfontsize
  \setlength{\itemsep}{1pt}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIOGRAPHY: 영문 작성, 마지막 장 (규정 20조)
%  심사용 논문·단편논문에서는 자동 생략
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{comment}

\newcommand{\kieee@biotitle}{%
  \par\vspace{7mm}%
  \noindent\makebox[\columnwidth]{%
    \rule[0.8ex]{0.22\columnwidth}{0.4pt}\hspace{1em}%
    {\setlength{\fboxsep}{3pt}%
     \framebox{\fontsize{10}{12}\selectfont\bfseries BIOGRAPHY}}%
    \hspace{1em}\rule[0.8ex]{0.22\columnwidth}{0.4pt}}%
  \par\vspace{4mm}}

\if@review
  \excludecomment{authorbiographies}
\else
  \if@shortpaper
    \excludecomment{authorbiographies}
  \else
    \newenvironment{authorbiographies}{\kieee@biotitle}{}
  \fi
\fi

% \begin{biography}[사진파일]{Gil-dong Hong (Member)} 약력(영문) \end{biography}
% 사진 크기 23x30mm; 사진파일 생략 시 빈 상자 표시
\newenvironment{biography}[2][]{%
  \par\noindent
  \begin{minipage}{\columnwidth}%
    \fontsize{9}{13}\selectfont
    \setlength{\parindent}{0pt}%
    \begin{minipage}[t]{24mm}%
      \vspace{0pt}%
      \if\relax\detokenize{#1}\relax
        \framebox[23mm][c]{\rule[-13.5mm]{0pt}{30mm}Photo}%
      \else
        \includegraphics[width=23mm,height=30mm]{#1}%
      \fi
    \end{minipage}\hspace{2mm}%
    \begin{minipage}[t]{\dimexpr\columnwidth-26mm-2mm\relax}%
      \vspace{0pt}%
      {\bfseries #2}\par
}{%
    \end{minipage}%
  \end{minipage}\par\vspace{5mm}}
