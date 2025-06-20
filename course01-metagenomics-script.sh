#!/bin/bash

# Pipeline script for metagenomics
# Usage ./Pipelinel <Inpute_Directory> <File_Type>


# Define input dir
Input_Directory=$1
Setting=$2

# Find reads
reads=$1/*_1.fq

# Loop through all samples
for read_1 in $reads;
do
	# Define variables
	B_name=$(basename $read_1)
	Sample_name=${B_name%_*}
	read_2=${Sample_name}_2.fq
	
	# Log
	echo "Starting trim_galore for $Sample_name"
	echo "file 1 = $read_1"
	echo "file 2 = $read_2"

	# Run trimgalore
	trim_galore --illumina --length 50 -q 30 --paired $read_1 $read_2 -o ${Sample_name}

	if [ $Setting == "contigs" ]
	then
	# Log
        echo "Starting Spades"

	# Run spades
	spades.py -t 4 --careful -k 21,45,73,101 --only-assembler -1 ${Sample_name}/${Sample_name}_1_val_1.fq -2 ${Sample_name}/${Sample_name}_2_val_2.fq -o ${Sample_name}/Spades_Out

	# Log
	echo "Running Kraken on $Sample_name"

	# Create output dir for kraken
	mkdir -p ${Sample_name}/Kraken_Output 

	# Run kraken
	/software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data ${Sample_name}/Spades_Out/contigs.fasta --output ${Sample_name}/Kraken_Output/kraken_output.txt --report ${Sample_name}/Kraken_Output/kraken_report.txt

	elif [ $Setting == "reads" ]
	then

	# Create output dir for kraken
        mkdir -p ${Sample_name}/Kraken_Output

	# Run kraken
        /software/kraken2-v2.1.1/kraken2 --db /home4/VBG_data/k2_standard_20230605 --threads 8 --minimum-hit-groups 3 --report-minimizer-data --paired ${Sample_name}/${Sample_name}_1_val_1.fq ${Sample_name}/${Sample_name}_2_val_2.fq --output ${Sample_name}/Kraken_Output/kraken_output.txt --report ${Sample_name}/Kraken_Output/kraken_report.txt
	fi

	# Generate HTML
	ktImportTaxonomy -q 2 -t 3 -s 4 ${Sample_name}/Kraken_Output/kraken_output.txt -o ${Sample_name}/Kraken_Output/kraken_krona.html -tax /db/kronatools/taxonomy

	# Loop complete - log
	echo "Analysis complete for $Sample_name"
done





