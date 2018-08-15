#! @System SkeletalDirectProduct

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
A := FinGSet( S3, [ 0, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
B := FinGSet( S3, [ 0, 0, 1, 0 ] );
#! <An object in SkeletalFinGSets>
Display( DirectProduct( A, B ) );
#! [ SymmetricGroup( [ 1 .. 3 ] ), [ 1, 0, 0, 0 ] ]

S4 := SymmetricGroup( 4 );
#! Sym( [ 1 .. 4 ] )
A := FinGSet( S4, [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
B := FinGSet( S4, [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
Display( DirectProduct( A, B ) );
#! [ SymmetricGroup( [ 1 .. 4 ] ), [ 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]

pi := ProjectionInFactorOfDirectProduct( [ A, A ], 1 );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( pi );
#! true
Display( pi );
#! [ [ [ 1, (), 3 ], [ 1, (), 3 ], [ 1, (), 3 ], [ 1, (), 3 ], 
#!       [ 1, (), 3 ] ], [  ], [ [ 1, (), 3 ], [ 1, (), 3 ] ], [  ], 
#!   [  ], [  ], [  ], [  ], [  ], [  ], [  ] ]



S5 := SymmetricGroup( 5 );
#! Sym( [ 1 .. 5 ] )
A := FinGSet( S5, [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
B := FinGSet( S5, [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
D := [ A, B ];
#! [ <An object in SkeletalFinGSets>, 
#!   <An object in SkeletalFinGSets> ]
pi1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( pi1 );
#! true
pi2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( pi2 );
#! true
tau := [ pi1, pi2 ];
#! [ <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets> ]
u := UniversalMorphismIntoDirectProduct( D, tau );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( u );
#! true


A := FinGSet( S3, [ 0, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
B := FinGSet( S3, [ 0, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
pi1 := ProjectionInFactorOfDirectProduct( [ A, B ], 1 );
#! <A morphism in SkeletalFinGSets>
pi2 := ProjectionInFactorOfDirectProduct( [ A, B ], 2 );
#! <A morphism in SkeletalFinGSets>
Display( pi1 );
#! [ [ [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [  ], [  ] ]
Display( pi2 );
#! [ [ [ 1, (1,3), 2 ] ], [ [ 1, (), 2 ] ], [  ], [  ] ]


M := FinGSet( S3, [ 1, 2, 0, 0 ] );
#! <An object in SkeletalFinGSets>
N := FinGSet( S3, [ 1, 0, 1, 2 ] );
#! <An object in SkeletalFinGSets>
D := [ M, N ];
#! [ <An object in SkeletalFinGSets>, 
#!   <An object in SkeletalFinGSets> ]
tau1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in SkeletalFinGSets>
tau2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in SkeletalFinGSets>
tau := [ tau1, tau2 ];
#! [ <A morphism in SkeletalFinGSets>, <A morphism in SkeletalFinGSets> ]
u := UniversalMorphismIntoDirectProduct( D, tau );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( u );
#! true
Display( u );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ], [ 6, (), 1 ], [ 7, (), 1 ], [ 8, (), 1 ],
#!      [ 9, (), 1 ], [ 10, (), 1 ], [ 11, (), 1 ], [ 12, (), 1 ], [ 13, (), 1 ], [ 14, (), 1 ], [ 15, (), 1 ],
#!      [ 16, (), 1 ], [ 17, (), 1 ], [ 18, (), 1 ] ], [ [ 1, (), 2 ], [ 2, (), 2 ], [ 3, (), 2 ], [ 4, (), 2 ] ],
#!  [  ], [  ] ]

L := FinGSet( S3, [ 2, 1, 0, 1 ] );
#! <An object in SkeletalFinGSets>
D := [ M, N, L ];
#! [ <An object in SkeletalFinGSets>,
#!   <An object in SkeletalFinGSets>, 
#!   <An object in SkeletalFinGSets> ]
tau := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( tau );
#! true



G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 7 ] );
#! <An object in SkeletalFinGSets>
n := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
p := FinGSet( G, [ 4 ] );
#! <An object in SkeletalFinGSets>
d := DirectProduct( [ m, n, p ] );
#! <An object in SkeletalFinGSets>
AsList( d );
#! [ 84 ]
pi1 := ProjectionInFactorOfDirectProduct( [ m, n, p ], 1 );
#! <A morphism in SkeletalFinGSets>
Display( pi1 );
#! [ [ [ 1, (), 1 ], [ 1, (), 1 ], [ 1, (), 1 ], [ 1, (), 1 ], 
#!       [ 1, (), 1 ], [ 1, (), 1 ], [ 1, (), 1 ], [ 1, (), 1 ], 
#!       [ 1, (), 1 ], [ 1, (), 1 ], [ 1, (), 1 ], [ 1, (), 1 ], 
#!       [ 2, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ], 
#!       [ 2, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ], 
#!       [ 2, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ], 
#!       [ 3, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ], 
#!       [ 3, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ], 
#!       [ 3, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ], 
#!       [ 4, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], 
#!       [ 4, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], 
#!       [ 4, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], 
#!       [ 5, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ], 
#!       [ 5, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ], 
#!       [ 5, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ], 
#!       [ 6, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], 
#!       [ 6, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], 
#!       [ 6, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], 
#!       [ 7, (), 1 ], [ 7, (), 1 ], [ 7, (), 1 ], [ 7, (), 1 ], 
#!       [ 7, (), 1 ], [ 7, (), 1 ], [ 7, (), 1 ], [ 7, (), 1 ], 
#!       [ 7, (), 1 ], [ 7, (), 1 ], [ 7, (), 1 ], [ 7, (), 1 ] ] ]
pi3 := ProjectionInFactorOfDirectProduct( [ m, n, p ], 3 );
#! <A morphism in SkeletalFinGSets>
Display( pi3 );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], 
#!       [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ] ] ]

#! @EndExample
