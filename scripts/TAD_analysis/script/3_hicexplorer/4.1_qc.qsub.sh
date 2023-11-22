#!/bin/bash  
#PBS -q batch
#PBS -V
#PBS -N hicexplorer_qc
#PBS -l nodes=1:ppn=48
#PBS -o ${work_dir}/sj_3d/logs/4_hicexplorer/4_qc_log
#PBS -j oe
#
export PATH=${work_dir}/mambaforge/bin:$PATH
# source  ${work_dir}/mambaforge/bin/activate
# ${work_dir}/mambaforge/bin/conda activate hicpro
source activate 
cd ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/
# ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/{sample}_${i}_corrected.h5"
echo ''>${work_dir}/tmp/hic_pro_hicexplorer.tmp
for i in `ls ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/`
do
#resolution
# echo "${i}"
# done
hicCorrelate -m ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/sjap_${i}_corrected.h5 \
 ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/scep_${i}_corrected.h5 \
 ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/syun_${i}_corrected.h5 \
  --method=pearson --log1p \
   --outFileNameHeatmap ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/correlate_heatmap_${i}.pdf \
  --outFileNameScatter ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/correlate_scatter_${i}.pdf

hicPlotDistVsCounts -m ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/sjap_${i}_corrected.h5 \
 ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/scep_${i}_corrected.h5 \
 ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/syun_${i}_corrected.h5 \
   -o ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/${i}/counts_vs_dist_${i}.pdf 
done
# ${work_dir}/mambaforge/bin/ParaFly -c ${work_dir}/tmp/hic_pro_hicexplorer.tmp -CPU 48 -v
















   
# hicCorrelate -m ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/control/control_100000_corrected.h5 ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/heat/heat_100000_corrected.h5 --method=pearson --log1p --outFileNameHeatmap result/3_hicCorrectMatrix/correlate_heatmap_100000.pdf --outFileNameScatter result/3_hicCorrectMatrix/correlate_scatter_100000.pdf

# hicCorrelate -m ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/control/control_250000_corrected.h5 ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/heat/heat_250000_corrected.h5 --method=pearson --log1p --outFileNameHeatmap result/3_hicCorrectMatrix/correlate_heatmap_250000.pdf --outFileNameScatter result/3_hicCorrectMatrix/correlate_scatter_250000.pdf

# hicCorrelate -m ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/control/control_500000_corrected.h5 ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/heat/heat_500000_corrected.h5 --method=pearson --log1p --outFileNameHeatmap result/3_hicCorrectMatrix/correlate_heatmap_500000.pdf --outFileNameScatter result/3_hicCorrectMatrix/correlate_scatter_500000.pdf







# hicPlotDistVsCounts -m ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/control/control_100000_corrected.h5 ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/heat/heat_100000_corrected.h5 \
# -o result/3_hicCorrectMatrix/counts_vs_dist_10000.pdf 

# hicPlotDistVsCounts -m ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/control/control_250000_corrected.h5 ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/heat/heat_250000_corrected.h5 \
# -o result/3_hicCorrectMatrix/counts_vs_dist_25000.pdf 

# hicPlotDistVsCounts -m ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/control/control_500000_corrected.h5 ${work_dir}/3d/hicexplorer/result/3_hicCorrectMatrix/heat/heat_500000_corrected.h5\
# -o result/3_hicCorrectMatrix/counts_vs_dist_50000.pdf 

