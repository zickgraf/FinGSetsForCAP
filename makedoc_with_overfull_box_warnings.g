#
# FinGSetsForCAP
#
# This file is a script which compiles the package manual and prints overfull hbox warnings.
#
if fail = LoadPackage("AutoDoc", "2016.02.16") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;

AutoDoc( 
        rec(
            scaffold := rec( gapdoc_latex_options := rec( 
                             LateExtraPreamble := Concatenation(
                                                  "\\usepackage[T1]{fontenc}",
                                                  "\\usepackage[british]{babel}",
                                                  "\\usepackage{microtype}",
                                                  "\\usepackage{amsmath}",
                                                  "\\usepackage{calc}",
                                                  "\\usepackage{amsthm}",
                                                  "\\usepackage{amssymb}",
                                                  "\\usepackage[dvipsnames]{xcolor}",
                                                  "\\usepackage{hyperref}",
                                                  "\\usepackage[linesnumbered,ruled,vlined]{algorithm2e}",
                                                  "\\usepackage{cite}",
                                                  "\\usepackage{url}",
                                                  "\\usepackage{tikz}",
                                                  "\\usetikzlibrary{shapes,arrows,matrix}",
                                                  "\\usepackage{tikz-cd}",
                                                  "\\usepackage{makeidx}",
                                                  "\\usepackage{listings}",
                                                  "\\usepackage[scaled]{beramono}",
                                                  "\\usepackage[figure]{hypcap}",
                                                  "\\renewcommand{\\hypcapspace}{2\\baselineskip}",
                                                  "\\usepackage{mathtools}",
                                                  "\\usepackage{faktor}",
                                                  "\\DeclareMathOperator{\\Stab}{Stab}",
                                                  "\\DeclareMathOperator{\\fix}{fix}",
                                                  "\\DeclareMathOperator{\\coeq}{coeq}",
                                                  "\\DeclareMathOperator{\\im}{im}",
                                                  "\\DeclareMathOperator{\\rank}{rank}",
                                                  "\\DeclareMathOperator{\\CartProdExt}{CartProdExt}",
                                                  "\\DeclareMathOperator{\\End}{End}",
                                                  "\\DeclareMathOperator{\\Hom}{Hom}",
                                                  "\\DeclareMathOperator{\\op}{op}",
                                                  "\\DeclareMathOperator{\\id}{id}",
                                                  "\\DeclareMathOperator{\\Obj}{Obj}",
                                                  "\\usepackage{ifthen}",
                                                  # use \ell instead of l everywhere
                                                  "\\mathcode`l=\"8000\\begingroup\\makeatletter\\lccode`\\~=`\\l\\DeclareMathSymbol{\\lsb@l}{\\mathalpha}{letters}{`l}\\lowercase{\\gdef~{\\ifnum\\the\\mathgroup=\\m@ne \\ell \\else \\lsb@l \\fi}}\\endgroup",
                                                  "\\RecustomVerbatimEnvironment{Verbatim}{BVerbatim}{}",
                                                  "" ) ),
                             entities := [ "GAP4", "CAP" ],
                             ),
            
            autodoc := rec( files := [ "doc/Doc.autodoc" ] ),

            maketest := rec( folder := ".",
                             commands :=
                             [ "LoadPackage( \"FinGSetsForCAP\" );",
                             ],
                           ),
            )
);

QUIT;
