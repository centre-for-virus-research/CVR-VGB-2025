#!/bin/bash

ref=$1

for r1 in *_R1*.f*q; do
	echo "R1 file = $r1"

	last_six="${r1: -6}"

	if [ "$last_six" = "_R1.fq" ]
	then
		r2=${r1%_R1.fq}_R2.fq
		sample=${r1%_R1.fq}

		echo "Processing pair:"
		echo "R1: $r1"
		echo "R2: $r2"
		echo "Sample = $sample"
		echo "Ref = $ref"

		bash algn.sh $r1 $r2 $ref $sample

	else
		r2=${r1%_R1_001.fastq}_R2_001.fastq
		sample=${r1%_R1_001.fastq}

		echo "Processing pair:"
        	echo "R1: $r1"
		echo "R2: $r2"
        	echo "Sample = $sample"
        	echo "Ref = $ref"

        	bash algn.sh $r1 $r2 $ref $sample

	fi

done
