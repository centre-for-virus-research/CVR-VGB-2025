# Text Processing and Linux Bash Scripting: Tutorial and Practical

## Overview

This tutorial introduces the fundamentals of  command-line text processing and Bash scripting. Linux is especially useful for life scientists and bioinformaticians who regularly handle large datasets, such as genome sequences and metadata.

The data for the next two sessions is in `/home4/VBG_data/BashDatasets/`. Copy the whole directory into your home directory and work from within the directory.



## 1. Text processing

### 1.1 Searching using `grep` (Global Regular Expression Print)

`grep` is a very useful command that searches for and prints lines that contain a specified pattern in a file. These patterns can be very simple (searching for a character, word or phrase) but can also when needed detect complex patterns using the regular expression (regex) syntax. Exploring the regex syntax could be its own tutorial, so instead it is more useful to look for websites that help build regular expressions for the information you want to extract (regexr.com is an example). For this example, we will filter a fasta file to only show the sequence header information (headers can be identified by the > character)


```bash
user@alpha2:~$ grep ">" sc2.fasta 
```

<details>
  <summary>Click me</summary> 
  
  ```bash
>NC_045512.2 Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1, complete genome
  ```
</details>



Another example would be extracting the gene names from genbank files. We also use the `-o` flag to print only the parts of the input that match the expression rather than the full line.

```bash
user@alpha2:~$ grep "gene=" sarscov2.gb
```

<details>
  <summary>Click me</summary>
  
  ```bash
                     /gene="ORF1ab"
                     /gene="S"
                     /gene="ORF3a"
                     /gene="E"
                     /gene="M"
                     /gene="ORF6"
                     /gene="ORF7a"
                     /gene="ORF7b"
                     /gene="ORF8"
                     /gene="N"
                     /gene="ORF10"
  ```
</details>


Using a basic regular expression `'".*"' ` (This one captures all strings within "" parenthesis), we can take grep a little further and trim this output so that we only get the gene names rather than the genbank formated line.

```bash
user@alpha2:~$ grep "gene=" sarscov2.gb | grep -o '".*"'               

```

<details>
  <summary>Click me</summary>
  
  ```bash
"ORF1ab"
"S"
"ORF3a"
"E"
"M"
"ORF6"
"ORF7a"
"ORF7b"
"ORF8"
"N"
"ORF10"
  ```
</details>


`grep`  is one of the most powerful commands for processing text files in linux, and is especially useful when used in conjunction with other commands.

**Task 1:**
Extract the lines containing the paper titles ("TITLE") in the sarscov2.gb file

<details>
  <summary>Don't cheat</summary>
  
  ```bash
grep "TITLE" sarscov2.gb
  ```
</details>



 
### 1.3 `head`, `tail` for File Previews

Use `head` to look at the top lines of a file. `-n 5` will show the top 5 lines.

```bash
head -n 5 metadata.csv
tail -n 3 metadata.csv
```

Useful command to skip the first N lines of a file `tail -n +<N+1> <filename>` so the following command will skip the first line of the metadata.csv file:

```bash
tail -n +2 metadata.csv
```




### 1.5 `wc` for Line and Word Counts

`wc` can be used for counting the number of lines in a file with the argument `-l` or the number of words with `-w` or the number of characters `-c`.

```bash
wc -l metadata.csv
```

---

### 1.6 Piping and Redirecting (`|`,`>`,`<`) 


We might want to perform a series of different commands on the command line. We can do this using the pipe (`|`) and redirection (`>`,`<`) operators when using different commands. A pipe takes the standard output of one command and sends it as the standard input of another command. Using our `head` and `tail` commands, we can extract lines 495-500 by piping the output of the `head` command into the input of the `tail` command like this:

```bash
user@alpha2:~$ head -n 500 metadata.csv | tail -n 5  

```

<details>
  <summary>Don't cheat</summary>
  
  ```bash
UK,UK-ENG,NORTHAMPTONSHIRE,MILK-28E97EC,2021-10-31,SANG,97,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E764B,2021-10-28,SANG,96,AY.4
UK,UK-ENG,EAST RIDING OF YORKSHIRE,QEUH-28E3946,2021-10-31,SANG,97,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E7A4F,2021-10-28,SANG,96,AY.4
UK,UK-NIR,BELFAST,NIRE-014205,2021-10-21,NIRE,95,AY.4
  ```
</details>


Lets say we want to save the output of this into a file. we can do this using a redirect (`>`) like so:

```bash
user@alpha2:~$ head -n 500 metadata.csv | tail -n 5  > 5_rows.txt
```

The `>` takes the output that would normally be printed to the terminal and redirects it into a file called "5_rows.txt". If this file does not exist, the file is created and filled with the output. If the file already exists, the file will be wiped blank and filled with the contents. If we want to keep what is already in the file, we can use the `>>` operator to append to the file.

