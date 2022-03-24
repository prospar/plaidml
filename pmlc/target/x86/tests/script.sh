cd /tier1/iitkanpur/plaidml
conda activate ./.cenv
module load gnu8

cd pmlc/target/x86/tests
python benchmark.py "/tier1/iitkanpur/SCALE-Sim/topologies/test"
