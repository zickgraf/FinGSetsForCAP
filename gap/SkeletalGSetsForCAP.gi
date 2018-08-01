#
# SkeletalGSetsForCAP: The skeletal category of G sets
#
# Implementations
#

##
InstallMethod( GSet,
        "for a group and a list of nonnegative integers",
        [ IsGroup, IsList ],
        
  function( group, L )
    local Omega;
    
    Omega := rec( );
    
    ObjectifyObjectForCAPWithAttributes( Omega, SkeletalGSets( group ),
            AsList, ShallowCopy( L ),
            UnderlyingGroup, group );
    
    Assert( 4, IsWellDefined( Omega ) );
    
    return Omega;
    
end );

##
InstallMethod( MapOfGSets,
        "for two CAP skeletal G sets and a list",
        [ IsSkeletalGSet, IsList, IsSkeletalGSet ],
        
  function( S, I, T )
    local group, map, k, imgs, g, j, U_j;
    
    group := UnderlyingGroup( S );

    if not IsIdenticalObj( group, UnderlyingGroup( T ) ) then
        Error( "The underlying groups of the source and the range are not the same with respect to IsIdenticalObj\n" );
    fi;
    
    k := Length( MatTom( TableOfMarks( group ) ) );
    
    if ( not IsList( I ) ) or ( not ForAll( I, x -> IsList( x ) ) ) then
        Error( "I has the wrong format\n" );
    fi;
    
    imgs := List( ShallowCopy( I ), x -> List( ShallowCopy( x ), function( img )
        if ( not IsList( img ) ) or Length( img ) <> 3 then
            Error( "images must be triples\n" );
        fi;

        img := ShallowCopy( img );
        
        g := img[ 2 ];
        if g in group then
            j := img[ 3 ];
            if not ( IsPosInt( j ) and j <= k ) then
                Error( "last entry of an image must be an integer j with 1 <= j <= k\n" );
            fi;
            U_j := RepresentativeTom( TableOfMarks( group ), j );
            img[ 2 ] := RightCoset( U_j, g );
        fi;
        return img;
    end ) );
    
    map := rec( );
    
    ObjectifyMorphismForCAPWithAttributes( map, SkeletalGSets( group ),
        AsList, imgs,
        Source, S,
        Range, T
    );
    
    Assert( 4, IsWellDefined( map ) );
     
    return map;
    
end );

