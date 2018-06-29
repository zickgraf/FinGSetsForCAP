#
# SkeletalGSetsForCAP: The elementary topos of skeletal finite G-sets
#
# Declarations
#

#! @Chapter The category of skeletal finite G-sets

#! @Section GAP Categories

#! @Description
#! The GAP category of objects in the category
#! of skeletal finite G-sets.
#! @Arguments object
DeclareCategory( "IsSkeletalGSet",
                 IsCapCategoryObject and IsCellOfSkeletalCategory );

#! @Description
#! The GAP category of morphisms in the category
#! of skeletal finite G-sets.
#! @Arguments object
DeclareCategory( "IsSkeletalGSetMap",
                 IsCapCategoryMorphism and IsCellOfSkeletalCategory );

#! @Section Attributes

#! @Description
#!  The &GAP; set of the list used to construct a finite $G$-set <A>Omega</A>, i.e.,
#!  <C>AsList( GSet( G, <A>L</A> ) ) = <A>L</A></C>.
#! @Arguments Omega
#! @Returns a &GAP; set
DeclareAttribute( "AsList",
        IsSkeletalGSet );

#! @Description
#!  The group $G$ underlying the $G$-set <A>Omega</A>.
#! @Arguments Omega
#! @Returns a group
DeclareAttribute( "UnderlyingGroup",
        IsSkeletalGSet );

#! @Description
#!  The table of marks of the group $G$ underlying the $G$-set <A>Omega</A>.
#! @Arguments Omega
#! @Returns a table of marks
DeclareAttribute( "TableOfMarks",
        IsSkeletalGSet );

#! @Description
#!  The number of conjugacy classes of subgroups of the group underlying the $G$-set <A>Omega</A>.
#! @Arguments Omega
#! @Returns a positive integer
DeclareAttribute( "NrConjugacyClassesOfSubgroups",
        IsSkeletalGSet );

#! @Section Constructors

#! @Description
#!  Construct an object in the skeletal category of G sets
#!  out of the group <A>G</A> and a list <A>L</A>, i.e.,
#!  an object in the &CAP; category <C>SkeletalGSets</C>.
#! @Arguments G, L
#! @Returns a &CAP; object
DeclareOperation( "GSet",
        [ IsGroup, IsList ] );
#! @InsertSystem GSet

#! @Description
#!  Construct a map $\phi \colon$<A>s</A>$\to$<A>t</A> of the skeletal G-sets <A>s</A> and <A>t</A>,
#!  i.e., a morphism in the &CAP; category <C>SkeletalGSets</C>, where <A>G</A>
#!  is a list of lists describing the graph of $\phi$.
#! @Arguments s, G, t
#! @Returns a &CAP; morphism
DeclareOperation( "MapOfGSets",
        [ IsSkeletalGSet, IsList, IsSkeletalGSet ] );
#! @InsertSystem  MapOfGSets

#! @Description
#! The argument is a group $G$.
#! The output is the skeletal category of finite $G$-Sets.
#! @Returns a category
#! @Arguments G
DeclareAttribute( "SkeletalGSets",
                  IsGroup );

#! @Section Tools

