 
#Extended Data Fig. 9A
python -m jcvi.formats.gff bed --type=mRNA --key=ID Stephania_yunnanensis.gene.gff -o syun.bed
grep chr3 sjap.bed | awk '$2 >= 51460000 && $3 <= 51960000' > sjap_cluster1.bed
grep chr3 syun.bed | awk '$2 >= 3890000 && $3 <= 4350000' > syun_cluster1.bed
cp sjap.cds sjap_cluster1.cds
cp syun.cds syun_cluster1.cds 
python -m jcvi.compara.catalog ortholog sjap_cluster1 syun_cluster1 --no_strip_names
python -m jcvi.graphics.dotplot sjap_cluster1.syun_cluster1.anchors
python -m jcvi.compara.synteny mcscan sjap_cluster1.bed sjap_cluster1.syun_cluster1.anchors -o sjap_cluster1_syun_cluster1.i1.blocks
cat syun_cluster1.bed sjap_cluster1.bed > syun_cluster1.sjap_cluster1.bed
python -m jcvi.graphics.synteny sjap_cluster1_syun_cluster1.i1.blocks syun_cluster1.sjap_cluster1.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6

#Extended Data Fig. 9B
grep chr4 scep.bed | awk '$2 >= 56620000 && $3 <= 57080000' > scep_cluster1.bed
grep chr3 syun.bed | awk '$2 >= 3890000 && $3 <= 4350000' > syun_cluster1.bed
cp scep.cds scep_cluster1.cds
cp syun.cds syun_cluster1.cds 
python -m jcvi.compara.catalog ortholog scep_cluster1 syun_cluster1 --no_strip_names
python -m jcvi.graphics.dotplot scep_cluster1.syun_cluster1.anchors
python -m jcvi.compara.synteny mcscan scep_cluster1.bed scep_cluster1.syun_cluster1.anchors -o scep_cluster1_syun_cluster1.i1.blocks
cat syun_cluster1.bed scep_cluster1.bed > syun_cluster1.scep_cluster1.bed
python -m jcvi.graphics.synteny scep_cluster1_syun_cluster1.i1.blocks syun_cluster1.scep_cluster1.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6

#Extended Data Fig. 9C
grep chr2 sjap.bed | awk '$2 >= 56360000 && $3 <= 57040000' > sjap_cluster2.bed
grep chr13 syun.bed | awk '$2 >= 48670000 && $3 <= 49230000' > syun_cluster2.bed
cp sjap.cds sjap_cluster2.cds
cp syun.cds syun_cluster2.cds 
python -m jcvi.compara.catalog ortholog sjap_cluster2 syun_cluster2 --no_strip_names
python -m jcvi.graphics.dotplot sjap_cluster1.syun_cluster1.anchors
python -m jcvi.compara.synteny mcscan sjap_cluster2.bed sjap_cluster2.syun_cluster2.anchors -o sjap_cluster2_syun_cluster2.i1.blocks
cat syun_cluster2.bed sjap_cluster2.bed > syun_cluster2.sjap_cluster2.bed
python -m jcvi.graphics.synteny sjap_cluster2_syun_cluster2.i1.blocks syun_cluster2.sjap_cluster2.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6

#Extended Data Fig. 9D
grep chr13 scep.bed | awk '$2 >= 7200000 && $3 <= 11600000' > scep_cluster2.bed
grep chr13 syun.bed | awk '$2 >= 48920000 && $3 <= 49210000' > syun_cluster2.bed
cp scep.cds scep_cluster2.cds
cp syun.cds syun_cluster2.cds 
python -m jcvi.compara.catalog ortholog scep_cluster2 syun_cluster2 --no_strip_names
python -m jcvi.graphics.dotplot scep_cluster2.syun_cluster2.anchors
python -m jcvi.compara.synteny mcscan scep_cluster2.bed scep_cluster2.syun_cluster2.anchors -o scep_cluster2_syun_cluster2.i1.blocks
cat syun_cluster2.bed scep_cluster2.bed > syun_cluster2.scep_cluster2.bed
python -m jcvi.graphics.synteny scep_cluster2_syun_cluster2.i1.blocks syun_cluster2.scep_cluster2.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6

