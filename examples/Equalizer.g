#! @System Equalizer

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
s := GSet( S3, [ 1, 0, 2, 0 ] );
#! <An object in Skeletal Category of G-Sets>
r := GSet( S3, [ 1, 2, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
psi1 := MapOfGSets( s, [ [ [ 1, (1,2), 1 ] ], [], [ [ 1, (), 3 ], [ 1, (1,2,3), 3 ] ], [] ], r );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi1 );
#! true
psi2 := MapOfGSets( s, [ [[ 1, (1,2), 3 ]], [], [[ 1, (), 3 ], [ 1, (), 3 ]], [] ], r );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi2 );
#! true
Eq := Equalizer( [ psi1, psi2 ] );
#! <An object in Skeletal Category of G-Sets>
AsList( Eq );
#! [ 0, 0, 2, 0 ]



G := SymmetricGroup( 0 );;
S := GSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
T := GSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
f1 := MapOfGSets( S, [ [ [ 3, (), 1 ], [ 3, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ] ] ], T );
#! <A morphism in Skeletal Category of G-Sets>
f2 := MapOfGSets( S, [ [ [ 3, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ] ] ], T );
#! <A morphism in Skeletal Category of G-Sets>
f3 := MapOfGSets( S, [ [ [ 3, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ] ] ], T );
#! <A morphism in Skeletal Category of G-Sets>
D := [ f1, f2, f3 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
Eq := Equalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Eq );
#! [ 2 ]
psi := EmbeddingOfEqualizer( D );
#! <A morphism in Skeletal Category of G-Sets>
Display( psi );
#! [ [ [ 1, (), 1 ], [ 5, (), 1 ] ] ]
D := [ f2, f3 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
Eq := Equalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Eq );
#! [ 3 ]
psi := EmbeddingOfEqualizer( D );
#! <A morphism in Skeletal Category of G-Sets>
Display( psi );
#! [ [ [ 1, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ] ] ]

#! @EndExample
