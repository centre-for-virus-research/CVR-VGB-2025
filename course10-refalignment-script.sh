#!/bin/bash

# Write a reference alignment pipeline
# Loop in multiple fastq

# 1. Index the reference
# 2.  bwa mem 
# 3. samtools
# 4. Consensus calling


read1=$1
read2=$2
ref=$3
name=$4


bwa index $ref
prinseq-lite.pl -stats_info -stats_len -fastq $read1 -fastq2 $read2 > prinseq_out.txt

trim_galore -q 20 --length 50 --max_n 0 --paired $read1 $read2

#don't forget to add the extension after the name (ex. .sam):

# Extract sample name (remove path and _1.fq suffix)
# Change names here, use the newly created FASTQ paired contained our trimmed/filtered reads

base1=$(basename "$read1")
filename1=${base1%.f*q}
trim1=${filename1}_val_1.fq
echo $base1
echo $filename1
echo $trim1

base2=$(basename "$read2")
filename2=${base2%.f*q}
trim2=${filename2}_val_2.fq
echo $base2
echo $filename2
echo $trim2

bwa mem -t 4 $ref $trim1 $trim2 > $name.sam 
samtools sort $name.sam -o $name.bam
samtools index $name.bam
rm $name.sam
echo "Happy to see the $ref  file"  #try if this ${} works or not
samtools view -c -f4 $name.bam # To count the number of unmapped reads
samtools view -c -F2308 $name.bam # Number of mapped reads 
weeSAM --bam $name.bam --html coverage_plot --overwrite # Graphical coverage plot

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/software/htslib-v1.12/lib 
samtools mpileup -aa -A -d 0 -Q 0 $name.bam | ivar consensus -p $name -t 0.4

# Kraken
/software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data --paired $trim1 $trim2 --output kraken_output.txt --report kraken_report.txt 
ktImportTaxonomy -q 2 -t 3 -s 4 kraken_output.txt -o kraken_krona.html -tax /db/kronatools/taxonomy


