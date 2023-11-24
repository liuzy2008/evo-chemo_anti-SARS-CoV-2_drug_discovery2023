diamond blastx --db ${protein} \
--query ${sample}/genome.fna \
--more-sensitive -p 1 --quiet -e 0.001 --compress 1 --outfmt 6  --threads 52 --quiet \
--out ./${sample}/anno.txt

iqtree -s ${test_seq} -m MFP -b 1000 -nt 5
raxml-ng --bootstrap --msa prim.phy --model GTR+G --prefix test --seed 2 --threads 2 --bs-trees 200

python3 removeRedundantProteins.py -i ${in} -o ${out}

python3 CAFE_fig.py ${cafe}  -p 0.05 -t 8 -r 10000 -filter --dump test/ -g svg --count_all_expansions



TransDecoder.LongOrfs -t {input.fas}  --output_dir  {params.output_dir}

