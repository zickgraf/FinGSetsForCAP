#! @System Coproduct

LoadPackage( "SkeletalGSets" );

#! @Example
S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M1 := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
M2 := GSet( S3, [ 1, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
M3 := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
M4 := GSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
C := Coproduct( [ M1, M2, M3, M4 ] );
#! <An object in Skeletal Category of G-Sets>
tau1 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 1 );
#! <A morphism in Skeletal Category of G-Sets>
tau2 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 2 );
#! <A morphism in Skeletal Category of G-Sets>
tau3 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 3 );
#! <A morphism in Skeletal Category of G-Sets>
tau4 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 4 );
#! <A morphism in Skeletal Category of G-Sets>
tau := [ tau1, tau2, tau3, tau4 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
D := [ M1, M2, M3, M4 ];
#! [ <An object in Skeletal Category of G-Sets>, <An object in Skeletal Category of G-Sets>, <An object in Skeletal Category of G-Sets>, <An object in Skeletal Category of G-Sets> ]
id_to_be := UniversalMorphismFromCoproduct( D, tau );
#! <A morphism in Skeletal Category of G-Sets>
id := IdentityMorphism( C );
#! <An identity morphism in Skeletal Category of G-Sets>
id_to_be = id;
#! true

T := TerminalObject( M1 );
#! <An object in Skeletal Category of G-Sets>
pi1 := UniversalMorphismIntoTerminalObject( M1 );
#! <A morphism in Skeletal Category of G-Sets>
pi2 := UniversalMorphismIntoTerminalObject( M2 );
#! <A morphism in Skeletal Category of G-Sets>
pi3 := UniversalMorphismIntoTerminalObject( M3 );
#! <A morphism in Skeletal Category of G-Sets>
pi4 := UniversalMorphismIntoTerminalObject( M4 );
#! <A morphism in Skeletal Category of G-Sets>
pi := [ pi1, pi2, pi3, pi4 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
universal_morphism_into_terminal_object_to_be := UniversalMorphismFromCoproduct( D, pi );
#! <A morphism in Skeletal Category of G-Sets>
universal_morphism_into_terminal_object_to_be = UniversalMorphismIntoTerminalObject( C );
#! true
IsEpimorphism( universal_morphism_into_terminal_object_to_be );
#! true


G := SymmetricGroup( 0 );;
m := GSet( G, [ 7 ] );
#! <An object in Skeletal Category of G-Sets>
n := GSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
p := GSet( G, [ 4 ] );
#! <An object in Skeletal Category of G-Sets>
c := Coproduct( m, n, p );
#! <An object in Skeletal Category of G-Sets>
AsList( c );
#! [ 14 ]
iota1 := InjectionOfCofactorOfCoproduct( [ m, n, p ], 1 );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( iota1 );
#! true
AsList( iota1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ], [ 6, (), 1 ], [ 7, (), 1 ] ] ]
iota3 := InjectionOfCofactorOfCoproduct( [ m, n, p ], 3 );
#! <A morphism in Skeletal Category of G-Sets>
AsList( iota3 );
#! [ [ [ 11, (), 1 ], [ 12, (), 1 ], [ 13, (), 1 ], [ 14, (), 1 ] ] ]

#! @EndExample
