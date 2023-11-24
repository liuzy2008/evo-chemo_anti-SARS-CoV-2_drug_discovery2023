#  BGI short-read sequencing data
jellyfish count -t 70 -C -m 19 -s 1G -o kmer19 -G 4 clean_R1.fq.gz clean_R2.fq.gz;jellyfish histo -v -o kmer19.histo kmer19 -t 70 -h 100000
gce -f kmer19.histo -M 1500 -H 1 > gce.table 2> ${log}/gce.log
# nextDenovo
nohup nextDenovo nextdenovo_run.cfg &
# racon
racon -t 10 select.fa select.sam  assembly.fa > racon.fa
#Pilon v1.23
java -jar pilon-1.23.jar --genome genome.fa --bam sorted.bam --changes --diploid --threads 4 --fix bases --output pilon.results

ALLHiC_partition -b sample.clean.bam -r ref/genome.fa -e GATC -k 10;ALLHiC_rescue -b sample.clean.bam -r ref/genome.fa -c sample.clean.clusters.txt -i sample.clean.counts_GATC.txt;ALLHiC_build ref/genome.fa

minimap2 -ax map-ont -t 20 genome.fa ont-reads.fq

# Identification of the telomere and centromere regions
nucmer --prefix=pre_tail single.fasta consensus.fasta --maxmatch || echo dacongming; show-coords -rcl pre_tail.delta > $pre_tail.coords





# INFERNAL 
cmscan -Z 2636016 --cut_ga --rfam --nohmmonly --tblout result.tblout -Z 747.66 --cut_ga --rfam --nohmmonly --cpu 15 genome.fa > result.cmscan



augustus --uniqueGeneId=true --noInFrameStop=true --gff3=on --strand=both genome.fa > ${sample}.gff

cd ${work_dir}
purge_haplotigs hist -b aligned.bam -g genome.fa -t 20
purge_haplotigs contigcov -i aligned.bam.genecov -l $low_cutoff -m $mid_cutoff -h $high_cutoff -o coverage_stats.csv 
purge_haplotigs purge -g genome.fa -c coverage_stats.csv -b aligned.bam -t 8 -a 60



raxml-ng --all --msa ${raxml_dir}/data/protein.fa --model LG+G8+F --tree pars{10} --bs-trees 200

winnowmap -W repetitive_k15.txt --MD -o results.paf

TransDecoder.LongOrfs -t transcripts.fa


glimmerhmm genome.fa -d ${tmppath} -g genome.fa.gff -n 1


exonerate --model protein2genome --showtargetgff 1  -q T_l_protein.faa -t exonerate.fa --showalignment no >T_l_output.gff



# others  
winnowmap -W repetitive_k15.txt --MD -o results.paf
