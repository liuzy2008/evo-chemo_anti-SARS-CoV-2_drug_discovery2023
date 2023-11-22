#!/bin/sh
# properties = {"type": "single", "rule": "hicCorrectMatrix", "local": false, "input": ["/home/lengliang/lzy/sj_3d/results/4_hicexplorer/2_hicNormmalize/300000/scep_300000_matrix.h5"], "output": ["/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/300000/scep_300000.pdf", "/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/300000/scep_300000_corrected.h5"], "wildcards": {"resolution": "300000", "sample": "scep"}, "params": {}, "log": [], "threads": 24, "resources": {"mem_mb": 1000, "disk_mb": 4191800, "tmpdir": "/home/lengliang/lzy/tmp/3d/"}, "jobid": 42, "cluster": {}}
cd '/home/lengliang/lzy/sj_3d/script/4_hicexplorer' && /home/lengliang/lzy/mambaforge/bin/python3.9 -m snakemake --snakefile '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/4_correct.smk' '/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/300000/scep_300000_corrected.h5' --allowed-rules 'hicCorrectMatrix' --cores 'all' --attempt 1 --force-use-threads  --resources 'mem_mb=1000' 'disk_mb=4191800' --wait-for-files '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.vlbllh4m' '/home/lengliang/lzy/sj_3d/results/4_hicexplorer/2_hicNormmalize/300000/scep_300000_matrix.h5' --force --keep-target-files --keep-remote --max-inventory-time 0 --nocolor --notemp --no-hooks --nolock --ignore-incomplete --rerun-triggers 'mtime' --skip-script-cleanup  --use-conda  --conda-frontend 'mamba' --conda-base-path '/home/lengliang/lzy/mambaforge' --wrapper-prefix 'https://github.com/snakemake/snakemake-wrappers/raw/' --printshellcmds  --latency-wait 5 --scheduler 'ilp' --scheduler-solver-path '/home/lengliang/lzy/mambaforge/bin' --default-resources 'mem_mb=max(2*input.size_mb, 1000)' 'disk_mb=max(2*input.size_mb, 1000)' 'tmpdir=system_tmpdir' --mode 2 && touch '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.vlbllh4m/42.jobfinished' || (touch '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.vlbllh4m/42.jobfailed'; exit 1)

