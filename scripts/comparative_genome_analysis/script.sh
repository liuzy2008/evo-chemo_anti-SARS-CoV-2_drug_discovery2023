 
# used https://github.com/schneebergerlab/syri


# 1. keep only main chromosome
nucmer  ../S_japonica/S_japonica_short.fa ../S_cepharantha/S_cepharantha_short.fa -p S_jap_S_cep
delta-filter -1 -q -r S_jap_S_cep.delta > S_jap_S_cep_delta.filter
show-coords -THrd S_jap_S_cep_delta.filter > S_jap_S_cep.delta_filter.coords
chroder S_jap_S_cep_out.filtered.coords ../S_japonica/S_japonica_short.fa  ../S_cepharantha/S_cepharantha_short.fa -o S_jap-S_cep-out.filter.chroder

# 2.<50bp SNP and indel
nucmer --mum -c 100 -l 50 -g 1000 ../S_japonica/S_japonica_short.fa S_cep.chroder.qry.fasta -p S_jap_S_cep
delta-filter -1 -q -r S_jap_S_cep.delta > S_jap_S_cep_out.delta.filter2
show-snps S_jap_S_cep.delta_filter -Clr -T >S_jap_S_cep.delta_filter_SNP.txt #show-snps call snp
perl ../pan-genome-class-default/snptovcf.pl -i S_jap_S_cep.delta_filter_SNP.txt -s S_cep -r S_japonica_short.fa -o S_jap_vs_S_cep_snp_filter.vcf 

# 3.>50bp SV

minimap2 -ax asm5 --eqx ../S_japonica/S_japonica_short.fa S_cep.chroder.qry.fasta > S_jap_S_cep_order.sam
syri -c S_jap_S_cep_order.sam -r ../S_japonica/S_japonica_short.fa -q S_cep.chroder.qry.fasta -k -F S --prefix S_jap_S_cep_sam
Merge vcf
ls *samsyri.vcf|grep -v S_cep_S_yun_samsyri.vcf >vcf_file
/software/SURVIVOR/Debug/SURVIVOR merge vcf_file 50 1 0 0 0 0 sample_merged.vcf  #https://github.com/fritzsedlazeck/SURVIVOR


plotsr --sr S_jap_S_cep_samsyri.out --sr S_cep_S_yun_samsyri.out  --genomes genome.txt_2 -o syri_output_plot.pdf #



# collect all  syri data to result directory

cat S_cep_S_yun_samsyri.out.syn |cut -f 1,2,3|mergeBed >scep_with_syun.area
cat S_jap_S_cep_samsyri.out.syn |cut -f 6,7,8|mergeBed >scep_with_sjap.area
intersectBed -a scep_with_syun.area -b scep_with_sjap.area|sortBed|mergeBed >core_syn_in_scep

cat S_jap_S_yun_samsyri.out.syn |cut -f 1,2,3|mergeBed >sjap_with_syun.area
cat S_jap_S_cep_samsyri.out.syn |cut -f 1,2,3|mergeBed >sjap_with_scep.area
intersectBed -a sjap_with_syun.area -b sjap_with_scep.area|sortBed|mergeBed >core_syn_in_sjap


cat S_cep_S_yun_samsyri.out.syn |cut -f 6,7,8|mergeBed >syun_with_scep.area
cat S_jap_S_yun_samsyri.out.syn |cut -f 6,7,8|mergeBed >syun_with_sjap.area
intersectBed -a syun_with_sjap.area -b syun_with_scep.area|sortBed|mergeBed >core_syn_in_syun


awk 'BEGIN{a=0}{a=a+$3-$2}END{print a}' core_syn_in_scep 
#3761,9718
awk 'BEGIN{a=0}{a=a+$3-$2}END{print a}' core_syn_in_sjap 
#1127,0520
awk 'BEGIN{a=0}{a=a+$3-$2}END{print a}' core_syn_in_syun 
#1400,6281


