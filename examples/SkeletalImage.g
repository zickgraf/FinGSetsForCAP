#! @System SkeletalImage

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfFinGSets( M, [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ], M );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( phi );
#! true
IsEpimorphism( phi );
#! false
I := ImageObject( phi );
#! <An object in Skeletal Category of G-Sets>
iota := ImageEmbedding( phi );
#! <A monomorphism in Skeletal Category of G-Sets>
phi_res := CoastrictionToImage( phi );
#! <A morphism in Skeletal Category of G-Sets>
phi = PreCompose( phi_res, iota );
#! true
T := FinGSet( S3, [ 1, 1, 0, 0 ] );;
tau1 := MapOfFinGSets( M, [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ], T );;
tau2 := MapOfFinGSets( T, [ [ [ 1, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], M );;
IsMonomorphism( tau2 );
#! true
phi = PreCompose( tau1, tau2 );
#! true
u := UniversalMorphismFromImage( phi, [ tau1, tau2 ] );
#! <A morphism in Skeletal Category of G-Sets>
tau1 = PreCompose( phi_res, u );
#! true
iota = PreCompose( u, tau2 );
#! true



S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfFinGSets( M, [ [ [ 2, (), 1 ], [ 1, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], M );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( phi );
#! true
IsEpimorphism( phi );
#! true
I := ImageObject( phi );
#! <An object in Skeletal Category of G-Sets>
psi := ImageEmbedding( phi );
#! <A monomorphism in Skeletal Category of G-Sets>
phi_res := CoastrictionToImage( phi );
#! <A morphism in Skeletal Category of G-Sets>
phi = PreCompose( phi_res, psi );
#! true



G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 7 ] );
#! <An object in Skeletal Category of G-Sets>
n := FinGSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfFinGSets( n, [ [ [ 7, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ] ] ], m );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( phi );
#! true
ImageObject( phi );
#! <An object in Skeletal Category of G-Sets>
AsList( ImageObject( phi ) );
#! [ 2 ]
pi := ImageEmbedding( phi );
#! <A monomorphism in Skeletal Category of G-Sets>
Display( pi );
#! [ [ [ 5, (), 1 ], [ 7, (), 1 ] ] ]
phi_res := CoastrictionToImage( phi );
#! <A morphism in Skeletal Category of G-Sets>
phi = PreCompose( phi_res, pi );
#! true

#! @EndExample
