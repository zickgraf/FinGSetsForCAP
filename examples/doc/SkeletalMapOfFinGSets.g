#! @Chunk SkeletalMapOfFinGSets

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
w1 := FinGSet( S3, [ 1, 2, 0, 0 ] );
#! <An object in SkeletalFinGSets>
w2 := FinGSet( S3, [ 0, 1, 0, 1 ] );
#! <An object in SkeletalFinGSets>
imgs1 := [ [ [ 1, (2,3), 2 ] ],
           [ [ 1, (), 4 ], [ 1, (), 2 ] ],
           [],
           [] ];;
pi1 := MapOfFinGSets( w1, imgs1, w2 );
#! <A morphism in SkeletalFinGSets>
imgs2 := [ [ [ 1, (), 2 ] ],
           [ [ 1, (), 4 ], [ 1, (2,3), 2 ] ],
           [],
           [] ];;
pi2 := MapOfFinGSets( w1, imgs2, w2 );
#! <A morphism in SkeletalFinGSets>
pi1 = pi2;
#! true
# BUT
imgs1 = imgs2;
#! false

M := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
N := FinGSet( SymmetricGroup( 3 ), [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ],
          [ [ 1, (), 2 ] ],
          [],
          [] ];;
phi := MapOfFinGSets( M, imgs, N );
#! Error, The underlying groups of the source and the range are not the same
#!   with respect to IsIdenticalObj
phi := MapOfFinGSets( M, [ 1 ], M );
#! Error, I has the wrong format
phi := MapOfFinGSets( M, [ [ 1 ] ], M );
#! Error, images must be triples
phi := MapOfFinGSets( M, [ [ [ 1, () ] ] ], M );
#! Error, images must be triples
phi := MapOfFinGSets( M, [ [ [ 1, (), -1 ] ] ], M );
#! Error, last entry of an image must be an integer j with 1 <= j <= 4
phi := MapOfFinGSets( M, [ [ [ 1, (), 5 ] ] ], M );
#! Error, last entry of an image must be an integer j with 1 <= j <= 4
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false
imgs := [ [ [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false
imgs := [ [ [ 0, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false
imgs := [ [ [ 3, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 2 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, "", 2 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ], [ [ 1, (), 3 ] ], [], [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false
imgs := [ [ [ 1, (), 2 ], [ 1, (), 2 ] ],
          [ [ 1, (1,2,3), 2 ] ],
          [],
          [] ];;
phi := MapOfFinGSets( M, imgs, M );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! false

#! @EndExample
