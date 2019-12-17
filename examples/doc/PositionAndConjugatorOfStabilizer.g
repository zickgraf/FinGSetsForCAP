#! @Chunk PositionAndConjugatorOfStabilizer

LoadPackage( "FinGSetsForCAP" );

#! @Example

G := SymmetricGroup( 3 );;
ToM := TableOfMarks( G );;
S := Stabilizer( G, 3 );
#! Sym( [ 1 .. 2 ] )
pos_and_conj := PositionAndConjugatorOfStabilizer( G, 3 );;
pos := pos_and_conj[1];
#! 2
conj := pos_and_conj[2];
#! (1,3)
ConjugateSubgroup( S, conj ) = RepresentativeTom( ToM, pos );
#! true

#! @EndExample
