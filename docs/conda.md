# Conda

[Conda](https://anaconda.org) is a package and environment manager that is widely used in bioinformatics, data science, and scientific computing. It is a tool that is capable of:

1. Installing software including all of the software's dependencies
2. Creating isolated environments so different projects can use different software versions without conflicts
3. Enables environment 'recipes' to be easily shared to help other people install and run your tools on their systems


## Why is it called conda?

The name **Conda** comes from **Anaconda**, which was the original scientific Python distribution created by the company now called Anaconda⁠.

The ecosystem ended up with a bit of a snake name theme:

* Anaconda = the full distribution (Python + many scientific packages)
* Conda = the package/environment manager that came with Anaconda
* Miniconda = a minimal installation containing just Conda
* Mamba = a faster reimplementation of Conda
* Micromamba = a lightweight version of Mamba

## Installing conda

We will install the **miniforge** version of conda. Miniforge is a modern Conda installation that uses conda-forge (a community-maintained repository or “channel” of Conda packages) by default and includes the fast Mamba implementation.

First we each need to install miniforge into our home directories, so cd into your home directory

```
cd
```

Now download the miniforge installation script using wget (a command-line program for downloading files from the web):

```
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
```

If you list the contents of the directory you should see the downloaded file Miniforge3-Linux-x86_64.sh:

```
ls
```

And now we install miniforge by running the download bash script - this will take a wee while and involves you responding to questions from the installtion script:

```
bash Miniforge3-Linux-x86_64.sh
```

It will ask: **Please, press ENTER to continue** -> You should press the **Enter** key

It will ask: **Do you accept the license terms? [yes|no]** -> You should type **Yes** and then press **Enter**

It will ask: **Confirm install location: [/home4/courseNN/miniforge3] >>>** -> You should press **Enter**

It will ask: **Proceed with initialization? [yes|no]** -> You should type **Yes** and then press **Enter**

You **must** now wait for the installation to finish and for your prompt to return.

Now we have installed miniforge. But we cant really access it unless we logout and log back in again as the install has changed the scripts run at login. However, we can force the startup script to be 'reloaded' now by typing:

```
source ~/.bashrc
```
The above command only needs to be run once after installation, not every time you use conda miniforge. What you should see is your command prompt change from:

**courseNN@alpha2:~$**

To:

**(base) courseNN@alpha2:~$**

Notice the extra **(base)**, this means that we are now located in the base enviroment of our new conda miniforge installation. When you login your are automatically in the base environment.

We have one more good practice configuration step to do before we start creating our own environments and installing tools and that is to add a few channels and set the priority order:

```
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --set channel_priority strict
```

A conda channel is simply a repository of pre-built software packages. The most important one for bioinformatics is bioconda, and conda-forge is the largest community-maintained repository of Conda packages. Setting channel_priority to strict means that if a certain tool/package is available in more than one of our channels, conda will always prefer the one from the highest priority channel. In our case this is bioconda as when you add a new channel it goes to the top of the priority list.

We can see the channels we have configured/added by typing:

```
conda config --show channels
```

Which should show you:

```
YOU DO NOT NEED TO TYPE THIS - YOU SHOULD SEE IT AFTER TYPING THE ABOVE COMMAND

channels:
  - bioconda
  - conda-forge
```

We are now all set to create an environment and install some tools. So, lets a create a new conda environment called 'test-env', we will use mamba to create it as it is faster than conda:


```
mamba create -n test-env
```

You should see a message that says: **Empty environment created at prefix: /home4/courseNN/miniforge3/envs/test-env**

In order to use an environment we need to **activate** it, slightly confusingly althouhg we use mamba to create and install things, we use conda to activate and deactivate environments:

```
conda activate test-env
```

You should see your command prompt change from:

**(base) courseNN@alpha2:~$**

To:

**(test-env) courseNN@alpha2:~$**


## Recap

We have now installed the miniforge version of conda/mamba and configured our channels - you only need to do this once. We have now created and activated our first enviroment called **test-env** and are ready to install some tools/packages


## Installing tools

Bioconda maintains a website list of avaialable packages/tools to install: [https://bioconda.github.io/conda-package_index.html](https://bioconda.github.io/conda-package_index.html)

The first tool we are going to install is called [seqtk](https://github.com/lh3/seqtk). This is not currently installed on our server, we can check by typing:


```
seqtk
```

You should see a message saying: **Command 'seqtk' not found**

To install seqtk, installation instructions are available on [bioconda](https://anaconda.org/channels/bioconda/packages/seqtk/overview), we type:

```
mamba install -c bioconda seqtk
```

After pressing enter, mamba will display a few dynamic (rapidly updating) messages, followed by a list of packages that need to be installed (seqtk but also the packages that seqtk depends on), but it will eventually ask:

**Confirm changes: [Y/n]** -> Type **Y** then press Enter

Eventually you will see a message saying **Transaction finished** and your command prompt will return

Now if we type **seqtk** we should see seqtk's help message:

```
seqtk
```

A useful command for seeing where a program is actually installed on Linux is the **which** command, if we type:

```
which seqtk
```

You should see something like: **/home4/courseNN/miniforge3/envs/test-env/bin/seqtk** which means seqtk is in the bin folder, of the test-env environemnt, in the envs (enviroments) folder of the miniforge3 folder in our home directory.

seqtk is a really useful program that can do a range of FASTQ/FASTA file manipulations, I use it alot for subsampling reads so lets try that. First we need to copy some example data, so lets do that:

```
cd

cp -r /home4/VBG_Data/Condata .

cd Condata

ls
```

You should see (amongst other things) a FASTQ file called **fmdv.fastq**. Lets randomly subsampe 10,000 reads from this to create a smaller FASTQ file using seqtk:

```
seqtk sample -s 1234 fmdv.fastq 10000 > fmdv_sub.fastq
```
**NB:** here the -s 1234 is a seed we are giving to the random number generator - you could use any number

If we now cant the number of lines in each of the FASTQ files you should see that the new fmdv_sub.fastq file has 40,000 lines corresponding to 10,000 reads:

```
wc -l fmdv.fastq

wc -l fmdv_sub.fastq
```












