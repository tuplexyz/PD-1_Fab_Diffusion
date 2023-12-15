#!/bin/csh
cd $1

## Source HADDOCK
source /root/haddock/haddock2.4-2021-01/haddock_configure.csh

## Print start message
echo "==========================================================="
echo "==========================================================="
echo "      RUNNING: ANTIBODY <> ANTIGEN DOCKING STARTED         "
echo "==========================================================="
echo "==========================================================="

## Create run1 folder and enter it
haddock2.4 >&/dev/null
cd run1

## Patch CNS
patch -p0 -i ../run.cns.patch >&/dev/null

## Run HADDOCK
haddock2.4 >&haddock.out

## Perform analyses
cd ..
./ana_scripts/run_all.csh run1 >&/dev/null
# ../results-stats.csh run1

## Clean up unnecessary files
python3 cleanup.py

## Print done message
echo "==========================================================="
echo "==========================================================="
echo "      DONE: ANTIBODY <> ANTIGEN DOCKING COMPLETED          "
echo "==========================================================="
echo "==========================================================="
