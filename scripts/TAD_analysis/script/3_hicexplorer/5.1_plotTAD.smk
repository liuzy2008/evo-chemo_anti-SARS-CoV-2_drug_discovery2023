#snakemake --use-conda  --cores 48 --rerun-triggers mtime  --rerun-incomplete  --cluster-cancel "qdel" --printshellcmds --cluster "qsub -V -q batch -l nodes=1:ppn=24  -N findTad -o ${work_dir}/sj_3d/logs/4_hicexplorer/hicFindTADs_{rule}_{jobid}.log -j oe"  -j 20  --snakefile 
# test
resolutions,samples,tmp = glob_wildcards("${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution2}_corrected.h5")

rule all:
    input:
        expand("${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_corrected_boundaries.bed", sample=samples,resolution=resolutions),



rule hicPlotTADs    :
    input:
        corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
        bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_corrected_boundaries.bed"
    output:
        bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_corrected_boundaries.bed"
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    shell:"""
    
${work_dir}/mambaforge/bin/hicPlotTADs --tracks tracks.ini --region chrX:6800000-8500000  -o TAD_calling_comparison.png
${work_dir}/mambaforge/bin/hicPlotTADs --correctForMultipleTesting fdr -m  {input.corrected_h5}  --outPrefix {params.hic_corrected} --numberOfProcessors {threads} 
"""
