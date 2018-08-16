#! @System SkeletalIdentityMorphism

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 1, 2, 1, 2 ] );
#! <An object in SkeletalFinGSets>
iota := IdentityMorphism( M );
#! <An identity morphism in SkeletalFinGSets>
IsWellDefined( iota );
#! true
IsEpimorphism( iota );
#! true
Display( iota );
#! [ [ [ 1, (), 1 ] ],
#!   [ [ 1, (), 2 ], [ 2, (), 2 ] ],
#!   [ [ 1, (), 3 ] ],
#!   [ [ 1, (), 4 ], [ 2, (), 4 ] ] ]

#! @EndExample
