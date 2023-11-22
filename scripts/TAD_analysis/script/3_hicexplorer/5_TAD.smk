#snakemake --use-conda  --cores 48 --rerun-triggers mtime  --rerun-incomplete  --cluster-cancel "qdel" --printshellcmds --cluster "qsub -V -q batch -l nodes=1:ppn=24  -N findTad -o ${work_dir}/sj_3d/logs/4_hicexplorer/hicFindTADs_{rule}_{jobid}.log -j oe"  -j 20  --snakefile 
resolutions,samples,tmp = glob_wildcards("${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution2}_corrected.h5")

pvals=[0.01,0.05,0.005]
mindepths=[3,5]
maxdepths=[6,10]
deltas=[0.01,0.05,0.005]
steps=2
samples=['scep','sjap','syun',]
# samples=[]

rule all:
    input:
        expand("${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_P_{pval}_corrected_boundaries.bed", sample=samples,resolution=resolutions,pval=pvals),
        expand("${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_P_{pval}_MinD_{mindepth}_MaxD_{maxdepth}_Delta_{delta}_Step_{step}_boundaries.bed", sample=samples,resolution=resolutions,pval=pvals,mindepth=mindepths,maxdepth=maxdepths,delta=deltas,step=steps),
        expand("${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/d_{sample}_{resolution}_P_{pval}_MinD_{mindepth}_MaxD_{maxdepth}_Delta_{delta}_boundaries.bed", sample=samples,resolution=resolutions,pval=pvals,mindepth=mindepths,maxdepth=maxdepths,delta=deltas),

# ${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix
rule hicFindTADs_default   :
    input:
        corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
    output:
        bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_P_{pval}_corrected_boundaries.bed"
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        hic_corrected="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_P_{pval}_corrected",
        resolution="{resolution}",
        pval="{pval}"
    shell:"""
${work_dir}/mambaforge/bin/hicFindTADs --correctForMultipleTesting fdr \
 -m  {input.corrected_h5} \
 --thresholdComparisons {params.pval} \
 --delta 0.01 \
 --outPrefix {params.hic_corrected} \
 --numberOfProcessors {threads} 

"""

rule hicFindTADs_try_with_step   :
    input:
        corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
    output:
        bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_P_{pval}_MinD_{mindepth}_MaxD_{maxdepth}_Delta_{delta}_Step_{step}_boundaries.bed"
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        hic_corrected="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_P_{pval}_MinD_{mindepth}_MaxD_{maxdepth}_Delta_{delta}_Step_{step}",
        resolution="{resolution}",
        pval="{pval}",
        mindepth="{mindepth}",
        maxdepth="{maxdepth}",
        delta="{delta}",
        step="{step}",
    shell:"""
${work_dir}/mambaforge/bin/hicFindTADs --correctForMultipleTesting fdr \
 -m  {input.corrected_h5} \
 --thresholdComparisons {params.pval} \
 --outPrefix {params.hic_corrected} \
 --numberOfProcessors {threads} \
 --minDepth $(({params.mindepth}*{params.resolution})) \
 --maxDepth $(({params.maxdepth}*{params.resolution})) \
 --step $(({params.step}*{params.resolution})) \
 --delta {params.delta} 
"""

rule hicFindTADs_try_default_step   :
    input:
        corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
    output:
        bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/d_{sample}_{resolution}_P_{pval}_MinD_{mindepth}_MaxD_{maxdepth}_Delta_{delta}_boundaries.bed"
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        hic_corrected="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/d_{sample}_{resolution}_P_{pval}_MinD_{mindepth}_MaxD_{maxdepth}_Delta_{delta}",
        resolution="{resolution}",
        pval="{pval}",
        mindepth="{mindepth}",
        maxdepth="{maxdepth}",
        delta="{delta}",
    shell:"""
${work_dir}/mambaforge/bin/hicFindTADs --correctForMultipleTesting fdr \
 -m  {input.corrected_h5} \
 --thresholdComparisons {params.pval} \
 --outPrefix {params.hic_corrected} \
 --numberOfProcessors {threads} \
 --minDepth $(({params.mindepth}*{params.resolution})) \
 --maxDepth $(({params.maxdepth}*{params.resolution})) \
 --delta {params.delta} 
"""




