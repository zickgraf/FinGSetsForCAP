#
# FinGSetsForCAP: ReconstructGroup
#
# Implementations
#

DeclareRepresentation( "IsReconstructedGroupElement", IsMultiplicativeElementWithInverse and IsAttributeStoringRep, [ ] );
TheTypeOfReconstructedGroupElements := NewType( NewFamily( "TheFamilyOfReconstructedGroupElements" ), IsReconstructedGroupElement );

DeclareAttribute( "AsList", IsReconstructedGroupElement );
DeclareAttribute( "ID", IsReconstructedGroupElement );

InstallGlobalFunction( ReconstructGroup, function ( C, HomC, ForgetfulFunctor, GeneratingSet, EndImplementation )
    local End, EndElements, unit, element;

    End := EndImplementation( C, HomC, ForgetfulFunctor, GeneratingSet );

    # construct group in GAP

    EndElements := List( [ 1 .. Length( End ) ], function ( i )
        local element;
        element := rec( );
        ObjectifyWithAttributes( element, TheTypeOfReconstructedGroupElements, AsList, End[i], ID, i );
        return element;
    end );

    InstallMethodWithCache( String,
      "for my group elements",
      [ IsReconstructedGroupElement ],
            
      function ( x )
        
        return Concatenation( "<Reconstructed group element with ID ", String( ID( x ) ), ">" );
        
    end );

    InstallMethodWithCache( \*,
      "for my group elements",
      [ IsReconstructedGroupElement, IsReconstructedGroupElement ],
            
      function ( x, y )
        local i, L, element;
        
        L := [ ];
        for i in [ 1 .. Length( AsList( x ) ) ] do
            L[i] := PreCompose( AsList( y )[i], AsList( x )[i] );
        od;
        
        for element in EndElements do
            if L = AsList( element ) then
                return element;
            fi;
        od;

        Error( "EndElements not closed under multiplication" );

    end );

    InstallMethodWithCache( \=,
      "for my group elements",
      [ IsReconstructedGroupElement, IsReconstructedGroupElement ],
        function ( x, y )
        
            return ID( x ) = ID( y );
        
        end );

    InstallMethodWithCache( \<,
      "for my group elements",
      [ IsReconstructedGroupElement, IsReconstructedGroupElement ],
         
      function ( x, y )
        
        return( ID( x ) < ID( y ) );

    end );

    unit := false;
    for element in EndElements do
        if ForAll( AsList( element ), f -> f = IdentityMorphism( Source( f ) ) ) then
            unit := element;
            break;
        fi;
    od;

    if unit = false then
        Error( "EndElements does not contain the identity" );
    fi;

    InstallMethodWithCache( One,
      "for my group elements",
      [ IsReconstructedGroupElement ],
            
      function ( x )
        
        return unit;
        
    end );

    InstallMethodWithCache( InverseOp,
      "for my group elements",
      [ IsReconstructedGroupElement ],
            
      function ( x )

        return x ^ (Length( EndElements ) - 1);
        
    end );

    return Group( EndElements );
end );
