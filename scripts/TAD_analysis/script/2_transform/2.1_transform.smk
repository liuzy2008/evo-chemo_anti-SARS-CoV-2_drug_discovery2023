# snakemake --use-conda  --cores 48 --cluster "qsub -V -q batch -l nodes=1:ppn=24 -M liuxiawei6@qq.com -N 3d_transform -o ${work_dir}/sj_3d/logs/1_transform/log/{rule}_{jobid}.log -j oe" --rerun-triggers mtime  --rerun-incomplete  --cluster-cancel "qdel" -j 20 --printshellcmds  --snakefile 2.1_transform.smk -n  
samples,tmp3,resolutions,tmp,tmp2, = glob_wildcards("${work_dir}/sj_3d/results/1_hicpro/{sample}/hic_results/matrix/{sample2}/iced/{resolution}/{sample3}_{resolution2}_iced.matrix")

rule all:
    input:
        expand("${work_dir}/sj_3d/results/2_transform/h5/{resolution}/{sample}_{resolution}_matrix.h5",  sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/2_transform/cool/{resolution}/{sample}_{resolution}_matrix.cool", sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/{sample}_{resolution}_matrix.bed", sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/{sample}_{resolution}.txt.gz", sample=samples,resolution=resolutions),
        expand("${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/Bins.{sample}_{resolution}.txt.gz", sample=samples,resolution=resolutions),
        # expand("${work_dir}/3d/hic-pro/3_3DChromatin_ReplicateQC/predata/{resolution}/{sample}_{resolution}_clean.txt.gz", sample=samples,resolution=resolutions),

rule hicpro2h5 :
    input:
        matrix="${work_dir}/sj_3d/results/1_hicpro/{sample}/hic_results/matrix/{sample}/iced/{resolution}/{sample}_{resolution}_iced.matrix",
        bed="${work_dir}/sj_3d/results/1_hicpro/{sample}/hic_results/matrix/{sample}/raw/{resolution}/{sample}_{resolution}_abs.bed",
    output:
        h5="${work_dir}/sj_3d/results/2_transform/h5/{resolution}/{sample}_{resolution}_matrix.h5",
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        resolution="{resolution}"
    shell:"""
~/lzy/mambaforge/bin/hicConvertFormat -m {input.matrix} --bedFileHicpro {input.bed} --inputFormat hicpro --outputFormat h5 -o {output.h5} 
"""

rule  hicpro2cool   :
    input:
        matrix="${work_dir}/sj_3d/results/1_hicpro/{sample}/hic_results/matrix/{sample}/iced/{resolution}/{sample}_{resolution}_iced.matrix",
        bed="${work_dir}/sj_3d/results/1_hicpro/{sample}/hic_results/matrix/{sample}/raw/{resolution}/{sample}_{resolution}_abs.bed",
    output:
        cool="${work_dir}/sj_3d/results/2_transform/cool/{resolution}/{sample}_{resolution}_matrix.cool",
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        resolution="{resolution}"
    shell:"""
~/lzy/mambaforge/bin/hicConvertFormat -m {input.matrix} --bedFileHicpro {input.bed} --inputFormat hicpro --outputFormat cool -o {output.cool} --resolutions {params.resolution} 
"""

rule  cool2bed:
    input:
        cool="${work_dir}/sj_3d/results/2_transform/cool/{resolution}/{sample}_{resolution}_matrix.cool",
    output:
        bed="${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/{sample}_{resolution}_matrix.bed",
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        resolution="{resolution}"
    shell:"""
~/lzy/mambaforge/bin/cooler dump  -t pixels --no-balance --join {input.cool} -o {output.bed} 
"""

rule  bed2data:
    input:
        bed="${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/{sample}_{resolution}_matrix.bed",
    output:
        contact_map="${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/{sample}_{resolution}.txt.gz",
        bins="${work_dir}/sj_3d/results/3_3DChromatin_ReplicateQC/predata/{resolution}/Bins.{sample}_{resolution}.txt.gz",
    threads: 24,
    resources: 
        tmpdir="${work_dir}/tmp/3d/",
        disk_mb=4191800
    params:
        resolution="{resolution}"
    shell:"""
cut -f 1,2,4,5,7 {input.bed} |awk 'BEGIN{{OFS="\t"}}{{$1="chr"substr($1,8,2);$3="chr"substr($3,8,2);print($0)}}'|gzip> {output.contact_map}
cut -f 1,2,3 {input.bed}  |sort|uniq|awk 'BEGIN{{OFS="\t"}}{{print $0"\t"$2}}' |awk 'BEGIN{{OFS="\t"}}{{$1="chr"substr($1,8,2);print($0)}}'|gzip>{output.bins} 
"""
