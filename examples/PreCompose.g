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
AsList( phi );
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
AsList( pi );
#! [ [ [ 1, (2,3), 3 ], [ 1, (1,2,3), 2 ] ], [ [ 1, (), 2 ], [ 1, (2,3), 2 ] ], [  ], [  ] ]

#! @EndExample
