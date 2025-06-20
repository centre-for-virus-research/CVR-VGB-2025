#user imput on command line - path to data (expecting data to be _1.fq and _2.fq)
path=$1

echo $path
for r1 in "$path"*_1.fq; do
# Derive R2 filename by replacing _1.fq with _2.fq
r2=${r1%_1.fq}_2.fq

echo $r1 $r2


file1=$(basename "$r1")
file2=$(basename "$r2")


trim_galore --illumina --length 50 -q 30 --paired $r1 $r2



trim1=${file1%.fq}_val_1.fq
trim2=${file2%.fq}_val_2.fq

spades.py -t 4 --careful -k 21,45,73,101 --only-assembler -1 $trim1 -2 $trim2 -o out_${file1%_1.fq}

/software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data out_${file1%_1.fq}/contigs.fasta --output out_${file1%_1.fq}/kraken_output.txt --report out_${file1%_1.fq}/kraken_report.txt 

ktImportTaxonomy -q 2 -t 3 -s 4 out_${file1%_1.fq}/kraken_output.txt -o out_${file1%_1.fq}/kraken_krona.html -tax /db/kronatools/taxonomy
done
