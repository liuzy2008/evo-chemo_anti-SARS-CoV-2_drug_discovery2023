#!/bin/sh
# properties = {"type": "single", "rule": "hicPlotMatrix", "local": false, "input": ["/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/40000/scep_40000_corrected.h5"], "output": ["/home/lengliang/lzy/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/40000/scep_40000_perchr.pdf", "/home/lengliang/lzy/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/40000/scep_40000_conbine.pdf", "/home/lengliang/lzy/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/40000/scep_40000_perchr_log.pdf", "/home/lengliang/lzy/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/40000/scep_40000_conbine_log.pdf"], "wildcards": {"resolution": "40000", "sample": "scep"}, "params": {}, "log": [], "threads": 24, "resources": {"mem_mb": 1000, "disk_mb": 4191800, "tmpdir": "/home/lengliang/lzy/tmp/3d/"}, "jobid": 65, "cluster": {}}
cd '/home/lengliang/lzy/sj_3d/script/4_hicexplorer' && /home/lengliang/lzy/mambaforge/bin/python3.9 -m snakemake --snakefile '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/4_correct.smk' '/home/lengliang/lzy/sj_3d/results/4_hicexplorer/4_hicPlotMatrix/40000/scep_40000_perchr.pdf' --allowed-rules 'hicPlotMatrix' --cores 'all' --attempt 1 --force-use-threads  --resources 'mem_mb=1000' 'disk_mb=4191800' --wait-for-files '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.q3tynhpe' '/home/lengliang/lzy/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/40000/scep_40000_corrected.h5' --force --keep-target-files --keep-remote --max-inventory-time 0 --nocolor --notemp --no-hooks --nolock --ignore-incomplete --rerun-triggers 'mtime' --skip-script-cleanup  --use-conda  --conda-frontend 'mamba' --conda-base-path '/home/lengliang/lzy/mambaforge' --wrapper-prefix 'https://github.com/snakemake/snakemake-wrappers/raw/' --printshellcmds  --latency-wait 5 --scheduler 'ilp' --scheduler-solver-path '/home/lengliang/lzy/mambaforge/bin' --default-resources 'mem_mb=max(2*input.size_mb, 1000)' 'disk_mb=max(2*input.size_mb, 1000)' 'tmpdir=system_tmpdir' --mode 2 && touch '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.q3tynhpe/65.jobfinished' || (touch '/home/lengliang/lzy/sj_3d/script/4_hicexplorer/.snakemake/tmp.q3tynhpe/65.jobfailed'; exit 1)

