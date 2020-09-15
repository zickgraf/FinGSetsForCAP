#
# FinGSetsForCAP: The elementary topos of (skeletal) finite G-sets
#
# This file is a script which compiles the package manual and prints overfull hbox warnings.
#
if fail = LoadPackage( "AutoDoc", "2019.05.20" ) then
    
    Error( "AutoDoc version 2019.05.20 or newer is required." );
    
fi;

AutoDoc( rec(
    dir := "doc_tmp/",
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc" ],
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage[T1]{fontenc}
                \usepackage[british]{babel}
                \usepackage{microtype}
                \usepackage{amsmath}
                \usepackage{calc}
                \usepackage{amsthm}
                \usepackage{amssymb}
                \usepackage[dvipsnames]{xcolor}
                \usepackage{hyperref}
                \usepackage[linesnumbered,ruled,vlined]{algorithm2e}
                \usepackage{cite}
                \usepackage{url}
                \usepackage{tikz}
                \usetikzlibrary{shapes,arrows,matrix}
                \usepackage{tikz-cd}
                \usepackage{makeidx}
                \usepackage{listings}
                \usepackage[scaled]{beramono}
                \usepackage[figure]{hypcap}
                \renewcommand{\hypcapspace}{2\baselineskip}
                \usepackage{mathtools}
                \usepackage{faktor}
                \DeclareMathOperator{\Stab}{Stab}
                \DeclareMathOperator{\fix}{fix}
                \DeclareMathOperator{\coeq}{coeq}
                \DeclareMathOperator{\im}{im}
                \DeclareMathOperator{\rank}{rank}
                \DeclareMathOperator{\CartProdExt}{CartProdExt}
                \DeclareMathOperator{\End}{End}
                \DeclareMathOperator{\Hom}{Hom}
                \DeclareMathOperator{\op}{op}
                \DeclareMathOperator{\id}{id}
                \DeclareMathOperator{\Obj}{Obj}
                \usepackage{ifthen}
                % use \ell instead of l everywhere
                \mathcode`l="8000
                \begingroup
                \makeatletter
                \lccode`\~=`\l
                \DeclareMathSymbol{\lsb@l}{\mathalpha}{letters}{`l}
                \lowercase{\gdef~{\ifnum\the\mathgroup=\m@ne \ell \else \lsb@l \fi}}%
                \endgroup
                % Many thanks to https://tex.stackexchange.com/questions/22466/how-to-convince-fancyvrb-to-give-overfull-warnings/534486#534486
                \makeatletter
                \def\FV@ListProcessLine#1{%
                  \hbox to \hsize{%
                    \kern\leftmargin
                    \hbox to \linewidth{%
                      \FV@LeftListNumber
                      \FV@LeftListFrame
                      \FancyVerbFormatLine{#1}\hfil % change \hss to \hfil
                      \FV@RightListFrame
                      \FV@RightListNumber}%
                    \hss}}
                \makeatother
            """,
        ),
    ),
    scaffold := rec(
        entities := [ "homalg", "CAP" ],
    ),
) );

QUIT;
