# NGS/HTS Data Practical

Derek W. Wright, MRC-University of Glasgow Centre for Virus Research [**Derek.Wright\@glasgow.ac.uk**](mailto:Derek.Wright@glasgow.ac.uk)

## Overview

In this practical, we will be exploring the FASTA, multi-FASTA and FASTQ formats.

## Linux Commands

Commands that you need to enter into the terminal window (command line) are presented in a box with a fixed-width font, like this:

``` bash
ls
```

A few tips to remember:

-   Use the **Tab** key to automatically complete file names (especially long ones) and commands.

-   Use the **up arrow** to scroll through your previous commands. It enables you to easily re-run or edit old commands.

-   Use **Ctrl + r** to reverse search your shell history to find and reuse old commands.

-   **history** to list your command line history

-   **!10** executes line 10 of your command line history again

-   **!:\$** uses the last argument of the most recent command in your bash history again

-   **Case matters.** The following file names are all different:

```         
Myfile.txt
MyFile.txt
MYFILE.txt
myfile.txt
my file.txt
my_file.txt
```

Watch out for number 1 being confused with lowercase letter L, and capital letter O being confused with zero 0.

-   **l** = lower case L

-   **1** = number one

-   **O** = capital letter O

-   **0** = zero

Shorthand/wildcard symbols help to save typing:

-   **\~** is shorthand for your home directory.

-   **.** is shorthand for the current working directory.

-   **..** is shorthand for the directory above.

-   **\*** may be used as a wildcard to match file names.

## Setup

-   Log in to Windows PC.
-   Log in to *alpha2* server via *MobaXTerm* program*.*

``` bash
ssh username@alpha2.cvr.gla.ac.uk
```

``` bash
cd ~ 
```

**\~** is shortcut for home directory

## File Formats

### Dataset

``` bash
cp -r /home3/dw73x/Formats .
```

**.** is shortcut for current working directory

``` bash
cd Formats
```

### View the FASTA Format

#### Nucleotide Sequence

``` bash
less single_seq.fasta
```

-   Press **space** or **f** to scroll down through the file page by page
-   Press **b** to scroll back up a page
-   Press **q** to quit

#### Amino Acid Sequence

``` bash
less protein.faa
```

-   Sars-CoV-2 spike protein amino acid sequence from NCBI

#### Multi-FASTA Format

``` bash
less BabayanEtAl_sequences.fasta 
```

-   Press space or **f** to scroll down through the file page by page
-   Press **b** to scroll back up
-   Press **q** to quit

``` bash
grep '>' BabayanEtAl_sequences.fasta
```

-   Search (*grep*) for lines with the **\>** symbol in the file

``` bash
grep '>' BabayanEtAl_sequences.fasta | wc -l
```

-   Search (*grep*) for lines with the **\>** symbol in the file
-   Pipe (**\|**) the results in to the next command
-   Word count (*wc*) the number of lines (**-l**)

I have also provided multi-FASTA files, in which the sequences have been aligned, using the [MAFFT](https://mafft.cbrc.jp/alignment/server/index.html "MAFFT multiple alignment program") multiple sequence aligner program. This aligns multiple sequences to the same length, interspersed with gap characters ('**-**'). There are are two files for the HA protein of the influenza virus: one for coding sequence nucleotides and one for amino acids.

``` bash
less sgt_4_HA_CDS.fasta
```

``` bash
less sgt_4_HA_AA.fasta
```

### View the FASTQ Format

``` bash
less reads_R1.fastq
```

-   Press **space** or **f** to scroll through the file page by page
-   Press **b** to scroll back up a page
-   Press **q** to quit

``` bash
grep '@SRR1553467.279000' reads_R1.fastq
```

-   Search (*grep*) for lines with string “SRR1553467.279000” (i.e. search for the read with the name *SRR1553467.279000*)

``` bash
grep '@SRR1553467.279000' -A 3 reads_R1.fastq
```

-   As a FASTQ read consists of 4 lines, also return the 3 lines after (*-A 3*)

``` bash
wc –l reads_R1.fastq
```

-   Word count (*wc*) the number of lines (**-l**) in the file (lines not reads)
-   Divide by 4 to get the number of reads

``` bash
grep '^@SRR1553467' reads_R1.fastq | wc -l
```

-   Search (*grep*) for lines beginning (**\^**) with the ‘SRR’ symbol in the file *reads.fastq*
-   Pipe (**\|**) the results on to the next command
-   Word count (*wc*) the number of lines (**-l**)
-   Number of reads in the file

#### Compressed Files

FASTQ files are often gzipped (compressed) and have *.fastq.gz* extension Use commands *zcat, zmore, zless, zgrep* to access these compressed files

``` bash
zless 00013_OS_L_NA_S1_R1_001.fastq.gz
```
