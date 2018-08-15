#! @System SkeletalPushout

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
A := FinGSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in SkeletalFinGSets>
B := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
C := FinGSet( S3, [ 3, 1, 1, 0 ] );
#! <An object in SkeletalFinGSets>
tau1 := MapOfFinGSets( A, [ [ [ 3, (), 1 ] ], [], [ [ 1, (), 3 ] ], [] ], C );
#! <A morphism in SkeletalFinGSets>
tau2 := MapOfFinGSets( B, [ [ [ 2, (), 1 ], [ 3, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], C );
#! <A morphism in SkeletalFinGSets>
D := [ tau1, tau2 ];
#! [ <A morphism in SkeletalFinGSets>, 
#!  <A morphism in SkeletalFinGSets> ]
F := FiberProduct( D );
#! <An object in SkeletalFinGSets>
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A morphism in SkeletalFinGSets>
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A morphism in SkeletalFinGSets>
iota := UniversalMorphismFromPushout( [ pi1, pi2 ], [ tau1, tau2 ] );
#! <A morphism in SkeletalFinGSets>
Display( iota );
#! [ [ [ 3, (), 1 ], [ 2, (), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 3 ] ], [  ] ]



G := SymmetricGroup( 0 );;
M := FinGSet( G, [ 5 ] );
#! <An object in SkeletalFinGSets>
N1 := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
iota1 := MapOfFinGSets( N1, [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ], M );
#! <A morphism in SkeletalFinGSets>
IsMonomorphism( iota1 );
#! true
N2 := FinGSet( G, [ 2 ] );
#! <An object in SkeletalFinGSets>
iota2 := MapOfFinGSets( N2, [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ], M );
#! <A morphism in SkeletalFinGSets>
IsMonomorphism( iota2 );
#! true
D := [ iota1, iota2 ];
#! [ <A monomorphism in SkeletalFinGSets>, <A monomorphism in SkeletalFinGSets> ]
Fib := FiberProduct( D );
#! <An object in SkeletalFinGSets>
AsList( Fib );
#! [ 2 ]
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A monomorphism in SkeletalFinGSets>
Display( pi1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ]
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A monomorphism in SkeletalFinGSets>
Display( pi2 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ]
D := [ pi1, pi2 ];
#! [ <A monomorphism in SkeletalFinGSets>, <A monomorphism in SkeletalFinGSets> ]
UU := Pushout( D );
#! <An object in SkeletalFinGSets>
AsList( UU );
#! [ 3 ]
kappa1 := InjectionOfCofactorOfPushout( D, 1 );
#! <A morphism in SkeletalFinGSets>
Display( kappa1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]
kappa2 := InjectionOfCofactorOfPushout( D, 2 );
#! <A morphism in SkeletalFinGSets>
Display( kappa2 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ]
PreCompose( pi1, kappa1 ) = PreCompose( pi2, kappa2 );
#! true


#! @EndExample
