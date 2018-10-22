#
# FinGSetsForCAP: Reconstruction
#
# Declarations
#

#! @Chapter Reconstructing G from the category of skeletal finite G-sets

#! @Section Reconstruction Tools

#! @Description
#!  @LatexOnly See \hyperref[rem:EndAsEqualizer]{Remark~\ref*{rem:EndAsEqualizer}}.
#! @Arguments C, HomC, ForgetfulFunctor, IndexSet
DeclareGlobalFunction( "EndAsEqualizer" );

#! @Description
#!  @LatexOnly See \hyperref[rem:EndByLifts]{Remark~\ref*{rem:EndByLifts}}.
#! @Arguments C, HomC, ForgetfulFunctor, Objects
DeclareGlobalFunction( "EndByLifts" );

#! @Description
#!  @LatexOnly See \hyperref[rem:ReconstructTableOfMarks]{Remark~\ref*{rem:ReconstructTableOfMarks}}.
#! @Arguments C, MinimalGeneratingSet, Decompose
DeclareGlobalFunction( "ReconstructTableOfMarks" );

#! @Description
#!  The finite set $\mathrm{Hom}_{\mathrm{SkeletalFinGSets}}( S, T )$.
#! @Arguments S, T
#! @Returns a finite set (see <C>FinSetsForCAP</C>)
DeclareGlobalFunction( "HomSkeletalFinGSets" );

#! @Description
#!  The forgetful functor SkeletalFinGSets $\rightarrow$ SkeletalFinSets.
#! @Arguments G
#! @Returns a functor SkeletalFinGSets $\rightarrow$ SkeletalFinSets
DeclareAttribute( "ForgetfulFunctorSkeletalFinGSets",
        IsGroup );

#! @Description
#!  The input is a &CAP; category <C>C</C> which is equivalent to the category of skeletal finite G-sets for some group $G$,
#!  a function <C>HomC</C> computing homs in <C>C</C> (e.g. <C>HomSkeletalFinGSets</C>),
#!  a generating set of <C>C</C>, and
#!  a function computing ends (e.g. <C>EndAsEqualizer</C> or <C>EndByLifts</C>).
#!  The output is a group isomorphic to $G$.
#! @Arguments C, HomC, ForgetfulFunctor, GeneratingSet, EndImplementation
#! @Returns a group
DeclareGlobalFunction( "ReconstructGroup" );
