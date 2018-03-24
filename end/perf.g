# records


L := [];
R := rec();
for i in [ 1 .. 1 ] do
  # j := [ 1, 2, 3 ];
  # j := rec( 1 := 1, 2 := 2, 3 := 3 );
  L[i] := i;
  R.(i) := i;
od;
Display(Runtimes());
# quit;

# Display(R);

c_1 := 10^6;
#c_2 := 5 * 10^5 + 0;
c_1 := 1;
c_2 := 1;

Display(Runtimes());
last := Runtimes().user_time;
for i in [ 1 .. 10^7 ] do
	j := R.(c_1);
od;
Display(Runtimes().user_time - last);
last := Runtimes().user_time;
for i in [ 1 .. 10^7 ] do
	j := R.(c_2);
od;
Display(Runtimes().user_time - last);
last := Runtimes().user_time;
for i in [ 1 .. 10^7 ] do
	j := L[c_1];
od;
Display(Runtimes().user_time - last);
last := Runtimes().user_time;
for i in [ 1 .. 10^7 ] do
	j := L[c_2];
od;
Display(Runtimes().user_time - last);
last := Runtimes().user_time;
quit;




# LoadPackage("AutoDoc");
#LoadPackage("ToolsForHomalg");
LoadPackage("CAP");
#LoadPackage("RingsForHomalg");
#LoadPackage("FinSets");

base := 8^8;
list := [ 1 .. base ];





DeclareRepresentation( "IsMyGroupElement", IsAttributeStoringRep, [] );
TheTypeOfMyGroupElements := NewType( NewFamily( "TheFamilyOfMyGroupElements" ), IsMyGroupElement );

DeclareAttribute( "TESTASD", IsMyGroupElement );

InstallImmediateMethod( TESTASD,
                        IsMyGroupElement,
                        0,
                        
  function( morphism )
    
	return true;

end );

Display(Runtimes());
begin := Runtimes().user_time;

for i in [ 1 .. (6^6 * 6) ] do
	element := rec( );
	ObjectifyWithAttributes( element, TheTypeOfMyGroupElements );
	# SetFilterObj( element, IsCapCategoryMorphism );
	# SetFilterObj( element, HasCapCategory );
	# SetFilterObj( element, HasSource );
	# SetFilterObj( element, HasRange );
	# ObjectifyWithAttributes( element, TheTypeOfMapsOfSkeletalFiniteSets );
od;


#Cartesian( [ list ] );
Display(Runtimes().user_time - begin);

quit;

mysource := RandomSource(IsMersenneTwister, 42);;


for i in [ 1 .. Length( list ) ] do
	list[ i ] := [Random(mysource, 1, 2^32)];
od;

Display(Runtimes());
quit;

list := List( list, x -> 1 );


quit;


int := 0;
for i in [ 0 .. ( base - 1 ) ] do
	int := int + i * base^i;
od;

Display(Runtimes());
# rec( system_time := 706, system_time_children := 0, user_time := 53080, user_time_children := 0 )
