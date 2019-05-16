#! @Chunk SkeletalImage

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! true
IsEpimorphism( phi );
#! false
I := ImageObject( phi );
#! <An object in SkeletalFinGSets>
iota := ImageEmbedding( phi );
#! <A monomorphism in SkeletalFinGSets>
phi_res := CoastrictionToImage( phi );
#! <A morphism in SkeletalFinGSets>
phi = PreCompose( phi_res, iota );
#! true
T := FinGSet( S3, [ 1, 1, 0, 0 ] );;
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ];;
tau1 := MapOfFinGSets( M, imgs, T );;
imgs := [ [ [ 1, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ];;
tau2 := MapOfFinGSets( T, imgs, M );;
IsMonomorphism( tau2 );
#! true
phi = PreCompose( tau1, tau2 );
#! true
u := UniversalMorphismFromImage( phi, [ tau1, tau2 ] );
#! <A morphism in SkeletalFinGSets>
tau1 = PreCompose( phi_res, u );
#! true
iota = PreCompose( u, tau2 );
#! true



S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 2, (), 1 ], [ 1, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! true
IsEpimorphism( phi );
#! true
I := ImageObject( phi );
#! <An object in SkeletalFinGSets>
psi := ImageEmbedding( phi );
#! <A monomorphism in SkeletalFinGSets>
phi_res := CoastrictionToImage( phi );
#! <A morphism in SkeletalFinGSets>
phi = PreCompose( phi_res, psi );
#! true



G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 7 ] );
#! <An object in SkeletalFinGSets>
n := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 7, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ] ] ];;
phi := MapOfFinGSets( n, imgs, m );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! true
ImageObject( phi );
#! <An object in SkeletalFinGSets>
AsList( ImageObject( phi ) );
#! [ 2 ]
pi := ImageEmbedding( phi );
#! <A monomorphism in SkeletalFinGSets>
Display( pi );
#! [ [ [ 5, (), 1 ], [ 7, (), 1 ] ] ]
phi_res := CoastrictionToImage( phi );
#! <A morphism in SkeletalFinGSets>
phi = PreCompose( phi_res, pi );
#! true

#! @EndExample
