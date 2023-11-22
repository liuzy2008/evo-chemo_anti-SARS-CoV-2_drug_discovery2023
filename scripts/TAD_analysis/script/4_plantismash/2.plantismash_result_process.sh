
mkdir -p ${work_dir}/sj_3d/results/plantismash/bed/
#mamnully create ${work_dir}/sj_3d/results/plantismash/bed/sjap.txt with table in index.html
# and ${work_dir}/sj_3d/results/plantismash/*/geneclusters.txt
cat ${work_dir}/sj_3d/results/plantismash/bed/sjap.txt |cut -f 2,4,5,14|sort -V -k1 -k2n|grep -v "From" >${work_dir}/sj_3d/results/plantismash/bed/sjap.bed 
cat ${work_dir}/sj_3d/results/plantismash/bed/scep.txt |cut -f 2,4,5,14|sort -V -k1 -k2n|grep -v "From" >${work_dir}/sj_3d/results/plantismash/bed/scep.bed 

# produce cluster gene gtf
rm -rf ${work_dir}/sj_3d/results/plantismash/bed/scep/*
rm -rf ${work_dir}/sj_3d/results/plantismash/bed/sjap/*
python ${work_dir}/sj_3d/script/plantismash/get_gtf_from_bed.py --i ${work_dir}/sj_3d/results/plantismash/bed/scep.bed --gtf ${work_dir}/sj_3d/genomes/scep/genome.gtf --o ${work_dir}/sj_3d/results/plantismash/bed/scep
python ${work_dir}/sj_3d/script/plantismash/get_gtf_from_bed.py --i ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed --gtf ${work_dir}/sj_3d/genomes/sjap/genome.gtf --o ${work_dir}/sj_3d/results/plantismash/bed/sjap


bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/scep.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/scep.bed -wa -c |cut -f 1,2,3,5
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap.bed -wa -c |cut -f 1,2,3,5


cat ${work_dir}/sj_3d/genomes/sjap/genome.gff|grep "gene"|awk 'BEGIN{OFS="\t"}NR==FNR{id[$1]="";}NR>FNR{split($9,tmp,"=");if(tmp[2]".1" in id){print($1,$4,$5,tmp[2])}}' ${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene.list - > ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap_all_gene.bed
cat ${work_dir}/sj_3d/genomes/scep/genome.gff|grep "gene"|awk 'BEGIN{OFS="\t"}NR==FNR{id[$1]="";}NR>FNR{split($9,tmp,"=");if(tmp[2]".1" in id){print($1,$4,$5,tmp[2])}}' ${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene.list - > ${work_dir}/sj_3d/results/plantismash/bia_gene/scep_all_gene.bed

# check num of intersect of TAD and cluster
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/scep.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/scep_all_gene.bed -wa -c |cut -f 1,2,3,5
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap_all_gene.bed -wa -c |cut -f 1,2,3,5

# get intersect region
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap_all_gene.bed -wa -c |cut -f 1,2,3,5|awk '$4>0'|sort -k4nr >  ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap_key_region.bed 

bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/scep.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/scep_all_gene.bed -wa -c |cut -f 1,2,3,5|awk '$4>0'|sort -k4nr >  ${work_dir}/sj_3d/results/plantismash/bia_gene/scep_key_region.bed 


# get key gene gtf
cat ${work_dir}/sj_3d/genomes/sjap/genome.gtf |awk 'BEGIN{OFS="\t"}NR==FNR{id["\""$1"\";"]=""}NR>FNR{if($10 in id){print($0)}}' ${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene.list -  > ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap_all_gene.gtf
cat ${work_dir}/sj_3d/genomes/scep/genome.gtf |awk 'BEGIN{OFS="\t"}NR==FNR{id["\""$1"\";"]=""}NR>FNR{if($10 in id){print($0)}}' ${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene.list -  > ${work_dir}/sj_3d/results/plantismash/bia_gene/scep_all_gene.gtf
cat ${work_dir}/sj_3d/genomes/syun/genome.gtf |awk 'BEGIN{OFS="\t"}NR==FNR{id["\""$1"\";"]=""}NR>FNR{if($10 in id){print($0)}}' ${work_dir}/sj_3d/results/plantismash/bia_gene/key_gene.list -  > ${work_dir}/sj_3d/results/plantismash/bia_gene/syun_all_gene.gtf
#########juicer
# check cluster and TAD intersect 
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/scep.bed -b ${work_dir}/sj_3d/results/5_juicer/scep/scep.allValidPairs_contact_domains/40000_blocks.bedpe -wa -c |cut -f 1,2,3,5
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed -b ${work_dir}/sj_3d/results/5_juicer/sjap/sjap.allValidPairs_contact_domains/40000_blocks.bedpe -wa -c |cut -f 1,2,3,5



# check keygene and TAD intersect 
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/scep.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/scep.bed -wa -c |cut -f 1,2,3,5  #only 1
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap.bed -wa -c |cut -f 1,2,3,5  #has many . esp chr3    51642209        51945145        4

#check key gene and TAD intersect and cluster
bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/scep.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/scep.bed -wa -c |cut -f 1,2,3,5|awk '$4!=0'|bedtools intersect -a - -b ${work_dir}/sj_3d/results/5_juicer/scep/scep.allValidPairs_contact_domains/40000_blocks.bedpe -wa -c |cut -f 1,2,3,5  #no

bedtools intersect -a ${work_dir}/sj_3d/results/plantismash/bed/sjap.bed -b ${work_dir}/sj_3d/results/plantismash/bia_gene/sjap.bed -wa -c |cut -f 1,2,3,5|awk '$4!=0'|bedtools intersect -a - -b ${work_dir}/sj_3d/results/5_juicer/sjap/sjap.allValidPairs_contact_domains/40000_blocks.bedpe -wa -c |cut -f 1,2,3,5  #only 1 chr4    16755633        17147981 #only one gene, abondon
