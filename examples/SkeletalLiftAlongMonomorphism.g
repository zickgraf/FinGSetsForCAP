#! @System SkeletalLiftAlongMonomorphism

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
M := FinGSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
N := FinGSet( S3, [ 2, 0, 2, 0 ] );
#! <An object in SkeletalFinGSets>
O := FinGSet( S3, [ 2, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
tau := MapOfFinGSets( M, [ [ [ 1, (1,2), 1 ] ], [], [], [] ], N );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( tau );
#! true
iota := MapOfFinGSets( O, [ [ [ 2, (), 1 ], [ 1, (1,3,2), 1 ] ], [], [], [] ], N );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( iota );
#! true
IsMonomorphism( iota );
#! true
u := LiftAlongMonomorphism( iota, tau );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( u );
#! true
tau = PreCompose( u, iota );
#! true

#! @EndExample
