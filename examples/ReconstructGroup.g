#! @Chunk ReconstructGroup

LoadPackage( "FinGSetsForCAP" );

#! @Example

G_1 := CyclicGroup( 5 );;
G_2 := SmallGroup( 20, 5 );;

#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" )
CapCategorySwitchLogicOff( FinSets );
DeactivateCachingOfCategory( FinSets );
DisableSanityChecks( FinSets );

DeactivateCachingOfCategory( SkeletalFinSets );
CapCategorySwitchLogicOff( SkeletalFinSets );
DisableSanityChecks( SkeletalFinSets );
#! #@fi

CapCategorySwitchLogicOff( SkeletalFinGSets( G_1 ) );
DeactivateCachingOfCategory( SkeletalFinGSets( G_1 ) );
DisableSanityChecks( SkeletalFinGSets( G_1 ) );

CapCategorySwitchLogicOff( SkeletalFinGSets( G_2 ) );
DeactivateCachingOfCategory( SkeletalFinGSets( G_2 ) );
DisableSanityChecks( SkeletalFinGSets( G_2 ) );

DeactivateToDoList();

ToM_1 := MatTom( TableOfMarks( G_1 ) );
#! [ [ 5, 0 ], [ 1, 1 ] ]

k_1 := Size( ToM_1 );
#! 2

generating_set_1 := [ ];;
for i in [ 1 .. k_1 ] do
    M := ListWithIdenticalEntries( k_1, 0 )
    ; M[i] := 1; Add( generating_set_1, FinGSet( G_1, M ) ); od;

ToM_2 := MatTom( TableOfMarks( G_2 ) );
#! [ [ 20, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 10, 10, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 10, 0, 10, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 10, 0, 0, 10, 0, 0, 0, 0, 0, 0 ], 
#!   [ 5, 5, 5, 5, 5, 0, 0, 0, 0, 0 ], 
#!   [ 4, 0, 0, 0, 0, 4, 0, 0, 0, 0 ], 
#!   [ 2, 2, 0, 0, 0, 2, 2, 0, 0, 0 ], 
#!   [ 2, 0, 2, 0, 0, 2, 0, 2, 0, 0 ], 
#!   [ 2, 0, 0, 2, 0, 2, 0, 0, 2, 0 ], 
#!   [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ]

k_2 := Size( ToM_2 );
#! 10

generating_set_2 := [ ];;
for i in [ 1 .. k_2 ] do
    M := ListWithIdenticalEntries( k_2, 0 )
    ; M[i] := 1; Add( generating_set_2, FinGSet( G_2, M ) ); od;

SetInfoLevel( InfoWarning, 0 );

#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" )
computed_group := ReconstructGroup(
    SkeletalFinGSets( G_1 ),
    HomSkeletalFinGSets,
    ForgetfulFunctorSkeletalFinGSets( G_1 ),
    generating_set_1,
    EndAsEqualizer
);;
IsFinite( computed_group );;
IsomorphismGroups( computed_group, G_1 ) <> fail;
#! true

computed_group := ReconstructGroup(
    SkeletalFinGSets( G_1 ),
    HomSkeletalFinGSets,
    ForgetfulFunctorSkeletalFinGSets( G_1 ),
    generating_set_1,
    EndByLifts
);;
IsFinite( computed_group );;
IsomorphismGroups( computed_group, G_1 ) <> fail;
#! true

computed_group := ReconstructGroup(
    SkeletalFinGSets( G_2 ),
    HomSkeletalFinGSets,
    ForgetfulFunctorSkeletalFinGSets( G_2 ),
    generating_set_2,
    EndByLifts
);;
IsFinite( computed_group );;
IsomorphismGroups( computed_group, G_2 ) <> fail;
#! true
#! #@fi

#! @EndExample
