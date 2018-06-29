#! @System LiftAlongMonomorphism

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := GSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
N := GSet( S3, [ 2, 0, 2, 0 ] );
#! <An object in Skeletal Category of G-Sets>
O := GSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau := MapOfGSets( M, [ [ [ 1, (1,2), 1 ] ], [], [], [] ], N );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( tau );
#! true
iota := MapOfGSets( O, [ [ [ 2, (), 1 ], [ 1, (1,3,2), 1 ] ], [], [], [] ], N );
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
