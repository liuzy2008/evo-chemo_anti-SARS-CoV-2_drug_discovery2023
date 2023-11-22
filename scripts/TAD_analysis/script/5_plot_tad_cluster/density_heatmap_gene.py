#!/bin/python
from pybedtools import BedTool
import multiprocessing
import statistics
from functools import partial
# from functools import partial
def get_random(id_num,beds,tads,all_gene_num,get_gene_num):
    #################################################
    # function used for get random gene by pybedtools.BedTool.random_subset
    # params
    #     @ id_num :   used for map range, not used for calculate
    #     @ beds   :   the genes beds from pybedtools.BedTool
    #     @ tads   :   the TAD beds from pybedtools.BedTool
    #     @ all_gene_num: used as calculate the percent of TAD numbers /gene numbers, wong and not finished 
    #     @ get_gene_num: how many random gene get from @beds
    # return:
    #     a python tuple as 
    #     (tad num, number of  tad with selected gene , the percent of TAD numbers /gene numbers)
    #################################################
    
    
    
    random = beds.random_subset(get_gene_num)
    # with open("${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene_heatmap/20230217/tmp/%i.%i.tmp。randomgene"%(id_num,all_gene_num),"w") as f:
    #     f.write(str(random))

    tads_intersect_genes=tads.intersect(random,wa=True,c=True)
    # with open("${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene_heatmap/20230217/tmp/%i.%i.tmp"%(id_num,all_gene_num),"w") as f:
    #     f.write(str(tads_intersect_genes))
    # print(tads_intersect_genes.head())
    tad_count_random_sub= 0
    tad_gene_count_random_sub={}
    for one_tad_gene in tads_intersect_genes:
        one_tad_gene_count=one_tad_gene[9]
        # print(one_tad_gene_count)
        if int(one_tad_gene_count)>0:
            if one_tad_gene_count not  in tad_gene_count_random_sub:
                tad_gene_count_random_sub[one_tad_gene_count]=0
            tad_count_random_sub+=1
            tad_gene_count_random_sub[one_tad_gene_count]+=1
    ratio_ramdom_count=tad_count_random_sub/all_gene_num
    # print(tad_count_random_sub,tad_gene_count_random_sub,ratio_ramdom_count)
    # print(tad_gene_count_random_sub)
    #       (tad num,             tad has gene number           ,ratio)
    return  (tad_count_random_sub,tad_gene_count_random_sub,ratio_ramdom_count)


if __name__ =='__main__':
    #samples=['scep','sjap']
    samples=['scep','sjap','syun']

    gene_num={}
    ### key genes
    tad_gene_count={}
    ratio={}
    tad_count={}

    ##############################
    ##  calculate the TADs number of genes in raw list 
    ##  the number printed and not wirte in file !!
    for sample in samples:
        tad_file="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/40000/%s_40000_P_0.01_MinD_5_MaxD_10_Delta_0.01_Step_2_domains.bed"%(sample,)
        gene_bed="${work_dir}/sj_3d_20220322/%s.bed"%(sample,)


        tads = BedTool(tad_file)  # [1]
        genes = BedTool(gene_bed)    # [1]
        gene_num[sample]=genes.count()
        tads_intersect_genes=tads.intersect(genes,wa=True,c=True)

        # In [12]: tads_intersect_genes.head()
        # chr1    1880000 2240000 ID_0.01_1       -0.624454500000 .       1880000 2240000 31,120,180      0
        if sample not in tad_count:
            tad_count[sample]=0
        if sample not in tad_gene_count:
            tad_gene_count[sample]={}
        for one_tad_gene in tads_intersect_genes:
            one_tad_gene_count=one_tad_gene[9]
            if int(one_tad_gene_count)>0:
                if one_tad_gene_count not  in tad_gene_count[sample]:
                    tad_gene_count[sample][one_tad_gene_count]=0
                tad_count[sample]+=1
                tad_gene_count[sample][one_tad_gene_count]+=1
        for one_sample in tad_count:
            ratio[one_sample]=tad_count[sample]/gene_num[sample]
    print(tad_count)  # the number printed and not wirte in file !!
    out_put_text=[]
    for sample in ratio:
        out_put_text.append("\t".join((sample,str(ratio[sample]))))
    with open('${work_dir}/sj_3d_20220322/density_line_heatmap_vs_all.csv','w') as f:
        f.write("\n".join(out_put_text))
                
    # #In [22]: tad_count
    # Out[22]: 191

    # In [23]: tad_gene_count
    # Out[23]: 
    # {'1': 95,
    #  '8': 1}

