#
# FinGSetsForCAP
#
# Reading the declaration part of the package.
#

ReadPackage( "FinGSetsForCAP", "gap/Tools.gd");

ReadPackage( "FinGSetsForCAP", "gap/SkeletalFinGSetsForCAP.gd");

if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" ) then
    ReadPackage( "FinGSetsForCAP", "gap/Reconstruction.gd");
fi;
