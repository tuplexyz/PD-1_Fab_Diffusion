#!/bin/csh -f
#
set found=`tail -n 500 $1 | grep "CHAIN LENGHT FOR SYMMETRY RESTRAINTS DO NOT MATCH" | grep -v display | wc -l | awk '{print $1}'`

if ($found > 0) then
  tail -n 500 $1 |grep -A 1 "CHAIN LENGHT FOR SYMMETRY RESTRAINTS DO NOT MATCH" >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "NCS-restraints error encountered: Improperly defined non-crystallographic symmetry"`

if ($found > 0) then
  tail -n 500 $1 |grep "NCS-restraints error encountered: Improperly defined non-crystallographic symmetry" >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "error in SYMMETRY potential, check NOE table"`

if ($found > 0) then
  tail -n 500 $1 |grep "error in SYMMETRY potential, check your symmetry restraints definition" >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "exceeded allocation for NOE-restraints"`

if ($found > 0) then
  tail -n 500 $1 |grep "exceeded allocation for NOE-restraints" >>FAILED
  echo "Check your definition of active and passive residues" >>FAILED
  echo "Make sure to filter those for solvent accessibility"  >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "SELRPN error encountered: parsing error"`

if ($found > 0) then
  tail -n 500 $1 |grep -B 10 "SELRPN error encountered: parsing error" >>FAILED
  echo "Check your restraint files " >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "PARSER error encountered: Encountered too many parsing errors"`

if ($found > 0) then
  tail -n 500 $1 |grep -B 10 "PARSER error encountered: Encountered too many parsing errors" >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "XMREAD error encountered:  sectioning of map incompatible with resolution"`

if ($found > 0) then
  tail -n 500 $1 | grep -A 2 -B 2 "XMREAD error encountered:  sectioning of map incompatible with resolution" >>FAILED
  echo "Check your EM map resolution and sectioning" >>FAILED
endif

set found=`tail -n 500 $1 | grep -c "not enough memory available to the program"`

if ($found > 0) then
  head -n 100 $1 | grep "Running on" >>WARNING
  tail -n 500 $1 | grep "not enough memory available to the program" >>WARNING
  echo "Check your definition of active and passive residues"     >>WARNING
  echo "Make sure to filter those for solvent accessibility"      >>WARNING
  echo "Try to decrease the size of your system where possible"   >>WARNING
endif

if ( -e WARNING ) then
  set warnlength=`wc -l WARNING | awk '{print $1}'`
  # if more than 100 structures fail we will flag the run as failed.
  if ( $warnlength > 500 ) then
    \cat WARNING >FAILED
  endif
endif
