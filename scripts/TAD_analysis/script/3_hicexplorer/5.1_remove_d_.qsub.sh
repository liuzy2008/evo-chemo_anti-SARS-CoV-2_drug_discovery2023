#!/bin/bash  
#PBS -q batch
#PBS -V
#PBS -N rm_d
#PBS -l nodes=1:ppn=48
#PBS -o ${work_dir}/sj_3d/logs/4_hicexplorer/4_rm_d
#PBS -j oe
#

for r in `ls ${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/`
do
for f in `ls ${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/${r}`
do 
if  [[ ${f} == d_* ]]
then
mv ${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/${r}/${f} ${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/${r}/${f#*_}
fi
done
done



