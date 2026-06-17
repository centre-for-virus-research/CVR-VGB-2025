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

**course19@alpha2:~$ **

To:

**(base) course19@alpha2:~$ **

Notice the extra **(base)**, this means that we are now located in the base enviroment of our new conda miniforge installation.