##
InstallMethod( SkeletalGSets,
               [ IsGroup ],
               
  function( group )
    local
        CategoryName,
        SkeletalGSets,
        k,
        IntZeroVector,
        RepresentativeOfSubgroupsUpToConjugation,
        PositionOfSubgroup,
        OrbitsOfActionOnCartesianProduct,
        SingleBinaryProduct,
        ProjectionOfASingleBinaryProduct,
        ProjectionInFactorOfBinaryDirectProduct,
        OffsetInCartesianProduct,
        UniversalMorphismIntoBinaryDirectProductWithGivenDirectProduct,
        ExplicitCoequalizer,
        ProjectionOntoCoequalizerOfAConnectedComponent,
        Positions,
        Component,
        TargetPosition,
        ImagePositions,
        PreimagePositions,
        EmbeddingOfPositions;
    
    if HasName( group ) then
        CategoryName := Concatenation( "Skeletal Category of ", Name( group ), "-Sets" );
    else
        CategoryName := "Skeletal Category of G-Sets";
    fi;
    
    SkeletalGSets := CreateCapCategory( CategoryName );
    
    SkeletalGSets!.group_for_category := group;
    
    DisableAddForCategoricalOperations( SkeletalGSets );
    
    AddObjectRepresentation( SkeletalGSets, IsSkeletalGSet );
    
    AddMorphismRepresentation( SkeletalGSets, IsSkeletalGSetMap );
    
    k := Length( MatTom( TableOfMarks( group ) ) );
    
    IntZeroVector := function( i )
        
        return ListWithIdenticalEntries( i, 0 );
        
    end;
    
    RepresentativeOfSubgroupsUpToConjugation := function( i )
        
        return RepresentativeTom( TableOfMarks( group ), i );
        
    end;
    
    PositionOfSubgroup := function( U )
        local i;

        for i in [ 1 .. k ] do
            if U in ConjugateSubgroups( group, RepresentativeOfSubgroupsUpToConjugation( i ) ) then
                return i;
            fi;
        od;
         
    end;

    ##
    AddIsWellDefinedForObjects( SkeletalGSets,
      function( Omega )
        local L;
        
        L := AsList( Omega );
        
        if not Length( L ) = k then
            return false;
        fi;
        
        if not ForAll( L, a -> IsInt( a ) and a >= 0 ) then
            return false;
        fi;
        
        return true;
        
    end );

    ##
    AddIsEqualForObjects( SkeletalGSets,
      function( Omega1, Omega2 )
        
        # groups have to be the same, because G is fixed
        return AsList( Omega1 ) = AsList( Omega2 );
        
    end );

    # returns the positions of an object 'Omega'
    Positions := function( Omega )
        local M, positions, i, l;
        
        M := AsList( Omega );
        
        positions := [];
        
        for i in [ 1 .. k ] do
            for l in [ 1 .. M[ i ] ] do
                Add( positions, [ i, l ] );
            od;
        od;
        
        return positions;
    end;


    ## Morphisms

    ##
    AddIsWellDefinedForMorphisms( SkeletalGSets,
      function( mor )
        local S, T, img, tom, s, t, U_i, U_j, u;
        
        S := Source( mor );
        
        T := Range( mor );
        
        if not ( group = UnderlyingGroup( S ) and group = UnderlyingGroup( T ) ) then
            return false;
        fi;
        
        img := AsList( mor );
        
        if not Length( img ) = k then
            return Error( "The length of the list of relations is wrong.\n");
        fi;
        
        tom := MatTom( TableOfMarks( group ) );
        
        s := AsList( S );
        t := AsList( T );
        
        if not ForAll( [ 1 .. k ], i -> IsList( img[ i ] ) and Length( img[ i ] ) = s[ i ] and
            ForAll( img[ i ], function( e )
                                local r, g, j;
                                
                                if not ( IsList( e ) and Length( e ) = 3 ) then
                                    return Error( "The list of relations has a wrong syntax.\n" );
                                fi;
                                
                                r := e[1];
                                g := e[2];
                                j := e[3];
                                
                                # j has to be the index of a subgroup of group, i.e. an integer between 1 and k
                                # r has to be the index of a copy of U_j
                                # g has to be an element of group
                                # U_i has to be a subgroup of U_j up to conjugation, which can be read off the table of marks
                                
                                if not ( IsPosInt( j ) and j <= k and IsPosInt( r ) and r <= t[ j ] ) then
                                    return Error( "2\n" );
                                fi;

                                U_i := RepresentativeOfSubgroupsUpToConjugation( i );
                                U_j := RepresentativeOfSubgroupsUpToConjugation( j );

                                if not ( g in RightCosets( group, U_j ) and tom[ j ][ i ] > 0 ) then
                                    return Error( "3\n" );
                                fi;
                                
                                # U_i has to be a subgroup of U_j up to conjugation with Inverse(g)
                                if not IsSubset( U_j, ConjugateSubgroup( U_i, Inverse( Representative( g ) ) ) ) then
                                    return Error( "4\n" );
                                fi;
                                
                                return true;
                            end
                  )
                     ) then
            return Error( "5\n" );
        fi;
        
        return true;
        
    end );

    ##
    AddIsEqualForMorphisms( SkeletalGSets,
      function( mor1, mor2 )
        
        return AsList( mor1 ) = AsList( mor2 );
        
    end );

    ##
    AddIdentityMorphism( SkeletalGSets,
      function( Omega )
        local L, M, i, C, l;
        
        L := [];
        M := AsList( Omega );
        
        for i in [ 1 .. k ] do
            C := [];
            for l in [ 1 .. M[ i ] ] do
                Add( C, [ l, Identity( group ), i ] );
            od;
            Add( L, C );
        od;
        
        return MapOfGSets( Omega, L, Omega );
        
    end );

    ##
    AddPreCompose( SkeletalGSets,
      function( map_pre, map_post )
        local cmp, S, M, i, C, l, img_1, r_1, g_1, j_1, img_2, r_2, g_2, j_2;
        
        cmp := [];
        
        S := Source( map_pre );
        
        M := AsList( S );
        
        for i in [ 1 .. k ] do
            C := [];
            for l in [ 1 .. M[ i ] ] do
                img_1 := Component( map_pre, [ i, l ] );
                r_1 := img_1[ 1 ];
                g_1 := img_1[ 2 ];
                j_1 := img_1[ 3 ];
                
                img_2 := Component( map_post, [ j_1 , r_1 ] );
                r_2 := img_2[ 1 ];
                g_2 := img_2[ 2 ];
                j_2 := img_2[ 3 ];
                
                Add( C, [ r_2, Representative( g_2 ) * Representative( g_1 ), j_2 ] );
            od;
            Add( cmp, C );
        od;
        
        return MapOfGSets( S, cmp, Range( map_post ) );
        
    end );
    
    # returns the component of a morphism 'phi' at position 'position'
    Component := function( phi, position )
        return AsList( phi )[ position[ 1 ] ][ position[ 2 ] ];
    end;
    
    # returns the target position of a component 'component' of a morphism
    TargetPosition := function( component )
        return [ component[ 3 ], component[ 1 ] ];
    end;
    
    ##
    ImagePositions := function( phi )
        local S, T, positions;
        
        S := Source( phi );
        T := Range( phi );
        
        positions := Filtered( Positions( T ), p_T -> ForAny( Positions( S ), p_S -> TargetPosition( Component( phi, p_S ) ) = p_T ) );

        return positions;
        
    end;
    
    ##
    PreimagePositions := function( phi, targetPositions )
        local S, positions;
        
        S := Source( phi );
        
        positions := Filtered( Positions( S ), p -> TargetPosition( Component( phi, p ) ) in targetPositions );
        
        return positions;
        
    end;
    
    ##
    EmbeddingOfPositions := function( positions, T )
        local L, S, M, D, i, C, l, iota;
        
        # impose lexicographical order
        positions := Set( positions );
        
        L := List( [ 1 .. k ], i -> Filtered( positions, p -> p[ 1 ] = i ) );
        
        S := GSet( group, List( L, p -> Length( p ) ) );
        
        M := AsList( S );
        
        D := [];
        
        for i in [ 1 .. k ] do 
            C := [];
            for l in [ 1 .. M[ i ] ] do
                Add( C, [ L[ i ][ l ][ 2 ], Identity( group ), i ] );
            od;
            Add( D, C );
        od;

        iota := MapOfGSets( S, D, T );
        
        Assert( 3, IsMonomorphism( iota ) );
        
        SetIsMonomorphism( iota, true );
        
        return iota;
        
    end;
    
    ##
    AddLiftAlongMonomorphism( SkeletalGSets,
      function( iota, phi )
        local S, T, M, D, i, C, l, img, r, g, j, preimagePosition, t, h, s;
      
        S := Source( phi );
        T := Source( iota );
        
        M := AsList( S );
        
        D := [];
        
        for i in [ 1 .. k ] do
            C := [];
            for l in [ 1 .. M[ i ] ] do
                img := Component( phi, [ i , l ] );
                r := img[ 1 ];
                g := Representative( img[ 2 ] );
                j := img[ 3 ];
                
                # get the unique preimage position under iota
                preimagePosition := PreimagePositions( iota, [ [ j, r ] ] )[ 1 ];
                
                t := preimagePosition[ 2 ];
                h := Representative( Component( iota, preimagePosition )[ 2 ] );
                s := preimagePosition[ 1 ];
                
                Add( C, [ t, Inverse( h ) * g, s ] );
            od;
            Add( D, C );
        od;

        return MapOfGSets( S, D, T );
        
    end );
    
    ##
    AddColiftAlongEpimorphism( SkeletalGSets,
      function( pi, phi )
        local S, T, M, D, i, C, l, img, r, g, j, preimagePosition, t, h, s;
      
        S := Range( pi );
        T := Range( phi );
        
        M := AsList( S );
        
        D := [];
        
        for i in [ 1 .. k ] do
            C := [];
            for l in [ 1 .. M[ i ] ] do
                # get some preimage position under pi
                preimagePosition := PreimagePositions( pi, [ [ i, l ] ] )[ 1 ];
                
                h := Representative( Component( pi, preimagePosition )[ 2 ] );

                img := Component( phi, preimagePosition );
                r := img[ 1 ];
                g := Representative( img[ 2 ] );
                j := img[ 3 ];
                
                Add( C, [ r, g * Inverse( h ), j ] );
            od;
            Add( D, C );
        od;

        return MapOfGSets( S, D, T );
        
    end );

    ## Limits

    ##
    AddTerminalObject( SkeletalGSets,
      function( arg )
        local L;
        
        L := IntZeroVector( k );
        
        L[ k ] := 1;
        
        return GSet( group, L );
        
    end );

    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( SkeletalGSets,
      function( Omega, T )
        local L, M, i, C, l;
        
        L := [];
        
        M := AsList( Omega );
        
        for i in [ 1 .. k ] do
            C := [];
            for l in [ 1 .. M[ i ] ] do
                Add( C, [ 1, Identity( group ), k ] );
            od;
            Add( L, C );
        od;
        
        return MapOfGSets( Omega, L, T );
        
    end );

    ##
    AddDirectProduct( SkeletalGSets,
      function( L )
        local ToM, prod, l, M_l, i, V, B, C;
        
        ToM := TableOfMarks( group );
        
        ToM := MatTom( ToM );
        
        prod := List( [ 1 .. k ], x -> 1 );
         
        for l in L do
            M_l := AsList( l ) * ToM;
            for i in [ 1 .. k ] do
                prod[i] := prod[i] * M_l[i];
            od;
        od;
        
        V := VectorSpace( Rationals, ToM );
        
        B := Basis( V, ToM );
        
        C := Coefficients( B, prod );
        
        return GSet( group, C );
        
    end );
    
    OrbitsOfActionOnCartesianProduct := function( L )
        local LoS, LoF, C, e, o;
        
        # ListOfSubgroups
        LoS := List( L, i -> RepresentativeOfSubgroupsUpToConjugation( i ) );
        
        # ListOfFactorgroups
        LoF := List( LoS, U -> RightCosets( group, U ) );
        
        C := Cartesian( LoF );
        
        # Action of G on C by rightmultiplication
        e := ExternalSet( group, C, OnRight );
        
        o := Orbits( e );
        
        return o;
        
    end;
    
    SingleBinaryProduct := function( i, j )
        local G_i, G_j;
        
        # U_i\G
        G_i := IntZeroVector( k );
        G_i[ i ] := 1;
        # U_j\G
        G_j := IntZeroVector( k );
        G_j[ j ] := 1;
        
        return DirectProduct( [ GSet( group, G_i ), GSet( group, G_j ) ] );
        
    end;
    
    ProjectionOfASingleBinaryProduct := function( i, j, pos, copy_number, target )
        local o, RoO, imgs, r, s, a, found_g, U_a, g, P, pi, l, img, target_index;
        
        o := OrbitsOfActionOnCartesianProduct( [ i, j ] );
        
        # Representatives Of Orbits
        RoO := List( o, x -> x[ 1 ] );
        
        imgs := List( [ 1 .. k ], x -> [] );
        
        for r in RoO do
            s := Stabilizer( group, r, OnRight );
            
            found_g := false;
            for a in [ 1 .. k ] do
                U_a := RepresentativeOfSubgroupsUpToConjugation( a );
                for g in group do
                    if ConjugateSubgroup( s, Inverse( g ) ) = U_a then
                        found_g := true;
                        break;
                    fi;
                od;
                if found_g then
                    break;
                fi;
            od;
            
            Add( imgs[ a ], r * Inverse( g ) );
        od;
        
        # take the direct product of U_i\G and U_j\G and construct the projection pi
        P := SingleBinaryProduct( i, j );
        
        pi := [];
        for l in [ 1 .. k ] do
            pi [ l ] := [];
            for img in imgs[ l ] do
                if pos = 1 then
                    target_index := i;
                else
                    target_index := j;
                fi;
                
                Add( pi[ l ], [ copy_number, img[ pos ], target_index ] );
            od;
        od;
        
        return MapOfGSets( P, pi, target );
        
    end;

    ProjectionInFactorOfBinaryDirectProduct := function( L, pos )
        local S, T, M, N, D, tau, i, j, l, imgs, img, m, n, target, copy_number, pi, P;
        
        Assert( 4, Size( L ) = 2 );
        
        S := DirectProduct( L );
        
        T := L[ pos ];
        
        M := AsList( L[ 1 ] );
        N := AsList( L[ 2 ] );
        
        D := [];
        tau := [];
        
        for i in [ 1 .. k ] do
            for j in [ 1 .. k ] do
                for m in [ 1 .. M[i] ] do
                    for n in [ 1 .. N[j] ] do
                        if pos = 1 then
                            copy_number := m;
                        else
                            copy_number := n;
                        fi;
                        
                        pi := ProjectionOfASingleBinaryProduct( i, j, pos, copy_number, T );
                           
                        P := Source( pi );
                        
                        Add( D, P );
                        Add( tau, pi );
                    od;
                od;
            od;
        od;
        
        return UniversalMorphismFromCoproduct( D, tau );
        
    end;

    ##
    AddProjectionInFactorOfDirectProduct( SkeletalGSets,
      function( L, pos )
        local P, pi1, pi2;
        
        if Length( L ) = 1 then
            return IdentityMorphism( L[ 1 ] );
        fi;
        
        P := DirectProduct( L{ [ 2 .. Length( L ) ] } );
        
        if pos = 1 then
            return ProjectionInFactorOfBinaryDirectProduct( [ L[ 1 ], P ], 1 );
        else
            pi1 := ProjectionInFactorOfBinaryDirectProduct( [ L[ 1 ], P ], 2 );
            pi2 := ProjectionInFactorOfDirectProduct( L{ [ 2 .. Length( L ) ] }, pos - 1 );
            return PreCompose( pi1, pi2 );
        fi;
        
    end );
     
    OffsetInCartesianProduct := function( M, N, given_i, given_j, given_m, given_n  )
        local result, i, j, m, n, pi;
        
        result := IntZeroVector( k );
        
        for i in [ 1 .. k ] do
            for j in [ 1 .. k ] do
                for m in [ 1 .. M[i] ] do
                    for n in [ 1 .. N[j] ] do
                        if i = given_i and j = given_j and m = given_m and n = given_n then
                            return result;
                        fi;
                        
                        result := result + AsList( SingleBinaryProduct( i, j ) );
                        
                    od;
                od;
            od;
        od;
        
    end;

    UniversalMorphismIntoBinaryDirectProductWithGivenDirectProduct := function( D, tau, T )
        local S, M, N, imgs, i, l, r_1, r_2, g_1, g_2, j_1, j_2, Offset, Orbits, RoO, SRO, img, o, g, s, j, Internaloffset, p, j_p, r, U_j, conj, found_conj;
        
        Assert( 4, Size( D ) = 2 );
        
        S := Source( tau[ 1 ] );
        
        M := AsList( Range( tau[ 1 ] ) );
        N := AsList( Range( tau[ 2 ] ) );
        
        imgs := [];
        
        for i in [ 1 .. k ] do
            imgs[ i ] := [];
            for l in [ 1.. AsList( S )[ i ] ] do
                r_1 := AsList( tau[ 1 ] )[ i ][ l ][ 1 ];
                r_2 := AsList( tau[ 2 ] )[ i ][ l ][ 1 ];
                g_1 := AsList( tau[ 1 ] )[ i ][ l ][ 2 ];
                g_2 := AsList( tau[ 2 ] )[ i ][ l ][ 2 ];
                j_1 := AsList( tau[ 1 ] )[ i ][ l ][ 3 ];
                j_2 := AsList( tau[ 2 ] )[ i ][ l ][ 3 ];
                
                Offset := OffsetInCartesianProduct( M, N, j_1, j_2, r_1, r_2 );
                
                Orbits := OrbitsOfActionOnCartesianProduct( [ j_1, j_2 ] );
                
                # Representatives Of Orbits
                RoO := List( Orbits, x -> x[ 1 ] );
                
                # Stabilizers of Representatives of orbits
                SRO := List( RoO, r -> Stabilizer( group, r, OnRight ) );
                
                # image in the Cartesian product
                img := [ g_1, g_2 ];
                
                # find the orbit containing img
                for o in [ 1 .. Length( Orbits ) ] do
                    if img in Orbits[ o ] then
                        break;
                    fi;
                od;
                 
                # find an element of g which maps the representative of o to img
                for g in group do
                    if RoO[ o ] * g = img then
                        break;
                    fi;
                od;
                
                s := SRO[ o ];
                
                found_conj := false;
                for j in [ 1 .. k ] do
                    U_j := RepresentativeOfSubgroupsUpToConjugation( j );
                    for conj in group do
                        if ConjugateSubgroup( s, Inverse( conj ) ) = U_j then
                            found_conj := true;
                            break;
                        fi;
                    od;
                    if found_conj then
                        break;
                    fi;
                od;
                 
                Internaloffset := 0;
                 
                for p in [ 1 .. Length( SRO )] do
                    j_p := PositionOfSubgroup( SRO[ p ] );
                    if j = j_p then
                        Internaloffset := Internaloffset + 1;
                        if p = o then
                            break;
                        fi;
                    fi;
                od;
                  
                r := Offset[ j ] + Internaloffset;
                Add( imgs[i], [ r, conj * g, j ] );
            od;
        od;
        
        return MapOfGSets( S, imgs, T );
        
    end;

    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( SkeletalGSets,
      function( D, tau, T )
        local D2, tau2, sigma;
        
        if Length( D ) = 1 then
            return tau[ 1 ];
        fi;
        
        if Length( D ) = 2 then
            return UniversalMorphismIntoBinaryDirectProductWithGivenDirectProduct( D, tau, T );
        fi;
        
        D2 := D{ [ 2 .. Length( D ) ] };
        tau2 := tau{ [ 2 .. Length( tau ) ] };
        
        sigma := UniversalMorphismIntoDirectProduct( D2, tau2 );
        return UniversalMorphismIntoBinaryDirectProductWithGivenDirectProduct( [ D[ 1 ], DirectProduct( D2 ) ], [ tau[ 1 ], sigma ], T );
        
    end );

    ##
    AddEmbeddingOfEqualizer( SkeletalGSets,
      function( D )
        local phi_1, S, positions;
        
        phi_1 := D[ 1 ];
        
        S := Source( phi_1 );
        
        D := D{ [ 2 .. Length( D ) ] };
        
        positions := Filtered( Positions( S ), p -> ForAll( D, phi -> Component( phi_1, p ) = Component( phi, p ) ) );
        
        return EmbeddingOfPositions( positions, S );
        
    end );

    ## Colimits

    ##
    AddInitialObject( SkeletalGSets,
      function( arg )
        
        return GSet( group, IntZeroVector( k ) );
        
    end );

    ##
    AddUniversalMorphismFromInitialObject( SkeletalGSets,
      function( Omega )
        
        return MapOfGSets( GSet( group, IntZeroVector( k ) ), List( AsList( Omega ), x -> [] ), Omega );
        
    end );

    ##
    AddCoproduct( SkeletalGSets,
      function( L )
        local sum, l;
        
        sum := IntZeroVector( k );
        
        for l in L do
            sum := sum + AsList( l );
        od;
        
        return GSet( group, sum );
        
    end );

    ##
    AddInjectionOfCofactorOfCoproduct( SkeletalGSets,
      function( L, pos )
        local S, M, T, sum, j, imgs, i, C, l;
        
        S := L[ pos ];
        
        M := AsList( S );
        
        T := Coproduct( L );
        
        sum := IntZeroVector( k );
        
        for j in [ 1 .. (pos - 1) ] do
            sum := sum + AsList( L[ j ] );
        od;
        
        imgs := [];
        
        for i in [ 1 .. k ] do
            C := [];
            for l in [ 1 .. M[ i ] ] do
                Add( C, [ sum[i] + l, Identity( group ), i ] );
            od;
            Add( imgs, C );
        od;
        
        return MapOfGSets( S, imgs, T );
        
    end );

    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( SkeletalGSets,
      function( D, tau, S )
        local T, M, imgs, i, C, j;
        
        T := Range( tau[1] );
        
        M := AsList( S );
        
        imgs := [];
        
        for i in [ 1 .. k ] do
            C := [];
            for j in [ 1 .. Length(tau) ] do
                C := Concatenation( C, AsList(tau[ j ])[ i ] );
            od;
            Add( imgs, C );
        od;
        
        return MapOfGSets( S, imgs, T );
        
    end );

    ##
    ExplicitCoequalizer :=  function( D )
    # TODO
        local IsEqualModSubgroup, AsASet, A, B, ASet, BSet, AreEquivalent, equivalence_classes, b, first_equivalence_class, i, class, j, element, OurAction, external_set, orbits, RoO, Cq, r, s;
        
        
        IsEqualModSubgroup := function( g1, g2, U )
            
            return g1 * Inverse( g2 ) in U;
            
        end;

        
        AsASet := function( M )
            local set, i, U, l, g;
            
            set := [];
            for i in [ 1 .. k ] do
                U := RepresentativeOfSubgroupsUpToConjugation( i );
                for l in [ 1 .. M[ i ] ] do
                    set := Concatenation( set, List( RightTransversal( group, U ), g -> [ l, g, i ] ) );
                od;
            od;
            return set;
            
        end;

        A := Source( D[ 1 ] );
        B := Range( D[ 1 ] );
        ASet := AsASet( AsList( A ) );
        BSet := AsASet( AsList( B ) );
        
        AreEquivalent := function(e, b)
            local a, imgs, found_e, found_b, img, U;
            if e = b then
                Error( "this should not happen" );
            fi;
            
            for a in ASet do
                imgs := List( D, f -> f( a ) );
                found_e := false;
                found_b := false;
                for img in imgs do
                    U := RepresentativeOfSubgroupsUpToConjugation( img[ 3 ] );
                    if e[ 3 ] = img[ 3 ] and e[ 1 ] = img[ 1 ] and IsEqualModSubgroup( e[ 2 ], img[ 2 ], U ) then
                        found_e := true;
                    fi;
                    if b[ 3 ] = img[ 3 ] and b[ 1 ] = img[ 1 ] and IsEqualModSubgroup( b[ 2 ], img[ 2 ], U ) then
                        found_b := true;
                    fi;
                    if found_e and found_b then
                        return true;
                    fi;
                od;
            od;
            
            return false;
        end;
        
        Display( ASet );
        Display( Length( ASet));
        Display( BSet );
        Display( Length( BSet));
        
        equivalence_classes := [];
        for b in BSet do
            first_equivalence_class := 0;
            for i in [ 1 .. Length( equivalence_classes ) ] do
                class := equivalence_classes[ i ];
                for j in [ 1 .. Length( class ) ] do
                    element := class[ j ];
                    # prüfe ob element ~ b
                    if AreEquivalent( element, b) then
                        if first_equivalence_class > 0 then
                            # merge class and first_equivalence_class
                            Display( "classes are merged" );
                            equivalence_classes[ first_equivalence_class ] := Union2( equivalence_classes[ first_equivalence_class ], class );
                            equivalence_classes[ i ] := [];
                        else
                            Add( equivalence_classes[ i ], b);
                            first_equivalence_class := i;
                        fi;
                        break;
                    fi;
                od;
            od;
            if first_equivalence_class = 0 then
                Add(equivalence_classes, [ b ]);
            fi;
        od;
        equivalence_classes := Filtered( equivalence_classes, x -> Length( x ) > 0 );
        
        Display( Size( equivalence_classes ) );
        
        OurAction := function( pnt, g )
            local representative, l_r, g_r, i_r, result, class, element, U;
            
            representative := pnt[ 1 ];
            
            l_r := representative[ 1 ];
            g_r := representative[ 2 ];
            i_r := representative[ 3 ];
            
            result := [ l_r, g_r * g, i_r ];
            for class in equivalence_classes do
                for element in class do
                    
                    U := RepresentativeOfSubgroupsUpToConjugation( result[ 3 ] );
                    
                    if result[ 3 ] = element[ 3 ] and result[ 1 ] = element[ 1 ] and IsEqualModSubgroup( result[ 2 ], element[ 2 ], U ) then
                        return class;
                    fi;
                od;
            od;
        end;

        external_set := ExternalSet( group, equivalence_classes, OurAction );

        
        orbits := Orbits( external_set );
        
        # Representatives Of Orbits
        RoO := List( orbits, x -> x[ 1 ] );
        
        Cq := IntZeroVector( k );
        for r in RoO do
            s := Stabilizer( group, r, OurAction );
            i := PositionOfSubgroup( s );
            Cq[ i ] := Cq[ i ] + 1;
        od;
        
        return GSet( group, Cq );
    end;

    ##
    ProjectionOntoCoequalizerOfAConnectedComponent := function( D )
      local S, T, M, N, equations, a, b, i, l, phi_a, phi_b, img_a, img_b, e, solutions, j_a, r_a, g_a, j_b, r_b, g_b, X, j, r, U_j, h, h_a, h_b, V, U_i, g, Cq, imgs, pi;
        
        S := Source( D[ 1 ] );
        T := Range( D[ 1 ] );

        M := AsList( S );
        N := AsList( T );
        
        # build the system of equations
        equations := [];
        for a in [ 1 .. Length( D ) ] do
            for b in [ ( a + 1 ) .. Length( D ) ] do
                for i in [ 1 .. k ] do
                    for l in [ 1 .. M[ i ] ] do
                        phi_a := D[ a ];
                        phi_b := D[ b ];
                        
                        img_a := Component( phi_a, [ i, l ] );
                        img_b := Component( phi_b, [ i, l ] );

                        e := rec();
                        e.("j_a") := img_a[ 3 ];
                        e.("r_a") := img_a[ 1 ];
                        e.("g_a") := Representative( img_a[ 2 ] );

                        e.("j_b") := img_b[ 3 ];
                        e.("r_b") := img_b[ 1 ];
                        e.("g_b") := Representative( img_b[ 2 ] );
                        
                        Add( equations, e );
                    od;
                od;
            od;
        od;

        # solve the system of equations
        # "false" indicates that a solution is not yet known
        solutions := List( [ 1 .. k ], j -> ListWithIdenticalEntries( N[ j ], false ) );
        solutions[ PositionProperty( N, x -> x <> 0 ) ][ 1 ] := Identity( group );
        repeat
            for e in equations do
                j_a := e.j_a;
                r_a := e.r_a;
                g_a := e.g_a;

                j_b := e.j_b;
                r_b := e.r_b;
                g_b := e.g_b;
                
                if solutions[ j_a ][ r_a ] = false and solutions[ j_b ][ r_b ] <> false then
                    solutions[ j_a ][ r_a ] := solutions[ j_b ][ r_b ] * g_b * Inverse( g_a );
                fi;
                if solutions[ j_a ][ r_a ] <> false and solutions[ j_b ][ r_b ] = false then
                    solutions[ j_b ][ r_b ] := solutions[ j_a ][ r_a ] * g_a * Inverse( g_b );
                fi;
            od;
            
        until ForAll( solutions, x -> ForAll( x, y -> y <> false ) );
        
        X := [];
        for j in [ 1 .. k ] do
            for r in [ 1 .. N[ j ] ] do
                U_j := RepresentativeOfSubgroupsUpToConjugation( j );
                h := solutions[ j ][ r ];
                X := Concatenation( X, GeneratorsOfGroup( ConjugateSubgroup( U_j, Inverse( h ) ) ) );
            od;
        od;
        
        for e in equations do
            h_a := solutions[ e.j_a ][ e.r_a ];
            h_b := solutions[ e.j_b ][ e.r_b ];
            Add( X , h_b * e.g_b * Inverse( e.g_a ) * Inverse( h_a ) );
        od;

        V := Subgroup( group, X );
        for i in [ 1 .. k ] do
            U_i := RepresentativeOfSubgroupsUpToConjugation( i );
            for g in group do
                if ConjugateSubgroup( V, Inverse( g ) ) = U_i then
                    Cq := IntZeroVector( k );
                    Cq[ i ] := 1;
                    
                    imgs := [];
                    for j in [ 1 .. k ] do
                        imgs[ j ] := [];
                        for r in [ 1 .. N[ j ] ] do
                            imgs[ j ][ r ] := [ 1, g * solutions[ j ][ r ], i ]; 
                        od;
                    od;
                    
                    pi := MapOfGSets( T, imgs, GSet( group, Cq ) );
                    
                    return pi;
                fi;
            od;
        od;
        
    end;

    ##
    AddProjectionOntoCoequalizer( SkeletalGSets,
      function( D )
        local S, T, M, N, Cq, rangePositions, imgs, j, r, previousImagePositions, preimagePositions, imagePositions, iota, preimageEmbedding, imageEmbedding, projection, imageEmbeddings, projections, tau, alpha, pi;
        
        S := Source( D[ 1 ] );
        T := Range( D[ 1 ] );

        M := AsList( S );
        N := AsList( T );
        
        imageEmbeddings := [];
        projections := [];
        
        rangePositions := Positions( T );
        
        if IsEmpty( rangePositions ) then
            # T is the empty G-set. Thus, the coequalizer also has to be the empty G-set and the projection is the identity.
            return IdentityMorphism( T );
        fi;
        
        while( not IsEmpty( rangePositions ) ) do
            imagePositions := [ rangePositions[ 1 ] ];
            previousImagePositions := [ ];
            while previousImagePositions <> imagePositions do
                previousImagePositions := imagePositions;
                preimagePositions := Union( List( D, phi -> PreimagePositions( phi, imagePositions ) ) );
                if not IsEmpty( preimagePositions ) then
                    iota := EmbeddingOfPositions( preimagePositions, S );
                    imagePositions := Union( List( D, phi -> ImagePositions( PreCompose( iota, phi ) ) ) );
                fi;
            od;

            preimageEmbedding := EmbeddingOfPositions( preimagePositions, S );
            imageEmbedding := EmbeddingOfPositions( imagePositions, T );
            projection := ProjectionOntoCoequalizerOfAConnectedComponent( List( D, phi -> LiftAlongMonomorphism( imageEmbedding, PreCompose( preimageEmbedding, phi ) ) ) );
            
            Add( imageEmbeddings, imageEmbedding );
            Add( projections, projection );
            
            Assert( 4, IsSubset( rangePositions, imagePositions ) );

            rangePositions := Difference( rangePositions, imagePositions );
        od;

        tau := CoproductFunctorial( projections );
        alpha := UniversalMorphismFromCoproduct( imageEmbeddings );
        pi := PreCompose( Inverse( alpha ), tau );
        
        return pi;
        
    end );
    
    ##
    AddImageEmbedding( SkeletalGSets,
      function( phi )
        
        return EmbeddingOfPositions( ImagePositions( phi ), Range( phi ) );
        
    end );

    ##
    AddIsEpimorphism( SkeletalGSets,
      function( phi )
        
        return ImageObject( phi ) = Range( phi );
        
    end );

    ##
    AddIsMonomorphism( SkeletalGSets,
      function( phi )
        
        return AsList( ImageObject( phi ) ) = AsList( Source( phi ) );
        
    end );

    Finalize( SkeletalGSets );

    ##
    InstallMethod( Display,
            "for a CAP skeletal G set",
            [ IsSkeletalGSet ],
            
      function( N )
        Display( [ UnderlyingGroup( N ), AsList( N ) ] );
    end );

    ##
    InstallMethod( Display,
            "for a CAP map of CAP skeletal G sets",
            [ IsSkeletalGSetMap ],
            
      function( mor )
        Display( List( AsList( mor ), x -> List( x, y -> [ y[ 1 ], Representative( y[ 2 ] ), y[ 3 ] ] ) ) );
    end );


    return SkeletalGSets;
        
end );
