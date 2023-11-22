#snakemake --use-conda  --cores 48 --rerun-triggers mtime  --rerun-incomplete  --cluster-cancel "qdel" --printshellcmds --cluster "qsub -V -q batch -l nodes=1:ppn=8  -N correct_matrix -o ${work_dir}/sj_3d/logs/4_hicexplorer/4_hicCorrectMatrix_{rule}_{jobid}.log -j oe" -j 20  --snakefile 
resolutions,samples,tmp = glob_wildcards("${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/{resolution}/{sample}_{resolution2}_matrix.h5")
# samples=[]
samples=['scep','sjap', 'syun',]
rule all:
    input:
        expand("${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/{resolution}/{sample}_{resolution}_correct.pdf", sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5", sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/{resolution}/{sample}_{resolution}_perchr.pdf", sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/{resolution}/{sample}_{resolution}_conbine.pdf", sample=samples,resolution=resolutions),


rule hicCorrectMatrix_plot:
    input:
        h5="${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/{resolution}/{sample}_{resolution}_matrix.h5",
    output:
        plot="${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/{resolution}/{sample}_{resolution}_correct.pdf",
    threads: 24,
    resources: 
        mem_mb=24576,
        tmpdir="${work_dir}/tmp/3d/",
    shell:"""
${work_dir}/mambaforge/bin/hicCorrectMatrix diagnostic_plot --matrix {input.h5} -o {output.plot}
"""

rule hicCorrectMatrix :
    input:
        h5="${work_dir}/sj_3d/results/4_hicexplorer/2_hicNormmalize/{resolution}/{sample}_{resolution}_matrix.h5",
    output:
        pdf="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}.pdf",
        corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    shell:"""
${work_dir}/mambaforge/bin/hicCorrectMatrix diagnostic_plot -m {input.h5} -o {output.pdf} 
${work_dir}/mambaforge/bin/hicCorrectMatrix correct -m {input.h5} --filterThreshold -1.5 5 -o {output.corrected_h5} 
"""

rule hicPlotMatrix  :
    input:
        corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
    output:
        pdf_perchr="${work_dir}/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/{resolution}/{sample}_{resolution}_perchr.pdf",
        pdf_conbine="${work_dir}/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/{resolution}/{sample}_{resolution}_conbine.pdf",
        pdf_perchr_log="${work_dir}/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/{resolution}/{sample}_{resolution}_perchr_log.pdf",
        pdf_conbine_log="${work_dir}/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/{resolution}/{sample}_{resolution}_conbine_log.pdf",

    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    shell:"""
${work_dir}/mambaforge/bin/hicPlotMatrix -m  {input.corrected_h5} -o {output.pdf_perchr_log} --dpi 330 --perChr --log1p 
${work_dir}/mambaforge/bin/hicPlotMatrix -m  {input.corrected_h5} -o {output.pdf_conbine_log}  --dpi 330 --log1p  
${work_dir}/mambaforge/bin/hicPlotMatrix -m  {input.corrected_h5} -o {output.pdf_conbine}  --dpi 330 --vMax 4  
${work_dir}/mambaforge/bin/hicPlotMatrix -m  {input.corrected_h5} -o {output.pdf_perchr} --dpi 330 --perChr --vMax 4  

"""
