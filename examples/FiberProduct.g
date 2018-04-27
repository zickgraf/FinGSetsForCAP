#! @System FiberProduct

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
A := GSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
C := GSet( S3, [ 2, 1, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
tau1 := MapOfGSets( A, [ [ [ 2, (), 1 ] ], [], [ [ 1, (), 3 ] ], [] ], C );
#! <A morphism in Skeletal Category of G-Sets>
tau2 := MapOfGSets( B, [ [ [ 1, (), 1 ], [ 2, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], C );
#! <A morphism in Skeletal Category of G-Sets>
D := [ tau1, tau2 ];
#! [ <A morphism in Skeletal Category of G-Sets>, 
#!  <A morphism in Skeletal Category of G-Sets> ]
F := FiberProduct( D );
#! <An object in Skeletal Category of G-Sets>
Display( F );
#! [ SymmetricGroup( [ 1 .. 3 ] ), [ 1, 0, 0, 0 ] ]
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A morphism in Skeletal Category of G-Sets>
Display( pi1 );
#! [ [ [ 1, (), 1 ] ], [  ], [  ], [  ] ]
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A morphism in Skeletal Category of G-Sets>
Display( pi2 );
#! [ [ [ 2, (), 1 ] ], [  ], [  ], [  ] ]



G := SymmetricGroup( 0 );;
m := GSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
n1 := GSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
iota1 := MapOfGSets( n1, [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ], m );
#! <A morphism in Skeletal Category of G-Sets>
IsMonomorphism( iota1 );
#! true
n2 := GSet( G, [ 4 ] );
#! <An object in Skeletal Category of G-Sets>
iota2 := MapOfGSets( n2, [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ] ] ], m );
#! <A morphism in Skeletal Category of G-Sets>
IsMonomorphism( iota2 );
#! true
D := [ iota1, iota2 ];
#! [ <A monomorphism in Skeletal Category of G-Sets>, <A monomorphism in Skeletal Category of G-Sets> ]
Fib := FiberProduct( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Fib );
#! [ 3 ]
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( pi1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]
int1 := ImageObject( pi1 );
#! <An object in Skeletal Category of G-Sets>
AsList( int1 );
#! [ 3 ]
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( pi2 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]
int2 := ImageObject( pi2 );
#! <An object in Skeletal Category of G-Sets>
AsList( int2 );
#! [ 3 ]
omega1 := PreCompose( pi1, iota1 );
#! <A monomorphism in Skeletal Category of G-Sets>
omega2 := PreCompose( pi2, iota2 );
#! <A monomorphism in Skeletal Category of G-Sets>
omega1 = omega2;
#! true
Display( omega1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]


#! @EndExample
