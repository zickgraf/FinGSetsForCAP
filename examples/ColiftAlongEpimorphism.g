#! @System ColiftAlongEpimorphism

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := GSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
N := GSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
O := GSet( S3, [ 2, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau := MapOfGSets( M, [ [ [ 1, (1,2), 1 ], [ 1, (), 3 ] ], [], [], [] ], O );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( tau );
#! true
epsilon := MapOfGSets( M, [ [ [ 1, (1,2,3), 1 ], [ 1, (1,2), 3 ] ], [], [], [] ], N );
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
