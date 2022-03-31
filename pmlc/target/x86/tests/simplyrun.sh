rm -f logs/*
rm -f script.sh.e*
rm -f script.sh.o*
qsub -q xeon -lselect=1:ncpus=160 ./script.sh
