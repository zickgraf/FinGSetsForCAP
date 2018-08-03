#! @System SkeletalCoequalizer

LoadPackage( "FinGSetsForCAP" );

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


A := FinGSet( S5, [ 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S5, [ 0, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
f_1 := MapOfFinGSets(A, [ [ [ 1, g_1_1, 2 ], [ 1, g_1_3, 2], [ 2, g_2_1, 2 ], [ 2, g_2_3, 2], [ 3, g_3_1, 2 ], [ 3, g_3_3, 2] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
f_2 := MapOfFinGSets(A, [ [ [ 1, g_1_2, 4 ], [ 1, g_1_4, 4], [ 2, g_2_2, 4 ], [ 2, g_2_4, 4], [ 3, g_3_2, 4 ], [ 3, g_3_4, 4] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f_1 );
#! true
IsWellDefined( f_2 );
#! true
D := [ f_1, f_2 ];;
Cq := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Cq );
#! [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1 ]
pi := ProjectionOntoCoequalizer( D );
#! <An epimorphism in Skeletal Category of G-Sets>
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


A := FinGSet( S5, [ 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S5, [ 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
f_1 := MapOfFinGSets(A, [ [ [ 1, g_1_1, 2 ], [ 1, g_1_3, 2], [ 2, g_2_1, 2 ], [ 2, g_2_3, 2], [ 3, g_3_1, 2 ], [ 3, g_3_3, 2] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
f_2 := MapOfFinGSets(A, [ [ [ 1, g_1_2, 4 ], [ 1, g_1_4, 4], [ 2, g_2_2, 4 ], [ 2, g_2_4, 4], [ 3, g_3_2, 4 ], [ 3, g_3_4, 4] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f_1 );
#! true
IsWellDefined( f_2 );
#! true
D := [ f_1, f_2 ];;
Cq := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Cq );
#! [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1 ]
pi := ProjectionOntoCoequalizer( D );
#! <An epimorphism in Skeletal Category of G-Sets>
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



A := FinGSet( S5, [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( S5, [ 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
f_1 := MapOfFinGSets(A, [ [ [ 1, (), 3 ] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
f_2 := MapOfFinGSets(A, [ [ [ 1, (1,2,3), 4] ], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [] ], B);
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f_1 );
#! true
IsWellDefined( f_2 );
#! true
D := [ f_1, f_2 ];;
Cq := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( Cq );
#! [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ]
pi := ProjectionOntoCoequalizer( D );
#! <An epimorphism in Skeletal Category of G-Sets>
IsWellDefined( pi );
#! true



G := SymmetricGroup( 0 );;
s := FinGSet( G, [ 5 ] );
#! <An object in Skeletal Category of G-Sets>
t := FinGSet( G, [ 4 ] );
#! <An object in Skeletal Category of G-Sets>
f := MapOfFinGSets( s, [ [ [ 3, (), 1 ], [ 4, (), 1 ], [ 4, (), 1 ], [ 2, (), 1 ], [ 4, (), 1 ] ] ], t );
#! <A morphism in Skeletal Category of G-Sets>
g := MapOfFinGSets( s, [ [ [ 3, (), 1 ], [ 3, (), 1 ], [ 4, (), 1 ], [ 2, (), 1 ], [ 4, (), 1 ] ] ], t );
#! <A morphism in Skeletal Category of G-Sets>
D := [ f, g ];
#! [ <A morphism in Skeletal Category of G-Sets>, <A morphism in Skeletal Category of G-Sets> ]
C := Coequalizer( D );
#! <An object in Skeletal Category of G-Sets>
AsList( C );
#! [ 3 ]
pi := ProjectionOntoCoequalizer( D );
#! <An epimorphism in Skeletal Category of G-Sets>
Display( pi );
#! [ [ [ 1, (), 1 ], [ 2, (), 1 ], [ 3, (), 1 ], [ 3, (), 1 ] ] ]
tau := MapOfFinGSets( t, [ [ [ 2, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ], [ 2, (), 1 ] ] ], FinGSet( G, [ 2 ] ) );
#! <A morphism in Skeletal Category of G-Sets>
phi := UniversalMorphismFromCoequalizer( D, tau );
#! <A morphism in Skeletal Category of G-Sets>
Display( phi );
#! [ [ [ 2, (), 1 ], [ 1, (), 1 ], [ 2, (), 1 ] ] ]
PreCompose( pi, phi ) = tau;
#! true




G := SymmetricGroup( 0 );;
A := FinGSet( G, [ 2 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( G, [ 3 ] );
#! <An object in Skeletal Category of G-Sets>
f := MapOfFinGSets( A, [ [ [ 1, (), 1 ], [ 2, (), 1 ] ] ], B );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f );
#! true
g := MapOfFinGSets( A, [ [ [ 2, (), 1 ], [ 3, (), 1 ] ] ], B );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( g );
#! true
D := [ f, g ];;
Cq := Coequalizer( D );;
Display( Cq );
#! [ Group( () ), [ 1 ] ]
pi := ProjectionOntoCoequalizer( D );;
IsWellDefined( pi );
#! true
PreCompose( f, pi ) = PreCompose( g, pi );
#! true


G := SymmetricGroup( 3 );;
A := FinGSet( G, [ 0, 0, 0, 0 ] );;
id := IdentityMorphism( A );
#! <An identity morphism in Skeletal Category of G-Sets>
D := [ id, id ];;
Cq := Coequalizer( D );;
Display( Cq );
#! [ SymmetricGroup( [ 1 .. 3 ] ), [ 0, 0, 0, 0 ] ]
pi := ProjectionOntoCoequalizer( D );;
IsWellDefined( pi );
#! true
pi = id;
#! true


G := SymmetricGroup( 3 );;
A := FinGSet( G, [ 0, 0, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
B := FinGSet( G, [ 1, 1, 1, 1 ] );
#! <An object in Skeletal Category of G-Sets>
f := MapOfFinGSets( A, [ [ ], [ ], [ ], [ ] ], B );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( f );
#! true
D := [ f, f ];;
Cq := Coequalizer( D );;
Display( Cq );
#! [ SymmetricGroup( [ 1 .. 3 ] ), [ 1, 1, 1, 1 ] ]
pi := ProjectionOntoCoequalizer( D );;
pi = IdentityMorphism( B );
#! true




#! @EndExample