```bash
user@alpha2:~$ head -n 505 metadata.csv | tail -n 5  >> 5_rows.txt
```


### 1.7 `cat` to view and concatenate 


To check whether we have appended the rows to the file, we can use `cat` to display the file contents:

```bash
user@alpha2:~$ cat 5_rows.txt 
```

<details>
  <summary>Click me</summary>
  
  ```bash
UK,UK-ENG,NORTHAMPTONSHIRE,MILK-28E97EC,2021-10-31,SANG,97,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E764B,2021-10-28,SANG,96,AY.4
UK,UK-ENG,EAST RIDING OF YORKSHIRE,QEUH-28E3946,2021-10-31,SANG,97,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E7A4F,2021-10-28,SANG,96,AY.4
UK,UK-NIR,BELFAST,NIRE-014205,2021-10-21,NIRE,95,AY.4
  ```
</details>


`cat` can also be used to concatenate two or more files, for example:

```bash
user@alpha2:~$ cat sc2.fasta omicron.fasta > two_seq.fasta
```


----

**Task 2:**
Use `grep` to check that you now have two sequences in the `two_seq.fasta` file
<details>
  <summary>Don't cheat</summary>
 
  ```bash
grep ">" two_seq.fasta
  ```
Or depending on what you want, pipe and count the lines

  ```bash
grep ">" two_seq.fasta | wc -l
  ```
</br></details>



**Task 3:**
Use `head` to retrieve the first line of the metadata.csv file use the redirect operator to make a new file header.csv 10_metadata.csv.

<details>
  <summary>Don't cheat</summary>
  
  ```bash
head -n 1 metadata.csv > header.csv
  ```
</br></details>

**Task 4:**
Retrieve the 90-100 lines of the metadata.csv save as 10line_metadata.csv

<details>
  <summary>Don't cheat</summary>
  
  ```bash
head -n 100 metadata.csv | tail -n 10 > 10line_metadata.csv
  ```
</br></details>

**Task 5:**
Add the header.csv to the top of the 10line_metadata.csv file to create a subset.csv file
<details>
  <summary>Don't cheat</summary>
  
  ```bash
cat header.csv 10line_metadata.csv > subset.csv
  ```
</br></details>

----

### 1.7 Ordering text in files `sort`

The `sort` command allows for files to be sorted, and a number of flags can be used to specify how the sorting should be done. 2 useful flags when sorting formatted data like csv or tsv files are the `-t` flag which indicates the character that separates the columns and the `-k` flag which allows for column selection.

```bash
user@alpha2:~$ sort 5_rows.txt -t "," -k 5  
```

<details>
  <summary>Click me</summary>

  ```bash
UK,UK-NIR,ARDS AND NORTH DOWN,NIRE-0142c6,2021-10-20,NIRE,95,AY.4
UK,UK-NIR,BELFAST,NIRE-014205,2021-10-21,NIRE,95,AY.4
UK,UK-NIR,LISBURN AND CASTLEREAGH,NIRE-0142b8,2021-10-21,NIRE,95,AY.4
UK,UK-ENG,LANCASHIRE,QEUH-28B7D30,2021-10-27,SANG,96,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E764B,2021-10-28,SANG,96,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E7A4F,2021-10-28,SANG,96,AY.4
UK,UK-ENG,NOTTINGHAMSHIRE,ALDP-28B5163,2021-10-28,SANG,96,AY.4
UK,UK-ENG,NOTTINGHAMSHIRE,ALDP-28B80FA,2021-10-28,SANG,96,AY.4
UK,UK-ENG,EAST RIDING OF YORKSHIRE,QEUH-28E3946,2021-10-31,SANG,97,AY.4
UK,UK-ENG,NORTHAMPTONSHIRE,MILK-28E97EC,2021-10-31,SANG,97,AY.4
  ```
</br></details>

By specifying the separator as a `,` and setting `-k 5`, we have sorted the file according to the 5 column of the csv file. By default the order is ascending, but the `-r` flag can be used to invert this behaviour to descending.

`sort` can also be used with the `-u` flag to make the sorted output unique (i.e it is similar to sorting a file and then piping the output to `uniq`)

----

**Task 6:**
Use `head` to retrieve the first 10 lines of the metadata.csv file and then sort the output on the 3th column.

<details>
  <summary>Don't cheat</summary>

  ```bash
head -n 10 metadata.csv |  sort -t "," -k 3
  ```
</br></details>


----


### 1.8 Selecting column with `cut`
The `cut` command allows for the selection of sections of files (such as a column, byte, or field). Similar to `sort`, `cut` takes a delimiter/separator flag (`-d`) and a flag to specify which type of `cut` operation you want to use (`-c` for characters, `-f` for fields/named columns, and `-b` for bytes). 

