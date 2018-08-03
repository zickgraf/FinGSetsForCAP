#! @System SkeletalLiftAlongMonomorphism

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
N := FinGSet( S3, [ 2, 0, 2, 0 ] );
#! <An object in Skeletal Category of G-Sets>
O := FinGSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau := MapOfFinGSets( M, [ [ [ 1, (1,2), 1 ] ], [], [], [] ], N );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( tau );
#! true
iota := MapOfFinGSets( O, [ [ [ 2, (), 1 ], [ 1, (1,3,2), 1 ] ], [], [], [] ], N );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( iota );
#! true
IsMonomorphism( iota );
#! true
u := LiftAlongMonomorphism( iota, tau );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( u );
#! true
tau = PreCompose( u, iota );
#! true

#! @EndExample
