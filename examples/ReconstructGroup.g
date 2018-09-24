#! @System ReconstructGroup

LoadPackage( "FinGSetsForCAP" );

#! @ExampleSession

#! gap> G_1 := CyclicGroup( 5 );;
#! gap> G_2 := SmallGroup( 20, 5 );;
#! gap> 
#! gap> CapCategorySwitchLogicOff( FinSets );
#! gap> DeactivateCachingOfCategory( FinSets );
#! gap> DisableBasicOperationTypeCheck( FinSets );
#! gap> 
#! gap> DeactivateCachingOfCategory( SkeletalFinSets );
#! gap> CapCategorySwitchLogicOff( SkeletalFinSets );
#! gap> DisableBasicOperationTypeCheck( SkeletalFinSets );
#! gap> 
#! gap> CapCategorySwitchLogicOff( SkeletalFinGSets( G_1 ) );
#! gap> DeactivateCachingOfCategory( SkeletalFinGSets( G_1 ) );
#! gap> DisableBasicOperationTypeCheck( SkeletalFinGSets( G_1 ) );
#! gap> 
#! gap> CapCategorySwitchLogicOff( SkeletalFinGSets( G_2 ) );
#! gap> DeactivateCachingOfCategory( SkeletalFinGSets( G_2 ) );
#! gap> DisableBasicOperationTypeCheck( SkeletalFinGSets( G_2 ) );
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
#! gap> computed_group := ReconstructGroup(
#! >     SkeletalFinGSets( G_1 ),
#! >     HomSkeletalFinGSets,
#! >     ForgetfulFunctorSkeletalFinGSets( G_1 ),
#! >     generating_set_1,
#! >     EndAsEqualizer
#! > );
#! #I  default `IsGeneratorsOfMagmaWithInverses' method returns `true' for [ 
#!   <Reconstructed group element with ID 1>, 
#!   <Reconstructed group element with ID 2>, 
#!   <Reconstructed group element with ID 3>, 
#!   <Reconstructed group element with ID 4>, 
#!   <Reconstructed group element with ID 5> ]
#! <group with 5 generators>
#! gap> IsomorphismGroups( computed_group, G_1 );
#! #I  Forcing finiteness test
#! [ <Reconstructed group element with ID 1> ] -> [ f1 ]
#! 
#! gap> computed_group := ReconstructGroup(
#! >     SkeletalFinGSets( G_1 ),
#! >     HomSkeletalFinGSets,
#! >     ForgetfulFunctorSkeletalFinGSets( G_1 ),
#! >     generating_set_1,
#! >     EndByLifts
#! > );
#! #I  default `IsGeneratorsOfMagmaWithInverses' method returns `true' for [ 
#!   <Reconstructed group element with ID 1>, 
#!   <Reconstructed group element with ID 2>, 
#!   <Reconstructed group element with ID 3>, 
#!   <Reconstructed group element with ID 4>, 
#!   <Reconstructed group element with ID 5> ]
#! <group with 5 generators>
#! gap> IsomorphismGroups( computed_group, G_1 );
#! #I  Forcing finiteness test
#! [ <Reconstructed group element with ID 2> ] -> [ f1 ]
#! 
#! gap> computed_group := ReconstructGroup(
#! >     SkeletalFinGSets( G_2 ),
#! >     HomSkeletalFinGSets,
#! >     ForgetfulFunctorSkeletalFinGSets( G_2 ),
#! >     generating_set_2,
#! >     EndByLifts
#! > );
#! #I  default `IsGeneratorsOfMagmaWithInverses' method returns `true' for [ 
#!   <Reconstructed group element with ID 1>, 
#!   <Reconstructed group element with ID 2>, 
#!   <Reconstructed group element with ID 3>, 
#!   <Reconstructed group element with ID 4>, 
#!   <Reconstructed group element with ID 5>, 
#!   <Reconstructed group element with ID 6>, 
#!   <Reconstructed group element with ID 7>, 
#!   <Reconstructed group element with ID 8>, 
#!   <Reconstructed group element with ID 9>, 
#!   <Reconstructed group element with ID 10>, 
#!   <Reconstructed group element with ID 11>, 
#!   <Reconstructed group element with ID 12>, 
#!   <Reconstructed group element with ID 13>, 
#!   <Reconstructed group element with ID 14>, 
#!   <Reconstructed group element with ID 15>, 
#!   <Reconstructed group element with ID 16>, 
#!   <Reconstructed group element with ID 17>, 
#!   <Reconstructed group element with ID 18>, 
#!   <Reconstructed group element with ID 19>, 
#!   <Reconstructed group element with ID 20> ]
#! <group with 20 generators>
#! gap> IsomorphismGroups( computed_group, G_2 );
#! #I  Forcing finiteness test
#! [ <Reconstructed group element with ID 6>, 
#!   <Reconstructed group element with ID 11>, 
#!   <Reconstructed group element with ID 2> ] -> [ f2, f1, f3^2 ]

#! @EndExampleSession
