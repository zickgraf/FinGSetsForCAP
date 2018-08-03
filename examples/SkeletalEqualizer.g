#! @System SkeletalEqualizer

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
s := FinGSet( S3, [ 1, 0, 2, 0 ] );
#! <An object in Skeletal Category of G-Sets>
r := FinGSet( S3, [ 1, 2, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
psi1 := MapOfFinGSets( s, [ [ [ 1, (1,2), 1 ] ], [], [ [ 1, (), 3 ], [ 1, (1,2,3), 3 ] ], [] ], r );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi1 );
#! true
psi2 := MapOfFinGSets( s, [ [[ 1, (1,2), 3 ]], [], [[ 1, (), 3 ], [ 1, (), 3 ]], [] ], r );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( psi2 );
#! true
D := [ psi1, psi2 ];;
Eq := Equalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Eq );
#! [ 0, 0, 2, 0 ]
psi := EmbeddingOfEqualizer( D );
#! <A monomorphism in Skeletal Category of G-Sets>
IsWellDefined( psi );
#! true
Display( psi );
#! [ [  ], [  ], [ [ 1, (), 3 ], [ 2, (), 3 ] ], [  ] ]
PreCompose( psi, psi1 ) = PreCompose( psi, psi2 );
#! true
t := FinGSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau := MapOfFinGSets( t, [ [ [ 2, (1,2), 3 ] ], [], [ [ 1, (1,2,3), 3 ] ], [] ] , s );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( tau );
#! true
phi := UniversalMorphismIntoEqualizer( D, tau );
#! <A morphism in Skeletal Category of G-Sets>
Display( phi );
#! [ [ [ 2, (1,2), 3 ] ], [  ], [ [ 1, (1,2,3), 3 ] ], [  ] ]
IsWellDefined( phi );
#! true
PreCompose( phi, psi ) = tau;
#! true


G := SymmetricGroup( 0 );;
S := FinGSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
T := FinGSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
f1 := MapOfFinGSets( S, [ [ [ 3, (), 1 ], [ 3, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ] ] ], T );
#! <A morphism in Skeletal Category of G-Sets>
f2 := MapOfFinGSets( S, [ [ [ 3, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ] ] ], T );
#! <A morphism in Skeletal Category of G-Sets>
f3 := MapOfFinGSets( S, [ [ [ 3, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ] ] ], T );
#! <A morphism in Skeletal Category of G-Sets>
D := [ f1, f2, f3 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
Eq := Equalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Eq );
#! [ 2 ]
psi := EmbeddingOfEqualizer( D );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( psi );
#! [ [ [ 1, (), 1 ], [ 5, (), 1 ] ] ]
PreCompose( psi, f1 ) = PreCompose( psi, f2 );
#! true
PreCompose( psi, f1 ) = PreCompose( psi, f3 );
#! true
D := [ f2, f3 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
Eq := Equalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Eq );
#! [ 3 ]
psi := EmbeddingOfEqualizer( D );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( psi );
#! [ [ [ 1, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ] ] ]

#! @EndExample
