# SetAssertionLevel( 4 );


LoadPackage("FinSets");
LoadPackage("SkeletalGSets");
LoadPackage( "profiling" );

CapCategorySwitchLogicOff( FinSets );
CapCategorySwitchLogicOff( SkeletalFinSets );
DeactivateCachingOfCategory( FinSets );
DeactivateCachingOfCategory( SkeletalFinSets );
DisableBasicOperationTypeCheck( FinSets );
DisableBasicOperationTypeCheck( SkeletalFinSets );
DeactivateToDoList();

#S1 := FinSet( 0 );
#T1 := FinSet( 0 );
#L := [];

#for phi in [ 1 .. 6^6 ] do
#	MapOfFinSets( S1, L, T1 );
#	# FinSet( 0 );
#	Display( phi );
#od;

#quit;

# G := SymmetricGroup( 3 );
#F := FreeGroup( "x" );
#G := F / [ F.1^6 ];
#G := CyclicGroup( 6 );
#G := SmallGroup( 4, 2 );
#G := SmallGroup( 8, 1 );
# TODO give errors
G := DihedralGroup( 8 );
# G := SmallGroup( 9, 1 );
# G := SmallGroup( 9, 2 );
# G := SmallGroup( 16, 7 );
#F := FreeGroup( "a", "x" );
#G := F / [ F.1^4, F.2^2, F.1*F.2*F.1*F.2^(-1) ];


G := SmallGroup( 30, 1 );
# G := SymmetricGroup( 3 );
# G := SmallGroup( 8, 1 );
# G := SmallGroup( 4, 2 );

#FinSet( [ MapOfGSets( GSet( G, [] ), [ ], GSet( G, [] ) ) ] ) = FinSet( [ MapOfFinSets( FinSet( [] ), [ ], FinSet( [] ) ) ] );

#IsWellDefined( FinSet( [ MapOfGSets( GSet( G, [] ), [ ], GSet( G, [] ) ) ] ) );
#IsWellDefined( FinSet( [ MapOfFinSets( FinSet( [] ), [ ], FinSet( [] ) ) ] ) );

#quit;


filter := MorphismFilter( SkeletalFinSets );
# MyNewType := NewType( TheFamilyOfCapCategoryObjects, IsSkeletalGSetMapRep and filter );

BindGlobal( "MyNewType",
         NewType( TheFamilyOfCapCategoryMorphisms,
                 IsSkeletalFiniteSetRep and filter ) );


CapCategorySwitchLogicOff( SkeletalGSets( G ) );
DeactivateCachingOfCategory( SkeletalGSets( G ) );
DisableBasicOperationTypeCheck( SkeletalGSets( G ) );

# TODO unabhängig von konkretem G?
# TODO Asserts?
# TODO AsList( G ) stabil?
ForgetfulFunctor := CapFunctor( "Forgetful functor SkeletalGSets -> SkeletalFinSets", SkeletalGSets( G ), SkeletalFinSets );
AddObjectFunction( ForgetfulFunctor, function( obj )
	
	local M, group, int, ToM, k, i;
	
	M := AsList( obj );
	group := UnderlyingGroup( obj );
	
	int := 0;
	
	ToM := MatTom( TableOfMarks( group ) );
	
	k := Size( ToM );
	
	for i in [ 1 .. k ] do
		# TODO: erste Spalte immer Indizes?
		
		int := int + M[ i ] * ToM[ i ][ 1 ];
	od;

	return FinSet( int );
	
end );

#A := GSet( G, [ 1, 1, 1, 1 ] );
#Display(ApplyFunctor( ForgetfulFunctor, A ));

