HomSkeletalGSets := function( S, T )
	local UnderlyingSet, M, N, group, k, homs, imgsList, imgs, graph, currentImgsPosition, i, U_i, l, img, r, g, j, U_j, wellDefined;
	
	UnderlyingSet := function( obj )
		local M, group, underlyingSet, ToM, k, i, U_i, l;
		
		M := AsList( obj );
		group := UnderlyingGroup( obj );
		
		underlyingSet := [];
		
		ToM := MatTom( TableOfMarks( group ) );
		
		k := Size( ToM );
		
		for i in [ 1 .. k ] do
			U_i := RepresentativeTom( TableOfMarks( group ), i );
			for l in [ 1 .. M[ i ] ] do
				# cosets must be indexed by l to distinguish different copies, also index by i to keep the notation similar to the notation of maps
				Append( underlyingSet, Immutable( List( RightCosets( group, U_i ), coset ->  [ l, coset, i ] ) ) );
			od;
		od;

		return underlyingSet;
		
	end;
	
	M := AsList( S );
	N := AsList( T );
	
	group := UnderlyingGroup( S );
	k := Size( M );
	
	homs := [];
	
	imgsList := Cartesian( List( [ 1 .. Sum( M ) ], x -> UnderlyingSet ( T ) ) );
	for imgs in imgsList do
		graph := List( [ 1 .. k ], x -> [] );
		currentImgsPosition := 1;
		wellDefined := true;
		for i in [ 1 .. k ] do
			U_i := RepresentativeTom( TableOfMarks( group ), i );
			for l in [ 1 .. M[ i ] ] do
				img := imgs[ currentImgsPosition ];
				r := img[ 1 ];
				g := img[ 2 ];
				j := img[ 3 ];
				
				U_j := RepresentativeTom( TableOfMarks( group ), j );

				wellDefined := IsSubset( U_j, ConjugateSubgroup( U_i, Inverse( Representative( g ) ) ) );
				
				if not wellDefined then
					break;
				fi;
				
				Add( graph[ i ], img );
				currentImgsPosition := currentImgsPosition + 1;
			od;
			if not wellDefined then
				break;
			fi;
		od;
		if wellDefined then
			Add( homs, MapOfGSets( S, graph, T ) );
		fi;
	od;
	
	return FinSetNC( homs );
end;