cat S_jap_S_yun_samsyri.out.syn|awk 'BEGIN{a=0;b=0;ad=0;bd=0}{posa=$1"_"$2"_"$3;posb=$6"_"$7"_"$8;if(posa in at){ad=ad+$3-$2}else{a=a+$3-$2;at[posa]=1}if(posb in bt){bd=bd+$8-$7}else{b=a+$8-$7;bt[posb]=1}}END{print a"\t"b"\n"ad"\t"bd}'
cat S_cep_S_yun_samsyri.out.syn|awk 'BEGIN{a=0;b=0;ad=0;bd=0}{posa=$1"_"$2"_"$3;posb=$6"_"$7"_"$8;if(posa in at){ad=ad+$3-$2}else{a=a+$3-$2;at[posa]=1}if(posb in bt){bd=bd+$8-$7}else{b=a+$8-$7;bt[posb]=1}}END{print a"\t"b"\n"ad"\t"bd}'
cat S_jap_S_cep_samsyri.out.syn|awk 'BEGIN{a=0;b=0;ad=0;bd=0}{posa=$1"_"$2"_"$3;posb=$6"_"$7"_"$8;if(posa in at){ad=ad+$3-$2}else{a=a+$3-$2;at[posa]=1}if(posb in bt){bd=bd+$8-$7}else{b=a+$8-$7;bt[posb]=1}}END{print a"\t"b"\n"ad"\t"bd}'

# some strange, check

cat S_jap_S_cep_samsyri.out.syn |awk 'BEGIN{a=0;b=0;ad=0;bd=0}{posa=$1"_"$2"_"$3;posb=$6"_"$7"_"$8;if(posa in at){ad=ad+$3-$2}else{a=a+$3-$2;at[posa]=1}if(posb in bt){bd=bd+$8-$7}else{b=a+$8-$7;bt[posb]=1}}END{print a"\t"b"\n"ad"\t"bd}'
cat S_cep_S_yun_samsyri.out.syn |awk 'BEGIN{a=0;b=0;ad=0;bd=0}{posa=$1"_"$2"_"$3;posb=$6"_"$7"_"$8;if(posa in at){ad=ad+$3-$2}else{a=a+$3-$2;at[posa]=1}if(posb in bt){bd=bd+$8-$7}else{b=a+$8-$7;bt[posb]=1}}END{print a"\t"b"\n"ad"\t"bd}'
cat S_jap_S_yun_samsyri.out.syn |awk '{a=$3-$2;b=$8-$7;print a"\t"b"\t"(b-a)}'|awk 'BEGIN{a=0}{a=a+$3}END{print a}'
# -5602179


# get ohter info
subtractBed -a scep_with_sjap.area -b  core_syn_in_scep >commonpart_with_sjap_scep_in_scep
subtractBed -a sjap_with_scep.area -b  core_syn_in_sjap  >commonpart_with_sjap_scep_in_sjap
subtractBed -a scep_with_syun.area -b  core_syn_in_scep  >commonpart_with_syun_scep_in_scep
subtractBed -a syun_with_scep.area -b  core_syn_in_syun  >commonpart_with_syun_scep_in_syun
subtractBed -a sjap_with_syun.area -b  core_syn_in_sjap  >commonpart_with_sjap_syun_in_sjap
subtractBed -a syun_with_sjap.area -b  core_syn_in_syun  >commonpart_with_sjap_syun_in_syun
for i in `ls commonpart_with*`
do
cat ${i}|awk -v vv="${i}" 'BEGIN{a=0}{a=a+$3-$2}END{print a"\t"vv}' 
done

# 1303,1528         commonpart_with_sjap_scep_in_scep
# 4739,3974         commonpart_with_sjap_scep_in_sjap
# 1089,9590         commonpart_with_sjap_syun_in_sjap
# 256,6177          commonpart_with_sjap_syun_in_syun
# 2,7363,9986       commonpart_with_syun_scep_in_scep
# 3,3285,7140       commonpart_with_syun_scep_in_syun


# collect info
for i in `ls *.out`;do cat ${i}|awk '$11=="INV"'>${i}.inv;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="TRANS"'>${i}.trans;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="DUP"'>${i}.dup;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="HDR"'>${i}.hdr;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="DEL"'>${i}.del;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="INS"'>${i}.ins;done;

