#! @System SkeletalCoproduct

LoadPackage( "FinGSetsForCAP" );

#! @Example
S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M1 := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
M2 := FinGSet( S3, [ 1, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
M3 := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
M4 := FinGSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
C := Coproduct( [ M1, M2, M3, M4 ] );
#! <An object in SkeletalFinGSets>
tau1 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 1 );
#! <A morphism in SkeletalFinGSets>
tau2 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 2 );
#! <A morphism in SkeletalFinGSets>
tau3 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 3 );
#! <A morphism in SkeletalFinGSets>
tau4 := InjectionOfCofactorOfCoproduct( [ M1, M2, M3, M4 ], 4 );
#! <A morphism in SkeletalFinGSets>
tau := [ tau1, tau2, tau3, tau4 ];
#! [ <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets> ]
D := [ M1, M2, M3, M4 ];
#! [ <An object in SkeletalFinGSets>, <An object in SkeletalFinGSets>, <An object in SkeletalFinGSets>, <An object in SkeletalFinGSets> ]
id_to_be := UniversalMorphismFromCoproduct( D, tau );
#! <A morphism in SkeletalFinGSets>
id := IdentityMorphism( C );
#! <An identity morphism in SkeletalFinGSets>
id_to_be = id;
#! true

T := TerminalObject( M1 );
#! <An object in SkeletalFinGSets>
pi1 := UniversalMorphismIntoTerminalObject( M1 );
#! <A morphism in SkeletalFinGSets>
pi2 := UniversalMorphismIntoTerminalObject( M2 );
#! <A morphism in SkeletalFinGSets>
pi3 := UniversalMorphismIntoTerminalObject( M3 );
#! <A morphism in SkeletalFinGSets>
pi4 := UniversalMorphismIntoTerminalObject( M4 );
#! <A morphism in SkeletalFinGSets>
pi := [ pi1, pi2, pi3, pi4 ];
#! [ <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets> ]
universal_morphism_into_terminal_object_to_be := UniversalMorphismFromCoproduct( D, pi );
#! <A morphism in SkeletalFinGSets>
universal_morphism_into_terminal_object_to_be = UniversalMorphismIntoTerminalObject( C );
#! true
IsEpimorphism( universal_morphism_into_terminal_object_to_be );
#! true


G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 7 ] );
#! <An object in SkeletalFinGSets>
n := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
p := FinGSet( G, [ 4 ] );
#! <An object in SkeletalFinGSets>
c := Coproduct( m, n, p );
#! <An object in SkeletalFinGSets>
AsList( c );
#! [ 14 ]
iota1 := InjectionOfCofactorOfCoproduct( [ m, n, p ], 1 );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( iota1 );
#! true
Display( iota1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ], [ 6, (), 1 ], [ 7, (), 1 ] ] ]
iota3 := InjectionOfCofactorOfCoproduct( [ m, n, p ], 3 );
#! <A morphism in SkeletalFinGSets>
Display( iota3 );
#! [ [ [ 11, (), 1 ], [ 12, (), 1 ], [ 13, (), 1 ], [ 14, (), 1 ] ] ]

#! @EndExample
