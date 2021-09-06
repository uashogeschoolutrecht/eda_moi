This repo is the basis for the bookdown reader of the "Exploratory Data Analysis & Data Mining" Course of the Master of Informatics at HU University of Applied Sciences, Utrecht, The Netherlands.

## Licence
The materials in this repo are under CC BY-NC 4.0 licence. Meaning you can use and adapt these materials for non-commercial ends as long as you provide proper credits and attribution to the copyright holder and the referenced sources (Marc A.T. Teunis, HU - 2021).

## Perequisites

### R and RStudio
The repo was developed to work with R version above or equal to version 4.0. If you want to learn which R packages are used as dependencies, you can take a look at the DESCRIPTION file in this repo.
We advise developing and working with R in RStudio. You can download R and RStudio from these links:

 - [R](https://cran.r-project.org/)
 - [RStudio](https://cran.r-project.org/)

### Memory and System specifications
To run the code in this repository we recommend a system with at least 8 cores and 16 Gb of RAM. Building of the reader could consume even more resources and was preformed on a UBUNTU Virtual Machine running R Version: `4.1.1 (2021-08-10) -- "Kick Things"` and RStudio Version: `Version 1.4.1717` . This machine had 

### Docker
To work with Docker you need to have a Docker Deamon installed. See the [Docker](https://www.docker.com/) homepage for more details

### Git
To work with Git and to be able to clone repositories you need Git installed. See the [Git](https://git-scm.com/) homepage for details.

### R package `{devtools}`
In order to install the edamoi as a package, you need to have the R packages `{devtools}` and `{rmarkdown}` available from your R environment. Run `install.packages(c("devtools", "rmarkdown))` from the R Console to install it. Please be aware that for Linux based OS you will probably need underlying system dependencies to install `{devtools}`. Refere to the [Public RStudio Package Manager page for `{devtools}`](https://packagemanager.rstudio.com/client/#/repos/1/packages/devtools), to find the system requirements for your OS. 

## Getting started
This repo is basically an R package and a bookdown site. To provide a reproducible way to deploy the content on your preferred device/online, a Dockerfile is also included. The Dockerfile defines a Docker image that can be used to run and further develop the materials in RStudio and to build the bookdown site. If you are familiar with Docker, I advise you to look at section [Docker](##Docker). Below a step-wise instruction on how to get the materials and how to build the book. These steps assume you have all prerequisites listed above.

 - A1. Clone the edamoi repo by running `git clone https://github.com/uashogeschoolutrecht/redamoi`. Pay attention that you are in a location where you want the folder 'redamoi' to land. For example 'Users/myname/myRprojects/'
 - A2. Go to RStudio and initiate a new RStudio project from the redamoi folder you created in step 1
 - A3. From the R Console (the R command line) in your 'redamoi' RStudio Project, run `devtools::install(".")`. This installs all neccessary requirements (R package dependencies) for the bookdown project. This will enable you to build the reader for the course locally and run all the code.
 - A4. When all dependencies are installed, you will see a notification on the R Console that should look something like this:
 ```
 Running /usr/local/lib/R/bin/R CMD INSTALL /tmp/RtmpYatPJy/edamoi_0.2.tar.gz \
 --install-tests 
 * installing to library '/home/rstudio/R/aarch64-unknown-linux-gnu-library/4.0'
 * installing *source* package 'edamoi' ...
 ** using staged installation
 ** R
 ** data
 ** inst
 ** byte-compile and prepare package for lazy loading
 ** help
 *** installing help indices
 ** building package indices
 ** testing if installed package can be loaded from temporary location
 ** testing if installed package can be loaded from final location
 ** testing if installed package keeps a record of temporary installation path
 * DONE (edamoi)
 ``` 
 If you experience any problems with this step, create an issue in this repo explaining what happended and we will try to reach out to solve it.
 
 - A5. You are now ready to build the bookdown site locally. Run `bookdown::render_book(".")` in the R Console. This will genererate a stand alone html site version of the reader in a folder called '\_book'. You can view the bookdown site by opening the '\_book' folder and opening the 'index.html' file in a browser.  



## Docker
For users that want to create a Docker container running RStudio with a compatible version of R and all the dependencies as well as a pre-build version of the bookdown reader already available in the container:

 - B1. Install a Docker Deamon (easiest is Docker Desktop for your OS). See the 'Prerequisites' section for details
 - B2. Clone the repo 'redamoi' to a local dir
 - B3. From the Terminal (inside the redamoi cloned dir you created in step B2) run: 
 ```
 docker build . -t redamoi
 ```
 This will build the required Docker image locally. Once finished you will be able to run the container with the next command.
 - B4. To run the Docker container with the contents of the repo mounted inside the container run: 
 ```
 docker run -d -p 8787:8787 -v <full_path_to_local_redamoi_cloned_dir>:/home/rstudio -e PASSWORD=abcd redamoi
 
 ```
 Change the password if you like. You will now be able to login into the running Docker container by pointing your webbrowser to local address: `http://localhost:8787/`. Login with username `rstudio` and password `<your_password_of_choice>`. 
 
There are many more options to the `docker run` command. See the [Rocker project](https://www.rocker-project.org/) or [Rocker on Docker Hub](https://hub.docker.com/r/rocker/rstudio) for more use cases. 
 
The base image for the Docker image used here was derived from this repo: https://github.com/elbamos/rstudio-m1. It is optimized for users on Mac with M1 Apple Silicon Chipset. I have not tested this Docker image on other OS or Mac Intel. Please file an issue if you are experiencing any problems.


