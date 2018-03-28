SetAssertionLevel( 4 );
LoadPackage("SkeletalGSets");



# find non-unique table of marks

for i in [ 1 .. 0 ] do
	Display( i );
	nr := NumberSmallGroups( i );
	for j in [ 1 .. nr ] do
		G_1 := SmallGroup( i, j );
		ToM_1 := MatTom( TableOfMarks( G_1 ) );
		for k in [ 1 .. ( j - 1 ) ] do
			G_2 := SmallGroup( i, k );
			ToM_2 := MatTom( TableOfMarks( G_2 ) );
			if ToM_1 = ToM_2 then
				Error( "found two non-isomorphic groups with the same table of marks" );
			fi;
		od;
	od;
od;









## library


## setup


# G := SymmetricGroup( 3 );
G := SmallGroup( 8, 1 );
G := SmallGroup( 2^8, 1734 );
# G := SmallGroup( 2^8, 1735 );

# G := SmallGroup( 80, 1 );
G := SymmetricGroup( 3 );

# for a in [ 1 .. 100 ] do
# 	Display( a );
# 	nr := NumberSmallGroups( a );
# 	for b in [ 1 .. nr ] do
# 		G := SmallGroup( a, b );




ToM := MatTom( TableOfMarks( G ) );
k := Size( ToM );

MyMinimalGeneratingSet:= [];

for i in [ 1 .. k ] do
	M := ListWithIdenticalEntries( k, 0 );
	M[ i ] := 1;
	Add( MyMinimalGeneratingSet, GSet( G, M ) );
od;

Decompose := function( Omega, MinimalGeneratingSet )
	return AsList( Omega );
end;

## code