AddMorphismFunction( ForgetfulFunctor, function( obj1, mor, obj2 )
	local S, T, imgs, M, N, group, ToM, k, OffsetOfCopyInTarget, OffsetOfElementInCopy, set_imgs, i, U_i, l, r, g, j, h;
	
	S := Source( mor );
	T := Range( mor );
	imgs := AsList( mor );
	M := AsList( S );
	N := AsList( T );
	group := UnderlyingGroup( S );
	ToM := MatTom( TableOfMarks( group ) );
	k := Size( ToM );
	
	OffsetOfCopyInTarget := function( _r, _j )
		local int, j, r;
		int := 0;
		for j in [ 1 .. k ] do
			for r in [ 1 .. N[ j ] ] do
				if j = _j and r = _r then
					return int;
				fi;
				# TODO: erste Spalte immer Indizes?
				
				int := int + ToM[ j ][ 1 ];
			od;
		od;
	end;
	
	OffsetOfElementInCopy := function( g, j )
		local U_j, RC;
		
		U_j := RepresentativeTom( TableOfMarks( group ), j );
		RC := RightCosets( group, U_j );
		
		return Position( RC, g );
		
	end;
	
	set_imgs := [];
	for i in [ 1 .. k ] do
		U_i := RepresentativeTom( TableOfMarks( group ), i );
		for l in [ 1 .. M[ i ] ] do
			r := imgs[ i ][ l ][ 1 ];
			g := imgs[ i ][ l ][ 2 ];
			j := imgs[ i ][ l ][ 3 ];
			
			for h in RightCosets( group, U_i ) do
				Add( set_imgs, OffsetOfCopyInTarget( r, j ) + OffsetOfElementInCopy( g * Representative( h ), j ) );
			od;
		od;
	od;

	return MapOfFinSets( obj1, set_imgs, obj2 );
	
end );





ForgetfulFunctorNonSkeletal := CapFunctor( "Forgetful functor SkeletalGSets -> FinSets", SkeletalGSets( G ), FinSets );
AddObjectFunction( ForgetfulFunctorNonSkeletal, function( obj )
	
	local M, group, UnderlyingSet, ToM, k, i, U_i, l;
	
	M := AsList( obj );
	group := UnderlyingGroup( obj );
	
	UnderlyingSet := [];
	
	ToM := MatTom( TableOfMarks( group ) );
	
	k := Size( ToM );
	
	for i in [ 1 .. k ] do
		U_i := RepresentativeTom( TableOfMarks( group ), i );
		# TODO: erste Spalte immer Indizes?
		for l in [ 1 .. M[ i ] ] do
			# cosets must be indexed by l to distinguish different copies, also index by i to keep the notation similar to the notation of maps
			Append( UnderlyingSet, Immutable( List( RightCosets( group, U_i ), coset ->  [ l, coset, i ] ) ) );
		od;
	od;

	return FinSet( UnderlyingSet );
	
end );


#B := GSet( G, [ 2, 1, 0, 1 ] );
#phi := MapOfGSets( A, [ [ [ 2, (1,2), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 4 ] ], [ [ 1, (), 4 ] ] ], B );
#set_phi := ApplyFunctor( ForgetfulFunctor, phi );
#Display( set_phi );
#IsWellDefined( set_phi );


HomFinSetsSkeletal := function ( S, T )
	local M, N;
	
	M := Length( S );
	N := Length( T );
	
	return FinSet( N^M );
end;


HomGSets := function( S, T )
	local M, N, group, k, homs, ImageLists, ImageList, graph, CurrentImageListPosition, i, U_i, l, img, r, g, j, U_j, WellDefined;
	
	M := AsList( S );
	N := AsList( T );
	
	group := UnderlyingGroup( S );
	k := Size( M );
	
	homs := [];
	
	# DirectProduct vs. Cartesian: use Cartesian to make explicit, that this is a set theoretic construction which might not work in general
	ImageLists := Cartesian( List( [ 1 .. Sum( M ) ], x -> AsList( ApplyFunctor( ForgetfulFunctorNonSkeletal, T ) ) ) );
	for ImageList in ImageLists do
		graph := List( [ 1 .. k ], x -> [] );
		CurrentImageListPosition := 1;
		WellDefined := true;
		for i in [ 1 .. k ] do
			U_i := RepresentativeTom( TableOfMarks( group ), i );
			for l in [ 1 .. M[ i ] ] do
				img := ImageList[ CurrentImageListPosition ];
				r := img[ 1 ];
				g := img[ 2 ];
				j := img[ 3 ];
				
				U_j := RepresentativeTom( TableOfMarks( group ), j );

				WellDefined := IsSubset( U_j, ConjugateSubgroup( U_i, Inverse( Representative( g ) ) ) );
				
				if not WellDefined then
					break;
				fi;
				
				Add( graph[ i ], img );
				CurrentImageListPosition := CurrentImageListPosition + 1;
			od;
			if not WellDefined then
				break;
			fi;
		od;
		if WellDefined then
			Add( homs, MapOfGSets( S, graph, T ) );
		fi;
	od;
	
	return FinSetNC( homs );
