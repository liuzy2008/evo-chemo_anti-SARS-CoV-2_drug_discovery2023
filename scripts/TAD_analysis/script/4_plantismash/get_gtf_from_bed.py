# this file based on  plantismash.2.sh's bed
#    filecontent:
#       chr,start,end,gene_list
# produce file:
#    chr_start_end:
#       chr,"clustergene",type,start,end,XXXXXXXXXXX

from optparse import OptionParser

parser=OptionParser()
parser.add_option('--i', dest='input_bed_file')
parser.add_option('--gtf', dest='input_gtf_file')
parser.add_option('--o', dest='outputpath')


(options, args) = parser.parse_args()

fi = options.input_bed_file
gtf = options.input_gtf_file
outputpath = options.outputpath

record={}
gene_list=[]
output_dict={}
with open(fi,"r") as f:
    for line in f.readlines():
        if line.startswith("#"):
            continue
        chr,start,end,genes=line.split("\t")
        if chr not in record:
            record[chr]={}
        if start not in record[chr]:
            record[chr][start]={}
        genes=genes.split(";")
        record[chr][start][end]=genes
        if chr not in output_dict:
            output_dict[chr]={}
        if start not in output_dict[chr]:
            output_dict[chr][start]={}
        output_dict[chr][start][end]=[]
        gene_list.extend(genes)
        
gene_list=list(set(gene_list))

with open(gtf,"r") as f:
    for line in f.readlines():
        if line.startswith("#"):
            print(line)
            continue
        infos=line.strip().split("\t")
        chr=infos[0]
        pstart=infos[3]
        pend=infos[4]
        detail=infos[8].split(";")
        for i in detail:
            if i :
                key,val=i.split()
                if key=="gene_id":
                    val=val.replace("\"", "")
                    if val in gene_list:
                        #pass ,get in file 
                        for one_cluster_start in record[chr]:
                            for one_cluster_end in record[chr][one_cluster_start]:
                                if int(pstart) <= int(one_cluster_end) and int(pend) >= int(one_cluster_start):
                                    #pass
                                    output_dict[chr][one_cluster_start][one_cluster_end].append(line)
                                
for chr in output_dict:
    for start in output_dict[chr]:
        for end in output_dict[chr][start]:
            with open(outputpath+"/"+"_".join((chr,start,end))+".gtf",'w') as f:
                f.write("".join(output_dict[chr][start][end]))
        

