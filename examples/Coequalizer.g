#! @System Coequalizer

LoadPackage( "SkeletalGSets" );

#! @Example

S5 := SymmetricGroup( 5 );
#! Sym( [ 1 .. 5 ] )
g_1_1 := ();;
g_1_2 := (1,2);;
g_1_3 := (1,3);;
g_1_4 := (1,4);;

g_2_1 := ();;
g_2_2 := (1,2);;
g_2_3 := ();;
g_2_4 := (1,2);;

g_3_1 := ();;
g_3_2 := (1,2);;
g_3_3 := (1,3);;
g_3_4 := (1,3);;


A := GSet( S5, [ 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := GSet( S5, [ 0, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
f_1 := MapOfGSets(A, [ [ [ 1, g_1_1, 2 ], [ 1, g_1_3, 2], [ 2, g_2_1, 2 ], [ 2, g_2_3, 2], [ 3, g_3_1, 2 ], [ 3, g_3_3, 2] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
f_2 := MapOfGSets(A, [ [ [ 1, g_1_2, 4 ], [ 1, g_1_4, 4], [ 2, g_2_2, 4 ], [ 2, g_2_4, 4], [ 3, g_3_2, 4 ], [ 3, g_3_4, 4] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f_1 );
#! true
IsWellDefined( f_2 );
#! true
D := [ f_1, f_2 ];;
Cq := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
Display( Cq );
#! [ SymmetricGroup( [ 1 .. 5 ] ), 
#!   [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 ] ]
pi := ProjectionOntoCoequalizer( D );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( pi );
#! true

id_to_be := UniversalMorphismFromCoequalizer( D, pi );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( id_to_be );
#! true
id := IdentityMorphism( Cq );
#! <An identity morphism in Skeletal Category of G-Sets>
id = id_to_be;
#! true


A := GSet( S5, [ 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := GSet( S5, [ 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
f_1 := MapOfGSets(A, [ [ [ 1, g_1_1, 2 ], [ 1, g_1_3, 2], [ 2, g_2_1, 2 ], [ 2, g_2_3, 2], [ 3, g_3_1, 2 ], [ 3, g_3_3, 2] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
f_2 := MapOfGSets(A, [ [ [ 1, g_1_2, 4 ], [ 1, g_1_4, 4], [ 2, g_2_2, 4 ], [ 2, g_2_4, 4], [ 3, g_3_2, 4 ], [ 3, g_3_4, 4] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f_1 );
#! true
IsWellDefined( f_2 );
#! true
D := [ f_1, f_2 ];;
Cq := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
Display( Cq );
#! [ SymmetricGroup( [ 1 .. 5 ] ), 
#!   [ 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 ] ]
pi := ProjectionOntoCoequalizer( D );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( pi );
#! true

id_to_be := UniversalMorphismFromCoequalizer( D, pi );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( id_to_be );
#! true
id := IdentityMorphism( Cq );
#! <An identity morphism in Skeletal Category of G-Sets>
id = id_to_be;
#! true

#! @EndExample
