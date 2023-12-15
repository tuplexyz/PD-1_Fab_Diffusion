#!/bin/csh
#
set WDIR=$HADDOCK/examples/protein-protein/ana_scripts
set refe=$WDIR/e2a-hpr_1GGR.pdb
set izone=$WDIR/e2a-hpr.izone
set atoms='CA'
#
# Define the location of profit
#
if ( `printenv |grep PROFIT | wc -l` == 0) then
  set found=`which profit |wc -l`
  if ($found == 0) then
     echo 'PROFIT environment variable not defined'
     echo '==> no rmsd calculations '
  else
     setenv PROFIT `which profit`
  endif
endif

cat /dev/null >rmsd-interface_xray.disp
gunzip *.pdb.gz >&/dev/null

foreach i (`cat file.nam`)
  echo $i >>rmsd-interface_xray.disp
  $PROFIT <<_Eod_ |grep RMS |tail -1 >>rmsd-interface_xray.disp
    refe $refe
    mobi $i
    `cat $izone`
    atom $atoms
    fit
    quit
_Eod_
end
echo "#struc i-RMSD" >i-RMSD.dat
awk '{if ($1 == "RMS:") {printf "%8.3f ",$2} else {printf "\n %s ",$1}}' rmsd-interface_xray.disp |grep pdb |awk '{print $1,$2}' >> i-RMSD.dat
head -1 i-RMSD.dat >i-RMSD-sorted.dat
grep pdb i-RMSD.dat |sort -nk2  >> i-RMSD-sorted.dat
\rm rmsd-interface_xray.disp
