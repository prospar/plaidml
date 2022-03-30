rm logs/*
rm script.sh.e*
rm script.sh.o*
qsub -q xeon -lselect=1:ncpus=160 ./script.sh
