# SetAssertionLevel( 4 );

LoadPackage("FinSets");
# LoadPackage("Semigroups");

# DeclareRepresentation( "IsMyGroupElement", IsMultiplicativeElementWithInverse and IsAttributeStoringRep, [] );
# TheTypeOfMyGroupElements := NewType( NewFamily( "TheFamilyOfMyGroupElements" ), IsMyGroupElement );
# 
# 
# x := "x";
# y := "y";
# 
# 
# xElement := rec( );
# ObjectifyWithAttributes( xElement, TheTypeOfMyGroupElements, AsList, x );
# yElement := rec( );
# ObjectifyWithAttributes( yElement, TheTypeOfMyGroupElements, AsList, y );
# 
# 
# InstallMethod( \*,
#   "for my group elements",
#   [ IsMyGroupElement, IsMyGroupElement ],
#         
#   function( x1, y1 )
#     
# 	if IsIdenticalObj( x1, y1 ) then
# 		return xElement;
# 	else
# 		return yElement;
#     fi;
# 
# end );
# 
# InstallMethod( \=,
#   "for my group elements",
#   [ IsMyGroupElement, IsMyGroupElement ],
#         IsIdenticalObj );
# 
# InstallMethod( \<,
#   "for my group elements",
#   [ IsMyGroupElement, IsMyGroupElement ],
#      
#   function( x1, y1 )
#     
# 	if IsIdenticalObj( x1, xElement ) and IsIdenticalObj( y1, yElement ) then
# 		return true;
# 	else
# 		return false;
#     fi;
# 
# end );
# 
# InstallMethod( One,
#   "for my group elements",
#   [ IsMyGroupElement ],
#         
#   function( x1 )
#     
# 	return xElement;
# 	
# end );
# 
# InstallMethod( InverseOp,
#   "for my group elements",
#   [ IsMyGroupElement ],
#         
#   function( x1 )
#     
# 	if IsIdenticalObj( x1, xElement ) then
# 		return xElement;
# 	fi;
# 	
# 	if IsIdenticalObj( x1, yElement ) then
# 		return yElement;
# 	fi;
# 	
# 	Error( "should not get here" );
# 	
# end );
# 
# MyMonoid := Group( [ xElement, yElement ] );
# IsomorphicMonoidToBe := Group( [ (1,2) ] );
# 
# IsomorphismGroups(MyMonoid,IsomorphicMonoidToBe);






LoadPackage("FinSets");
LoadPackage("SkeletalGSets");

G := SymmetricGroup( 3 );
# G := SmallGroup(4,2);

#FinSet( [ MapOfGSets( GSet( G, [] ), [ ], GSet( G, [] ) ) ] ) = FinSet( [ MapOfFinSets( FinSet( [] ), [ ], FinSet( [] ) ) ] );

#IsWellDefined( FinSet( [ MapOfGSets( GSet( G, [] ), [ ], GSet( G, [] ) ) ] ) );
#IsWellDefined( FinSet( [ MapOfFinSets( FinSet( [] ), [ ], FinSet( [] ) ) ] ) );

#quit;

CapCategorySwitchLogicOff(FinSets);
CapCategorySwitchLogicOff(SkeletalFinSets);

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
			
			for h in RightTransversal( group, U_i ) do
				Add( set_imgs, OffsetOfCopyInTarget( r, j ) + OffsetOfElementInCopy( g * h, j ) );
			od;
		od;
	od;
	
	return MapOfFinSets( obj1, set_imgs, obj2 );
	
end );


#B := GSet( G, [ 2, 1, 0, 1 ] );
#phi := MapOfGSets( A, [ [ [ 2, (1,2), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 4 ] ], [ [ 1, (), 4 ] ] ], B );
#set_phi := ApplyFunctor( ForgetfulFunctor, phi );
#Display( set_phi );
#IsWellDefined( set_phi );


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
			Append( UnderlyingSet, List( RightCosets( group, U_i ), coset ->  [ l, coset, i ] ) );
		od;
	od;

	return FinSetNC( MakeImmutable( UnderlyingSet ) );
	
end );

#A := GSet( G, [ 1, 1, 1, 1 ] );
#Display(ApplyFunctor( ForgetfulFunctor, A ));

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
				Add( graph, [ [ l, h, i ], [ r, g * Representative( h ), j ] ] );
			od;
		od;
	od;
	
	return MapOfFinSets( obj1, graph, obj2 );
	
