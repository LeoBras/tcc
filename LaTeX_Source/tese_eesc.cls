
%========================================================================
% Identificação
%========================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tese_eesc}[2009/10/28 v0.1 Classe Tese EESC - Teses Escola de Engenharia de São Carlos]

%========================================================================
% Declaração de opções
%========================================================================
%\AtEndOfClass{\input{teseeesctese.def}}
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption{tese}{
\newcommand{\titlepagespecificinfo}{\tesespecificinfo}
\def\@approvalspecificinfo{\teseapprovalspecificinfo}
}
\DeclareOption{qualidr}{
\newcommand{\titlepagespecificinfo}{\qualidrspecificinfo}
\def\@approvalspecificinfo{\qualidrapprovalspecificinfo}
}
\ProcessOptions\relax
%\newcommand{\titlepagespecificinfo}{\tesespecificinfo}
%\def\@approvalspecificinfo{\teseapproval}

%=========================================================================
% Herança da classe `memoir' e inclusão de pacotes e arquivos necessários
%=========================================================================
\LoadClass[a4paper,12pt,twoside,openright]{memoir}
\RequirePackage[english,brazilian]{babel}
\RequirePackage{tese_eesc_defs}
\input{tese_eesc_pt_BR.ldf}
\renewcommand{\chaptername}{Capítulo}
\renewcommand{\partname}{Parte}
\if@english
	\selectlanguage{english}
	\AtBeginDocument{\selectlanguage{english}}
\fi

%=========================================================================
% Margens do Texto
%=========================================================================

\setlrmarginsandblock{3cm}{2cm}{*}
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout

\setsecnumdepth{subsection}
\maxsecnumdepth{subsection}

%=========================================================================
% Espaçamento
%=========================================================================

\OnehalfSpacing % Espaçamento 1/2 (para duplo, \DoubleSpacing)
\chapterstyle{bianchi}

%=========================================================================
% Definição de autor(es), orientador, co-orientador e banca
%=========================================================================

\newcounter{teseeesc@authorcount}
\renewcommand{\author}[2]{
	\addtocounter{teseeesc@authorcount}{1}
	\expandafter\gdef\csname @author\alph{teseeesc@authorcount}last\endcsname{#1}
	\expandafter\gdef\csname @author\alph{teseeesc@authorcount}first\endcsname{#2}
	\expandafter\gdef\csname @author\alph{teseeesc@authorcount}\endcsname{#2 #1}
}

\DeclareRobustCommand{\advisor}[3][]{
	\gdef\@advisorlast{#2}
  \gdef\@advisorfirst{#3}
  \gdef\@advisor{#1~#3 #2}
}

\newcommand{\advisorinfo}[2]{%
	\gdef\@advisorinstitution{#1}
	\gdef\@advisortitleinfo{#2}
}

\newcommand{\advisorwidth}[1]{\gdef\@advisorwidth{#1}}
\advisorwidth{0.55\textwidth}

\DeclareRobustCommand{\coadvisor}[3][]{
	\gdef\@coadvisorlast{#2}
	\gdef\@coadvisorfirst{#3}
	\gdef\@coadvisor{#1~#3 #2}
}
\newcommand{\coadvisorinfo}[2]{
	\gdef\@coadvisorinstitution{#1}
	\gdef\@coadvisortitleinfo{#2}
}

\newcounter{teseeesc@examinercount}
\DeclareRobustCommand{\examiner}[3][]{
	\addtocounter{teseeesc@examinercount}{1}
	\expandafter\gdef\csname @examiner\alph{teseeesc@examinercount}last\endcsname{#2}
	\expandafter\gdef\csname @examiner\alph{teseeesc@examinercount}first\endcsname{#3}
	\expandafter\gdef\csname @examiner\alph{teseeesc@examinercount}\endcsname{#1~#3 #2}
}

\newcounter{teseeesc@examinerinfocount}
\newcommand{\examinerinfo}[2]{
	\addtocounter{teseeesc@examinerinfocount}{1}
  \expandafter\gdef\csname @examiner\alph{teseeesc@examinerinfocount}institution\endcsname{#1}
  \expandafter\gdef\csname @examiner\alph{teseeesc@examinerinfocount}titleinfo\endcsname{#2}
}

%=====================================================================
% Definição das palavras-chave (máx. 10)
%=====================================================================
\newcounter{kwcounter}
\newcommand{\keyword}[1]{
        \addtocounter{kwcounter}{1}
        \expandafter\gdef\csname keyw\alph{kwcounter}\endcsname{#1}
}
\newcommand{\@cipkw}{%
        \@ifundefined{keywa}{}{1.~\expandafter\MakeUppercase\keywa\@. }%
        \@ifundefined{keywb}{}{2.~\expandafter\MakeUppercase\keywb\@. }%
        \@ifundefined{keywc}{}{3.~\expandafter\MakeUppercase\keywc\@. }%
        \@ifundefined{keywd}{}{4.~\expandafter\MakeUppercase\keywd\@. }%
        \@ifundefined{keywe}{}{5.~\expandafter\MakeUppercase\keywe\@. }%
        \@ifundefined{keywf}{}{6.~\expandafter\MakeUppercase\keywf\@. }%
        \@ifundefined{keywg}{}{7.~\expandafter\MakeUppercase\keywg\@. }%
        \@ifundefined{keywh}{}{8.~\expandafter\MakeUppercase\keywh\@. }%
        \@ifundefined{keywi}{}{9.~\expandafter\MakeUppercase\keywi\@. }%
        \@ifundefined{keywj}{}{10.~\expandafter\MakeUppercase\keywj\@. }%
}
\newcommand{\@abstractkw}{%
        \@ifundefined{keywa}{}{\expandafter\MakeUppercase\keywa}%
        \@ifundefined{keywb}{}{, \keywb}%
        \@ifundefined{keywc}{}{, \keywc}%
        \@ifundefined{keywd}{}{, \keywd}%
        \@ifundefined{keywe}{}{, \keywe}%
        \@ifundefined{keywf}{}{, \keywf}%
        \@ifundefined{keywg}{}{, \keywg}%
        \@ifundefined{keywh}{}{, \keywh}%
        \@ifundefined{keywi}{}{, \keywi}%
        \@ifundefined{keywj}{}{, \keywj}%
}

%========================================================================
% Definição da capa, folha de rosto e folha de aprovação.
% Os dados específicos do tipo de trabalho (dissertação, tese, etc.) são
% informados definindo-se o comando \titlepagespecificinfo. Veja os
% arquivos .def incluídos com a classe.
%========================================================================

\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{120mm}
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{120mm}

\newcommand{\location}[2]{\gdef\@city{#1}\gdef\@state{#2}}
\renewcommand{\date}[3]{
	\gdef\@publmonth{#1}
	\gdef\@publyear{#2}
	\gdef\@publday{#3}}
\date{\monthname}{\number\year}

\location{S\~ao~Carlos}{SP}

% --------------------------------
% Definição Geral

\renewcommand{\maketitle}{%
	% Capa
	\@makecover
	% Folha de Rosto
	\@ifundefined{@deletexest}{\thetitlepage}{}
	\setcounter{page}{1}\thispagestyle{empty}\clearpage
	%	\if@openright\cleardoublepage\else\clearpage\fi%
	% Ficha Catalográfica
	\thispagestyle{empty} $~$ \clearpage
  % Folha de Aprovação
  \@makeapprovalpage
  %\@ifundefined{@approvalspecificinfo}{}{\@makeapprovalpage}
}

% --------------------------------
% Definição da Capa


\newcommand*{\titleGP}{\begingroup% Geometric Modeling
%\drop=0.1\textheight
\centering
\vspace*{\baselineskip}
\rule{\textwidth}{1.6pt}\vspace*{-\baselineskip}\vspace*{2pt}
\rule{\textwidth}{0.4pt}\\[\baselineskip]
{\LARGE CONUNDRUMS\\ AND \\[0.3\baselineskip]
PUZZLES}\\[0.2\baselineskip]
\rule{\textwidth}{0.4pt}\vspace*{-\baselineskip}\vspace{3.2pt}
\rule{\textwidth}{1.6pt}\\[\baselineskip]
\scshape
Selected and Expanded Papers from the Organisation Working
Conference on \\ Enigmas \\
Location, date from--to\par
\vspace*{2\baselineskip}
Edited by \\[\baselineskip]
{\Large FIRST EDITOR \\ SECOND EDITOR \\ THIRD EDITOR}\\
{\itshape Organisation \\ Address}\par
\vfill
{\scshape year} \\
{\large THE PUBLISHER}\par
\endgroup}





\newcommand{\@makecover}{%
  \@thecover%
%  \clearpage
%	\titleGP%
	\if@openright\cleardoublepage\else\clearpage\fi%
}

\newcommand{\@thecover}{%
	\thispagestyle{empty}
	\noindent\@covertopbox
  \vfill
	\@ifundefined{@deletexest}{}{%
		\@ifundefined{@advisor}{}{
    	\hspace*{\fill}\parbox[b]{\@advisorwidth}{\titlepageadvisorinfo}
			\vfill	
      }%
	}%
  \centerline{\@city}
	\centerline{\@publyear}
}

\def\@covertopbox{%
	\parbox[t]{\textwidth}{%
		\centering%
		\vbox to \titlepagewinvoffset{\titlepagetopinfo\vfill
		\@winbox
		}
	}
}

\newcommand{\titlepagetopinfo}{%
  {\scshape\ufrgs}\\
	{\scshape\ee}\\
	\@ifundefined{@depmt}{}{{\scshape\@depmt}\\}
	\@ifundefined{@course}{}{{\scshape\@course}\\}
%	\MakeUppercase{\ufrgs}\\
%	\MakeUppercase{\ee}\\
%	\@ifundefined{@depmt}{}{\MakeUppercase{\@depmt}\\}
%	\@ifundefined{@course}{}{\MakeUppercase{\@course}\\}
%	{\itshape\ufrgs}\\
%	{\itshape\ee}\\
%	\@ifundefined{@depmt}{}{{\itshape\@depmt}\\}
%	\@ifundefined{@course}{}{{\itshape\@course}\\}
}

\def\@winbox{%

	
	\parbox[b]{\titlepagewinwidth}{%
		\centering\vbox to \titlepagewinheight{%
			\vspace*{\fill}
			{\Large\scshape\textbf{\@authora}}\\
      \@ifundefined{@authorb}{}{\MakeUppercase{\textbf{\@authorb}}\\}%
      \@ifundefined{@authorc}{}{\MakeUppercase{\textbf{\@authorc}}\\}%
      \@ifundefined{@authord}{}{\MakeUppercase{\textbf{\@authord}}\\}%
      \vspace*{\fill}
    }
   }

%	\rule{\textwidth}{1.6pt}\vspace*{-\baselineskip}\vspace*{2pt}
%	\rule{\textwidth}{0.4pt}\\[\baselineskip]
	\parbox[b]{\titlepagewinwidth}{%
		\centering\vbox to \titlepagewinheight{%
			\vspace*{\fill}
      {\Large{\textbf{\@title}}\par}
			\vspace*{\fill}
    }
   }
%   \rule{\textwidth}{0.4pt}\vspace*{-\baselineskip}\vspace{3.2pt}
%	 \rule{\textwidth}{1.6pt}\\[\baselineskip]

}

\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\depmt}[1]{\gdef\@depmt{#1}}

% --------------------------------
% Definição da Folha de Rosto

\newcommand{\thetitlepage}{%
	\noindent\@titlepagetopbox
  \vfill
  \@ifundefined{titlepagespecificinfo}{}{
  	\hspace*{\fill}\makebox[.55\textwidth][l]{%
    	\parbox[b]{8.5cm}{\titlepagespecificinfo}}
    \vfill}
  \@ifundefined{@advisor}{}{
  	\hspace*{\fill}\parbox[b]{\@advisorwidth}{\titlepageadvisorinfo}
    \vfill}
  \centerline{\@city}
	\centerline{\@publyear}
}

%\newcommand{\subject}[1]{\gdef\@subject{#1}}


\def\@titlepagetopbox{%
	\parbox[t]{\textwidth}{%
		\centering%
		\vbox to \titlepagewinvoffset{\@winbox}
	}
}

\newcommand{\titlepageadvisorinfo}{%
	\@ifundefined{@advisor}{}{\vfill\MakeUppercase{\advisorname}: \@advisor}
	\@ifundefined{@coadvisor}{}{\\[6ex]\MakeUppercase{\coadvisorname}: \@coadvisor}
}

\def\tesespecificinfo{%
	Trabalho de Conclusão de curso apresentado ao
	\ppgee\ da Escola de Engenharia de São Carlos como parte dos requisitos para a
	obten{\c{c}}{\~a}o do t\'{\i}tulo de Engenheiro Eletricista.\\
		
	\'Area de concentra\c{c}\~ao: Sistemas Embarcados
}%

\def\qualidrspecificinfo{%
	Qualificação do Trabalho de Conclusão de Curso apresentado ao
	\ppgee\ da Escola de Engenharia de São Carlos como parte dos requisitos para a
	obten{\c{c}}{\~a}o do t\'{\i}tulo de Engenheiro Eletricista.\\
		
	\'Area de concentra\c{c}\~ao: Sistemas Embarcados
}%


% ---------------------
% Folha de Aprovação

\newcommand{\@makeapprovalpage}{%
	\@ifundefined{@deletexest}{\@theapprovalpage}{\@approvalspecificinfo}
	\if@openright\cleardoublepage\else\clearpage\fi%
}

\newcommand{\@theapprovalpage}{%
	\begin{center}{\Large\scshape Folha de Aprovação}\end{center} \par
	\vfill
	\thispagestyle{empty}
	Autor: \@authora \par
  Título: \@title
  \vfill
	\begin{center}
  \@ifundefined{@approvalspecificinfo}{}{
  	\hspace*{\fill}\makebox[.625\textwidth][l]{\parbox[b]{10cm}{\@approvalspecificinfo}}
  	\vfill}
	\end{center}
	\hspace*{\fill}\parbox[b]{1.0\textwidth}{\examinername:}
	\vfill
	\@approvalpageexaminerinfo
  \vfill\vfill
  \hfill\@city,~\@publday~de~\delet@date.
}

\def\teseapprovalspecificinfo{%
	Monografia apresentada ao Programa de Engenharia El\'etrica da Escola de Engenharia de S\~ao Carlos da Universidade de S\~ao Paulo para a obten\c{c}\~ao do título de Engenheiro Eletricista e julgada adequada pela banca examinadora.\\
	
	\'Area de Concentra\c{c}\~ao: Sistemas Embarcados}
	
\def\qualidrapprovalspecificinfo{%
	Qualificação apresentada ao Departamento de Engenharia El\'etrica da Escola de Engenharia de S\~ao Carlos da Universidade de S\~ao Paulo para a obten\c{c}\~ao do título de Engenheiro Eletricista e julgada adequada pela banca examinadora.\\
	
	\'Area de Concentra\c{c}\~ao: Sistemas Embarcados}	

\newcommand{\@approvalpageadvisorinfo}{%
        \@ifundefined{@advisor}{}{%
		\vfill
		\advisorname: \hrulefill\\
		\@advisor, \@advisorinstitution\\
		\@advisortitleinfo 
	}
}

\newcommand{\@approvalpageexaminerinfo}{%
	
	\vfill
	\noindent \@advisor ~(Orientador) \\
	\@advisorinstitution \\
	Assinatura: \hrulefill \\
	
	\noindent \@examinera \\
	\@examinerainstitution \\
	Assinatura: \hrulefill \\
%	\@examineratitleinfo\\

	\@ifundefined{@examinerb}{}{%
		\noindent \@examinerb \\
		\@examinerbinstitution \\
		Assinatura: \hrulefill \\}%
		
  \@ifundefined{@examinerc}{}{%
		\noindent \@examinerc \\
		\@examinercinstitution \\
		Assinatura: \hrulefill \\}%
		
	\@ifundefined{@examinerd}{}{%
		\noindent \@examinerd \\
		\@examinerdinstitution \\
		Assinatura: \hrulefill \\}%
		
	\@ifundefined{@examinere}{}{%
		\noindent \@examinere \\
		\@examinereinstitution \\
		Assinatura: \hrulefill \\}%
		
}


%======================================================================
% Dedicatória, Agradecimentos e Epígrafe
%======================================================================


\newcommand{\epigrafe}[2]{\gdef\@epigrafe{#1}\gdef\@epigautor{#2}\epigpage}

\newcommand{\epigpage}{
	\if@openright\cleardoublepage\else\clearpage\fi
	\thispagestyle{empty}
	\vspace*{\fill}\vspace*{\fill}\vspace*{\fill}
	\hspace*{\fill}
	\begin{minipage}[r]{0.8\textwidth}
	\begin{flushright}
	{\emph{\@epigrafe} }
	\vspace{12pt} \\
	\@epigautor
	\end{flushright}
	\end{minipage}
	\vspace*{\fill}
}

\newcommand{\dedicatoria}[1]{\gdef\@dedicatoria{#1}\dedicpage}

\newcommand{\dedicpage}{
	\if@openright\cleardoublepage\else\clearpage\fi
	\thispagestyle{empty}
	\vspace*{\fill}\vspace*{\fill}
	\hspace*{\fill}
  \makebox[0.5\textwidth][l]{\parbox[b]{0.5\textwidth}{\Large\itshape\@dedicatoria}}
	\vspace*{\fill}
}

\newenvironment{agradecimentos}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
	\chapter*{Agradecimentos}
	\thispagestyle{empty}
	$~$\par
}{
	\par\vspace{2ex}
}


%========================================================================
% Resumo (abstract) e Abstract (englishabstract)
%========================================================================

\renewenvironment{abstract}{\chapter*{\abstractname}}{%
	\par\vspace{2ex} %\vfill
	\noindent\textbf{\keywordsname: \@abstractkw.}
	\thispagestyle{empty}
}

\newenvironment{englishabstract}[1]{%
        \if@openright\cleardoublepage\else\clearpage\fi%
        \gdef\@englishkeywords{#1}%
        \iflanguage{english}{\begin{otherlanguage}{brazilian}}{
                \begin{otherlanguage}{english}}
                \chapter*{Abstract}
}{
        \par\vspace{2ex} %\vfill
        \noindent\textbf{Keywords: \@englishkeywords.}
        \end{otherlanguage}
        \thispagestyle{empty}
        \if@openright\cleardoublepage\else\clearpage\fi
}

%======================================================================
% Ajuste do sumário (nada indentado) 
%======================================================================
\renewcommand{\tableofcontents}{%
	\chapter*{\contentsname}
	\thispagestyle{empty}
	\pagestyle{empty}
	\@starttoc{toc}
	\clearpage}
	
\renewcommand{\listoffigures}{%
	\chapter*{\listfigurename}
	\thispagestyle{empty}
	\pagestyle{empty}
	\@starttoc{lof} 
	\clearpage}	
	
\renewcommand{\listoftables}{%
	\chapter*{\listtablename}
	\thispagestyle{empty}
	\pagestyle{empty}
	\@starttoc{lot} 
	\clearpage}		
	

%=======================================================================
% Ajuste do cabeçalho e rodapé
%=======================================================================

\renewcommand*{\chaptermark}[1]{\thispagestyle{empty}\markboth{\thechapter. #1}{\thechapter. #1}\chaptermarkeesc}
\renewcommand*{\partmark}[1]{\thispagestyle{empty}\markboth{\thechapter. #1}{\thechapter. #1}\chaptermarkeesc}
\renewcommand*{\sectionmark}[1]{\markright{\thesection. #1}}
\renewcommand*{\bibmark}{\thispagestyle{empty}\markboth{\scshape Referências Bibliográficas}{\scshape Referências Bibliográficas}\chaptermarkeesc}

\newcommand{\chaptermarkeesc}{
\makepagestyle{myheadings}
\makeheadrule{myheadings}{\textwidth}{\normalrulethickness}
\makeevenhead{myheadings}{\thepage}{}{\scshape\leftmark} % small caps
\makeoddhead{myheadings}{\scshape\rightmark}{}{\thepage}
\pagestyle{myheadings}
}

% ==========================================
% APÊNDICES E ANEXOS
% ==========================================

\newcommand{\apendices}{
\appendix
\renewcommand{\appendixpagename}{Apêndices}
\renewcommand{\appendixtocname}{Apêndices}
\appendixpage
}

\newcommand{\anexos}{
\setcounter{chapter}{0}
\renewcommand{\appendixname}{Anexo}
\renewcommand{\appendixpagename}{Anexos}
\renewcommand{\appendixtocname}{Anexos}
\appendixpage
}

\renewcommand{\cftpartnumwidth}{0.75cm}
\renewcommand{\cftpartname}{Parte\space}

% ==========================================
% Lista de Abreviaturas e Símbolos
% ==========================================

\newenvironment{listofabbrv}[1]{
        \chapter*{Lista de Abreviaturas}
        \SingleSpacing
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
        \OnehalfSpacing
}
\newenvironment{listofsymbols}[1]{
        \chapter*{Lista de Símbolos}
        \SingleSpacing
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
        \OnehalfSpacing
}
