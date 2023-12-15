#!/bin/csh
#
setenv target protein-protein
setenv WDIR $HADDOCK/examples/protein-protein/ana_scripts

cd $1/structures/it1/water/analysis
gunzip cluster.out.gz; \rm *out.gz
cd ..
$WDIR/i-rmsd_to_xray.csh 
$WDIR/l-rmsd_to_xray.csh 
$HADDOCKTOOLS/ana_structures.csh
$WDIR/fraction-native.csh 
$HADDOCKTOOLS/ana_clusters.csh -best 4 analysis/cluster.out
$WDIR/cluster-fnat.csh 4
cd ../analysis
gunzip cluster.out.gz; \rm *out.gz
cd ..
$WDIR/i-rmsd_to_xray.csh 
$WDIR/l-rmsd_to_xray.csh 
$HADDOCKTOOLS/ana_structures.csh
$WDIR/fraction-native.csh 
$HADDOCKTOOLS/ana_clusters.csh -best 4 analysis/cluster.out
$WDIR/cluster-fnat.csh 4
cd ../it0
$WDIR/i-rmsd_to_xray.csh 
$WDIR/l-rmsd_to_xray.csh 
$HADDOCKTOOLS/ana_structures.csh
$WDIR/fraction-native.csh 
cd ../../../