end );


#B := GSet( G, [ 2, 1, 0, 1 ] );
#phi := MapOfGSets( A, [ [ [ 2, (1,2), 1 ] ], [ [ 1, (), 2 ] ], [ [ 1, (), 4 ] ], [ [ 1, (), 4 ] ] ], B );
#set_phi := ApplyFunctor( ForgetfulFunctor, phi );
#Display( set_phi );
#IsWellDefined( set_phi );



HomFinSets := function ( S, T )
	local M, N, homs, Graphs, ImageLists, ImageList, graph, i;
	
	M := AsList( S );
	N := AsList( T );
	
	homs := [];
	
	# DirectProduct vs. Cartesian: use Cartesian to make explicit, that this is a set theoretic construction which might not work in general
	ImageLists := MakeImmutable( Cartesian( List( M, m -> N ) ) );
	for ImageList in ImageLists do
		Assert( 3, Size( ImageList ) = Size( M ) );
		graph := [];
		for i in [ 1 .. Size( M ) ] do
			Add( graph, [ M[ i ], ImageList[ i ] ] );
		od;
		Add( homs, MapOfFinSetsNC( S, graph, T ) );
	od;
	
	return FinSetNC( homs );
end;


HomGSets := function( S, T )
	local M, N, group, k, homs, ImageLists, ImageList, graph, CurrentImageListPosition, i, U_i, l, img, r, g, j, U_j, WellDefined;
	
	M := AsList( S );
	N := AsList( T );
	
	group := UnderlyingGroup( S );
	k := Size( M );
	
	homs := [];
	
	# DirectProduct vs. Cartesian: use Cartesian to make explicit, that this is a set theoretic construction which might not work in general
	ImageLists := Cartesian( List( [ 1 .. Sum( M ) ], x -> AsList( ApplyFunctor( ForgetfulFunctor, T ) ) ) );
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


GetRhoComponent := function( IndexSet, i_1, i_2 )
	local Omega_1, Omega_2, S, T, Graph, SourceComponents, pi, RhoComponent;
	Display("RhoComponent");
	Display(i_1);
	Display(i_2);
	Display("started");
	Omega_1 := IndexSet[ i_1 ];
	Omega_2 := IndexSet[ i_2 ];
	
	S := HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_1 ) );
	T := HomFinSets( HomGSets( Omega_1, Omega_2), HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	Graph := List( S, phi -> 
		[
			phi,
			MapOfFinSetsNC(
				HomGSets( Omega_1, Omega_2),
				List( HomGSets( Omega_1, Omega_2), f ->
					[
						f,
						PreCompose( phi, ApplyFunctor( ForgetfulFunctor, f ) )
					]
				),
				HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )
			)
		]
	);
	
	SourceComponents := List( IndexSet, Omega -> HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
	
	Display("Graph");
	
	pi := ProjectionInFactorOfDirectProduct( SourceComponents, i_1 );
	
	Display("pi");

	RhoComponent := PreCompose( pi, MapOfFinSetsNC( S, Graph, T ) );

	Display("finished");

	return RhoComponent;
end;

GetLambdaComponent := function( IndexSet, i_1, i_2 )
	local Omega_1, Omega_2, S, T, Graph, SourceComponents, pi, LambdaComponent;
	Display("LambdaComponent");
	Display(i_1);
	Display(i_2);
	Display("started");
	Omega_1 := IndexSet[ i_1 ];
	Omega_2 := IndexSet[ i_2 ];
	
	S := HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_2 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) );
	T := HomFinSets( HomGSets( Omega_1, Omega_2), HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) ) );

	Graph := List( S, phi -> 
		[
			phi,
			MapOfFinSetsNC(
				HomGSets( Omega_1, Omega_2),
				List( HomGSets( Omega_1, Omega_2), f ->
					[
						f,
						PreCompose( ApplyFunctor( ForgetfulFunctor, f ), phi )
					]
				),
				HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )
			)
		]
	);
	
	SourceComponents := List( IndexSet, Omega -> HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
	
	Display("Graph");
	
	pi := ProjectionInFactorOfDirectProduct( SourceComponents, i_2 );
	
	Display("pi");

	LambdaComponent := PreCompose( pi, MapOfFinSetsNC( S, Graph, T ) );

	Display("finished");

	return LambdaComponent;
end;

ToM := MatTom( TableOfMarks( G ) );
k := Size( ToM );

IndexSet := [];

for i in [ 1 ] do
	M := ListWithIdenticalEntries( k, 0 );
	M[ i ] := 1;
	Add( IndexSet, GSet( G, M ) );
od;


# IsWellDefined( FinSet( HomGSets( IndexSet[ 1 ], IndexSet[ 1 ] ) ));
#Display("hi");

#IsWellDefined( FinSet( [ MapOfGSets( GSet( G, [] ), [ ], GSet( G, [] ) ) ] ) );
#IsWellDefined( FinSet( [ MapOfFinSets( FinSet( [] ), [ ], FinSet( [] ) ) ] ) );
#quit;

SourceComponents := List( IndexSet, Omega -> HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega ), ApplyFunctor( ForgetfulFunctor, Omega ) ) );
Display("SourceComponents");
S := DirectProduct( SourceComponents );
Display("Source");
Projections := List( [ 1 .. Length( IndexSet ) ], i -> ProjectionInFactorOfDirectProduct( SourceComponents, i ) );
Display("Projections");
TargetComponents := Concatenation( List( IndexSet, Omega_1 -> List( IndexSet, Omega_2 -> HomFinSets( HomGSets( Omega_1, Omega_2 ) , HomFinSets( ApplyFunctor( ForgetfulFunctor, Omega_1 ), ApplyFunctor( ForgetfulFunctor, Omega_2 ) )  ) ) ) );
Display("TargetComponents");
T := DirectProduct( TargetComponents );
Display("Target");
RhoComponents := Concatenation( List( [ 1 .. Size( IndexSet ) ], i_1 -> List( [ 1 .. Size( IndexSet ) ], i_2 -> GetRhoComponent(IndexSet, i_1, i_2) ) ) );
Display("RhoComponents");
Rho := UniversalMorphismIntoDirectProduct( RhoComponents );
Display("Rho");
LambdaComponents := Concatenation( List( [ 1 .. Size( IndexSet ) ], i_1 -> List( [ 1 .. Size( IndexSet ) ], i_2 -> GetLambdaComponent(IndexSet, i_1, i_2) ) ) );
Display("LambdaComponents");
Lambdaa := UniversalMorphismIntoDirectProduct( LambdaComponents );
Display("Lambda");