for i in `ls *.out`;do cat ${i}|awk '$11=="INVTR"'>${i}.invtr;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="INVDP"'>${i}.invdp;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="NOTAL"'>${i}.notal;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="CPG"'>${i}.cpg;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="CPL"'>${i}.cpl;done;
for i in `ls *.out`;do cat ${i}|awk '$11=="TDM"'>${i}.tdm;done;


#1. 5m and 1m cut-off  ,save all SV
for i in `ls *.out.*`;do cat ${i}|awk 'BEGIN{FS=OFS="\t"}{a=$3-$2;b=$8-$7;d=a-b;print $0,a,b,d}' >${i}.diff;cat ${i}|awk 'BEGIN{FS=OFS="\t"}{a=$3-$2;b=$8-$7;d=a-b;if(a>5000000||b>5000000){print $0,a,b,d}}' > ${i}.diff.5m;cat ${i}|awk 'BEGIN{FS=OFS="\t"}{a=$3-$2;b=$8-$7;d=a-b;if(a>1000000||b>1000000){print $0,a,b,d}}' > ${i}.diff.1m;done


for i in `ls *diff*`;do echo ${i};cat ${i}|cut -f 1-3|awk 'BEGIN{FS=OFS="\t"}$3!="-"'|sortBed|mergeBed |awk -v s=${i} 'BEGIN{FS=OFS="\t"}$3!="-"{len=$3-$2;print $0,len,"query",s}' > ${i}.query;cat ${i}|cut -f 6-8|awk 'BEGIN{FS=OFS="\t"}$3!="-"'|sortBed|mergeBed |awk -v s=${i} 'BEGIN{FS=OFS="\t"}$3!="-"{len=$3-$2;print $0,len,"ref",s}' > ${i}.ref;done 

wc -l * 


for i in `ls |grep -E "ref|query"`;do cat ${i}|awk 'BEGIN{FS=OFS="\t";a=0}{a+=$4}END{print a,$5,$6}';done 

mkdir filter2
spices=(jap cep yun)
types=(cpg cpl del dup hdr ins inv invdp invtr notal syn tdm trans)
files=("diff.(query|ref)" "diff.1m.(query|ref)" "diff.5m.(query|ref)")
# for s in ${spices[@]}; do for t in ${types[@]}; do for f in ${files[@]}; do echo $f,$s,$t; tmp=`ls |grep -E "S_${s}.*\.ref|S.*S_${s}.*\.query" |grep -E "${t}.${f}"`; echo "S_${s}*\.ref|S.*S_${s}.*\.query"; echo "${t}.${f}"; echo ${tmp}; done; done; done
# for s in ${spices[@]}; do for t in ${types[@]}; do for f in ${files[@]}; do echo $f,$s,$t; tmp=`ls |grep -E "S_${s}.*\.ref|S.*S_${s}.*\.query"  |grep -E "${t}.${f}"`;if [ ! -z $tmp ];then cat ${tmp}|sortBed |mergeBed |awk -v s="${t},${f}" 'BEGIN{FS=OFS="\t"}$3!="-"{len=$3-$2;print $0,len,"merged",s}' > filter2/S_${s}_${t}.${f};fi done; done; done
for s in ${spices[@]}; do for t in ${types[@]}; do for f in ${files[@]}; do echo $f,$s,$t; tmp=`ls |grep -E "S_${s}.*\.ref|S.*S_${s}.*\.query"  |grep -E "${t}.${f}"`; cat ${tmp}|sortBed |mergeBed |awk -v s="${t},${f}" 'BEGIN{FS=OFS="\t"}$3!="-"{len=$3-$2;print $0,len,"merged",s}' > filter2/S_${s}_${t}.${f%.*}; done; done; done


for i in `ls  filter2/`; do cat filter2/${i} |awk -v t="${i}"  'BEGIN{FS=OFS="\t";a=0}{a+=$4}END{if(a!=0){print a,$5,$6,t}}';  done 

