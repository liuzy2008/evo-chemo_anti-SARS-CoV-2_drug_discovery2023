#!/bin/bash  
#PBS -q batch
#PBS -V
#PBS -N plantismash
#PBS -l nodes=1:ppn=48
#PBS -o ${work_dir}/sj_3d/logs/plantismash/pbs.log
#PBS -j oe
#


#the core number is the result that plantismash produce empty, make sure the core number is less than real 
source ${work_dir}/mambaforge/bin/activate plantismash
mkdir ${work_dir}/sj_3d/results/plantismash/scep
python2 ${work_dir}/soft/plantismash/plantismash-1.0/run_antismash.py  --taxon plants --gff3 ${work_dir}/sj_3d/genomes/scep/genome.gff ${work_dir}/sj_3d/genomes/scep/genome.fa -c 47  --min-domain-number  1 --outputfolder ${work_dir}/sj_3d/results/plantismash/scep2/ 
mkdir ${work_dir}/sj_3d/results/plantismash/sjap
python2 ${work_dir}/soft/plantismash/plantismash-1.0/run_antismash.py  --taxon plants --gff3 ${work_dir}/sj_3d/genomes/sjap/genome.gff ${work_dir}/sj_3d/genomes/sjap/genome.fa -c 47 --min-domain-number 1 --outputfolder ${work_dir}/sj_3d/results/plantismash/sjap2/
wait

