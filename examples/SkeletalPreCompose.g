#! @System SkeletalPreCompose

LoadPackage( "FinGSetsForCAP" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
S := FinGSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
R := FinGSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
T := FinGSet( S3, [ 1, 0, 0, 0 ] );
#! <An object in SkeletalFinGSets>
psi1 := MapOfFinGSets( S, [ [ [ 1, (1,2), 1 ] ], [], [], [] ], R );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( psi1 );
#! true
psi2 := MapOfFinGSets( R, [ [ [ 1, (1,2,3), 1 ] ] , [], [], [] ] , T );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( psi2 );
#! true
PreCompose( psi1, psi2 );
#! <A morphism in SkeletalFinGSets>
phi := PreCompose( psi1, psi2 );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( phi );
#! true
Display( phi );
#! [ [ [ 1, (2,3), 1 ] ], [  ], [  ], [  ] ]

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
S := FinGSet( S3, [ 2, 2, 0, 0 ] );
#! <An object in SkeletalFinGSets>
R := FinGSet( S3, [ 2, 1, 0, 0 ] );
#! <An object in SkeletalFinGSets>
T := FinGSet( S3,  [ 2, 1, 1, 0 ] );
#! <An object in SkeletalFinGSets>
psi1 := MapOfFinGSets( S, [ [ [ 2, (1,2), 1 ], [ 1, (1,2,3), 2 ] ], [ [ 1, (), 2 ], [ 1, (2,3), 2 ] ], [], [] ], R );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( psi1 );
#! true
psi2 := MapOfFinGSets( R, [ [ [ 1, (1,3), 1 ], [ 1, (1,2,3), 3 ] ], [ [ 1, (), 2 ] ], [], [] ], T );
#! <A morphism in SkeletalFinGSets>
IsWellDefined( psi2 );
#! true
pi := PreCompose( psi1, psi2 );
#! <A morphism in SkeletalFinGSets>
Display( pi );
#! [ [ [ 1, (2,3), 3 ], [ 1, (1,2,3), 2 ] ], [ [ 1, (), 2 ], [ 1, (2,3), 2 ] ], [  ], [  ] ]


G := SymmetricGroup( 0 );;
m := FinGSet( G, [ 3 ] );
#! <An object in SkeletalFinGSets>
n := FinGSet( G, [ 5 ] );
#! <An object in SkeletalFinGSets>
p := FinGSet( G, [ 7 ] );
#! <An object in SkeletalFinGSets>
psi := MapOfFinGSets( m, [ [ [ 2, (), 1 ], [ 5, (), 1 ], [ 3, (), 1 ] ] ], n );
#! <A morphism in SkeletalFinGSets>
phi := MapOfFinGSets( n, [ [ [ 1, (), 1 ], [ 4, (), 1 ], [ 6, (), 1 ], [ 6, (), 1 ], [ 3, (), 1 ] ] ], p );
#! <A morphism in SkeletalFinGSets>
alpha := PreCompose( psi, phi );
#! <A morphism in SkeletalFinGSets>
Display( alpha );
#! [ [ [ 4, (), 1 ], [ 3, (), 1 ], [ 6, (), 1 ] ] ]


#! @EndExample
