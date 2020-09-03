#
# FinGSetsForCAP: The elementary topos of (skeletal) finite G-sets
#
# Implementations
#

InstallGlobalFunction( PositionAndConjugatorOfStabilizer, function ( args... )
    local S, G, ToM, U_i, i, g;
    
    S := CallFuncList( Stabilizer, args );
    
    # Stabilizer has done input type checks
    G := args[1];
    
    ToM := TableOfMarks( G );
    
    for i in [ 1 .. Length( MarksTom( ToM ) ) ] do
        U_i := RepresentativeTom( ToM, i );
        for g in G do
            if ConjugateSubgroup( S, g ) = U_i then
                return [ i, g ];
            fi;
        od;
    od;
    
end );
