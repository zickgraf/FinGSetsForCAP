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

#! @EndExample