emb := EmbeddingOfEqualizer( [ Rho, Lambdaa ] );
Enda := Source( emb );

NaturalTransformations := List( Enda, i -> List( Projections, pi -> PreCompose( emb, pi )( i ) ) );


DeclareRepresentation( "IsMyGroupElement", IsMultiplicativeElementWithInverse and IsAttributeStoringRep, [] );
TheTypeOfMyGroupElements := NewType( NewFamily( "TheFamilyOfMyGroupElements" ), IsMyGroupElement );

NaturalTransformationElements := List( NaturalTransformations, function(x)
	local element;
	element := rec( );
	ObjectifyWithAttributes( element, TheTypeOfMyGroupElements, AsList, x );
	return element;
end );

InstallMethod( \*,
  "for my group elements",
  [ IsMyGroupElement, IsMyGroupElement ],
        
  function( x, y )
    local i, L, element;
	
	L := [];
	for i in [ 1 .. Length( AsList( x ) ) ] do
		L[i] := PreCompose( AsList(x)[ i ], AsList(y)[ i ] );
	od;
	
	for element in NaturalTransformationElements do
		if L = AsList( element ) then
			return element;
		fi;
	od;

	Error( "should never get here" );

end );

InstallMethod( \=,
  "for my group elements",
  [ IsMyGroupElement, IsMyGroupElement ],
        IsIdenticalObj );

InstallMethod( \<,
  "for my group elements",
  [ IsMyGroupElement, IsMyGroupElement ],
     
  function( x, y )
    
	return( Position( NaturalTransformations, x ) < Position( NaturalTransformations, y ) );

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


InstallMethod( One,
  "for my group elements",
  [ IsMyGroupElement ],
        
  function( x1 )
    
	return MyOne;
	
end );

InstallMethod( InverseOp,
  "for my group elements",
  [ IsMyGroupElement ],
        
  function( x )
    
	return x^( Length( NaturalTransformationElements ) - 1 );
	
end );

MyGroup := Group( NaturalTransformationElements );

IsomorphismGroups( MyGroup, G );
