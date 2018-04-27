#! @System Pushout

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
A := GSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
C := GSet( S3, [ 3, 1, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau1 := MapOfGSets( A, [ [ [ 3, (), 1 ] ], [], [ [ 1, (), 3 ] ], [] ], C );
#! <A morphism in Skeletal Category of G-Sets>
tau2 := MapOfGSets( B, [ [ [ 2, (), 1 ], [ 3, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], C );
#! <A morphism in Skeletal Category of G-Sets>
D := [ tau1, tau2 ];
#! [ <A morphism in Skeletal Category of G-Sets>, 
#!  <A morphism in Skeletal Category of G-Sets> ]
F := FiberProduct( D );
#! <An object in Skeletal Category of G-Sets>
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A morphism in Skeletal Category of G-Sets>
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A morphism in Skeletal Category of G-Sets>
iota := UniversalMorphismFromPushout( [ pi1, pi2 ], [ tau1, tau2 ] );
#! <A morphism in Skeletal Category of G-Sets>
Display( iota );
#! [ [ [ 3, (), 1 ], [ 2, (), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 3 ] ], [  ] ]



G := SymmetricGroup( 0 );;
M := GSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
N1 := GSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
iota1 := MapOfGSets( N1, [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ], M );
#! <A morphism in Skeletal Category of G-Sets>
IsMonomorphism( iota1 );
#! true
N2 := GSet( G, [ 2 ] );
#! <An object in Skeletal Category of G-Sets>
iota2 := MapOfGSets( N2, [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ], M );
#! <A morphism in Skeletal Category of G-Sets>
IsMonomorphism( iota2 );
#! true
D := [ iota1, iota2 ];
#! [ <A monomorphism in Skeletal Category of G-Sets>, <A monomorphism in Skeletal Category of G-Sets> ]
Fib := FiberProduct( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Fib );
#! [ 2 ]
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( pi1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ]
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( pi2 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ]
D := [ pi1, pi2 ];
#! [ <A monomorphism in Skeletal Category of G-Sets>, <A monomorphism in Skeletal Category of G-Sets> ]
UU := Pushout( D );
#! <An object in Skeletal Category of G-Sets>
AsList( UU );
#! [ 3 ]
kappa1 := InjectionOfCofactorOfPushout( D, 1 );
#! <A morphism in Skeletal Category of G-Sets>
Display( kappa1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]
kappa2 := InjectionOfCofactorOfPushout( D, 2 );
#! <A morphism in Skeletal Category of G-Sets>
Display( kappa2 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ]
PreCompose( pi1, kappa1 ) = PreCompose( pi2, kappa2 );
#! true


#! @EndExample
