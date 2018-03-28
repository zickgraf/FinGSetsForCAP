EndByLifts := function( C, HomC, ForgetfulFunctor, Objects )
    local PermutationsListKWithRestrictions, PermutationsListWithRestrictions, LiftMaps, knownLifts, LiftEfficiently, End_C_1;

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

	LiftMaps := function( C, C_1, maps_1, C_2, maps_2 )
		local liftImages, Hom_C_C_C_1_as_maps, Hom_C_C_C_2_as_maps, alpha_1, alpha_2, preimages, i, preimage_1, preimage_2, preimage, newLiftImages, Set_C, lifts;
		
		liftImages := [];
		
		Set_C := ApplyFunctor( ForgetfulFunctor, C );
		
		Hom_C_C_C_1_as_maps := List( HomC( C, C_1 ), phi -> ApplyFunctor( ForgetfulFunctor, phi ) );
		Hom_C_C_C_2_as_maps := List( HomC( C, C_2 ), phi -> ApplyFunctor( ForgetfulFunctor, phi ) );

		for alpha_1 in maps_1 do
			for alpha_2 in maps_2 do

				preimages := [];
				for i in [ 1 .. Length( Set_C ) ] do
					preimage_1 := Intersection( List( Hom_C_C_C_1_as_maps, phi -> Preimage( phi, [ AsList( PreCompose( phi, alpha_1 ) )[ i ] ] ) ) );
					preimage_2 := Intersection( List( Hom_C_C_C_2_as_maps, phi -> Preimage( phi, [ AsList( PreCompose( phi, alpha_2 ) )[ i ] ] ) ) );
					preimage := Intersection( preimage_1, preimage_2 );
					if IsEmpty( preimage ) then
						break;
					fi;
					preimages[ i ] := preimage;
				od;

				if not IsEmpty( preimage ) then
					newLiftImages := PermutationsListWithRestrictions( [ 1 .. Length( Set_C ) ], preimages );
				
					liftImages := Union2( liftImages, newLiftImages );
				fi;
			od;
		od;

		Set_C := ApplyFunctor( ForgetfulFunctor, C );

		lifts := List( liftImages, imgs -> MapOfFinSets( Set_C, imgs, Set_C ) );
		
		return lifts;
	end;

	# cache computed lifts
	knownLifts := [];
	LiftEfficiently := function( Objects, pos )
		local C, Set_C, pos_1, C_1, pos_2, C_2, Set_C_1, Set_C_2, factor_1, factor_2, maps_1, maps_2, lifts, group_order, HomC_as_maps;
		
		C := Objects[ pos ];
		Set_C := ApplyFunctor( ForgetfulFunctor, C );

		if pos = Length( Objects ) then
			return [ IdentityMorphism( Set_C ) ];
		fi;
		
		# look for C_1 and C_2 which can be lifted to C
		for pos_1 in [ ( pos + 1 ) .. Length( Objects ) ] do
			C_1 := Objects[ pos_1 ];
			if Length( HomC( C, C_1 ) ) > 0 then
				break;
			fi;
		od;

		pos_2 := Length( Objects );
		C_2 := Objects[ pos_2 ];
		for pos_2 in [ ( pos_1 + 1 ) .. Length( Objects ) ] do
			C_2 := Objects[ pos_2 ];
			# there are morphisms C -> C_2 but there are no morphisms C_1 -> C_2
			if Length( HomC( C_1, C_2 ) ) = 0 and Length( HomC( C, C_2 ) ) > 0 then
				break;
			fi;
		od;

		Set_C_1 := ApplyFunctor( ForgetfulFunctor, C_1 );
		Set_C_2 := ApplyFunctor( ForgetfulFunctor, C_2 );

		factor_1 := Length( Set_C ) / Length( Set_C_1 );
		factor_2 := Length( Set_C ) / Length( Set_C_2 ); 
		
		if factor_1 >= 11 then
		    Error( "Stopping, this would never terminate anyway..." );
		fi;

		if IsBound( knownLifts[ pos_1 ] ) then
		    maps_1 := knownLifts[ pos_1 ];
		else
		    maps_1 := LiftEfficiently( Objects, pos_1 );
		fi;

		if IsBound( knownLifts[ pos_2 ] ) then
		    maps_2 := knownLifts[ pos_2 ];
		else
		    maps_2 := LiftEfficiently( Objects, pos_2 );
		fi;
		
		# compute common lifts of maps_1 and maps_2 to C
		lifts := LiftMaps( C, C_1, maps_1, C_2, maps_2 );
		
		# if pos = 1 and we have found exactly as many lifts as the group order: we do not have to filter anymore
		group_order := Length( ApplyFunctor( ForgetfulFunctor, Objects[ 1 ] ) );
		if not ( pos = 1 and Length( lifts ) = group_order ) then
			# check compatibility with C
			HomC_as_maps := List( HomC( C, C ), phi -> ApplyFunctor( ForgetfulFunctor, phi ) );
			# every map is compatible with the identity
			HomC_as_maps := Filtered( HomC_as_maps, phi -> phi <> IdentityMorphism( Set_C ) );
			
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

	End_C_1 := List( LiftEfficiently( Objects, 1 ), map -> [ map ] );

	return End_C_1;
end;
