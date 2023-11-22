#!/bin/bash  
#PBS -q batch
#PBS -V
#PBS -N hicNormmalize
#PBS -l nodes=1:ppn=48
#PBS -o ${work_dir}/sj_3d/logs/4_hicexplorer/2_hicNormmalize_pbs_log
#PBS -j oe
#
export PATH=${work_dir}/mambaforge/bin:$PATH
source  ${work_dir}/mambaforge/bin/activate
# ${work_dir}/mambaforge/bin/conda activate hicpro
# source activate 
# cd ${work_dir}/sj_3d/results/4_hicexplorer/1_hicSumMatrices
echo ''>${work_dir}/tmp/hic_pro_hicexplorer.tmp
for i in `ls ${work_dir}/sj_3d/results/2_transform/h5/`
do
#resolution
echo """
mkdir -p ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/
${work_dir}/mambaforge/bin/hicNormalize \
 --matrices \
 ${work_dir}/sj_3d/results/2_transform/h5/${i}/scep_${i}_matrix.h5 \
 ${work_dir}/sj_3d/results/2_transform/h5/${i}/sjap_${i}_matrix.h5 \
 ${work_dir}/sj_3d/results/2_transform/h5/${i}/syun_${i}_matrix.h5 \
 --normalize smallest \
 --outFileName \
 ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/scep_${i}_matrix.h5 \
 ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/sjap_${i}_matrix.h5 \
 ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/syun_${i}_matrix.h5 \

 """>> ${work_dir}/tmp/hic_pro_hicexplorer.tmp
done
${work_dir}/mambaforge/bin/ParaFly -c ${work_dir}/tmp/hic_pro_hicexplorer.tmp -CPU 48 -v
# i=40000
# mkdir -p ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/
# ${work_dir}/mambaforge/bin/hicNormalize \
#  --matrices \
#  ${work_dir}/sj_3d/results/2_transform/h5/${i}/scep_${i}_matrix.h5 \
#  ${work_dir}/sj_3d/results/2_transform/h5/${i}/sjap_${i}_matrix.h5 \
#  --normalize smallest \
#  --outFileName \
#  ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/scep_${i}_matrix.h5 \
#  ${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/${i}/sjap_${i}_matrix.h5 \


