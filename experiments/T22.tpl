\documentclass[a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage[polish]{babel}
\usepackage{polski}
\usepackage[version=4]{mhchem}
\usepackage{bm}
\usepackage{cancel}
\usepackage[most]{tcolorbox}
%\usepackage{palatino}
\usepackage{pgfplotstable}
\usepackage{pgfplots}
\pgfplotsset{compat=1.14}
\usepackage{tikz}
\usepackage[margin=2cm]{geometry}
\usepackage{fontspec,xcolor}
\colorlet{on}{red}
\colorlet{off}{gray!10}
\usepackage{ragged2e}
\usepackage{pgffor}
\usepackage{subcaption}
\usepackage{multicol}
\usepackage{media9}
\usepackage{tikz-3dplot}
\usepackage{tkz-euclide}
\usepackage[pdfauthor={Malgorzata Florek-Wojciechowska},
pdftitle={},
pdfproducer={Latex}]{hyperref}
\usepackage{fancyhdr}
\pagestyle{fancy}
\cfoot{\VAR{cfoot}}
\rhead{Zestaw nr \num[round-mode=places,round-precision=0]{\VAR{indeks}}}
\renewcommand{\footrulewidth}{0.4pt}
\lhead{Wyznaczanie ciepła topnienia lodu i zmian entropii w układzie}
\makeatletter
\newcommand{\angleMark}[4][.5cm]{%
    \pgfmathanglebetweenpoints{\pgfpointanchor{#3}{center}}
                              {\pgfpointanchor{#2}{center}}
    \let\my@angleA\pgfmathresult
    \pgfmathanglebetweenpoints{\pgfpointanchor{#3}{center}}
                              {\pgfpointanchor{#4}{center}}
    \let\my@angleB\pgfmathresult
    \pgfmathparse{int(abs(\my@angleA-\my@angleB))}
    \ifnum\pgfmathresult>180
%     \node at ($(#2) + (-2,-2)$) {$\my@angleA , \my@angleB$};
      \pgfmathparse{int(\my@angleA-180)}
      \ifnum\pgfmathresult>0
	\pgfmathsetmacro\my@angleA{\my@angleA-360}
      \else
	\pgfmathsetmacro\my@angleB{\my@angleB-360}
      \fi
    \fi
    \filldraw[angleMark] (#3) -- ($(#3)!#1!(#2)$)
      arc (\my@angleA:\my@angleB:#1) -- cycle;
    % put the angle in \pgfmathresult
    \pgfmathparse{abs(\my@angleA-\my@angleB)}
}
\makeatother
\newcommand{\pgfextractangle}[3]{%
	\pgfmathanglebetweenpoints{\pgfpointanchor{#2}{center}}
	{\pgfpointanchor{#3}{center}}
	\global\let#1\pgfmathresult
}

\usetikzlibrary{patterns,calc,arrows,arrows.meta,decorations.pathmorphing,decorations.pathreplacing, intersections, decorations.text, spy}
 \usetikzlibrary{
	pgfplots.colorbrewer,
}

\usepackage{siunitx}
\usepackage{animate}
\usepackage{ifthen}

\newcommand{\tp}{\VAR{tp}}
\newcommand{\tk}{\VAR{tk}}
\newcommand{\deltaT}{0.01}

\newcommand{\kalorymetr}[1]{
\begin{tikzpicture}[scale=0.9, font=\normalsize, y=25.5]
%		\draw[white] (-3,-5) rectangle (5,15);
\begin{scope}
\pgfmathparse{\tk+((\tp-\tk)/(300*\deltaT))*\deltaT*abs(#1-300)}
\edef\temperatura{\pgfmathresult}

\draw [rounded corners=1] (2.3,5) rectangle (2.7,28);
\draw (2.45,5) rectangle (2.55,27.5);
\draw[fill=red, rounded corners=2] (2.42,5) rectangle (2.58,3.5);
%
\draw[fill=red] (2.45,5) rectangle (2.55,\temperatura);
\foreach \ii in {10,11,...,27}
{\draw[thick] (2.45,\ii) -- (2.7,\ii) node[right] {\ii};
}
\foreach \ii in {10.2, 10.4, ..., 26.8}
{\draw[thin] (2.45,\ii) -- (2.63,\ii);
}
\end{scope}
\draw[fill=gray] [rounded corners=3] (-2,0) rectangle ++(9,8.5);
	\end{tikzpicture}%
}

 \newcommand{\kostka}[1]{
 	\begin{tikzpicture}[scale=0.9, font=\normalsize, y=25.5]
 		%		\draw[white] (-3,-5) rectangle (5,15);
 		\begin{scope}
 			\draw [rounded corners=1] (2.3,5) rectangle (2.7,28);
 			\draw (2.45,5) rectangle (2.55,27.5);
 			\draw[fill=red, rounded corners=2] (2.42,5) rectangle (2.58,3.5);
 			%
 			\draw[fill=red] (2.45,5) rectangle (2.55,\tp);
\foreach \ii in {10,11,...,27}
{\draw[thick] (2.45,\ii) -- (2.7,\ii) node[right] {\ii};
}
\foreach \ii in {10.2, 10.4, ..., 26.8}
{\draw[thin] (2.45,\ii) -- (2.63,\ii);
}
 		\end{scope}
 		\pgfmathparse{10.5-#1/5}
 	\edef\yy{\pgfmathresult}

 	\draw[fill=cyan!50, opacity=0.9] [rounded corners=3] (-0.8,\yy) rectangle ++(1,1);

 		\draw[fill=gray, opacity=0.1] [rounded corners=3] (-2,0) rectangle ++(9,8.5);
 		 	 \draw[pattern=crosshatch dots, pattern color= cyan, opacity=0.4] [rounded corners=3] (-2,0) rectangle ++(9,5.5);
 	\end{tikzpicture}%
 }

\begin{document}
\begin{figure}
	\centering
%	\begin{animateinline}[label=st2,controls=play]{5}
	\begin{animateinline}[label=st2,controls=play, timeline=timeline.txt]{10}
		\multiframe{20}{iFrame=0+1}{\kostka{\iFrame}}
	\newframe
		\multiframe{400}{iFrame=0+1}{\kalorymetr{\iFrame}}
	\end{animateinline}
	\caption{Symulacja procesu roztapiania kostki lodu o masie $m_l=$ \num[round-mode=places,round-precision=2]{\VAR{ml}} \si{g} w wodzie o masie $m_w=$ \num[round-mode=places,round-precision=2]{\VAR{mw}} \si{g} zamkniętej w kalorymetrze o masie $m_k=$ \num[round-mode=places,round-precision=2]{\VAR{mk}} \si{g} ($\Delta m=0.01$ \si{g}). Temperatura początkowa kostki lodu wynosi $0$\si{\degreeCelsius}. Kliknięcie obrazka startuje eksperyment (wrzucenie kostki lodu do kalorymetru).}
\end{figure}
\end{document}