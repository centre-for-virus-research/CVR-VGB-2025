#!/bin/bash

read1=$1
read2=$2
ref=$3
samplename=$4

echo  "read 1 file = $read1" 
echo  "read 2 file = $read2"
echo "ref file = $ref"
echo "output file = $samplename"


prinseq-lite.pl -stats_info -stats_len -fastq $read1 -fastq2 $read2 >  printseqoutput.txt

trim_galore -q 20 --length 50 --max_n 0 --paired $read1 $read2

base1=$(basename "$read1")
filename1=${base1%.f*q}
trim1=${filename1}_val_1.fq


base2=$(basename "$read2")
filename2=${base2%.f*q}
trim2=${filename2}_val_2.fq

echo "trim file 1 = $trim1"
echo "trim file 2 = $trim2"

bwa index $ref
bwa mem -t 4 $ref $trim1 $trim2 > $samplename.sam 

samtools sort $samplename.sam -o $samplename.bam
samtools index $samplename.bam
rm $samplename.sam

rm ${samplename}_log.txt
touch ${samplename}_log.txt

echo "unmappedreads=" >> ${samplename}_log.txt
samtools view -c -f4 $samplename.bam >> ${samplename}_log.txt

echo "mappedreads=" >> ${samplename}_log.txt
samtools view -c -F2308 $samplename.bam >> ${samplename}_log.txt

weeSAM --bam $samplename.bam --html $samplename --overwrite

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/software/htslib-v1.12/lib

samtools mpileup -aa -A -d 0 -Q 0 $samplename.bam | ivar consensus -p $samplename -t 0.4 

/software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data --paired $trim1 $trim2 --output ${samplename}_kraken_output.txt --report ${samplename}_kraken_report.txt 

ktImportTaxonomy -q 2 -t 3 -s 4 ${samplename}_kraken_output.txt -o ${samplename}_kraken_krona.html -tax /db/kronatools/taxonomy
