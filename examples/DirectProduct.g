#! @System DirectProduct

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
A := FinGSet( S3, [ 0, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S3, [ 0, 0, 1, 0 ] );
#! <An object in Skeletal Category of G-Sets>
Display( DirectProduct( A, B ) );
#! [ SymmetricGroup( [ 1 .. 3 ] ), [ 1, 0, 0, 0 ] ]

S4 := SymmetricGroup( 4 );
#! Sym( [ 1 .. 4 ] )
A := FinGSet( S4, [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S4, [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
Display( DirectProduct( A, B ) );
#! [ SymmetricGroup( [ 1 .. 4 ] ), [ 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]

pi := ProjectionInFactorOfDirectProduct( [ A, A ], 1 );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( pi );
#! true
Display( pi );
#! [ [ [ 1, (), 3 ], [ 1, (), 3 ], [ 1, (), 3 ], [ 1, (), 3 ], 
#!       [ 1, (), 3 ] ], [  ], [ [ 1, (), 3 ], [ 1, (), 3 ] ], [  ], 
#!   [  ], [  ], [  ], [  ], [  ], [  ], [  ] ]



S5 := SymmetricGroup( 5 );
#! Sym( [ 1 .. 5 ] )
A := FinGSet( S5, [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S5, [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
D := [ A, B ];
#! [ <An object in Skeletal Category of G-Sets>, 
#!   <An object in Skeletal Category of G-Sets> ]
pi1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( pi1 );
#! true
pi2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( pi2 );
#! true
tau := [ pi1, pi2 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
u := UniversalMorphismIntoDirectProduct( D, tau );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( u );
#! true


A := FinGSet( S3, [ 0, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S3, [ 0, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
pi1 := ProjectionInFactorOfDirectProduct( [ A, B ], 1 );
#! <A morphism in Skeletal Category of G-Sets>
pi2 := ProjectionInFactorOfDirectProduct( [ A, B ], 2 );
#! <A morphism in Skeletal Category of G-Sets>
Display( pi1 );
#! [ [ [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [  ], [  ] ]
Display( pi2 );
#! [ [ [ 1, (1,3), 2 ] ], [ [ 1, (), 2 ] ], [  ], [  ] ]


M := FinGSet( S3, [ 1, 2, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
N := FinGSet( S3, [ 1, 0, 1, 2 ] );
#! <An object in Skeletal Category of G-Sets>
D := [ M, N ];
#! [ <An object in Skeletal Category of G-Sets>, 
#!   <An object in Skeletal Category of G-Sets> ]
tau1 := ProjectionInFactorOfDirectProduct( D, 1 );
#! <A morphism in Skeletal Category of G-Sets>
tau2 := ProjectionInFactorOfDirectProduct( D, 2 );
#! <A morphism in Skeletal Category of G-Sets>
tau := [ tau1, tau2 ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
u := UniversalMorphismIntoDirectProduct( D, tau );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( u );
#! true
Display( u );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], [ 5, (), 1 ], [ 6, (), 1 ], [ 7, (), 1 ], [ 8, (), 1 ],
#!      [ 9, (), 1 ], [ 10, (), 1 ], [ 11, (), 1 ], [ 12, (), 1 ], [ 13, (), 1 ], [ 14, (), 1 ], [ 15, (), 1 ],
#!      [ 16, (), 1 ], [ 17, (), 1 ], [ 18, (), 1 ] ], [ [ 1, (), 2 ], [ 2, (), 2 ], [ 3, (), 2 ], [ 4, (), 2 ] ],
#!  [  ], [  ] ]

L := FinGSet( S3, [ 2, 1, 0, 1 ] );
#! <An object in Skeletal Category of G-Sets>
D := [ M, N, L ];
#! [ <An object in Skeletal Category of G-Sets>,
#!   <An object in Skeletal Category of G-Sets>, 
#!   <An object in Skeletal Category of G-Sets> ]
tau := ProjectionInFactorOfDirectProduct( D, 3 );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( tau );
#! true



G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 7 ] );
#! <An object in Skeletal Category of G-Sets>
n := FinGSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
p := FinGSet( G, [ 4 ] );
#! <An object in Skeletal Category of G-Sets>
d := DirectProduct( [ m, n, p ] );
#! <An object in Skeletal Category of G-Sets>
AsList( d );
#! [ 84 ]
pi1 := ProjectionInFactorOfDirectProduct( [ m, n, p ], 1 );
#! <A morphism in Skeletal Category of G-Sets>
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
#! <A morphism in Skeletal Category of G-Sets>
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
