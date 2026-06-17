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

You should see is your command prompt change from:

**(base) courseNN@alpha2:~$**

To:

**(test-env) courseNN@alpha2:~$**






