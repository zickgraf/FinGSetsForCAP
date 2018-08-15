#! @System SkeletalFinGSet

LoadPackage( "FinGSetsForCAP" );

#! @Example
S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
SetName( S3, "S3" );
w1 := FinGSet( S3, [ 1, 2, 3, 1 ] );
#! <An object in SkeletalFin-S3-Sets>
IsWellDefined( w1 );
#! true
w2 := FinGSet( S3, [ 1, 2, 3, 1 ] );
#! <An object in SkeletalFin-S3-Sets>
IsWellDefined( w2 );
#! true
w1 = w2;
#! true

# do not add objects which are not well-defined to cache
DeactivateCachingOfCategory( SkeletalFinGSets( S3 ) );

S := FinGSet( S3, [ 1 ] );
#! <An object in SkeletalFin-S3-Sets>
IsWellDefined( S );
#! false
S := FinGSet( S3, [ "a", 0, 0, 0 ] );
#! <An object in SkeletalFin-S3-Sets>
IsWellDefined( S );
#! false
S := FinGSet( S3, [ -1, 0, 0, 0 ] );
#! <An object in SkeletalFin-S3-Sets>
IsWellDefined( S );
#! false

SetCachingOfCategoryWeak( SkeletalFinGSets( S3 ) );

#! @EndExample
