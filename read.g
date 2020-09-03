#
# FinGSetsForCAP: The elementary topos of (skeletal) finite G-sets
#
# Reading the implementation part of the package.
#

ReadPackage( "FinGSetsForCAP", "gap/Tools.gi");

ReadPackage( "FinGSetsForCAP", "gap/SkeletalFinGSetsForCAP.gi");

if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2018.09.17" ) then
    ReadPackage( "FinGSetsForCAP", "gap/EndAsEqualizer.gi");
    ReadPackage( "FinGSetsForCAP", "gap/EndByLifts.gi");
    ReadPackage( "FinGSetsForCAP", "gap/ReconstructTableOfMarks.gi");
    ReadPackage( "FinGSetsForCAP", "gap/HomSkeletalFinGSets.gi");
    ReadPackage( "FinGSetsForCAP", "gap/ForgetfulFunctorSkeletalGSets.gi");
    ReadPackage( "FinGSetsForCAP", "gap/ReconstructGroup.gi");
fi;
