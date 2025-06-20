##metagenomics pipeline


DATA_DIR=$1

for r1 in "$DATA_DIR"/*_1.fq; do

# Derive R2 filename by replacing _1.fq with _2.fq
r2=${r1%_1.fq}_2.fq

echo "Processing pair:"
echo "R1: $r1"
echo "R2: $r2"

#define the variables for trimming
F1=$r1
F2=$r2

#trimming (trimgalore)
#trim_galore --illumina --length 50 -q 30 --paired $F1 $F2
#rename the variables for spades imput
TRIM1=$(basename ${F1%.fq}_val_1.fq)
TRIM2=$(basename ${F2%.fq}_val_2.fq)
#name check
echo $TRIM1
echo $TRIM2
#define the output directory
OUTDIR=$(basename ${F1%_1.fq}_results)
#name check
echo $OUTDIR
mkdir $OUTDIR
#host depletion human
#bowtie2 -x /home4/VBG_data/hg19/hg19 -1 $TRIM1 -2 $TRIM2 -S ${OUTDIR}/human.sam -p 8
#samtool for unassegned
#samtools fastq -1 ${OUTDIR}/nonhuman_1.fastq -2 ${OUTDIR}/nonhuman_2.fastq -f 4 -s singleton.fastq ${OUTDIR}/human.sam
NOHUM1=${OUTDIR}/nonhuman_1.fastq
NOHUM2=${OUTDIR}/nonhuman_2.fastq
#echo $NOHUM1
#echo $NOHUM2
#denovo assembly
#spades.py -t 4 --careful -k 21,45,73,101 --only-assembler -1 $NOHUM1 -2 $NOHUM2 -o $OUTDIR
#kraken2 contig classification
#/software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data ${OUTDIR}/contigs.fasta --output ${OUTDIR}/kraken_output.txt --report ${OUTDIR}/kraken_report.txt 
#krona taxonomy visualisation
#ktImportTaxonomy -q 2 -t 3 -s 4 ${OUTDIR}/kraken_output.txt -o ${OUTDIR}/kraken_krona.html -tax /db/kronatools/taxonomy
#kraken2 read classification
/software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data --paired $NOHUM1 $NOHUM2 --output ${OUTDIR}/kraken_READS_output.txt --report ${OUTDIR}/kraken_READS_report.txt 
#krona taxonomy visualisation
ktImportTaxonomy -q 2 -t 3 -s 4 ${OUTDIR}/kraken_READS_output.txt -o ${OUTDIR}/kraken_READS_krona.html -tax /db/kronatools/taxonomy

done


