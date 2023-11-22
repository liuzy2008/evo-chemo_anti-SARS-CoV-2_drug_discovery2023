# corrected_h5="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/{resolution}/{sample}_{resolution}corrected.h5",
# bed="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/{resolution}/{sample}_{resolution}_corrected_boundaries.bed"
import os
h5_path_dir="${work_dir}/sj_3d/results/4_hicexplorer/3_hicCorrectMatrix/"
h5_end="corrected.h5"
tad_bed_path_dir="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/"
tad_end="domains.bed"
ini_dir="${work_dir}/sj_3d/results/4_hicexplorer/6_hicPlotTADs/ini/"

one_tad_part="""
[hic]
file = %s
title = %s
colormap = Spectral_r
depth = %s
transform = log1p
file_type = hic_matrix
show_masked_bins = false
depth = 721385

[tads]
file = %s
file_type = domains
border_color = black
color = none
overlay_previous = share-y

"""
gene_part="""
[genes]
file = %s
title = genes
color = black
height = 3
labels = false
file_type = gtf
"""
template_head="""
[x-axis]
fontsize=10
where = top
"""
space_part="""
[spacer]
height = 0.2
"""

bed_part="""
[test bed4]
file = ${work_dir}/sj_3d/results/plantismash/bed/sjap/chr3_51642209_51945145.domains.bed
title = domains
file_type = bed
global_max_row = true
line_width = 1.5
height =0.75
"""

name_template=['P','MinD','MaxD','Delta','Step']
sample_list=['sjap','scep']
p_list=['P_0.1','P_0.01','P_0.05','P_0.005','P_0.001']
mind_list=['MinD_3','MinD_5']
maxd_list=['MaxD_6','MaxD_10']
delta_list=['Delta_0.1','Delta_0.01','Delta_0.001','Delta_0.05','Delta_0.005']
step_list=['','Step_1','Step_2']

