LoadPackage("FinSets");
LoadPackage("SkeletalGSets");

G := SymmetricGroup( 3 );

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

A := GSet( G, [ 1, 1, 1, 1 ] );
Display(ApplyFunctor( ForgetfulFunctor, A ));

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
			
			for h in RightTransversal( group, U_i ) do
				Add( set_imgs, OffsetOfCopyInTarget( r, j ) + OffsetOfElementInCopy( g * h, j ) );
			od;
		od;
	od;
	
	return MapOfFinSets( obj1, set_imgs, obj2 );
	
end );


B := GSet( G, [ 2, 1, 0, 1 ] );
phi := MapOfGSets( A, [ [ [ 2, (1,2), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 4 ] ], [ [ 1, (), 4 ] ] ], B );
set_phi := ApplyFunctor( ForgetfulFunctor, phi );
Display( set_phi );
IsWellDefined( set_phi );


################################################################################################################################################


ForgetfulFunctor := CapFunctor( "Forgetful functor SkeletalGSets -> FinSets", SkeletalGSets( G ), FinSets );
AddObjectFunction( ForgetfulFunctor, function( obj )
	
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
			UnderlyingSet := Union2( UnderlyingSet, List( RightCosets( group, U_i ), coset ->  [ l, coset, i ] ) );
		od;
	od;

	return FinSet( UnderlyingSet );
	
end );

A := GSet( G, [ 1, 1, 1, 1 ] );
Display(ApplyFunctor( ForgetfulFunctor, A ));

AddMorphismFunction( ForgetfulFunctor, function( obj1, mor, obj2 )
	local S, T, imgs, M, N, group, ToM, k, graph, i, U_i, l, r, g, j, h;
	
	S := Source( mor );
	T := Range( mor );
	imgs := AsList( mor );
	M := AsList( S );
	N := AsList( T );
	group := UnderlyingGroup( S );
	ToM := MatTom( TableOfMarks( group ) );
	k := Size( ToM );
	
	graph := [];
	for i in [ 1 .. k ] do
		U_i := RepresentativeTom( TableOfMarks( group ), i );
		for l in [ 1 .. M[ i ] ] do
			r := imgs[ i ][ l ][ 1 ];
			g := imgs[ i ][ l ][ 2 ];
			j := imgs[ i ][ l ][ 3 ];
			
			for h in RightCosets( group, U_i ) do
				graph := Union2( graph, [ [ [ l, h, i ], [ r, g * Representative( h ), j ] ] ] );
			od;
		od;
	od;
	
	return MapOfFinSets( obj1, graph, obj2 );
	
end );


B := GSet( G, [ 2, 1, 0, 1 ] );
phi := MapOfGSets( A, [ [ [ 2, (1,2), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 4 ] ], [ [ 1, (), 4 ] ] ], B );
set_phi := ApplyFunctor( ForgetfulFunctor, phi );
Display( set_phi );
IsWellDefined( set_phi );



HomFinSets := function ( M, N )
	local m, n, homs;
	
	m := AsList( M );
	n := AsList( N );
	
	homs := [];
	
	for m in AsList(M) do
		for 
	
	return homs;
end;




GetRhoComponent := function( IndexSet, i_1, i_2 )
	local Omega_1, Omega_2;
	Omega_1 := IndexSet[ i_1 ];
	Omega_2 := IndexSet[ i_2 ];
	
	S := HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
	T := HomFinSets( HomGSets( Omega_1, Omega_2), HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	imgs := List( S, phi ->
		List( HomGSets( Omega_1, Omega_2), f -> 
			PreCompose( phi, ApplyFunctor( ForgetfulFunctor, f ) )
		)
	);

	SourceComponents := List( IndexSet, Omega -> HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
	
	return PreCompose( ProjectionInFactorOfDirectProduct( SourceComponents, i_1 ), MapOfFinSets( S, imgs, T ) );
end;


GetLambdaComponent := function( IndexSet, i_1, i_2 )
	local Omega_1, Omega_2;
	Omega_1 := IndexSet[ i_1 ];
	Omega_2 := IndexSet[ i_2 ];
	
	S := HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_2 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
	T := HomFinSets( HomGSets( Omega_1, Omega_2), HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	imgs := List( S, phi ->
		List( HomGSets( Omega_1, Omega_2), f -> 
			PreCompose( ApplyFunctor( ForgetfulFunctor, f ), phi )
		)
	);

	
	SourceComponents := List( IndexSet, Omega -> HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
	
	return PreCompose( ProjectionInFactorOfDirectProduct( SourceComponents, i_1 ), MapOfFinSets( S, imgs, T ) );
end;

ToM := MatTom( TableOfMarks( G ) );
k := Size( ToM );

IndexSet := List( [ 1 .. k ], i ->  RepresentativeTom( ToM, i ) );
SourceComponents := List( IndexSet, Omega -> HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
Source := DirectProduct( SourceComponents );
TargetComponents := Union( List( IndexSet, Omega_1 -> List( IndexSet, Omega_2 -> HomFinSets( HomGSets( Omega_1, Omega_2), HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) ) ) ) );
Target := DirectProduct( TargetComponents );
RhoComponents := Union( List( [ 1 .. Size( IndexSet ) ], i_1 -> List( [ 1 .. Size( IndexSet ) ], i_2 -> GetRhoComponent(IndexSet, i_1, i_2) ) ) );
Rho := UniversalMorhpismIntoDirectProduct( RhoComponents );
LambdaComponents := Union( List( [ 1 .. Size( IndexSet ) ], i_1 -> List( [ 1 .. Size( IndexSet ) ], i_2 -> GetLambdaComponent(IndexSet, i_1, i_2) ) ) );
Lambda := UniversalMorhpismIntoDirectProduct( LambdaComponents );
End := Equalizer( [ rho, lambda ] );
