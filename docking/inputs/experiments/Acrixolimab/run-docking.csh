#!/bin/csh
cd $1
# source ../../haddock_configure.csh
# source $HOME/haddock/haddock2.4-2021-01/haddock_configure.csh
source /root/haddock/haddock2.4-2021-01/haddock_configure.csh
echo "==========================================================="
echo "==========================================================="
echo " RUNNING: ANTIBODY <> ANTIGEN DOCKING STARTED         "
echo "==========================================================="
echo "==========================================================="
haddock2.4 >&/dev/null
cd run1
patch -p0 -i ../run.cns.patch >&/dev/null
haddock2.4 >&haddock.out
cd ..
./ana_scripts/run_all.csh run1 >&/dev/null
# ../results-stats.csh run1
python3 cleanup.py
echo "==========================================================="
echo "==========================================================="
echo " DONE: ANTIBODY <> ANTIGEN DOCKING COMPLETED          "
echo "==========================================================="
echo "==========================================================="
