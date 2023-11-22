# corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}_corrected.h5",
# bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_corrected_boundaries.bed"
import os
h5_path_dir="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/"
h5_end="_corrected.h5"
tad_bed_path_dir="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/"
tad_end="_corrected_boundaries.bed"

template="""
[x-axis]
fontsize=10

[hic]
file = %s
title = %s
colormap = Spectral_r
depth = 400000
min_value = 1
max_value = 80
transform = log1p
file_type = hic_matrix
show_masked_bins = false

[tads]
file = %s
file_type = domains
border_color = black
color = none
overlay_previous = share-y

[genes]
file = %s
title = genes
color = black
height = 18
labels = true
file_type = gtf


[hic]
file = %s
title = %s
colormap = Spectral_r
depth = 400000
min_value = 1
max_value = 80
transform = log1p
file_type = hic_matrix
show_masked_bins = false

[tads]
file =%s
file_type = domains
border_color = black
color = none
overlay_previous = share-y

[genes]
file = %s
title = genes
color = black
height = 18
labels = true
file_type = gtf


[spacer]
height = 0.1

[hic]
file =%s
title = %s
colormap = Spectral_r
depth = 400000
min_value = 1
max_value = 80
transform = log1p
file_type = hic_matrix
show_masked_bins = false

[tads]
file = %s
file_type = domains
border_color = black
color = none
overlay_previous = share-y

[spacer]
height = 0.1
[spacer]
height = 0.1

[genes]
file = %s
title = genes
color = black
height = 18
labels = true
file_type = gtf
"""
for resolution in os.listdir(h5_path_dir):
    if resolution.startswith("Fail"):
        continue
    res_path=h5_path_dir+resolution+"/"
    sample=[]
    for one_file in os.listdir(res_path):
        if one_file.endswith(h5_end):
            #one file is  resolution's h5,get tad
            # tmp_list=os.listdir(tad_bed_path_dir+resolution+"/")
            sample.append(one_file.split("_")[0])
    track_info=[] 
    for one_sample in sample:
        h5_file=res_path+'_'.join((
            one_sample,
            resolution,
            h5_end
                                    ))
        tad_file=tad_bed_path_dir+resolution+"/"+'_'.join((
            one_sample,
            resolution,
            tad_end
                                    ))
        h5_title=one_sample
        gene_file="${work_dir}/sj_3d/genomes/%s/genome.gtf"%(one_sample,)
        track_info.extend((
            h5_file,
            h5_title,
            tad_file,
            gene_file,
            )
        )
    track_file="/".join((
        "${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs",
        resolution,
        'track.ini',
        
    ))
    with open(track_file,'w') as f:
        f.write(template%tuple(track_info))
    # print()

    
