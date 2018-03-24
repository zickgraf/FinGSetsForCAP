EndByLifts := function( C, HomC, HomFinSetsSkeletal, ForgetfulFunctor, GeneratingSet )
    local IntToMorphism, PseudoMorphismToInt, PermutationsListKWithRestrictions, PermutationsListWithRestrictions, LiftsAlongEpis, knownLifts, LiftMapsAlongEpis, LiftEfficiently, End_G;

	IntToMorphism := function( S, int, T )
		local s, t, L, i, phi;
		s := Length( S );
		t := Length( T );
		L := ListWithIdenticalEntries( s, 1 );
		# lists start with entry 1, we want to start at 0 and add back 1 later
		int := int - 1;
		i := 1;
		while int <> 0 do
			L[ i ] := ( int mod t ) + 1;
			int := QuoInt( int, t );
			i := i + 1;
		od;
		phi := MapOfFinSets( S, L, T );

		return phi;
	end;
	
	PseudoMorphismToInt := function( s, imgs, t )
		local int, i;
		
		int := 0;
		for i in [ 0 .. ( s - 1 ) ] do
			int := int + ( imgs[ i + 1 ] - 1 ) * t^i;
		od;

		return int + 1;
	end;
	
	# adapted from PermutationsListK
	PermutationsListKWithRestrictions := function ( mset, m, n, k, perm, i, restrictions )
		local  perms, l;
		if k = 0  then
			perm := ShallowCopy( perm );
			perms := [ perm ];
		else
			perms := [  ];
			for l  in [ 1 .. n ]  do
				if m[l] and (l = 1 or m[l - 1] = false or mset[l] <> mset[l - 1]) and (mset[l] in restrictions[i]) then
					perm[i] := mset[l];
					m[l] := false;
					Append( perms, PermutationsListKWithRestrictions( mset, m, n, k - 1, perm, i + 1, restrictions ) );
					m[l] := true;
				fi;
			od;
		fi;
		return perms;
	end;

	# adapted from PermutationsList
	PermutationsListWithRestrictions := function ( mset, restrictions )
		local  m;
		mset := ShallowCopy( mset );
		Sort( mset );
		m := List( mset, function ( i )
				return true;
			end );
		return PermutationsListKWithRestrictions( mset, m, Length( mset ), Length( mset ), [  ], 1, restrictions );
	end;

	LiftsAlongEpis := function( f_1, epis_1, f_2, epis_2 )
		local S, T, s, t, preimages, i, preimage_1, preimage_2, preimage, lifts, maps;

		S := Source( epis_1[ 1 ] );
		T := S;
		s := Length( S );
		t := s;
		
		preimages := [];
		for i in [ 1 .. s ] do
			preimage_1 := Intersection( List( epis_1, epi -> Preimage( epi, [ AsList( PreCompose( epi, f_1 ) )[ i ] ] ) ) );
			preimage_2 := Intersection( List( epis_2, epi -> Preimage( epi, [ AsList( PreCompose( epi, f_2 ) )[ i ] ] ) ) );
			preimage := Intersection( preimage_1, preimage_2 );
			if IsEmpty( preimage ) then
				return [];
			fi;
			preimages[ i ] := preimage;
		od;

		lifts := PermutationsListWithRestrictions( [ 1 .. s ], preimages );
		
		maps := List( lifts, imgs -> PseudoMorphismToInt( s, imgs, t ) );
		
		return maps;
	end;

	knownLifts := [];

	LiftMapsAlongEpis := function( Omega, Delta_1, maps_1, Delta_2, maps_2 )
		local lifts, Forgetful_HomGSets_1, Forgetful_HomGSets_2, counter, Length_maps_1, Length_maps_2, Length_maps, f_1, f_2, new_lifts, ApplyFunctor_ForgetfulFunctor_Omega;
		
		lifts := [];

		Display( "compute HomGSets" );
		
		Forgetful_HomGSets_1 := List( HomC( Omega, Delta_1 ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
		Forgetful_HomGSets_2 := List( HomC( Omega, Delta_2 ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
		counter := 1;
		Length_maps_1 := Length( maps_1 );
		Length_maps_2 := Length( maps_2 );
		Length_maps := Length_maps_1 * Length_maps_2;

		# Size_Omega_1 := Length( ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
		# Size_Omega_2 := Length( ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
		# LiftCount := ( Size_Omega_1 / Size_Omega_2 )^Size_Omega_1;
		
		for f_1 in maps_1 do
			Display( Concatenation( String( counter ), " of ", String( Length_maps ) ) );
			for f_2 in maps_2 do
				# Display( Concatenation( "Expecting ", String( Length( Forgetful_HomGSets ) ), " times <= ", String( LiftCount ) , " new_lifts" ) );
				counter := counter + 1;
				new_lifts := LiftsAlongEpis( f_1, Forgetful_HomGSets_1, f_2, Forgetful_HomGSets_2 );
				lifts := Union2( lifts, new_lifts );
			od;
		od;

		ApplyFunctor_ForgetfulFunctor_Omega := ApplyFunctor( ForgetfulFunctor, Omega );

		return List( lifts, lift -> IntToMorphism( ApplyFunctor_ForgetfulFunctor_Omega, lift, ApplyFunctor_ForgetfulFunctor_Omega ) );
	end;

	LiftEfficiently := function( GeneratingSet, pos )
		local Omega, pos_1, Delta_1, pos_2, Delta_2, factor_1, factor_2, maps_1, maps_2, lifts, Forgetful_HomGSets, group_order, counter;
		
		Omega := GeneratingSet[ pos ];

		if pos = Length( GeneratingSet ) then
			Display( "lift from trivial G-set" );
			return [ IdentityMorphism( ApplyFunctor( ForgetfulFunctor, Omega ) ) ];
		fi;
		
		# look for Delta_1 and Delta_2 which can be lifted to Delta
		for pos_1 in [ ( pos + 1 ) .. Length( GeneratingSet ) ] do
			Delta_1 := GeneratingSet[ pos_1 ];
			if Length( HomC( Omega, Delta_1 ) ) > 0 then
				break;
			fi;
		od;

		pos_2 := Length( GeneratingSet );
		Delta_2 := GeneratingSet[ pos_2 ];
		for pos_2 in [ ( pos_1 + 1 ) .. Length( GeneratingSet ) ] do
			Delta_2 := GeneratingSet[ pos_2 ];
			if Length( HomC( Delta_1, Delta_2 ) ) = 0 and Length( HomC( Omega, Delta_2 ) ) > 0 then
				break;
			fi;
		od;

		factor_1 := Length( ApplyFunctor( ForgetfulFunctor, Omega ) ) / Length( ApplyFunctor( ForgetfulFunctor, Delta_1 ) );
		factor_2 := Length( ApplyFunctor( ForgetfulFunctor, Omega ) ) / Length( ApplyFunctor( ForgetfulFunctor, Delta_2 ) ); 
		
		if factor_1 >= 11 then
		    Error( "Stopping, this would never terminate anyway..." );
		fi;

		Display( Concatenation( "lift along ", String( pos ), " -> ", String( pos_1 ), ", factor ", String( factor_1 ) ) );

		if IsBound( knownLifts[ pos_1 ] ) then
		    maps_1 := knownLifts[ pos_1 ];
		else
		    maps_1 := LiftEfficiently( GeneratingSet, pos_1 );
		fi;

		Display( Concatenation( "lift along ", String( pos ), " -> ", String( pos_2 ), ", factor ", String( factor_2 ) ) );
		
		if IsBound( knownLifts[ pos_2 ] ) then
		    maps_2 := knownLifts[ pos_2 ];
		else
		    maps_2 := LiftEfficiently( GeneratingSet, pos_2 );
		fi;
		
		lifts := LiftMapsAlongEpis( Omega, Delta_1, maps_1, Delta_2, maps_2 );
		
		# if pos = 1 and we have found exactly as many lifts as the group order we do not have to filter anymore
		group_order := Length( ApplyFunctor( ForgetfulFunctor, GeneratingSet[ 1 ] ) );
		if not ( pos = 1 and Length( lifts ) = group_order ) then
			# check compatibility with Omega
			Display( Concatenation( "filter ", String( Length( lifts ) ), " lifts" ) );

			# IDEA exclude id
			Forgetful_HomGSets := List( HomC( Omega, Omega ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
			
			counter := 0;
			lifts := Filtered( lifts, function( phi )
				if counter mod 10000 = 0 then
					Display(counter);
				fi;
				counter := counter + 1;
				return ForAll( Forgetful_HomGSets, function( f )
					return AsList( PreCompose( phi, f ) ) = AsList( PreCompose( f, phi ) );
				end );
			end );
		fi;

		Display( Concatenation( "################################### ", String( Length( lifts ) ), " lifts for position " , String( pos ) ) );
		
		knownLifts[ pos ] := lifts;

		return lifts;

	end;

	End_G := List( LiftEfficiently( GeneratingSet, 1 ), map -> [ map ] );

	return End_G;
end;
