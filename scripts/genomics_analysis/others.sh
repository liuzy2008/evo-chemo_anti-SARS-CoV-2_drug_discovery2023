#

BuildDatabase -name ${sample} -engine ncbi ${genome.fa}

RepeatModeler -pa 10 -database ${sample} -engine ncbi

RepeatMasker -pa 10 -gff -lib ${sample}.fa -dir repeat ${genome.fa}


stringtie -p 10 -e -G genomic.gff -o sample.gtf -i sample.bam

busco --config config.ini -i ${genome.fa} -r -o ${sample_name} --out_path ./busco -l arthropoda_odb10 -m geno -c 32 -f  --offline

makeblastdb -in genome.fa -dbtype nucl -parse_seqids -out ./index
blastp -query ${q1} -db ${db} -evalue 1e-5 -outfmt "6 qseqid sseqid evalue pident qcovs bitscore qstart qend qlen sstart send slen" -out Blastp



