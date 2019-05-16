#! @Chunk SkeletalIsEqualForObjects

LoadPackage( "FinGSetsForCAP" );

#! @Example
# Groups have to be the same with respect to IsIdenticalObj
C6 := CyclicGroup( 6 );
#! <pc group of size 6 with 2 generators>

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )

w1 := FinGSet( C6, [1, 2, 3, 1]);
#! <An object in SkeletalFinGSets>

IsWellDefined( w1 );
#! true

w2 := FinGSet( S3, [1, 2, 3, 1]);
#! <An object in SkeletalFinGSets>

IsWellDefined( w2 );
#! true

w1 = w2;
#! Error, the object "An object in SkeletalFinGSets" and the object "An o\
#! bject in SkeletalFinGSets" do not belong to the same CAP category

#! @EndExample
