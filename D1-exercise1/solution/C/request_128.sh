#!/bin/bash
#PBS -l nodes=16:ppn=20 -q regular -l walltime=00:05:00
#PBS -N fft

module load openmpi/1.8.3/gnu/4.9.2
module load fftw/3.3.4/gnu/4.9.2

cd /home/cdenobi/P2.8_seed/D1-exercise1/solution/C

make clean
make

num_nodes="1 2 4 8"

for node in $num_nodes; do
    nproc=$(($node * 16))
    echo "------------- NUMBER OF PROCESSOR = $nproc -----------------" >> log_strong128.txt
    mpirun -np $nproc --map-by ppr:16:node:pe=1 ./diffusion.x 128 >> log_strong128.txt
done
