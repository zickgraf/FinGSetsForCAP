#! @System InitialTerminal

LoadPackage( "SkeletalGSets" );

#! @Example

S3 := SymmetricGroup( 3 );
#! Sym( [ 1 .. 3 ] )
S := GSet( S3, [ 2, 2, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
u := UniversalMorphismFromInitialObject( S );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( u );
#! true

S := GSet( S3, [ 2, 2, 0, 0 ] );
#! <An object in Skeletal Category of G-Sets>
u := UniversalMorphismIntoTerminalObject( S );
#! <A morphism in Skeletal Category of G-Sets>
IsWellDefined( u );
#! true

#! @EndExample
