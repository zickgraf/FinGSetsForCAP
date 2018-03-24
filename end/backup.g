# SetAssertionLevel( 4 );

LoadPackage( "FinSets" );
LoadPackage( "SkeletalGSets" );
LoadPackage( "profiling" );

CapCategorySwitchLogicOff( FinSets );
CapCategorySwitchLogicOff( SkeletalFinSets );
DeactivateCachingOfCategory( FinSets );
DeactivateCachingOfCategory( SkeletalFinSets );
DisableBasicOperationTypeCheck( FinSets );
DisableBasicOperationTypeCheck( SkeletalFinSets );
DeactivateToDoList();


# G := SymmetricGroup( 3 );
#F := FreeGroup( "x" );
#G := F / [ F.1^6 ];
#G := CyclicGroup( 6 );
#G := SmallGroup( 4, 2 );
#G := SmallGroup( 8, 1 );
G := DihedralGroup( 8 );
# G := SmallGroup( 9, 1 );
# G := SmallGroup( 9, 2 );
# G := SmallGroup( 16, 7 );
#F := FreeGroup( "a", "x" );
#G := F / [ F.1^4, F.2^2, F.1*F.2*F.1*F.2^(-1) ];


#G := SmallGroup( 30, 1 );
# G := SymmetricGroup( 3 );
# G := SmallGroup( 8, 1 );
# G := SmallGroup( 4, 2 );


G := SmallGroup( 105, 2 );

G := SymmetricGroup( 3 );
G := SmallGroup( 32, 1 ); # 2^5
G := SmallGroup( 40, 1 ); # 2^3 * 5
G := SmallGroup( 144, 1 ); # 2^4 * 3^2
G := SmallGroup( 30, 1 ); # 2^5
G := SmallGroup( 56, 1 ); # 2^5
G := SmallGroup( 90, 1 ); # 2^5
G := SmallGroup( 96, 1 ); # 2^5
G := SmallGroup( 98, 1 ); # 2^5
G := SmallGroup( 100, 1 ); # 2^5
G := SmallGroup( 140, 1 ); # 2^5
#G := SmallGroup( 125, 1 ); # 2^5
#G := SmallGroup( 140, 1 ); # 2^5
G := SmallGroup( 216, 52 ); # 2^5

blacklist := [ 11, 13, 17, 19, 22, 23, 26, 27, 29, 31, 33, 34, 37, 38, 39, 41, 42, 43, 44, 46, 47, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 67, 68, 69, 71, 73, 74, 75, 76, 77, 78, 79, 81, 82, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 97, 98, 99, 100,  ];


CapCategorySwitchLogicOff( SkeletalGSets( G ) );
DeactivateCachingOfCategory( SkeletalGSets( G ) );
DisableBasicOperationTypeCheck( SkeletalGSets( G ) );


Read( "ForgetfulFunctor.g" );
Read( "HomSkeletalGSets.g" );
Read( "HomFinSets.g" );


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

	Enda := EndByLifts( SkeletalGSets( G ), HomSkeletalGSets, ForgetfulFunctorSkeletalGSets, IndexSet );

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

	Enda := EndAsEqualizer( SkeletalGSets( G ), HomSkeletalGSets, ForgetfulFunctorSkeletalGSets, IndexSet );

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

IdGroup( MyGroup );

Display( IsomorphismGroups( MyGroup, G ) );

Display( Runtimes() );
