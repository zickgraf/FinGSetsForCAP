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
AsList( iota );
#! [ [ [ 3, (), 1 ], [ 2, (), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 3 ] ], [  ] ]

#! @EndExample
