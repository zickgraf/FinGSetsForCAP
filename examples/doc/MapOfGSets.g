#! @System MapOfGSets

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
w1 := GSet( S3, [ 1, 2, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
w2 := GSet( S3, [ 0, 1, 0, 1 ] );
#! <An object in Skeletal Category of G-Sets>
imgs1 := [ [ [ 1, (2,3), 2 ] ], [ [ 1, (), 4 ], [ 1, (), 2 ] ], [], [] ];;
pi1 := MapOfGSets( w1, imgs1, w2 );
#! <A morphism in Skeletal Category of G-Sets>
imgs2 := [ [ [ 1, (), 2 ] ], [ [ 1, (), 4 ], [ 1, (2,3), 2 ] ], [], [] ];;
pi2 := MapOfGSets( w1, imgs2, w2 );
#! <A morphism in Skeletal Category of G-Sets>
pi1 = pi2;
#! true
# BUT
imgs1 = imgs2;
#! false

M := GSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
phi := MapOfGSets( M, [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (1,2,3), 2 ] ], [], [] ], M );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( phi );
#! Error, 4

#! @EndExample
