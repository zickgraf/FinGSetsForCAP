#! @System IdentityMorphism

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := GSet( S3, [ 1, 2, 1, 2 ] );
#! <An object in Skeletal Category of G-Sets>
iota := IdentityMorphism( M );
#! <An identity morphism in Skeletal Category of G-Sets>
IsWellDefined( iota );
#! true
IsEpimorphism( iota );
#! true
AsList( iota );
#! [ [ [ 1, (), 1 ] ], [ [ 1, (), 2 ], [ 2, (), 2 ] ], [ [ 1, (), 3 ] ], [ [ 1, (), 4 ], [ 2, (), 4 ] ] ]

#! @EndExample
