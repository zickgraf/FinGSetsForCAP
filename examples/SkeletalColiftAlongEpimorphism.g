#! @System SkeletalColiftAlongEpimorphism

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
N := FinGSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
O := FinGSet( S3, [ 2, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau := MapOfFinGSets( M, [ [ [ 1, (1,2), 1 ], [ 1, (), 3 ] ], [], [], [] ], O );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( tau );
#! true
epsilon := MapOfFinGSets( M, [ [ [ 1, (1,2,3), 1 ], [ 1, (1,2), 3 ] ], [], [], [] ], N );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( epsilon );
#! true
IsEpimorphism( epsilon );
#! true
u := ColiftAlongEpimorphism( epsilon, tau );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( u );
#! true
tau = PreCompose( epsilon, u );
#! true

#! @EndExample
