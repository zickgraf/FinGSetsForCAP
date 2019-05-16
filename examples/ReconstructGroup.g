#! @Chunk ReconstructGroup

LoadPackage( "FinGSetsForCAP" );

#! @ExampleSession

#! gap> G_1 := CyclicGroup( 5 );;
#! gap> G_2 := SmallGroup( 20, 5 );;
#! gap> 
#! gap> if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" ) then
#! >     CapCategorySwitchLogicOff( FinSets );
#! >     DeactivateCachingOfCategory( FinSets );
#! >     DisableSanityChecks( FinSets );
#! > 
#! >     DeactivateCachingOfCategory( SkeletalFinSets );
#! >     CapCategorySwitchLogicOff( SkeletalFinSets );
#! >     DisableSanityChecks( SkeletalFinSets );
#! > fi;
#! gap> 
#! gap> CapCategorySwitchLogicOff( SkeletalFinGSets( G_1 ) );
#! gap> DeactivateCachingOfCategory( SkeletalFinGSets( G_1 ) );
#! gap> DisableSanityChecks( SkeletalFinGSets( G_1 ) );
#! gap> 
#! gap> CapCategorySwitchLogicOff( SkeletalFinGSets( G_2 ) );
#! gap> DeactivateCachingOfCategory( SkeletalFinGSets( G_2 ) );
#! gap> DisableSanityChecks( SkeletalFinGSets( G_2 ) );
#! gap> 
#! gap> DeactivateToDoList();
#! 
#! gap> ToM_1 := MatTom( TableOfMarks( G_1 ) );
#! [ [ 5, 0 ], [ 1, 1 ] ]
#! gap> k_1 := Size( ToM_1 );
#! 2
#! gap> generating_set_1 := [ ];;
#! gap> for i in [ 1 .. k_1 ] do
#! >     M := ListWithIdenticalEntries( k_1, 0 );
#! >     M[i] := 1;
#! >     Add( generating_set_1, FinGSet( G_1, M ) );
#! > od;
#! 
#! gap> ToM_2 := MatTom( TableOfMarks( G_2 ) );
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
#! gap> k_2 := Size( ToM_2 );
#! 10
#! gap> generating_set_2 := [ ];;
#! gap> for i in [ 1 .. k_2 ] do
#! >     M := ListWithIdenticalEntries( k_2, 0 );
#! >     M[i] := 1;
#! >     Add( generating_set_2, FinGSet( G_2, M ) );
#! > od;
#! 
#! gap> SetInfoLevel( InfoWarning, 0 );
#! 
#! gap> if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" ) then
#! >     computed_group := ReconstructGroup(
#! >         SkeletalFinGSets( G_1 ),
#! >         HomSkeletalFinGSets,
#! >         ForgetfulFunctorSkeletalFinGSets( G_1 ),
#! >         generating_set_1,
#! >         EndAsEqualizer
#! >     );
#! >     IsFinite( computed_group );
#! >     Display( IsomorphismGroups( computed_group, G_1 ) <> fail );
#! > else
#! >     Display( true );
#! > fi;
#! true
#! 
#! gap> if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" ) then
#! >     computed_group := ReconstructGroup(
#! >         SkeletalFinGSets( G_1 ),
#! >         HomSkeletalFinGSets,
#! >         ForgetfulFunctorSkeletalFinGSets( G_1 ),
#! >         generating_set_1,
#! >         EndByLifts
#! >     );
#! >     IsFinite( computed_group );
#! >     Display( IsomorphismGroups( computed_group, G_1 ) <> fail );
#! > else
#! >     Display( true );
#! > fi;
#! true
#! 
#! gap> if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" ) then
#! >     computed_group := ReconstructGroup(
#! >         SkeletalFinGSets( G_2 ),
#! >         HomSkeletalFinGSets,
#! >         ForgetfulFunctorSkeletalFinGSets( G_2 ),
#! >         generating_set_2,
#! >         EndByLifts
#! >     );
#! >     IsFinite( computed_group );
#! >     Display( IsomorphismGroups( computed_group, G_2 ) <> fail );
#! > else
#! >     Display( true );
#! > fi;
#! true

#! @EndExampleSession
