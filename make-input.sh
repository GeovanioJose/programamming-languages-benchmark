#!/bin/bash

mkdir -p input

cd c
cd fasta
echo -ne '\rCreating... [0/4]'
./fasta.gcc-9.gcc_run 5000000 > ../../input/regexredux-input5000000.txt
echo -ne '\rCreating... [1/4]'
cp ../../input/regexredux-input5000000.txt ../../fortran/regexredux
echo -ne '\rCreating... [2/4]'
./fasta.gcc-9.gcc_run 100000001 > ../../input/revcomp-input100000001.txt #only fortran
echo -ne '\rCreating... [3/4]'
./fasta.gcc-9.gcc_run 25000000 > ../../input/knucleotide-input25000000.txt
echo -ne '\rCreating... [4/4]\r'
echo -e '\e[32mSuccessfully created\e[0m'