#build ini
for resolution in os.listdir(h5_path_dir):
    if resolution.startswith("Fail"):
        continue
    res_path=h5_path_dir+resolution+"/"
    # sample=[]
    # for one_file in os.listdir(res_path):
    #     if one_file.endswith(h5_end):
    #         #one file is  resolution's h5,get tad
    #         # tmp_list=os.listdir(tad_bed_path_dir+resolution+"/")
    #         sample.append(one_file.split("_")[0])
    # track_info=[] 
    ############
    #sample
    for one_p in p_list:
        for one_mind in mind_list:
            for one_maxd in maxd_list:
                for one_delta in delta_list:
                    for one_step in step_list:
                        ini_result=''
                        for one_sample in sample_list:
                            tad_file=tad_bed_path_dir+resolution+"/"+'_'.join((
                                one_sample,
                                resolution,
                                one_p,
                                one_mind,
                                one_maxd,
                                one_delta,
                                one_step,
                                tad_end,
                            ))
                            h5_file=res_path+'_'.join((
                                        one_sample,
                                        resolution,
                                        'corrected.h5'
                                    ))
                            # print(h5_file)
                            if not ( os.path.exists(h5_file) and os.path.exists(tad_file) ):
                                continue

                            title=one_sample
                            ini_result=ini_result+one_tad_part%(
                                    h5_file,
                                    title,
                                    tad_file
                                )+gene_part%(
                                    "${work_dir}/sj_3d/genomes/%s/genome.gtf"%one_sample,
                                )
                        if not ini_result:
                            continue
                        # print(ini_result)
                        track_file=ini_dir+'_'.join((
                                resolution,
                                one_p,
                                one_mind,
                                one_maxd,
                                one_delta,
                                one_step,
                                'sample_compared.ini',
                            ))
                        with open(track_file,'w') as f:
                            f.write(ini_result)
                            
    ############
    #step
    for one_p in p_list:
        for one_mind in mind_list:
            for one_maxd in maxd_list:
                for one_delta in delta_list:
                    ini_result=''
                    for one_sample in sample_list:
                        for one_step in step_list:
                            tad_file=tad_bed_path_dir+resolution+"/"+'_'.join((
                                one_sample,
                                resolution,
                                one_p,
                                one_mind,
                                one_maxd,
                                one_delta,
                                one_step,
                                tad_end,
                            ))
                            h5_file=res_path+'_'.join((
                                        one_sample,
                                        resolution,
                                        'corrected.h5'
                                    ))
                            if not ( os.path.exists(h5_file) and os.path.exists(tad_file) ):
                                continue
                            title=one_sample
                            ini_result=ini_result+one_tad_part%(
                                    h5_file,
                                    title,
                                    tad_file
                                )
                        if not ini_result:
                            continue
                        ini_result=ini_result+gene_part%(
                                    "${work_dir}/sj_3d/genomes/%s/genome.gtf"%one_sample,
                                )
                            
                    if not ini_result:
                        continue
                    # print(ini_result)
                    track_file=ini_dir+'_'.join((
                            one_sample,
                            resolution,
                            one_p,
                            one_mind,
                            one_maxd,
                            one_delta,
                            'step_compared.ini',
                        ))
                    with open(track_file,'w') as f:
                        f.write(ini_result)
                            
    ############
    #maxd
    for one_p in p_list:
        for one_mind in mind_list:
            for one_step in step_list:
                for one_delta in delta_list:
                    ini_result=''
                    for one_sample in sample_list:
                        for one_maxd in maxd_list:
                            tad_file=tad_bed_path_dir+resolution+"/"+'_'.join((
                                one_sample,
                                resolution,
                                one_p,
                                one_mind,
                                one_maxd,
                                one_delta,
                                one_step,
                                tad_end,
                            ))
                            h5_file=res_path+'_'.join((
                                        one_sample,
                                        resolution,
                                        'corrected.h5'
                                    ))
                            if not ( os.path.exists(h5_file) and os.path.exists(tad_file) ):
                                continue
                            title=one_sample
                            ini_result=ini_result+one_tad_part%(
                                    h5_file,
                                    title,
                                    tad_file
                                )
                        if not ini_result:
                            continue
                        ini_result=ini_result+gene_part%(
                                    "${work_dir}/sj_3d/genomes/%s/genome.gtf"%one_sample,
                                )
                            
                    if not ini_result:
                        continue
                    # print(ini_result)
                    track_file=ini_dir+'_'.join((
                            one_sample,
                            resolution,
                            one_p,
                            one_mind,
                            one_delta,
                            one_step,
                            'maxd_compared.ini',
                        ))
                    with open(track_file,'w') as f:
                        f.write(ini_result)  
                            
    ############
    #mind
    for one_p in p_list:
        for one_maxd in maxd_list:
            for one_delta in delta_list:
                for one_step in step_list:
                    ini_result=''
                    for one_sample in sample_list:
                        for one_mind in mind_list:
                            tad_file=tad_bed_path_dir+resolution+"/"+'_'.join((
                                one_sample,
                                resolution,
                                one_p,
                                one_mind,
                                one_maxd,
                                one_delta,
                                one_step,
                                tad_end,
                            ))
                            h5_file=res_path+'_'.join((
                                        one_sample,
                                        resolution,
                                        'corrected.h5'
                                    ))
                            if not ( os.path.exists(h5_file) and os.path.exists(tad_file) ):
                                continue
                            title=one_sample
                            ini_result=ini_result+one_tad_part%(
                                    h5_file,
                                    title,
                                    tad_file
                                )
                        if not ini_result:
                            continue
                        ini_result=ini_result+gene_part%(
                                    "${work_dir}/sj_3d/genomes/%s/genome.gtf"%one_sample,
                                )
                            
                    if not ini_result:
                        continue
                    # print(ini_result)
                    track_file=ini_dir+'_'.join((
                            one_sample,
                            resolution,
                            one_p,
                            one_maxd,
                            one_delta,
                            one_step,
                            'mind_compared.ini',
                        ))
                    with open(track_file,'w') as f:
                        f.write(ini_result)
                            
                
    ############
    #delta
    for one_p in p_list:
        for one_maxd in maxd_list:
            for one_mind in mind_list:
                for one_step in step_list:
                    ini_result=''
                    for one_sample in sample_list:
                        for one_delta in delta_list:
                            tad_file=tad_bed_path_dir+resolution+"/"+'_'.join((
                                one_sample,
                                resolution,
                                one_p,
                                one_mind,
                                one_maxd,
                                one_delta,
                                one_step,
                                tad_end,
                            ))
                            h5_file=res_path+'_'.join((
                                        one_sample,
                                        resolution,
                                        'corrected.h5'
                                    ))
                            if not ( os.path.exists(h5_file) and os.path.exists(tad_file) ):
                                continue
                            title=one_sample
                            ini_result=ini_result+one_tad_part%(
                                    h5_file,
                                    title,
                                    tad_file
                                )
                        if not ini_result:
                            continue
                        ini_result=ini_result+gene_part%(
                                    "${work_dir}/sj_3d/genomes/%s/genome.gtf"%one_sample,
                                )
                            
                    if not ini_result:
                        continue
                    # print(ini_result)
                    track_file=ini_dir+'_'.join((
                            one_sample,
                            resolution,
                            one_p,
                            one_mind,
                            one_maxd,
                            one_step,
                            'delta_compared.ini',
                        ))
                    with open(track_file,'w') as f:
                        f.write(ini_result)
                            
                            
                            
#plot
for one_ini in os.listdir(ini_dir):
    flag=False
    todo_file_name='*'
    ini_flag_list=one_ini.split('_')
    for one_flag in name_template:
        if one_flag not in one_ini:
            flag=one_flag
            # print(one_ini,flag)
            todo_file_name+='*'
        else:
            
            todo_file_name+='_'.join(('',one_flag,ini_flag_list[ini_flag_list.index(one_flag)+1]))
    todo_file_name+='*_domains.bed'
    print(todo_file_name) # bed file
     
#         if one_flag==False:
#             #sample_compared
#             pass
#         elif one_flag=="P":
#             pass
#         elif one_flag=="MinD":
#             pass
#         elif one_flag=="MaxD":
#             pass
#         elif one_flag=="Delta":
#             pass
#         elif one_flag=="Step":
#             pass
#     sample_and_res,other_conf=one_ini.split('_P_')
#     if "_" in sample_and_res:
#         # sample compared
#         pass
#     else:
#         one_sample,one_resolution=sample_and_res.split('_')
#     pval,other_conf=other_conf.split('_MinD_')
#     mind,other_conf=other_conf.split('_Max_D_')
#     maxd,other_conf=other_conf.split('_Delta_')
#     other_configs=other_conf.split("_")
#     delta=
    
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
