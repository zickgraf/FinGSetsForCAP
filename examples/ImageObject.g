#! @System ImageObject

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfGSets( M, [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ], M );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( phi );
#! true
IsEpimorphism( phi );
#! false
I := ImageObject( phi );
#! <An object in Skeletal Category of G-Sets>
psi := ImageEmbedding( phi );
#! <A monomorphism in Skeletal Category of G-Sets>
phi_res := CoastrictionToImage( phi );
#! <An epimorphism in Skeletal Category of G-Sets>
phi = PreCompose( phi_res, psi );
#! true



S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfGSets( M, [ [ [ 2, (), 1 ], [ 1, (), 1 ] ], [ [ 1, (), 2 ] ], [], [] ], M );
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
#! <An epimorphism in Skeletal Category of G-Sets>
phi = PreCompose( phi_res, psi );
#! true



G := SymmetricGroup( 0 );;
m := GSet( G, [ 7 ] );
#! <An object in Skeletal Category of G-Sets>
n := GSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfGSets( n, [ [ [ 7, (), 1 ], [ 5, (), 1 ], [ 5, (), 1 ] ] ], m );
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
#! <An epimorphism in Skeletal Category of G-Sets>
phi = PreCompose( phi_res, pi );
#! true

#! @EndExample
