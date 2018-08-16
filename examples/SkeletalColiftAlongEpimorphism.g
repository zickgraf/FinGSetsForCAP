#! @System SkeletalColiftAlongEpimorphism

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
N := FinGSet( S3, [ 1, 0, 1, 0 ] );
#! <An object in SkeletalFinGSets>
O := FinGSet( S3, [ 2, 0, 1, 0 ] );
#! <An object in SkeletalFinGSets>
imgs := [ [ [ 1, (1,2), 1 ], [ 1, (), 3 ] ], [], [], [] ];;
tau := MapOfFinGSets( M, imgs, O );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( tau );
#! true
imgs := [ [ [ 1, (1,2,3), 1 ], [ 1, (1,2), 3 ] ], [], [], [] ];;
epsilon := MapOfFinGSets( M, imgs, N );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( epsilon );
#! true
IsEpimorphism( epsilon );
#! true
u := ColiftAlongEpimorphism( epsilon, tau );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( u );
#! true
tau = PreCompose( epsilon, u );
#! true

#! @EndExample
