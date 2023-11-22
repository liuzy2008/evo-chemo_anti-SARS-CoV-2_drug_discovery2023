# c panel
grep chr2 sjap.bed | awk '$2 >= 56360000 && $3 <= 57040000' > sjap_cluster2.bed
grep chr13 scep.bed | awk '$2 >= 720000 && $3 <= 1160000' > scep_cluster2.bed
cp sjap.cds sjap_cluster2.cds
cp scep.cds scep_cluster2.cds 
python -m jcvi.compara.catalog ortholog sjap_cluster2 scep_cluster2 --no_strip_names
python -m jcvi.graphics.dotplot sjap_cluster2.scep_cluster2.anchors
python -m jcvi.compara.synteny mcscan sjap_cluster2.bed sjap_cluster2.scep_cluster2.anchors -o sjap_cluster2_scep_cluster2.i1.blocks
cat scep_cluster2.bed sjap_cluster2.bed > scep_cluster2.sjap_cluster2.bed
python -m jcvi.graphics.synteny sjap_cluster2_scep_cluster2.i1.blocks scep_cluster2.sjap_cluster2.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6

# d panel
python -m jcvi.formats.gff bed --type=mRNA --key=ID Stephania_japonica.gene.gff -o Sjap.bed 
python -m jcvi.formats.gff bed --type=mRNA --key=ID Stephania_cepharantha.gene.gff -o Scep.bed
grep chr3 sjap.bed | awk '$2 >= 51440000 && $3 <= 51960000' > sjap_cluster1.bed
grep chr4 scep.bed | awk '$2 >= 56600000 && $3 <= 57080000' > scep_cluster1.bed
cp sjap.cds sjap_cluster1.cds
cp scep.cds scep_cluster1.cds 
python -m jcvi.compara.catalog ortholog sjap_cluster1 scep_cluster1 --no_strip_names
python -m jcvi.graphics.dotplot sjap_cluster1.scep_cluster1.anchors
python -m jcvi.compara.synteny mcscan sjap_cluster1.bed sjap_cluster1.scep_cluster1.anchors -o sjap_cluster1_scep_cluster1.i1.blocks
cat scep_cluster1.bed sjap_cluster1.bed > scep_cluster1.sjap_cluster1.bed
python -m jcvi.graphics.synteny sjap_cluster1_scep_cluster1.i1.blocks scep_cluster1.sjap_cluster1.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6
grep chr2 sjap.bed | awk '$2 >= 56360000 && $3 <= 57040000' > sjap_cluster2.bed
grep chr13 scep.bed | awk '$2 >= 720000 && $3 <= 1160000' > scep_cluster2.bed
cp sjap.cds sjap_cluster2.cds
cp scep.cds scep_cluster2.cds 
python -m jcvi.compara.catalog ortholog sjap_cluster2 scep_cluster2 --no_strip_names
python -m jcvi.graphics.dotplot sjap_cluster2.scep_cluster2.anchors
python -m jcvi.compara.synteny mcscan sjap_cluster2.bed sjap_cluster2.scep_cluster2.anchors -o sjap_cluster2_scep_cluster2.i1.blocks
cat scep_cluster2.bed sjap_cluster2.bed > scep_cluster2.sjap_cluster2.bed
python -m jcvi.graphics.synteny sjap_cluster2_scep_cluster2.i1.blocks scep_cluster2.sjap_cluster2.bed blocks.layout --glyphstyle=arrow --glyphcolor=orthogroup --genelabelsize 6

# Fig 2H
grep chr2 sjap.bed | awk '$2 >= 3449000 && $3 <= 3950000' > SjNCS_cluster1.bed 
cp sjap.cds SjNCS_cluster1.cds
cp syun.cds Syun.cds 
python -m jcvi.compara.catalog ortholog SjNCS_cluster1 Syun --no_strip_names
python -m jcvi.graphics.dotplot SjNCS_cluster1.Syun.anchors
cat SjNCS_cluster1.bed Syun.bed > SjNCS_cluster1.Syun.bed
python -m jcvi.compara.synteny mcscan SjNCS_cluster1.bed SjNCS_cluster1.Syun.anchors -o SjNCS_cluster1.Syun.i1.blocks
python -m jcvi.graphics.synteny SjNCS_cluster1.Syun.i1.blocks SjNCS_cluster1.Syun.bed blocks.jayout --glyphstyle=arrow --glyphcolor=orthogroup 
python -m jcvi.compara.catalog ortholog SjNCS_cluster1 Scep --no_strip_names
python -m jcvi.graphics.dotplot SjNCS_cluster1.Scep.anchors
cat SjNCS_cluster1.bed Scep.bed > SjNCS_cluster1.Scep.bed
python -m jcvi.compara.synteny mcscan SjNCS_cluster1.bed SjNCS_cluster1.Scep.anchors -o SjNCS_cluster1.Scep.i1.blocks
python -m jcvi.graphics.synteny SjNCS_cluster1.Scep.i1.blocks SjNCS_cluster1.Scep.bed blocks.jayout --glyphstyle=arrow --glyphcolor=orthogroup 
python -m jcvi.formats.base join SjNCS_cluster1.Syun.i1.blocks SjNCS_cluster1.Syun.i1.blocks --noheader | cut -f1,2,4 > NCS_cluster1.blocks
cat SjNCS_cluster1.Scep.bed Syun.bed > SjNCS_cluster1.Scep.Syun.bed 
python -m jcvi.graphics.synteny NCS_cluster1.blocks SjNCS_cluster1.Scep.Syun.bed blocks.jayout --glyphstyle=arrow --genelabelsize 6

grep chr7 sjap.bed | awk '$2 >= 5890000 && $3 <= 6080000' > SjNCS_cluster2.bed 
cp sjap.cds SjNCS_cluster2.cds
python -m jcvi.compara.catalog ortholog SjNCS_cluster2 Syun --no_strip_names
python -m jcvi.graphics.dotplot SjNCS_cluster2.Syun.anchors
cat SjNCS_cluster2.bed Syun.bed > SjNCS_cluster2.Syun.bed
python -m jcvi.compara.synteny mcscan SjNCS_cluster2.bed SjNCS_cluster2.Syun.anchors -o SjNCS_cluster2.Syun.i1.blocks
python -m jcvi.graphics.synteny SjNCS_cluster2.Syun.i1.blocks SjNCS_cluster2.Syun.bed blocks.jayout --glyphstyle=arrow --glyphcolor=orthogroup 
python -m jcvi.compara.catalog ortholog SjNCS_cluster2 Scep --no_strip_names
python -m jcvi.graphics.dotplot SjNCS_cluster2.Scep.anchors
cat SjNCS_cluster2.bed Scep.bed > SjNCS_cluster2.Scep.bed
python -m jcvi.compara.synteny mcscan SjNCS_cluster2.bed SjNCS_cluster2.Scep.anchors -o SjNCS_cluster2.Scep.i1.blocks
python -m jcvi.graphics.synteny SjNCS_cluster2.Scep.i1.blocks SjNCS_cluster2.Scep.bed blocks.jayout --glyphstyle=arrow --glyphcolor=orthogroup 
python -m jcvi.formats.base join SjNCS_cluster2.Syun.i1.blocks SjNCS_cluster2.Syun.i1.blocks --noheader | cut -f1,2,4 > NCS_cluster2.blocks
cat SjNCS_cluster2.Scep.bed Syun.bed > SjNCS_cluster2.Scep.Syun.bed 
python -m jcvi.graphics.synteny NCS_cluster2.blocks SjNCS_cluster2.Scep.Syun.bed blocks.jayout --glyphstyle=arrow --genelabelsize 6
