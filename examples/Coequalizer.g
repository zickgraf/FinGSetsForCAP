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
AsList( Cq );
#! [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 ]
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
AsList( Cq );
#! [ 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 ]
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



A := GSet( S5, [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := GSet( S5, [ 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
f_1 := MapOfGSets(A, [ [ [ 1, (), 3 ] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
f_2 := MapOfGSets(A, [ [ [ 1, (1,2,3), 4] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f_1 );
#! true
IsWellDefined( f_2 );
#! true
D := [ f_1, f_2 ];;
Cq := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Cq );
#! [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
pi := ProjectionOntoCoequalizer( D );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( pi );
#! true



G := SymmetricGroup( 0 );;
s := GSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
t := GSet( G, [ 4 ] );
#! <An object in Skeletal Category of G-Sets>
f := MapOfGSets( s, [ [ [ 3, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], [ 2, (), 1 ], [ 4, (), 1 ] ] ], t );
#! <A morphism in Skeletal Category of G-Sets>
g := MapOfGSets( s, [ [ [ 3, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], [ 2, (), 1 ], [ 4, (), 1 ] ] ], t );
#! <A morphism in Skeletal Category of G-Sets>
D := [ f, g ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
C := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( C );
#! [ 3 ]
pi := ProjectionOntoCoequalizer(D);
#! <A morphism in Skeletal Category of G-Sets>
AsList( pi );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ] ] ]
tau := MapOfGSets( t, [ [ [ 2, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ] ] ], GSet( G, [ 2 ] ) );
#! <A morphism in Skeletal Category of G-Sets>
phi := UniversalMorphismFromCoequalizer( D, tau );
#! <A morphism in Skeletal Category of G-Sets>
AsList( phi );
#! [ [ [ 2, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ] ] ]
PreCompose( pi, phi ) = tau;
#! true

#! @EndExample
