#
# FinGSetsForCAP: The elementary topos of (skeletal) finite G-sets
#
# Declarations
#

#! @Chapter The category of skeletal finite $G$-sets

#! @Section GAP Categories

#! @Description
#! The GAP category of objects in the category
#! of skeletal finite $G$-sets.
#! @Arguments object
DeclareCategory( "IsSkeletalFinGSet",
                 IsCapCategoryObject and IsCellOfSkeletalCategory );

#! @Description
#! The GAP category of morphisms in the category
#! of skeletal finite $G$-sets.
#! @Arguments object
DeclareCategory( "IsSkeletalFinGSetMap",
                 IsCapCategoryMorphism and IsCellOfSkeletalCategory );

#! @Section Attributes

#! @Description
#!  The &GAP; set of the list used to construct a finite $G$-set <A>Omega</A>, i.e.,
#!  <C>AsList( FinGSet( G, <A>L</A> ) ) = <A>L</A></C>.
#! @Arguments Omega
#! @Returns a &GAP; set
DeclareAttribute( "AsList",
        IsSkeletalFinGSet );

#! @Description
#!  The group $G$ underlying the finite $G$-set <A>Omega</A>.
#! @Arguments Omega
#! @Returns a group
DeclareAttribute( "UnderlyingGroup",
        IsSkeletalFinGSet );

#! @Section Constructors

#! @Description
#!  Construct a skeletal finite $G$-set
#!  out of the group <A>G</A> and a list <A>L</A>, i.e.,
#!  an object in the &CAP; category <C>SkeletalFinGSets</C>.
#! @Arguments G, L
#! @Returns a &CAP; object
DeclareOperation( "FinGSet",
        [ IsGroup, IsList ] );
#! @InsertSystem FinGSet

#! @Description
#!  Construct a map $\phi \colon$<A>s</A>$\to$<A>t</A> of the skeletal finite $G$-sets <A>s</A> and <A>t</A>,
#!  i.e., a morphism in the &CAP; category <C>SkeletalFinGSets</C>, where <A>G</A>
#!  is a list of lists describing the graph of $\phi$.
#! @Arguments s, G, t
#! @Returns a &CAP; morphism
DeclareOperation( "MapOfFinGSets",
        [ IsSkeletalFinGSet, IsList, IsSkeletalFinGSet ] );
#! @InsertSystem  MapOfFinGSets

#! @Description
#! The argument is a group $G$.
#! The output is the category of skeletal finite $G$-Sets.
#! @Returns a category
#! @Arguments G
DeclareAttribute( "SkeletalFinGSets",
                  IsGroup );

#! @Section Tools

