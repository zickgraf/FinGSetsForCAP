#! @System SkeletalFiberProduct

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
A := FinGSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in SkeletalFinGSets>
B := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
C := FinGSet( S3, [ 2, 1, 1, 0 ] );
#! <An object in SkeletalFinGSets>
tau1 := MapOfFinGSets( A, [ [ [ 2, (), 1 ] ], [], [ [ 1, (), 3 ] ], [] ], C );
#! <A morphism in SkeletalFinGSets>
tau2 := MapOfFinGSets( B, [ [ [ 1, (), 1 ], [ 2, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], C );
#! <A morphism in SkeletalFinGSets>
D := [ tau1, tau2 ];
#! [ <A morphism in SkeletalFinGSets>, 
#!  <A morphism in SkeletalFinGSets> ]
F := FiberProduct( D );
#! <An object in SkeletalFinGSets>
Display( F );
#! [ SymmetricGroup( [ 1 .. 3 ] ), [ 1, 0, 0, 0 ] ]
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A morphism in SkeletalFinGSets>
Display( pi1 );
#! [ [ [ 1, (), 1 ] ], [  ], [  ], [  ] ]
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A morphism in SkeletalFinGSets>
Display( pi2 );
#! [ [ [ 2, (), 1 ] ], [  ], [  ], [  ] ]



G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 5 ] );
#! <An object in SkeletalFinGSets>
n1 := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
iota1 := MapOfFinGSets( n1, [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ], m );
#! <A morphism in SkeletalFinGSets>
IsMonomorphism( iota1 );
#! true
n2 := FinGSet( G, [ 4 ] );
#! <An object in SkeletalFinGSets>
iota2 := MapOfFinGSets( n2, [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ] ] ], m );
#! <A morphism in SkeletalFinGSets>
IsMonomorphism( iota2 );
#! true
D := [ iota1, iota2 ];
#! [ <A monomorphism in SkeletalFinGSets>, <A monomorphism in SkeletalFinGSets> ]
Fib := FiberProduct( D );
#! <An object in SkeletalFinGSets>
AsList( Fib );
#! [ 3 ]
pi1 := ProjectionInFactorOfFiberProduct( D, 1 );
#! <A monomorphism in SkeletalFinGSets>
Display( pi1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]
int1 := ImageObject( pi1 );
#! <An object in SkeletalFinGSets>
AsList( int1 );
#! [ 3 ]
pi2 := ProjectionInFactorOfFiberProduct( D, 2 );
#! <A monomorphism in SkeletalFinGSets>
Display( pi2 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]
int2 := ImageObject( pi2 );
#! <An object in SkeletalFinGSets>
AsList( int2 );
#! [ 3 ]
omega1 := PreCompose( pi1, iota1 );
#! <A monomorphism in SkeletalFinGSets>
omega2 := PreCompose( pi2, iota2 );
#! <A monomorphism in SkeletalFinGSets>
omega1 = omega2;
#! true
Display( omega1 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ] ] ]


#! @EndExample
