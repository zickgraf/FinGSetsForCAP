# SetAssertionLevel( 4 );



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
# G := SmallGroup( 216, 52 ); # 2^5


G := SymmetricGroup( 3 );
G := SmallGroup( 4, 2 );
# G := SmallGroup( 30, 1 );


blacklist := [ 11, 13, 17, 19, 22, 23, 26, 27, 29, 31, 33, 34, 37, 38, 39, 41, 42, 43, 44, 46, 47, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 67, 68, 69, 71, 73, 74, 75, 76, 77, 78, 79, 81, 82, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 97, 98, 99, 100,  ];


LoadPackage( "FinSets" );
LoadPackage( "SkeletalGSets" );

CapCategorySwitchLogicOff( FinSets );
DeactivateCachingOfCategory( FinSets );
DisableBasicOperationTypeCheck( FinSets );

DeactivateCachingOfCategory( SkeletalFinSets );
CapCategorySwitchLogicOff( SkeletalFinSets );
DisableBasicOperationTypeCheck( SkeletalFinSets );

CapCategorySwitchLogicOff( SkeletalGSets( G ) );
DeactivateCachingOfCategory( SkeletalGSets( G ) );
DisableBasicOperationTypeCheck( SkeletalGSets( G ) );

DeactivateToDoList();

Read( "ForgetfulFunctorSkeletalGSets.g" );
Read( "HomSkeletalGSets.g" );
Read( "EndAsEqualizer.g" );
Read( "EndByLifts.g" );

DeclareRepresentation( "IsMyGroupElement", IsMultiplicativeElementWithInverse and IsAttributeStoringRep, [] );
TheTypeOfMyGroupElements := NewType( NewFamily( "TheFamilyOfMyGroupElements" ), IsMyGroupElement );

DeclareAttribute( "AsList", IsMyGroupElement );
DeclareAttribute( "MyIndex", IsMyGroupElement );

TannakaIsomorphism := function( G )
  	local ToM, k, GeneratingSet, i, M, version, End, EndElements, MyOne, element, MyGroup;

	#################################################################################################################################################################
	# create generating set

	ToM := MatTom( TableOfMarks( G ) );
	k := Size( ToM );

	GeneratingSet := [];

	for i in [ 1 .. k ] do
		M := ListWithIdenticalEntries( k, 0 );
		M[ i ] := 1;
		Add( GeneratingSet, GSet( G, M ) );
	od;

	version := 1;

	#################################################################################################################################################################
	# first version

	if version = 1 then

		End := EndAsEqualizer( SkeletalGSets( G ), HomSkeletalGSets, ForgetfulFunctorSkeletalGSets, GeneratingSet );

	fi;


	#################################################################################################################################################################
	# second version

	if version = 2 then

		End := EndByLifts( SkeletalGSets( G ), HomSkeletalGSets, ForgetfulFunctorSkeletalGSets, GeneratingSet );

	fi;

	
	Display( Runtimes() );

	#################################################################################################################################################################
	# construct group in GAP

	EndElements := List( [ 1 .. Length( End ) ], function( i )
		local element;
		element := rec( );
		ObjectifyWithAttributes( element, TheTypeOfMyGroupElements, AsList, End[ i ], MyIndex, i );
		return element;
	end );

	InstallMethodWithCache( String,
	  "for my group elements",
	  [ IsMyGroupElement ],
			
	  function( x )
		
		return Concatenation( "<My group element with index ", String( MyIndex( x ) ), ">" );
		
	end );

	InstallMethodWithCache( \*,
	  "for my group elements",
	  [ IsMyGroupElement, IsMyGroupElement ],
			
	  function( x, y )
		local i, L, element;
		
		L := [];
		for i in [ 1 .. Length( AsList( x ) ) ] do
			L[i] := PreCompose( AsList(y)[ i ], AsList(x)[ i ] );
		od;
		
		for element in EndElements do
			if L = AsList( element ) then
				return element;
			fi;
		od;

		Error( "EndElements not closed under multiplication" );

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
		
		return( MyIndex( x ) < MyIndex( y ) );

	end );

	MyOne := false;
	for element in EndElements do
		if ForAll( AsList( element ), f -> f = IdentityMorphism( Source( f ) ) ) then
			MyOne := element;
			break;
		fi;
	od;

	if MyOne = false then
		Error( "EndElements does not contain the identity" );
	fi;

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

		return x^( Length( EndElements ) - 1 );
		
	end );

	MyGroup := Group( EndElements );

	return IsomorphismGroups( MyGroup, G );
end;

Display( TannakaIsomorphism( G ) );