end;

HomGSetsSkeletal := function( S, T )
	local homs;
	
	homs := HomGSets( S, T );
	
	return FinSet( Length( homs ) );
end;

counter := 0;

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

MorphismToInt := function( phi )
	local S, T, s, t, imgs, int, i;
	
	S := Source( phi );
	T := Range( phi );
	s := Length( S );
	t := Length( T );
	imgs := AsList( phi );
	
	int := 0;
	for i in [ 0 .. ( s - 1 ) ] do
		int := int + ( imgs[ i + 1 ] - 1 ) * t^i;
	od;

	return int + 1;
end;


PseudoMorphismToInt := function( s, imgs, t )
	local int, i;
	
	int := 0;
	for i in [ 0 .. ( s - 1 ) ] do
		int := int + ( imgs[ i + 1 ] - 1 ) * t^i;
	od;

	return int + 1;
end;


ComposeInts := function(s, int1, m, int2, t)
	local int, i, img1, img2;
	
	int1 := int1 - 1;
	int2 := int2 - 1;
	
	int := 0;
	for i in [ 0 .. ( s - 1 ) ] do
		# get i-th digit of int1 w.r.t to base m
		img1 := QuoInt( int1, m^i ) mod m;
		# get img1-th digit of int2 w.r.t to base t
		img2 := QuoInt( int2, t^img1 ) mod t;
		int := int + img2 * t^i;
	od;

	return int + 1;
end;