```bash
user@alpha2:~$ cut -d"," -f1,5 5_rows.txt 
```

<details>
  <summary>Click me</summary>

  ```bash
UK,2021-10-31
UK,2021-10-28
UK,2021-10-31
UK,2021-10-28
UK,2021-10-21
UK,2021-10-21
UK,2021-10-20
UK,2021-10-28
UK,2021-10-27
UK,2021-10-28
  ```
</br></details>


The `-f` flag takes lists of columns using `,`, or `-` so multiple columns can be selected. 


----

### 1.9 Filtering duplicates with `uniq` (Unique)
`uniq` allows for filtering of duplicate parts of a file (but only where the lines follow each other). At its most basic, `uniq` with used with no flags will output only unique lines of a sorted file. We can see this in action by selecting the first column

```bash
user@alpha2:~$ cut -d "," -f 2 5_rows.txt| sort | uniq

UK-ENG
UK-NIR
```
By sorting the continent column, duplicate continent labels can be filtered by `uniq` since they will appear after each other. Try the command again without the `sort` to see how this behaviour changes.

The argument `-c` can be used with `uniq` to count the number of occurrences:

```bash
user@alpha2:~$ cut -d "," -f 2 5_rows.txt| sort | uniq -c
      7 UK-ENG
      3 UK-NIR
```


----

### Task 7
Use `head` to retrieve the first 1000 lines of the metadata.csv file (excluding the header), retrieve the 2st column and count the number of unique occurrences of the entries.

<details>
  <summary>Don't cheat</summary>

  ```bash
tail +2 metadata.csv | head -n 1000 | cut -d"," -f2 | sort | uniq -c
  ```
</br></details>


----

## 1.13: `sed` (Stream Editor)
`sed` is a command that allows for editing of a text stream. It allows for printing, deleting and replacing of regular expressions, words or characters in text streams like files. `sed` takes a string that specifies how the incoming text should be processed. For printing the `p` character can be used with a number (which indicates a line number) or a range (indicates a line range). By default the entire contents of the input stream will be printed, but this can be suppressed using the `-n` flag.

```bash
user@alpha2:~$ sed -n "1p" metadata.csv 
country,adm1,adm2,central_sample_id,collection_date,sequencing_org_code,epi_week,lineage

user@alpha2:~$ sed -n "1,5p" metadata.csv 
country,adm1,adm2,central_sample_id,collection_date,sequencing_org_code,epi_week,lineage
UK,UK-SCT,GLASGOW,QEUH-2A6D335,2021-11-13,SANG,98,AY.4.2
UK,UK-SCT,GLASGOW,QEUH-2A53806,2021-11-12,SANG,98,AY.43
UK,UK-SCT,GLASGOW,QEUH-2A35B7A,2021-11-12,SANG,98,B.1.617.2
UK,UK-SCT,GLASGOW,QEUH-2A35B2F,2021-11-11,SANG,98,AY.4
```

The `d` character can be used to delete lines in a similar manner. Here we delete the first line of the file before piping it to head to show that the firt line is no longer the header. `-n` is not needed here since we are wanting everyting that has not been deleted.

```bash
user@alpha2:~$ sed "1d" metadata.csv | head -n 1
UK,UK-SCT,GLASGOW,QEUH-2A6D335,2021-11-13,SANG,98,AY.4.2
```
Important to note as well, `sed` does not be default change the contents of the original file, unless the `-i` flag is used.

The `s` character is used to indicate a string substitution, with slashes used to indicate the search term followed by the replacement term. 

```bash
user@alpha2:~$ head -n 1 subset.csv | sed -n 's/country/COUNTRY/p'    
COUNTRY,adm1,adm2,central_sample_id,collection_date,sequencing_org_code,epi_week,lineage
```

Numbers can be used after the last `/` to indicate what instance of the string should be changed (for example if you only want to substitute the second occurrence of a word). The `g` character can also be place here to indicate that the change should be made globally (be default, `sed` only changes the first instance). Regular expressions can be used with `sed` as well to capture more complex patterns to substitute.


----
 
 
### Task 8
Get the lines from the metadata.csv that have UK-SCT in them, substitute UK-SCT for Scotland, then save the output to another file.

<details>
  <summary>Don't cheat</summary>

  ```bash
sed 's/UK-SCT/Scotland/' metadata.csv > modified_metadata.csv
  ```
</br></details>


----

## 2. Bash shell scripts

### 2.1.What is a Shell Script?

* A **shell script** is a text file containing a sequence of Unix/Linux commands.
* Scripts typically start with a **shebang** (`#!`) followed by the path to the shell (e.g., `#!/bin/bash`).
* If no shebang is included, the script is run using the current shell.
* Any command available in the user's `PATH` can be used (i.e., a list of directories the system checks).
* Commands are executed **sequentially** unless control structures (like `if`, `while`, or `for`) are used.



