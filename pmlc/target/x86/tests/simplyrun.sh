rm -f logs/*
rm -f script.sh.e*
rm -f script.sh.o*

cd /tier1/iitkanpur/plaidml
conda activate ./.cenv
module load gnu8

cd pmlc/target/x86/tests
export PLAIDML_PROFILE=1
export PLAIDML_VERBOSE=1
export OMP_NUM_THREADS=1
export KMP_AFFINITY="granularity=verbose,fine,proclist=[0],explicit"

qsub -q clx -lselect=1:ncpus=112 -V ./script.sh
