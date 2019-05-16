#! @Chunk SkeletalEqualizer

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
s := FinGSet( S3, [ 1, 0, 2, 0 ] );
#! <An object in SkeletalFinGSets>
r := FinGSet( S3, [ 1, 2, 1, 0 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 1, (1,2), 1 ] ],
          [],
          [ [ 1, (), 3 ], [ 1, (1,2,3), 3 ] ],
          [] ];;
psi1 := MapOfFinGSets( s, imgs, r );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( psi1 );
#! true
imgs := [ [[ 1, (1,2), 3 ]], [], [[ 1, (), 3 ], [ 1, (), 3 ]], [] ];;
psi2 := MapOfFinGSets( s, imgs, r );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( psi2 );
#! true
D := [ psi1, psi2 ];;
Eq := Equalizer( D );
#! <An object in SkeletalFinGSets>
AsList( Eq );
#! [ 0, 0, 2, 0 ]
psi := EmbeddingOfEqualizer( D );
#! <A monomorphism in SkeletalFinGSets>
IsWellDefined( psi );
#! true
Display( psi );
#! [ [  ], [  ], [ [ 1, (), 3 ], [ 2, (), 3 ] ], [  ] ]
PreCompose( psi, psi1 ) = PreCompose( psi, psi2 );
#! true
t := FinGSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 2, (1,2), 3 ] ], [], [ [ 1, (1,2,3), 3 ] ], [] ];;
tau := MapOfFinGSets( t, imgs , s );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( tau );
#! true
phi := UniversalMorphismIntoEqualizer( D, tau );
#! <A morphism in SkeletalFinGSets>
Display( phi );
#! [ [ [ 2, (1,2), 3 ] ], [  ], [ [ 1, (1,2,3), 3 ] ], [  ] ]
IsWellDefined( phi );
#! true
PreCompose( phi, psi ) = tau;
#! true


G := SymmetricGroup( 0 );;
S := FinGSet( G, [ 5 ] );
#! <An object in SkeletalFinGSets>
T := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 3, (), 1 ],
            [ 3, (), 1 ],
            [ 1, (), 1 ],
            [ 2, (), 1 ],
            [ 2, (), 1 ] ] ];;
f1 := MapOfFinGSets( S, imgs, T );
#! <A morphism in SkeletalFinGSets>
imgs := [ [ [ 3, (), 1 ],
            [ 2, (), 1 ],
            [ 3, (), 1 ],
            [ 1, (), 1 ],
            [ 2, (), 1 ] ] ];;
f2 := MapOfFinGSets( S, imgs, T );
#! <A morphism in SkeletalFinGSets>
imgs := [ [ [ 3, (), 1 ],
            [ 1, (), 1 ],
            [ 2, (), 1 ],
            [ 1, (), 1 ],
            [ 2, (), 1 ] ] ];;
f3 := MapOfFinGSets( S, imgs, T );
#! <A morphism in SkeletalFinGSets>
D := [ f1, f2, f3 ];;
Eq := Equalizer( D );
#! <An object in SkeletalFinGSets>
AsList( Eq );
#! [ 2 ]
psi := EmbeddingOfEqualizer( D );
#! <A monomorphism in SkeletalFinGSets>
Display( psi );
#! [ [ [ 1, (), 1 ], [ 5, (), 1 ] ] ]
PreCompose( psi, f1 ) = PreCompose( psi, f2 );
#! true
PreCompose( psi, f1 ) = PreCompose( psi, f3 );
#! true
D := [ f2, f3 ];
#! [ <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets> ]
Eq := Equalizer( D );
#! <An object in SkeletalFinGSets>
AsList( Eq );
#! [ 3 ]
psi := EmbeddingOfEqualizer( D );
#! <A monomorphism in SkeletalFinGSets>
Display( psi );
#! [ [ [ 1, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ] ] ]

#! @EndExample
