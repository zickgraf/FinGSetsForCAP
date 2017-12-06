#! @System GSet

LoadPackage( "SkeletalGSets" );

#! @Example
S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
w1 := GSet( S3, [1, 2, 3, 1]);
#! <An object in Skeletal Category of G-Sets>
IsWellDefined( w1 );
#! true
w2 := GSet( S3, [1, 2, 3, 1]);
#! <An object in Skeletal Category of G-Sets>
IsWellDefined( w2 );
#! true
w1 = w2;
#! true
#! @EndExample