### 2.2 Why Write Scripts?

* Automate repetitive tasks (e.g., data filtering, renaming files).
* Ensure reproducibility.
* Simplify complex data workflows.
* Schedule jobs on high-performance clusters.



### 2.3 Text Editor `nano`

In linux, there are a number of text editors (`nano` and `vim` are two included examples) that allow the user to open files and type text on the command line. These operate similarly to traditional text editors you might use like Notepad, but often require the use of a number of key combinations(**macros**) to do common operations like save or even exit the editor. `nano` is an editor that is (relatively) easy to use. We can use `nano` to create new text files, or open existing ones as follows:


```bash
user@alpha2:~$ nano new_file.txt
```

Your terminal should now look as follows once you have typed "Here is some text I want to save":

```
GNU nano 4.8                                                                                                          

Here is some text I want to save.


                                                                                             [ New File ]
^G Get Help       ^O Write Out      ^W Where Is       ^K Cut Text       ^J Justify        ^C Cur Pos        M-U Undo          M-A Mark Text     M-] To Bracket    M-Q Previous      ^B Back           ^◀ Prev Word      ^A Home
^X Exit           ^R Read File      ^\ Replace        ^U Paste Text     ^T To Spell       ^_ Go To Line     M-E Redo          M-6 Copy Text     ^Q Where Was      M-W Next          ^F Forward        ^▶ Next Word      ^E End
```

`nano` displays the commonly used macros at the bottom of the interface. The user can otherwise type the contents of the file as they wish and save once they are done with Ctrl+O followed by Enter and  Ctrl+X to Exit.


**Task 9:** Open a text file with `nano`, add some text, save the file and exit `nano`.



### 2.4 Your First Script

Open `nano` on the command line and copy or write the following three lines of code.

```bash
#!/bin/bash
# This is our first script
echo "Hello World"
```

The first line of code is the shebang, so the script knows where to find the command line interpreter.
The second line with the # is just a comment. It is good practice to comment your code so that
you and others that look at it, can understand what it is meant to do.
The third line is asking for the words "Hello World" to be printed.

**Task 10:** Save this in a file called `hello.sh`, then run it:

```bash
chmod +x hello.sh
./hello.sh
```

The `chmod` command is making your bash script executable. Then you can run the script with `./hello.sh`

### 2.5 Control Flow in Bash


#### 2.5.1 Hardcoding a string into a variable

When bash scripting, you usually want to process a file. The file name can be hardcoded into the script as in the following example:

```bash
#!/bin/bash
filename="sc2.fasta"
echo $filename
```

#### 2.5.2 Accepting Arguments

However, it is usally more useful to write a script where the files to be processed can be provided on the command line allowing for the script to work with different file names.
Open `nano` and save the following lines as `script.sh`

```bash
#!/bin/bash
echo $1
echo $2
```

Make the script executable and  and run with:

```bash
./script.sh file1.txt file2.txt
```

**Task 11:** Modify your `hello.sh` so that you accept two arguments from the command line in the following order: name and surname. Then print them out the surname first then the name. 

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
name=$1
surname=$2
echo $surname $name
  ```

</br></details>

#### 2.5.3 Storing Command Outputs

The output of a command can be stored in a variable within the bash script:

```bash
#!/bin/bash
count=$(grep ">" two_seq.fasta | wc -l)
echo "$count"
```

**Task 12:** Write a script called `count_genes.sh` that takes the genbank file `sarscov2.gb` as input from the command line and counts how many unique gene names the file has. Print out the name of the file and the number of unique gene names.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
filename=$1
count=$(grep "gene=" $filename |  sort | uniq | wc -l)
echo "Number of unqiue genes in $filename is $count"

  ```

</br></details>


#### 2.5.4 Prefix or Suffix Removal using Parameter Expansion


We often want to use a modified input filename as an output filename to record the results from the bash script.
The following commands enable the prefix or suffix of a filename to be removed.
`${var#pattern}` remove shortest match from the beginning (prefix)
`${var%pattern}` remove shortest match from the end (suffix)

For example, the following would remove the `.csv` extension of the `metadata.csv` and replace it with `.txt`:

```bash
#!/bin/bash
input="metadata.csv"
echo ${input%.csv}.txt

```

**Task 14:** Modify your script `count_genes.sh` so that it save the number of genes in a file called `sarscov2_gene_count.txt`

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
filename=$1
count=$(grep "gene=" $filename |  sort | uniq | wc -l)
echo $count > ${filename%.gb}_gene_count.txt

  ```

Check that the file `sarscov2_gene_count.txt` has been created and with `more sarscov2_gene_count.txt` check that it has `11`.

</br></details>