###########################
###########################
#   heatmap genes vs all genes 
###########################
###########################
    #random genes
    # num_processes = multiprocessing.cpu_count()-2 
    num_processes = 40 
    pool = multiprocessing.Pool(processes=num_processes) 
    tad_gene_count_random={}
    tad_count_random={}
    ratio_ramdom_count={}
    # for sample in samples:
    #     ratio_ramdom_count[sample]={}
    #     for i in range(1,1000+1):      
    #         ratio_ramdom_count[sample][i/1000]=0
    test_number=1000   #get 1000 time random test
    for sample in samples:
        # for get_gene_num in [gene_num[sample],50,60,70,80,90,100,120,150,180]:   ##test more gene number
        tad_file="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/40000/%s_40000_P_0.01_MinD_5_MaxD_10_Delta_0.01_Step_2_domains.bed"%(sample,)
        gene_gff="${work_dir}/sj_3d/genomes/%s/genome_main.gff"%(sample,)
        tads = BedTool(tad_file)  # [1]
        genes = BedTool(gene_gff)    # [1]
        for get_gene_num in [gene_num[sample],]:
            if get_gene_num not in tad_count_random:
                tad_count_random[get_gene_num]={}
            # use multiprocessing to accerlarate , use partial to set known params
            func = partial(get_random,beds=genes,tads=tads,all_gene_num=gene_num[sample],get_gene_num=get_gene_num)
            # get the result 
            ret=list(pool.map(func,range(0,test_number)))
            # print(list(ret))
            # return  (tad_count_random_sub,tad_gene_count_random_sub,ratio_ramdom_count)
            # [(2, {'1': 2}, 0.008547008547008548), (2, {'1': 2}, 0.008547008547008548)]
            # print(ret)
            for i in range(0,len(ret)):
                if i not in tad_count_random[get_gene_num]:
                    tad_count_random[get_gene_num][i]={}        
                if i not in ratio_ramdom_count:
                    ratio_ramdom_count[i]={}        
                if sample not in ratio_ramdom_count[i]:
                    ratio_ramdom_count[i][sample]={}
                tad_count_random[get_gene_num][i][sample],tad_gene_count_random[i],ratio_ramdom_count[i][sample]=list(ret[i])

        
    #close pool
    pool.close()
    pool.join()
        
    tmp={}
    out_put_text=[]
    average_tad_count={}
    for get_gene_num in tad_count_random:
        for i in tad_count_random[get_gene_num]:
            for sample in tad_count_random[get_gene_num][i]:
                if sample not in tmp:
                    tmp[sample]={}
                out_put_text.append("\t".join((
                    sample,
                    str(tad_count_random[get_gene_num][i][sample]),
                    str(gene_num[sample]),
                    str(get_gene_num),
                    
                    )))
                if sample not in  average_tad_count:
                    average_tad_count[sample]=[]    
                average_tad_count[sample].append(int(tad_count_random[get_gene_num][i][sample]))  
    #########
    #  print the average and median
    print("all gene:")
    for  sample in average_tad_count:
        print(sample,sum(average_tad_count[sample])/len(average_tad_count[sample]),"median:",statistics.median(average_tad_count[sample]))
    out_put_text.append("")# to add empty line at end
    with open('${work_dir}/sj_3d_20220322/density_table_vs_all.csv','w') as f:
        f.write("\n".join(out_put_text))



###################################
###################################
## vs key gene , change "all gene gff" to " key gene bed " and the output name 
###################################
###################################
    pool = multiprocessing.Pool(processes=num_processes) 
        
    tad_gene_count_random={}
    tad_count_random={}
    ratio_ramdom_count={}    
    for sample in samples:
        for get_gene_num in [gene_num[sample]]:
        # for get_gene_num in [gene_num[sample],50,60,70,80,90,100,120,150,180]:
            if get_gene_num not in tad_count_random:
                tad_count_random[get_gene_num]={}
            tad_file="${work_dir}/sj_3d/results/4_hicexplorer/5_hicFindTADs/40000/%s_40000_P_0.01_MinD_5_MaxD_10_Delta_0.01_Step_2_domains.bed"%(sample,)
            gene_gff="${work_dir}/sj_3d/results/plantismash/bia_gene/%s_all_gene.bed"%(sample,)
            tads = BedTool(tad_file)  # [1]
            genes = BedTool(gene_gff)    # [1]
            func = partial(get_random,beds=genes,tads=tads,all_gene_num=gene_num[sample],get_gene_num=get_gene_num)
            # def get_random(id_num,beds,tads,all_gene_num,get_gene_num):
            # get 

            ret=list(pool.map(func,range(0,test_number)))
            # print(list(ret))
            # return  (tad_count_random_sub,tad_gene_count_random_sub,ratio_ramdom_count)
            # [(2, {'1': 2}, 0.008547008547008548), (2, {'1': 2}, 0.008547008547008548)]
            # print(ret)
            for i in range(0,len(ret)):
                if i not in tad_count_random[get_gene_num]:
                    tad_count_random[get_gene_num][i]={}        
                if i not in ratio_ramdom_count:
                    ratio_ramdom_count[i]={}        
                if sample not in ratio_ramdom_count[i]:
                    ratio_ramdom_count[i][sample]={}
                tad_count_random[get_gene_num][i][sample],tad_gene_count_random[i],ratio_ramdom_count[i][sample]=list(ret[i])

        
        
    pool.close()
    pool.join()
        

# tad_count_random[get_gene_num][i][sample],
    tmp={}
    out_put_text=[]
    average_tad_count={}
    for get_gene_num in tad_count_random:
        for i in tad_count_random[get_gene_num]:
            for sample in tad_count_random[get_gene_num][i]:
                if sample not in tmp:
                    tmp[sample]={}
                out_put_text.append("\t".join((
                    sample,
                    str(tad_count_random[get_gene_num][i][sample]),
                    str(gene_num[sample]),
                    str(get_gene_num),
                    
                    )))       
                if sample not in  average_tad_count:
                    average_tad_count[sample]=[]    
                average_tad_count[sample].append(int(tad_count_random[get_gene_num][i][sample]))  
    print("key gene:")
    for  sample in average_tad_count:
        print(sample,sum(average_tad_count[sample])/len(average_tad_count[sample]),"median:",statistics.median(average_tad_count[sample]))

    out_put_text.append("")# to add empty line at end
    with open('${work_dir}/sj_3d_20220322/density_table_vs_key.csv','w') as f:
        f.write("\n".join(out_put_text))

    
    
    
    
