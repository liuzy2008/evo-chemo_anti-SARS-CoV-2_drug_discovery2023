#!/bin/sh
# properties = {"type": "single", "rule": "hicFindTADs_try_with_step", "local": false, "input": ["/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/40000/scep_40000_corrected.h5"], "output": ["/home/lengliang/lzy/sj_3d/results/4_hicexplorer/5_hicFindTADs/40000/scep_40000_P_0.05_MinD_3_MaxD_10_Delta_0.01_Step_1_boundaries.bed"], "wildcards": {"resolution": "40000", "sample": "scep", "pval": "0.05", "mindepth": "3", "maxdepth": "10", "delta": "0.01", "step": "1"}, "params": {"hic_corrected": "/home/lengliang/lzy/sj_3d/results/4_hicexplorer/5_hicFindTADs/40000/scep_40000_P_0.05_MinD_3_MaxD_10_Delta_0.01_Step_1", "resolution": "40000", "pval": "0.05", "mindepth": "3", "maxdepth": "10", "delta": "0.01", "step": "1"}, "log": [], "threads": 24, "resources": {"mem_mb": 1000, "disk_mb": 4191800, "tmpdir": "/home/lengliang/lzy/tmp/3d/"}, "jobid": 386, "cluster": {}}
cd '/home/lengliang/lzy/sj_3d/script/4_hicexplorer' && /home/lengliang/lzy/mambaforge/bin/python3.9 -m snakemake --snakefile '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/5_TAD.smk' '/home/lengliang/lzy/sj_3d/results/4_hicexplorer/5_hicFindTADs/40000/scep_40000_P_0.05_MinD_3_MaxD_10_Delta_0.01_Step_1_boundaries.bed' --allowed-rules 'hicFindTADs_try_with_step' --cores 'all' --attempt 1 --force-use-threads  --resources 'mem_mb=1000' 'disk_mb=4191800' --wait-for-files '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.p5p0g9ov' '/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/40000/scep_40000_corrected.h5' --force --keep-target-files --keep-remote --max-inventory-time 0 --nocolor --notemp --no-hooks --nolock --ignore-incomplete --rerun-triggers 'mtime' --skip-script-cleanup  --use-conda  --conda-frontend 'mamba' --conda-base-path '/home/lengliang/lzy/mambaforge' --wrapper-prefix 'https://github.com/snakemake/snakemake-wrappers/raw/' --printshellcmds  --latency-wait 5 --scheduler 'ilp' --scheduler-solver-path '/home/lengliang/lzy/mambaforge/bin' --default-resources 'mem_mb=max(2*input.size_mb, 1000)' 'disk_mb=max(2*input.size_mb, 1000)' 'tmpdir=system_tmpdir' --mode 2 && touch '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.p5p0g9ov/386.jobfinished' || (touch '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.p5p0g9ov/386.jobfailed'; exit 1)

