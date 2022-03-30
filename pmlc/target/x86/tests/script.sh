cd /tier1/iitkanpur/plaidml
conda activate ./.cenv
module load gnu8

cd pmlc/target/x86/tests
export OMP_NUM_THREADS=1
export KMP_AFFINITY="granularity=verbose,fine,proclist=[0],explicit"
python benchmark.py "/tier1/iitkanpur/SCALE-Sim/topologies/test"
