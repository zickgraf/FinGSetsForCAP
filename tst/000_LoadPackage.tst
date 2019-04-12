gap> LoadPackage( "FinGSetsForCAP", false );
true
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "FinGSetsForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