ReconstructTableOfMarks := function( C, MinimalGeneratingSet, Decompose )
    local ArgMax, k, sizes, i, Square, i_1, C_1, P, L, equations, j, C_i, C_j, l, ToM, nonZeroValues, GetValue, Simplify, SetValue, WasSolved, updated, e, e_simple;

	# argmax for a non-empty list, only the last maximizer is returned
	ArgMax := function( list )
		local i, max, argmax;
		Assert( 4, Length( list ) > 0 );
		max := list[ 1 ];
		argmax := 1;
		for i in [ 2 .. Length( list ) ] do
			if list[ i ] > max then
				max := list[ i ];
				argmax := i;
			fi;
		od;
		return argmax;
	end;

	k := Length( MinimalGeneratingSet );

	sizes := ListWithIdenticalEntries( k, 0 );

	# determine the objects with C x C = m_C C
	for i in [ 1 .. k ] do
		C_i := MinimalGeneratingSet[ i ];
		Square := DirectProduct( [ C_i, C_i ] );
		L := Decompose( Square, MinimalGeneratingSet );
		# check if all entries of L except the i-th are zero
		if ForAll( [ 1 .. k ], j -> j = i or L[ j ] = 0 ) then
			# size^2 = L[ i ] * size and size <> 0, so size = L[ i ]
			sizes[ i ] := L[ i ];
		fi;
	od;
	
	# identify the object correspoding with the role of G
	i_1 := ArgMax( sizes );
	C_1 := MinimalGeneratingSet[ i_1 ];

	# determine the sizes of the remaining objects
	for i in [ 1 .. k ] do
		if sizes[ i ] = 0 then
			C_i := MinimalGeneratingSet[ i ];
			P := DirectProduct( [ C_i, C_1 ] );
			L := Decompose( P, MinimalGeneratingSet );
			# all entries of L except the i_1-th must be zero
			Assert( 4, ForAll( [ 1 .. k ], j -> j = i_1 or L[ j ] = 0 ) );
			sizes[ i ] := L[ i_1 ];
		fi;
	od;

	# now we know all sizes
	Assert( 4, ForAll( sizes, size -> size > 0 ) );


	# sort by sizes
	#SortParallel( Sizes, MyMinimalGeneratingSet );
	#sizes := Reversed( sizes );
	#MinimalGeneratingSet := Reversed( MinimalGeneratingSet );


	equations := [];
	# take product of all pairs of non-trivial generators and generate the corresponding equations
	for i in [ 2 .. ( k - 1 ) ] do
		for j in [ 2 .. i ] do
			C_i := MinimalGeneratingSet[ i ];
			C_j := MinimalGeneratingSet[ j ];
			P := DirectProduct( [ C_i, C_j ] );
			L := Decompose( P, MinimalGeneratingSet );
			for l in [ 1 .. k ] do
				# equations are of the form a * b = c + Sum_m c_m v_m
				Add( equations, [ [ [i,l], [j,l] ], [ 0, Filtered( List( [ 1 .. k ], m -> [ L[ m ], [m,l] ] ), pair -> pair[ 1 ] > 0 ) ] ] );
			od;
		od;
	od;

	# insert known values
	ToM := List( [ 1 .. k ], i -> List( [ 1 .. k ], j -> -1 ) );
	for i in [ 1 .. k ] do
		# first column contains the sizes
		ToM[ i ][ 1 ] := sizes[ i ];
	od;

	for j in [ 1 .. k ] do
		# last row contains ones
		ToM[ k ][ j ] := 1;
	od;

	for i in [ 2 .. ( k - 1 ) ] do
		# if two groups have the same size there cannot be any map between them
		for j in [ 2 .. ( i - 1 ) ] do
			if sizes[ i ] = sizes[ j ] then
				ToM[ i ][ j ] := 0;
			fi;
		od;
	od;

	for j in [ 2 .. k ] do
		for i in [ 1 .. ( j - 1 ) ] do
			# upper right-hand triangle is 0
			ToM[ i ][ j ] := 0;
		od;
	od;



	# diagonal values cannot be zero
	nonZeroValues := List( [ 2 .. ( k - 1 ) ], i -> [i,i] );

	GetValue := function( ToM, index )
		return ToM[ index[ 1 ] ][ index[ 2 ] ];
	end;
	
	Simplify := function( e, ToM )
		local lhs, rhs, sum, i, s;
		lhs := e[ 1 ];
		rhs := e[ 2 ];
		if IsList( lhs[ 1 ] ) and GetValue( ToM, lhs[ 1 ] ) > -1 then
			lhs[ 1 ] := GetValue( ToM, lhs[ 1 ] );
		fi;
		if IsList( lhs[ 2 ] ) and GetValue( ToM, lhs[ 2 ] ) > -1 then
			lhs[ 2 ] := GetValue( ToM, lhs[ 2 ] );
		fi;
		sum := rhs[ 2 ];
		for i in [ 1 .. Length( sum ) ] do
			s := sum[ i ];
			if GetValue( ToM, s[ 2 ] ) > -1 then
				rhs[ 1 ] := rhs[ 1 ] + s[ 1 ] * GetValue( ToM, s[ 2 ] );
				s[ 1 ] := 0;
			fi;
		od;
		rhs[ 2 ] := Filtered( sum, pair -> pair[ 1 ] > 0 );
		return e;
	end;

	SetValue := function( ToM, index, value )
		if IsList( index ) then
			# we should never set a value to zero which is in nonZeroValues
			Assert( 4, value <> 0 or ( not index in nonZeroValues ) );
			# we should never set a value which is already set
			Assert( 4, ToM[ index[ 1 ] ][ index[ 2 ] ] = -1 );
			ToM[ index[ 1 ] ][ index[ 2 ] ] := value;
		else
			# if index is already is a value, then is has to be the value to set
			Assert( 4, index = value );
		fi;
	end;

	WasSolved := function( e, nonZeroValues, ToM )
		local lhs, rhs, a, b, c, sum, s, d;
		lhs := e[ 1 ];
		rhs := e[ 2 ];
		a := lhs[ 1 ];
		b := lhs[ 2 ];
		c := rhs[ 1 ];
		sum := rhs[ 2 ];

		if c = 0 and IsEmpty( sum ) then
			# rhs is 0
			if a in nonZeroValues or ( IsInt( a ) and a > 0 ) then
				SetValue( ToM, b, 0 );
				return true;
			fi;
			if b in nonZeroValues or ( IsInt( b ) and b > 0 ) then
				SetValue( ToM, a, 0 );
				return true;
			fi;
		fi;
		
		if c = 0 and Length( sum ) = 1 then
			s := sum[ 1 ];
			d := s[ 2 ];
			if d = a and a in nonZeroValues then
				# cancel a
				SetValue( ToM, b, s[ 1 ] );
				return true;
			fi;
			if d = b and b in nonZeroValues then
				# cancel b
				SetValue( ToM, a, s[ 1 ] );
				return true;
			fi;
		fi;

		if IsInt( a ) and IsInt( b ) and IsEmpty( sum ) then
			# all values in this equation are known, assert that the equation holds
			Assert( 4, a * b = c );
			return true;
		fi;

		if IsEmpty( sum ) then
			if IsInt( a ) then
				Assert( 4, a <> 0 or c = 0 );
				if a <> 0 then
					SetValue( ToM, b, c / a );
				fi;
				return true;
			fi;
			if IsInt( b ) then
				Assert( 4, b <> 0 or c = 0 );
				if b <> 0 then
					SetValue( ToM, a, c / b );
				fi;
				return true;
			fi;
		fi;
		
		return false;
	end;

	while not IsEmpty( equations ) do
		updated := false;
		for i in [ 1 .. Length( equations ) ] do
			if IsBound( equations[ i ] ) then
				e := equations[ i ];
				# simplify e
				e_simple := Simplify( ShallowCopy( e ), ToM );
				if e <> e_simple then
				    # remember simplified equation
					equations[ i ] := e_simple;
					updated := true;
				fi;
				# try to solve e_simple
				if WasSolved( e_simple, nonZeroValues, ToM ) then
					Unbind( equations[ i ] );
					updated := true;
				fi;
			fi;
		od;
		if not updated then
			Error( "could not further simplify equations, sorry :-(" );
		fi;
	od;

	return ToM;
end;

MyToM := ReconstructTableOfMarks( SkeletalGSets( G ), MyMinimalGeneratingSet, Decompose );

Display( MyToM );
Display( MyToM = ToM );
Assert( 4, MyToM = ToM );

