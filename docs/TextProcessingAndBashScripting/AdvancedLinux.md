

# Practical 2: Advanced Bash Scripting and Control Structures


## Overview

Often bash scripts are created as a way to automate tasks. Bash scripts are small files that contain a series of bash commands and can be run from the command line. The scripts can take arguments like filenames, can perform repeated operations using loops, and can allow for easily reproducible execution of operations.


This practical focuses on more advanced Bash scripting techniques to automate common tasks, with an emphasis on control flow and logic. You'll learn how to:
- Use loops and conditionals
- Accept arguments and store command outputs
- Perform string manipulations
- Apply these to real-world bioinformatics problems


---

## 1: Loops

### 1.1 `for` Loop

Loops are a fundamental aspect of most programming languages, and are necessary for automating tasks. Loops in bash come in 3 different forms: `for`, `while` and `until` loops.


```bash
names='Alice Bob Charlie'
for name in $names
do
  echo $name
done
```

Another way of writting the above that is a bit more solid.

```bash
names=("Alice" "Bob" "Charlie")
for name in ${names[@]}
do
  echo $name
done


```bash
for file in fastq_sets/*.fq
do
  echo $file
done
```


```bash
##A bash for loop through the number range 1-3
for number in {1..3}
do
  echo $number
done
```

**Task 1:** Loop through files in current directory and print the file name and their line counts.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for file in ./*
do 
  wc -l $file
done

  ```

How would you change this script to work on any input specied directory?

</br></details>

#### Task 3
Make a bash script that uses a `for` loop to print numbers from 50-55.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for number in {50..55}
do
  echo $number
done

  ```

</br></details>



---

### 2.2 `while` and `until` Loops

`while` loops can be used when an action should be repeated until a given condition is met. Common conditions in `while` loops are less than (denoted by `-lt`), greater than (`-gt`), equal to (`-eq`), greater than or equal to (`-ge`) and less than or equal to (`-le`). Here we use double brackets to increment the value of `i` so that the loop does not run forever.

```bash
i=1
while [ $i -lt 10 ]
do
  echo $i
  ((i++))
done
```

The `until` loop is identical to the while, and is mostly a semantic change to make the bash script easier to understand. The example below produces the same output as the `while` loop, but since we are looping until `i>=10`, we need to change our comparison operator to `-ge` instead of `-lt`

```bash
i=1
until [ $i -ge 10 ]
do
  echo $i
  ((i++))
done
```

**Task 4:** Print numbers 10 to 15 using a loop.


<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for number in {10..15}
do
  echo $number
done

  ```

</br></details>



---

## 3: If/Else Statements

Sometimes we will want to complete certain task only if a condition is met. To do this in a bash script, we use `if` statements. Similar to the `while` condition, an `if` condition will only execute the commands if the condition is met. All if statements begin with `if`, followed by the condition. If there are multiple conditions, an `elif` or an `else` statement can be used to capture this. All if statments are concluded with a `fi` statement. **The spaces next to the square brackets are an import part of the syntax.** 

```bash
i=1
if [ $i -eq 1 ]; then
  echo "i == 1"
else
  echo "i != 1"
fi
```

### String Conditions

For checking string equality, the syntax in bash is a little different. The comparison operators are different, and depending in the syntax used the structure if the if is also a little altered. Below are 2 different methods to do a string comparison, as well as a way to check for substrings inside a string with the wildcard syntax.
```bash
#!/bin/bash

##An if condition that prints "i == 1" if i == 1
i="Hello"
j="Goodbye"

#The first method uses a single [] in the if, with equality being the `=` symbol
if [ "$i" = "$j" ]
then
  echo "i and j are the same string!"
else
  echo "i and j are different strings"
fi

#The second way uses a double [] in the if, with equality being the `==` symbol
if [[ $i == $j ]]
then
  echo "i and j are the same string!"
else
  echo "i and j are different strings"
fi

i="Hello and Goodbye"

#Check string contains other string with wildcard
if [[ $i == *"Goodbye"* ]]
then
  echo "i contains goodbye"
else
  echo "i does not contain goodbye"
fi

```




**Task 5:**
Make a bash script that uses eith `for` or `while` loop to print the line count of 2 files in the current directory (you can use a break in the for loop to exit the loop early).

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash

count=0
for file in *; do
  [[ -f "$file" ]] || continue

  echo "$file: $(wc -l < "$file") lines"

  ((count++))
  [[ $count -eq 2 ]] && break
done

  ```

Or

  ```bash
#!/bin/bash

files=(*)
i=0
c=0

while (( c < 2 )); do
  f="${files[i++]}"
  echo "$f: $(wc -l < "$f") lines"
  ((c++))
done
  ```

</br></details>


---

## 4: String Manipulation

Extracting substrings from strings is a very common form of string manipulation. In bash, there are multiple ways we can do this. We have seen already how commands like 'awk' and 'cut' can be used to retrieve sections of strings, but bash has its own method of doing this using the `${string_variable:position:length}` syntax. 


```bash
#!/bin/bash
name="metadata.csv"

#Print csv
echo ${name: -3}
#Also print csv
echo ${name: 9}
#Also print csv
echo ${name: 9:3}
```

This syntax allows us to quickly and easily extract sections of strings. This syntax is called parameter expansion and has another trick that is very convenient for when we arent sure of the size of the substring we are extracting (i.e not all file extensions are 3 letters).


```bash
name="alignment.fasta"
echo ${name#*.}  # fasta
echo ${name%.*}  # alignment
```

Parameter expansion allows for specification of a pattern/character to operate around and a character to determine what side of this pattern to operate on (left side is #, rightside %). By specifying `"#*."` we are saying remove everything on the left hand side of the ".". By saying `"%.fasta"` we say remove anythin on the right of `".fasta"`.

### 4.1: Working with filenames `basename`

Sometimes we are working with full file paths (e.g., /home/user/data/file1.txt) and only want the filename (file1.txt). The basename command extracts just the name from a full path.


```bash
#!/bin/bash
path="/home4/VBG_data/BashDatasets/metadata.csv"
echo $path
filename=$(basename "$path")
echo $filename  # Outputs: metadata.csv

```


This is especially useful when looping through files in a directory, because it lets us strip the path and manipulate just the file name.


---

### Task 6
Make a bash script that loops through each file in `/home4/VBG_data/BashDatasets/` directory and prints the file name without the extension, then on the next line print the extension of that file.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash

for file in /home4/VBG_data/BashDatasets/*; do
  fname=$(basename "$file")
  name="${fname%.*}"
  ext="${fname##*.}"

  echo "$name"
  echo "$ext"
done

  ```

</br></details>


---

## 5: Automating Quality Control


Now we can use the skills from above to make a script to automate some quality control for a set of fastq files. We are going to use the `FastQC` and `TrimGalore!` package to run some quality control checks on our sequences. `As a reminder, TrimGalore!` is a `perl` package that links together the `cutadapt` and `fastqc` packages to make a pipeline that trims sequence reads of their adaptor sequences and removes low quality reads. We can call the package as follows:

```bash
user@alpha2:~$ trim_galore [-flags] [-files]
```
`TrimGalore!` only runs `fastqc` on the trimmed output files, so we may also want to run `fastqc` on the files before they are trimmed.


```bash
user@alpha2:~$ fastqc filename
```

`TrimGalore!` will automatically check for adaptor type, but this can be specified with the `--illumina`, `--nextera` or `--small_rna` flags.  


### 5.1 Creating output directories

When writing scripts that generate results, it's often useful to create a directory for each sample or for storing all outputs in one place.

To make sure a directory exists, you can use:

```bash
user@alpha2:~$ mkdir -p output/result1
```

`-p` means “make parent directories as needed”.
It won’t complain if the directory already exists — this makes it safe to use in loops and scripts. You’ll use this approach in Task 8 to create a results/ folder for each sample before writing trimmed reads and quality reports.



---

### Task 7
Make a bash script that loops through each file in the `/home4/VBG_data/BashDatasets/fastq_data/`, checks if the file is illumina or nextera based on the name, runs `fastqc` on the files, then runs `trim_galore` and uses the correct parameters based on the filetype.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash

DATA_DIR="/home4/VBG_data/BashDatasets/fastq_data"

for file in "$DATA_DIR"/*.fastq.gz; do
  echo "Processing $file"

  # Run FastQC before trimming
  fastqc "$file"

  # Determine adaptor type
  if [[ "$file" == *illumina* ]]; then
    echo "Detected Illumina file"
    trim_galore --illumina "$file"

  elif [[ "$file" == *nextera* ]]; then
    echo "Detected Nextera file"
    trim_galore --nextera "$file"

  else
    echo "Unknown adaptor type, using auto-detection"
    trim_galore "$file"
  fi
done

  ```

</br></details>


### Task 8 
This time process the paired-end reads in `/home4/VBG_data/BashDatasets/fastq_data/paired_end`. You can use autodetect adaptors in trim_galore. These are paired-end reads so you will need to use string manipulation to process them as a pair. There are many ways to do this. I would suggest looping through the `*_1.fq` files and then modifying the string for the second pair. Output the files in a directory called `results` labelled according to the filename.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash

DATA_DIR="/home4/VBG_data/BashDatasets/fastq_data/paired_end"
RESULTS_DIR="results"

mkdir -p "$RESULTS_DIR"


for r1 in "$DATA_DIR"/*_1.fq; do
  # Derive R2 filename by replacing _1.fq with _2.fq
  r2=${r1%_1.fq}_2.fq

  echo "Processing pair:"
  echo "R1: $r1"
  echo "R2: $r2"

  # Extract sample name (remove path and _1.fq suffix)
  base=$(basename "$r1")
  filename=${base%_0_1.fq}
  sample_dir="$RESULTS_DIR/$filename"


  # Run FastQC on both
  fastqc "$r1"
  fastqc "$r2"

  # Run TrimGalore! with autodetection in paired-end mode
  trim_galore --paired "$r1" "$r2" --output_dir "$sample_dir"
done

  ```

</br></details>


## 6: Basic integer arithmetics

Use the built-in `$((...))` syntax:

```bash
a=5
b=3
sum=$((a + b))        # Addition
diff=$((a - b))       # Subtraction
prod=$((a * b))       # Multiplication
div=$((a / b))        # Division (integer only)
mod=$((a % b))        # Modulus (remainder)

echo "Sum: $sum"
```

This only works with integers. 
Bash itself doesn't support decimals, but you can use `bc` (basic calculator).
This can be quite useful when combined with other command line tools.

### Task 10
Write a script that calculates the number of reads in a fastq file.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
file="$1"

# Count the number of reads
# Each read in FASTQ is 4 lines
lines=$(wc -l < "$file")
reads=$((lines / 4))

echo "Number of reads in '$file': $reads"


  ```

</br></details>

# Practicing bash

### Task 11 
Write a script that reverse complements a sequence

### Task 12
Improve your script so that it works with a file provided from the command line

### Task 13
Further improve your script so that it checks that there is a single sequence in your fasta file, if not it returns an error message.

### Task 14
Write a script that converts a fastq file to a fasta file with the input and output filenames pprovided on the command line.

### Task 15
Write a script that counds the number of sequences in a file. The input can be either fasta or fastq. So first check what the extension is and count the number of sequences accordingly.

### Task 16
Write a script that loops through all fastq files in a directory, for example: `fastq_data` and counts the number of reads in each file.