GetRhoComponent := function( IndexSet, Projections, i_1, i_2 )
	local Omega_1, Omega_2, S, T, Graph, Graph1, pi, RhoComponent, IntsHomGSets, Length_HomGSetsSkeletal_Omega_1_Omega_2, Length_ApplyFunctor_ForgetfulFunctor_Omega_1, Length_ApplyFunctor_ForgetfulFunctor_Omega_2, Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2, ApplyFunctor_ForgetfulFunctor_Omega_1, Forgetful_HomGSets, HomGSetsSkeletal_Omega_1_Omega_2, HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2;
	Display("RhoComponent");
	Display( i_1 );
	Display( i_2 );
	Display("started");
	Omega_1 := IndexSet[ i_1 ];
	Omega_2 := IndexSet[ i_2 ];
	
	S := HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
	T := HomFinSetsSkeletal( HomGSets( Omega_1, Omega_2 ), HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	# this code is equal to the commented code below, but much faster since it only deals with integers and avoids polluting the GAP and CAP caches
	IntsHomGSets := List( HomGSets( Omega_1, Omega_2 ), f -> MorphismToInt( ApplyFunctor( ForgetfulFunctor, f ) ) );
	Length_HomGSetsSkeletal_Omega_1_Omega_2 := Length( HomGSetsSkeletal( Omega_1, Omega_2 ) );
	Length_ApplyFunctor_ForgetfulFunctor_Omega_1 := Length( ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
	Length_ApplyFunctor_ForgetfulFunctor_Omega_2 := Length( ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
	Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2 := Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );
	
	Graph := List( [ 1 .. Length( S ) ], phi ->
		PseudoMorphismToInt(
			Length_HomGSetsSkeletal_Omega_1_Omega_2,
			List( IntsHomGSets, function( f )
				Display( counter );
				counter := counter + 1;
				
				return ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 );
			end ),
			Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2
		)
	);

	ApplyFunctor_ForgetfulFunctor_Omega_1 := ApplyFunctor( ForgetfulFunctor, Omega_1 );
	Forgetful_HomGSets := List( HomGSets( Omega_1, Omega_2 ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
	HomGSetsSkeletal_Omega_1_Omega_2 := HomGSetsSkeletal( Omega_1, Omega_2 );
	HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2 := HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) );

	Graph1 := List( [ 1 .. Length( S ) ], phi -> 
	 	MorphismToInt( MapOfFinSets(
	 		HomGSetsSkeletal_Omega_1_Omega_2,
	 		List( Forgetful_HomGSets, function( f )
				local x, category, L;
				Display( counter );
				counter := counter + 1;

				# return ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 );

				x := IntToMorphism( ApplyFunctor_ForgetfulFunctor_Omega_1, phi, ApplyFunctor_ForgetfulFunctor_Omega_1 );
				return MorphismToInt( PreCompose( x, f ) );
	 		end ),
	 		HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2
	 	) )
	);
	Assert( 4, Graph = Graph1 );

	Display("Graph");
	Display(Runtimes());
	
	pi := Projections[ i_1 ];
	
	Display("pi");

	RhoComponent := PreCompose( pi, MapOfFinSets( S, Graph, T ) );

	Display("finished");

	return RhoComponent;
end;


GetLambdaComponent := function( IndexSet, Projections, i_1, i_2 )
	local Omega_1, Omega_2, S, T, Graph, Graph1, pi, LambdaComponent, IntsHomGSets, Length_HomGSetsSkeletal_Omega_1_Omega_2, Length_ApplyFunctor_ForgetfulFunctor_Omega_1, Length_ApplyFunctor_ForgetfulFunctor_Omega_2, Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2;
	Display("LambdaComponent");
	Display( i_1 );
	Display( i_2 );
	Display("started");
	Omega_1 := IndexSet[ i_1 ];
	Omega_2 := IndexSet[ i_2 ];
	
	S := HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_2 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
	T := HomFinSetsSkeletal( HomGSets( Omega_1, Omega_2 ), HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	# this code is equal to the commented code below, but much faster since it only deals with integers and avoids polluting the GAP and CAP caches
	IntsHomGSets := List( HomGSets( Omega_1, Omega_2 ), f -> MorphismToInt( ApplyFunctor( ForgetfulFunctor, f ) ) );
	Length_HomGSetsSkeletal_Omega_1_Omega_2 := Length( HomGSetsSkeletal( Omega_1, Omega_2 ) );
	Length_ApplyFunctor_ForgetfulFunctor_Omega_1 := Length( ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
	Length_ApplyFunctor_ForgetfulFunctor_Omega_2 := Length( ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
	Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2 := Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	Graph := List( [ 1 .. Length( S ) ], phi ->
		PseudoMorphismToInt(
			Length_HomGSetsSkeletal_Omega_1_Omega_2,
			List( IntsHomGSets, f ->
				ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 )
			),
			Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2
		)
	);

	# Graph1 := List( [ 1 .. Length( S ) ], phi -> 
	#  	MorphismToInt( MapOfFinSets(
	#  		HomGSetsSkeletal( Omega_1, Omega_2 ),
	#  		List( HomGSets( Omega_1, Omega_2 ), f ->
	#  			MorphismToInt( PreCompose( ApplyFunctor( ForgetfulFunctor, f ), IntToMorphism( ApplyFunctor( ForgetfulFunctor, Omega_2 ), phi, ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) ) )
	#  		),
	#  		HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )
	#  	) )
	# );
	# Assert( 4, Graph = Graph1 );

	Display("Graph");
	
	pi := Projections[ i_2 ];
	
	Display("pi");

	LambdaComponent := PreCompose( pi, MapOfFinSets( S, Graph, T ) );

	Display("finished");

	return LambdaComponent;
end;



#################################################################################################################################################################
# IndexSet



ToM := MatTom( TableOfMarks( G ) );
k := Size( ToM );

IndexSet := [];

for i in [ 1 .. k ] do
	M := ListWithIdenticalEntries( k, 0 );
	M[ i ] := 1;
	Add( IndexSet, GSet( G, M ) );
od;

version := 3;


#################################################################################################################################################################
# continuity test

if version = 5 then

D := [ GSet( G, [ 1, 0, 3, 0 ] ), GSet( G, [ 1, 3, 0, 0 ] ) ];

pi_G_set := ProjectionInFactorOfDirectProduct( D, 1 );
pi_set := ProjectionInFactorOfDirectProduct( List( D, d -> ApplyFunctor( ForgetfulFunctor, d )), 1 );

Display( ApplyFunctor( ForgetfulFunctor, pi_G_set ) );
Display( pi_set );

quit;

fi;

#################################################################################################################################################################
# fourth version

if version = 4 then

Omega_1 := IndexSet[ 1 ];
Omega_2 := IndexSet[ 1 ];

Forgetful_HomGSets := List( HomGSets( Omega_1, Omega_2 ), f -> ApplyFunctor( ForgetfulFunctor, f ) );

NaturalTransformations := List( Forgetful_HomGSets, morphism -> [ morphism ] );

Display( "NaturalTransformations" );

fi;

#################################################################################################################################################################
# third version

if version = 3 then

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

	# Display( preimages );
	
	lifts := PermutationsListWithRestrictions( [ 1 .. s ], preimages );
	
	maps := List( lifts, imgs -> PseudoMorphismToInt( s, imgs, t ) );
	
	return maps;
end;

knownLifts := [];

LiftMapsAlongEpis := function( Omega, Delta_1, maps_1, Delta_2, maps_2 )
  	local lifts, Forgetful_HomGSets_1, Forgetful_HomGSets_2, counter, Length_maps_1, Length_maps_2, Length_maps, f_1, f_2, new_lifts, ApplyFunctor_ForgetfulFunctor_Omega;
	
	lifts := [];

	Display( "compute HomGSets" );
	
	Forgetful_HomGSets_1 := List( HomGSets( Omega, Delta_1 ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
	Forgetful_HomGSets_2 := List( HomGSets( Omega, Delta_2 ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
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

LiftEfficiently := function( IndexSet, pos )
    local Omega, pos_1, Delta_1, pos_2, Delta_2, factor_1, factor_2, maps_1, maps_2, lifts, Forgetful_HomGSets, group_order, counter;
	
	Omega := IndexSet[ pos ];


	if pos = Length( IndexSet ) then
		Display( "lift from trivial G-set" );
		return [ IdentityMorphism( ApplyFunctor( ForgetfulFunctor, Omega ) ) ];
	fi;
	
	# look for Delta_1 and Delta_2 which can be lifted to Delta
	for pos_1 in [ ( pos + 1 ) .. Length( IndexSet ) ] do
		Delta_1 := IndexSet[ pos_1 ];
		if Length( HomGSets( Omega, Delta_1 ) ) > 0 then
			break;
		fi;
	od;

	pos_2 := Length( IndexSet );
	Delta_2 := IndexSet[ pos_2 ];
	for pos_2 in [ ( pos_1 + 1 ) .. Length( IndexSet ) ] do
		Delta_2 := IndexSet[ pos_2 ];
		# IDEA
		if Length( HomGSets( Delta_1, Delta_2 ) ) = 0 and Length( HomGSets( Omega, Delta_2 ) ) > 0 then
		# if Length( HomGSets( Omega, Delta_2 ) ) > 0 then
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
	  maps_1 := LiftEfficiently( IndexSet, pos_1 );
	fi;

	Display( Concatenation( "lift along ", String( pos ), " -> ", String( pos_2 ), ", factor ", String( factor_2 ) ) );
	
	if IsBound( knownLifts[ pos_2 ] ) then
	  maps_2 := knownLifts[ pos_2 ];
	else
	  maps_2 := LiftEfficiently( IndexSet, pos_2 );
	fi;
	
	lifts := LiftMapsAlongEpis( Omega, Delta_1, maps_1, Delta_2, maps_2 );
	
	# if pos = 1 and we have found exactly as many lifts as the group order we do not have to filter anymore
	group_order := Length( ApplyFunctor( ForgetfulFunctor, IndexSet[ 1 ] ) );
	if not (pos = 1 and Length( lifts ) = group_order ) then
		# check compatibility with Omega
		Display( Concatenation( "filter ", String( Length( lifts ) ), " lifts" ) );

		# IDEA exclude id
		Forgetful_HomGSets := List( HomGSets( Omega, Omega ), f -> ApplyFunctor( ForgetfulFunctor, f ) );
		
		counter := 0;
		lifts := Filtered( lifts, function( phi )
			if counter mod 10000 = 0 then
				Display(counter);
			fi;
			counter := counter + 1;
			return ForAll( Forgetful_HomGSets, function( f )
				return AsList( PreCompose( phi, f ) ) = AsList( PreCompose( f, phi ) );
				# return ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 ) =
				# ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 );
			end );
		end );
  	fi;

	Display( Concatenation( "################################### ", String( Length( lifts ) ), " lifts for position " , String( pos ) ) );
	
	knownLifts[ pos ] := lifts;

	return lifts;

end;

#ProfileLineByLine( "profile.gz" );
Enda := LiftEfficiently( IndexSet, 1 );
# Display(Runtimes());
# quit;
#UnprofileLineByLine();
#parsed := ReadLineByLineProfile( "profile.gz" );;
#OutputAnnotatedCodeCoverageFiles( parsed, "profile_dir" );


# Omega_1 := IndexSet[ 2 ];
# Omega_2 := IndexSet[ 3 ];
# 
# ApplyFunctor_ForgetfulFunctor_Omega_1 := ApplyFunctor( ForgetfulFunctor, Omega_1 );
# ApplyFunctor_ForgetfulFunctor_Omega_2 := ApplyFunctor( ForgetfulFunctor, Omega_2 );
# 
# Enda1 := LiftMapsAlongEpis( Omega_1, Omega_2, List( [ 1 .. Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_2 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )  ) ], i -> IntToMorphism( ApplyFunctor_ForgetfulFunctor_Omega_2, i, ApplyFunctor_ForgetfulFunctor_Omega_2 ) ) );
# Display( Enda1 );
# 
# Omega_1 := IndexSet[ 1 ];
# Omega_2 := IndexSet[ 2 ];
# 
# ApplyFunctor_ForgetfulFunctor_Omega_1 := ApplyFunctor( ForgetfulFunctor, Omega_1 );
# ApplyFunctor_ForgetfulFunctor_Omega_2 := ApplyFunctor( ForgetfulFunctor, Omega_2 );
# 
# #Enda2 := LiftMapsAlongEpis( Omega_1, Omega_2, List( [ 1 .. Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_2 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )  ) ], i -> IntToMorphism( ApplyFunctor_ForgetfulFunctor_Omega_2, i, ApplyFunctor_ForgetfulFunctor_Omega_2 ) ) );
# Enda2 := LiftMapsAlongEpis( Omega_1, Omega_2, Enda1 );
# Display( Enda2 );

# Omega_1 := IndexSet[ 1 ];
# Omega_2 := IndexSet[ 1 ];
# 
# ApplyFunctor_ForgetfulFunctor_Omega_1 := ApplyFunctor( ForgetfulFunctor, Omega_1 );
# ApplyFunctor_ForgetfulFunctor_Omega_2 := ApplyFunctor( ForgetfulFunctor, Omega_2 );
# 
# Enda3 := LiftMapsAlongEpis( Omega_1, Omega_2, List( [ 1 .. Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_2 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )  ) ], i -> IntToMorphism( ApplyFunctor_ForgetfulFunctor_Omega_2, i, ApplyFunctor_ForgetfulFunctor_Omega_2 ) ) );
# # Enda3 := LiftMapsAlongEpis( Omega_1, Omega_2, Enda2 );
# Display( Enda3 );

Display( Runtimes() );

# Enda := Filtered( Enda1, morphism -> morphism in Enda2 );

NaturalTransformations := List( Enda, morphism -> [ morphism ] );

fi;

#################################################################################################################################################################
# second version

if version = 2 then

counter := 0;
Omega_1 := IndexSet[ 1 ];
Omega_2 := Omega_1;


HomGSetsWithoutId := Filtered( HomGSets( Omega_1, Omega_2 ), f -> f <> IdentityMorphism( Omega_1 ) );

IntsHomGSets := List( HomGSetsWithoutId, f -> MorphismToInt( ApplyFunctor( ForgetfulFunctor, f ) ) );
Length_HomGSetsSkeletal_Omega_1_Omega_2 := Length( HomGSetsSkeletal( Omega_1, Omega_2 ) );
Length_ApplyFunctor_ForgetfulFunctor_Omega_1 := Length( ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
Length_ApplyFunctor_ForgetfulFunctor_Omega_2 := Length( ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
Length_HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2 := Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );


ApplyFunctor_ForgetfulFunctor_Omega_1 := ApplyFunctor( ForgetfulFunctor, Omega_1 );
ApplyFunctor_ForgetfulFunctor_Omega_2 := ApplyFunctor( ForgetfulFunctor, Omega_2 );
Forgetful_HomGSets := List( HomGSetsWithoutId, f -> ApplyFunctor( ForgetfulFunctor, f ) );
Display(Forgetful_HomGSets);
HomGSetsSkeletal_Omega_1_Omega_2 := HomGSetsSkeletal( Omega_1, Omega_2 );
HomFinSetsSkeletal_ApplyFunctor_ForgetfulFunctor_Omega_1_ApplyFunctor_ForgetfulFunctor_Omega_2 := HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) );


Enda := Filtered( [ 1 .. Length( HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_1 ) ) ) ], function( phi )
	local x;
	x := IntToMorphism( ApplyFunctor_ForgetfulFunctor_Omega_1, phi, ApplyFunctor_ForgetfulFunctor_Omega_1 );
	# if not IsMonomorphism( x ) then
	# 	return false;
	# fi;

	# if not IsEpimorphism( x ) then
	# 	return false;
	# fi;
	
	return ForAll( Forgetful_HomGSets, function(f)
		Display(counter);
		counter := counter + 1;

		return AsList( PreCompose( x, f ) ) = AsList( PreCompose( f, x ) );
		# return ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 ) =
		ComposeInts( Length_ApplyFunctor_ForgetfulFunctor_Omega_1, f, Length_ApplyFunctor_ForgetfulFunctor_Omega_2, phi, Length_ApplyFunctor_ForgetfulFunctor_Omega_2 );
	end );
end );

Display(Runtimes());
Display(Enda);

NaturalTransformations := List( [ 1 .. Length( Enda ) ], i -> List( [ 1 .. Length( IndexSet ) ], j -> IntToMorphism( ApplyFunctor( ForgetfulFunctor, IndexSet[ j ] ), Enda[ i ], ApplyFunctor( ForgetfulFunctor, IndexSet[ j ] ) ) ) );

fi;


#################################################################################################################################################################
# first version

if version = 1 then

Display("start");
SourceComponents := List( IndexSet, Omega -> HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
Display("SourceComponents");
S := DirectProduct( SourceComponents );
Display("Source");
Projections := List( [ 1 .. Length( IndexSet ) ], i -> ProjectionInFactorOfDirectProduct( SourceComponents, i ) );
Display("Projections");
TargetComponents := Concatenation( List( IndexSet, Omega_1 -> List( IndexSet, Omega_2 -> HomFinSetsSkeletal( HomGSets( Omega_1, Omega_2 ), HomFinSetsSkeletal( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) ) ) ) );
Display("TargetComponents");
T := DirectProduct( TargetComponents );
Display("Target");
Display(Runtimes());
RhoComponents := Concatenation( List( [ 1 .. Size( IndexSet ) ], i_1 -> List( [ 1 .. Size( IndexSet ) ], i_2 -> GetRhoComponent( IndexSet, Projections, i_1, i_2 ) ) ) );
Display(Runtimes());
Display("RhoComponents");
Rho := UniversalMorphismIntoDirectProduct( RhoComponents );
Display("Rho");
LambdaComponents := Concatenation( List( [ 1 .. Size( IndexSet ) ], i_1 -> List( [ 1 .. Size( IndexSet ) ], i_2 -> GetLambdaComponent( IndexSet, Projections, i_1, i_2 ) ) ) );
Display("LambdaComponents");
Lambdaa := UniversalMorphismIntoDirectProduct( LambdaComponents );
Display("Lambda");
emb := EmbeddingOfEqualizer( [ Rho, Lambdaa ] );
Enda := Source( emb );

NaturalTransformations := List( Enda, i -> List( [ 1 .. Length( Projections ) ], j -> IntToMorphism( ApplyFunctor( ForgetfulFunctor, IndexSet[ j ] ), PreCompose( emb, Projections[ j ] )( i ), ApplyFunctor( ForgetfulFunctor, IndexSet[ j ] ) ) ) );

fi;

#################################################################################################################################################################
# group stuff

Display( NaturalTransformations );
Display( Runtimes() );
quit;


DeclareRepresentation( "IsMyGroupElement", IsMultiplicativeElementWithInverse and IsAttributeStoringRep, [] );
TheTypeOfMyGroupElements := NewType( NewFamily( "TheFamilyOfMyGroupElements" ), IsMyGroupElement );


DeclareAttribute( "AsList", IsMyGroupElement );
DeclareAttribute( "MyIndex", IsMyGroupElement );


NaturalTransformationElements := List( [ 1 .. Length( NaturalTransformations ) ], function( i )
	local element;
	element := rec( );
	ObjectifyWithAttributes( element, TheTypeOfMyGroupElements, AsList, NaturalTransformations[ i ], MyIndex, i );
	return element;
end );

InstallMethodWithCache( String,
  "for my group elements",
  [ IsMyGroupElement ],
        
  function( x )
    
	return Concatenation( "<My group element with index ", String( MyIndex( x ) ), ">" );
	
end );

multiplying_counter := 0;
InstallMethodWithCache( \*,
  "for my group elements",
  [ IsMyGroupElement, IsMyGroupElement ],
        
  function( x, y )
    local i, L, element;
	
	Display( Concatenation( "multiplying ", String( multiplying_counter ) ) );
	multiplying_counter := multiplying_counter + 1;
	
	L := [];
	for i in [ 1 .. Length( AsList( x ) ) ] do
		L[i] := PreCompose( AsList(y)[ i ], AsList(x)[ i ] );
	od;
	
	for element in NaturalTransformationElements do
		if L = AsList( element ) then
			return element;
		fi;
	od;

	Error( "should never get here" );

end );

InstallMethodWithCache( \=,
  "for my group elements",
  [ IsMyGroupElement, IsMyGroupElement ],
	function( x, y )
	
		return MyIndex( x ) = MyIndex( y );
	
	end );

InstallMethodWithCache( \<,
  "for my group elements",
  [ IsMyGroupElement, IsMyGroupElement ],
     
  function( x, y )
    
	if MyIndex( x ) <> Position( NaturalTransformationElements, x ) then
		Error( "hi" );
	fi;
	return( MyIndex( x ) < MyIndex( y ) );

end );

MyOne := false;
for element in NaturalTransformationElements do
	if ForAll( AsList( element ), f -> f = IdentityMorphism( Source( f ) ) ) then
		MyOne := element;
		break;
	fi;
od;

if MyOne = false then
	Error( "MyOne not found" );
fi;

Display( MyOne );


InstallMethodWithCache( One,
  "for my group elements",
  [ IsMyGroupElement ],
        
  function( x )
    
	return MyOne;
	
end );

InstallMethodWithCache( InverseOp,
  "for my group elements",
  [ IsMyGroupElement ],
        
  function( x )

    Display("inverting");
    
	return x^( Length( NaturalTransformationElements ) - 1 );
	
end );

MyGroup := Group( NaturalTransformationElements );

Display( IsomorphismGroups( MyGroup, G ) );

Display( Runtimes() );
