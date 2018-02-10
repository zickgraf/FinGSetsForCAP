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


## setup

G := SymmetricGroup( 3 );
# G := SmallGroup( 100, 1 );

ToM := MatTom( TableOfMarks( G ) );
k := Size( ToM );

MyMinimalGeneratingSet:= [];

for i in [ 1 .. k ] do
	M := ListWithIdenticalEntries( k, 0 );
	M[ i ] := 1;
	Add( MyMinimalGeneratingSet, GSet( G, M ) );
od;

Decompose := function( MyOmega, MyMinimalGeneratingSet )
	return AsList( MyOmega );
end;

## code


k := Length( MyMinimalGeneratingSet );

Sizes := ListWithIdenticalEntries( k, 0 );

for i in [ 1 .. k ] do
	MyOmega := MyMinimalGeneratingSet[ i ];
	MySquare := DirectProduct( [ MyOmega, MyOmega ] );
	L := Decompose( MySquare, MyMinimalGeneratingSet );
	# check if all entries of L except the i-th are zero
	if ForAll( [ 1 .. k ], j -> j = i or L[ j ] = 0 ) then
		# size^2 = L[ i ] * size and size <> 0, so size = L[ i ]
		Sizes[ i ] := L[ i ];
	fi;
od;

i_G := ArgMax( Sizes );
MyOmega_G := MyMinimalGeneratingSet[ i_G ];

for i in [ 1 .. k ] do
	if Sizes[ i ] = 0 then
		MyOmega := MyMinimalGeneratingSet[ i ];
		P := DirectProduct( [ MyOmega, MyOmega_G ] );
		L := Decompose( P, MyMinimalGeneratingSet );
		# all entries of L except the i_G-th must be zero
		Assert( 4, ForAll( [ 1 .. k ], j -> j = i_G or L[ j ] = 0 ) );
		Sizes[ i ] := L[ i_G ];
	fi;
od;

# now we know all sizes
Assert( 4, ForAll( Sizes, size -> size > 0 ) );


## sort by sizes
SortParallel( Sizes, MyMinimalGeneratingSet );
Sizes := Reversed( Sizes );
MyMinimalGeneratingSet := Reversed( MyMinimalGeneratingSet );


MyEquations := [];
# take product of all pairs of non-trivial generators
for i in [ 2 .. ( k - 1 ) ] do
	for j in [ 2 .. i ] do
		Omega_i := MyMinimalGeneratingSet[ i ];
		Omega_j := MyMinimalGeneratingSet[ j ];
		P := DirectProduct( [ Omega_i, Omega_j ] );
		L := Decompose( P, MyMinimalGeneratingSet );
		for l in [ 1 .. k ] do
			# equations are of the form a * b = c + Sum_m c_m v_m
			Add( MyEquations, [ [ [i,l], [j,l] ], [ 0, Filtered( List( [ 1 .. k ], m -> [ L[ m ], [m,l] ] ), pair -> pair[ 1 ] > 0 ) ] ] );
			Display( [ [ [i,l], [j,l] ], [ 0, Filtered( List( [ 1 .. k ], m -> [ L[ m ], [m,l] ] ), pair -> pair[ 1 ] > 0 ) ] ] );
		od;
	od;
od;

# insert known values
MyToM := List( [ 1 .. k ], i -> List( [ 1 .. k ], j -> -1 ) );
for i in [ 1 .. k ] do
	# first column contains the sizes
	MyToM[ i ][ 1 ] := Sizes[ i ];
od;

for j in [ 1 .. k ] do
	# last row contains ones
	MyToM[ k ][ j ] := 1;
od;

for i in [ 2 .. ( k - 1 ) ] do
	# if two groups have the same size there cannot be any map between them
	for j in [ 2 .. ( i - 1 ) ] do
		if Sizes[ i ] = Sizes[ j ] then
			MyToM[ i ][ j ] := 0;
		fi;
	od;
od;

for j in [ 2 .. k ] do
	for i in [ 1 .. ( j - 1 ) ] do
		# upper right-hand triangle is 0
		MyToM[ i ][ j ] := 0;
	od;
od;



# diagonal values cannot be zero
NonZeroValues := List( [ 2 .. ( k - 1 ) ], i -> [i,i] );

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
		ToM[ index[ 1 ] ][ index[ 2 ] ] := value;
	else
		# if index is already is a value, then is has to be the value to set
		Assert( 4, index = value );
	fi;
end;

WasSolved := function( e, NonZeroValues, ToM )
	local lhs, rhs, a, b, c, sum;
	lhs := e[ 1 ];
	rhs := e[ 2 ];
	a := lhs[ 1 ];
	b := lhs[ 2 ];
	c := rhs[ 1 ];
	sum := rhs[ 2 ];

	if c = 0 and IsEmpty( sum ) then
		# rhs is 0
		if a in NonZeroValues or ( IsInt( a ) and a > 0 ) then
			SetValue( ToM, b, 0 );
			return true;
		fi;
		if b in NonZeroValues or ( IsInt( b ) and b > 0 ) then
			SetValue( ToM, a, 0 );
			return true;
		fi;
	fi;
	
	if c = 0 and Length( sum ) = 1 then
		s := sum[ 1 ];
		d := s[ 2 ];
		if d = a and a in NonZeroValues then
			# cancel a
			SetValue( ToM, b, s[ 1 ] );
			return true;
		fi;
		if d = b and b in NonZeroValues then
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
	
	return false;
end;

Display( MyToM );
Display( MyEquations[ 1 ] );

while not IsEmpty( MyEquations ) do
	updated := false;
	for i in [ 1 .. Length( MyEquations ) ] do
		if IsBound( MyEquations[ i ] ) then
			e := MyEquations[ i ];
			e_simple := Simplify( ShallowCopy( e ), MyToM );
			if e <> e_simple then
				MyEquations[ i ] := e_simple;
				updated := true;
			fi;
			if WasSolved( e_simple, NonZeroValues, MyToM ) then
				Unbind( MyEquations[ i ] );
				updated := true;
			fi;
		fi;
	od;
	if not updated then
		Error( "could not further simplify equations, sorry :-(" );
	fi;
od;


Display( MyToM );
