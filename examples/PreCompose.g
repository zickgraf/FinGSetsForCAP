#! @System PreCompose

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
S := GSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
R := GSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
T := GSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
psi1 := MapOfGSets( S, [ [ [ 1, (1,2), 1 ] ], [], [], [] ], R );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi1 );
#! true
psi2 := MapOfGSets( R, [ [ [ 1, (1,2,3), 1 ] ] , [], [], [] ] , T );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi2 );
#! true
PreCompose( psi1, psi2 );
#! <A morphism in Skeletal Category of G-Sets>
phi := PreCompose( psi1, psi2 );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( phi );
#! true
Display( phi );
#! [ [ [ 1, (2,3), 1 ] ], [  ], [  ], [  ] ]

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
S := GSet( S3, [ 2, 2, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
R := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
T := GSet( S3,  [ 2, 1, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
psi1 := MapOfGSets( S, [ [ [ 2, (1,2), 1 ], [ 1, (1,2,3), 2 ] ], [ [ 1, (), 2 ], [ 1, (2,3), 2 ] ], [], [] ], R );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi1 );
#! true
psi2 := MapOfGSets( R, [ [ [ 1, (1,3), 1 ], [ 1, (1,2,3), 3 ] ], [ [ 1, (), 2 ] ], [], [] ], T );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi2 );
#! true
pi := PreCompose( psi1, psi2 );
#! <A morphism in Skeletal Category of G-Sets>
Display( pi );
#! [ [ [ 1, (2,3), 3 ], [ 1, (1,2,3), 2 ] ], [ [ 1, (), 2 ], [ 1, (2,3), 2 ] ], [  ], [  ] ]


G := SymmetricGroup( 0 );;
m := GSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
n := GSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
p := GSet( G, [ 7 ] );
#! <An object in Skeletal Category of G-Sets>
psi := MapOfGSets( m, [ [ [ 2, (), 1 ], [ 5, (), 1 ], [ 3, (), 1 ] ] ], n );
#! <A morphism in Skeletal Category of G-Sets>
phi := MapOfGSets( n, [ [ [ 1, (), 1 ], [ 4, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], [ 3, (), 1 ] ] ], p );
#! <A morphism in Skeletal Category of G-Sets>
alpha := PreCompose( psi, phi );
#! <A morphism in Skeletal Category of G-Sets>
Display( alpha );
#! [ [ [ 4, (), 1 ], [ 3, (), 1 ], [ 6, (), 1 ] ] ]


#! @EndExample
