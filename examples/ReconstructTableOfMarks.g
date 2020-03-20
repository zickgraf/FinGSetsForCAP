#! @Chunk ReconstructTableOfMarks

LoadPackage( "FinGSetsForCAP" );

#! @Example

G := CyclicGroup( 210 );;

ToM := MatTom( TableOfMarks( G ) );
#! [ [ 210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 105, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 70, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 42, 0, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 35, 35, 35, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 30, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 21, 21, 0, 21, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 15, 15, 0, 0, 0, 15, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 14, 0, 14, 14, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0 ], 
#!   [ 10, 0, 10, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0 ], 
#!   [ 7, 7, 7, 7, 7, 0, 7, 0, 7, 0, 7, 0, 0, 0, 0, 0 ], 
#!   [ 6, 0, 0, 6, 0, 6, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0 ], 
#!   [ 5, 5, 5, 0, 5, 5, 0, 5, 0, 5, 0, 0, 5, 0, 0, 0 ], 
#!   [ 3, 3, 0, 3, 0, 3, 3, 3, 0, 0, 0, 3, 0, 3, 0, 0 ], 
#!   [ 2, 0, 2, 2, 0, 2, 0, 0, 2, 2, 0, 2, 0, 0, 2, 0 ], 
#!   [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ]

k := Size( ToM );
#! 16

minimal_generating_set := [ ];;

for i in [ 1 .. k ] do
    M := ListWithIdenticalEntries( k, 0 )
    ; M[ i ] := 1; Add( minimal_generating_set, FinGSet( G, M ) ); od;

Decompose := function( Omega, minimal_generating_set )
    return List( [ 1 .. k ], i ->
        AsList( Omega )[Position( AsList( minimal_generating_set[i] ), 1 )]
    ); end;;

#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" )
computed_ToM := ReconstructTableOfMarks(
    SkeletalFinGSets( G ),
    minimal_generating_set,
    Decompose
);;
computed_ToM = ToM;
#! true
#! #@fi

#! @EndExample
