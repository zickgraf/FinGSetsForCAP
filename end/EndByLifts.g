EndByLifts := function( C, HomC, ForgetfulFunctor, GeneratingSet )
    local PermutationsListKWithRestrictions, PermutationsListWithRestrictions, LiftsAlongEpis, knownLifts, LiftMapsAlongEpis, LiftEfficiently, End_G;

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

	LiftsAlongEpis := function( alpha_1, epis_1, alpha_2, epis_2 )
		local S, T, s, t, preimages, i, preimage_1, preimage_2, preimage, liftImages;

		S := Source( epis_1[ 1 ] );
		T := S;
		s := Length( S );
		t := s;
		
		preimages := [];
		for i in [ 1 .. s ] do
			preimage_1 := Intersection( List( epis_1, epi -> Preimage( epi, [ AsList( PreCompose( epi, alpha_1 ) )[ i ] ] ) ) );
			preimage_2 := Intersection( List( epis_2, epi -> Preimage( epi, [ AsList( PreCompose( epi, alpha_2 ) )[ i ] ] ) ) );
			preimage := Intersection( preimage_1, preimage_2 );
			if IsEmpty( preimage ) then
				return [];
			fi;
			preimages[ i ] := preimage;
		od;

		liftImages := PermutationsListWithRestrictions( [ 1 .. s ], preimages );
		
		return liftImages;
	end;

	LiftMapsAlongEpis := function( Omega, Delta_1, maps_1, Delta_2, maps_2 )
		local liftImages, Hom_C_Omega_Delta_1_as_maps, Hom_C_Omega_Delta_2_as_maps, alpha_1, alpha_2, newLiftImages, Set_Omega, lifts;
		
		liftImages := [];

		Hom_C_Omega_Delta_1_as_maps := List( HomC( Omega, Delta_1 ), phi -> ApplyFunctor( ForgetfulFunctor, phi ) );
		Hom_C_Omega_Delta_2_as_maps := List( HomC( Omega, Delta_2 ), phi -> ApplyFunctor( ForgetfulFunctor, phi ) );

		for alpha_1 in maps_1 do
			for alpha_2 in maps_2 do
				newLiftImages := LiftsAlongEpis( alpha_1, Hom_C_Omega_Delta_1_as_maps, alpha_2, Hom_C_Omega_Delta_2_as_maps );
				liftImages := Union2( liftImages, newLiftImages );
			od;
		od;

		Set_Omega := ApplyFunctor( ForgetfulFunctor, Omega );

		lifts := List( liftImages, imgs -> MapOfFinSets( Set_Omega, imgs, Set_Omega ) );
		
		return lifts;
	end;

	# cache computed lifts
	knownLifts := [];
	LiftEfficiently := function( GeneratingSet, pos )
		local Omega, Set_Omega, pos_1, Delta_1, pos_2, Delta_2, Set_Delta_1, Set_Delta_2, factor_1, factor_2, maps_1, maps_2, lifts, group_order, HomC_as_maps;
		
		Omega := GeneratingSet[ pos ];
		Set_Omega := ApplyFunctor( ForgetfulFunctor, Omega );

		if pos = Length( GeneratingSet ) then
			return [ IdentityMorphism( Set_Omega ) ];
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
			# there are morphisms Omega -> Delta_2 but there are no morphisms Delta_1 -> Delta_2
			if Length( HomC( Delta_1, Delta_2 ) ) = 0 and Length( HomC( Omega, Delta_2 ) ) > 0 then
				break;
			fi;
		od;

		Set_Delta_1 := ApplyFunctor( ForgetfulFunctor, Delta_1 );
		Set_Delta_2 := ApplyFunctor( ForgetfulFunctor, Delta_2 );

		factor_1 := Length( Set_Omega ) / Length( Set_Delta_1 );
		factor_2 := Length( Set_Omega ) / Length( Set_Delta_2 ); 
		
		if factor_1 >= 11 then
		    Error( "Stopping, this would never terminate anyway..." );
		fi;

		if IsBound( knownLifts[ pos_1 ] ) then
		    maps_1 := knownLifts[ pos_1 ];
		else
		    maps_1 := LiftEfficiently( GeneratingSet, pos_1 );
		fi;

		if IsBound( knownLifts[ pos_2 ] ) then
		    maps_2 := knownLifts[ pos_2 ];
		else
		    maps_2 := LiftEfficiently( GeneratingSet, pos_2 );
		fi;
		
		# compute common lifts of maps_1 and maps_2 to Omega
		lifts := LiftMapsAlongEpis( Omega, Delta_1, maps_1, Delta_2, maps_2 );
		
		# if pos = 1 and we have found exactly as many lifts as the group order: we do not have to filter anymore
		group_order := Length( ApplyFunctor( ForgetfulFunctor, GeneratingSet[ 1 ] ) );
		if not ( pos = 1 and Length( lifts ) = group_order ) then
			# check compatibility with Omega
			HomC_as_maps := List( HomC( Omega, Omega ), phi -> ApplyFunctor( ForgetfulFunctor, phi ) );
			# every map is compatible with the identity
			HomC_as_maps := Filtered( HomC_as_maps, phi -> phi <> IdentityMorphism( Set_Omega ) );
			
			lifts := Filtered( lifts, function( alpha )
				return ForAll( HomC_as_maps, function( phi )
					return AsList( PreCompose( alpha, phi ) ) = AsList( PreCompose( phi, alpha ) );
				end );
			end );
		fi;

		# cache computed lifts for future use
		knownLifts[ pos ] := lifts;

		return lifts;

	end;

	End_G := List( LiftEfficiently( GeneratingSet, 1 ), map -> [ map ] );

	return End_G;
end;
