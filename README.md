This repo is the basis for the bookdown reader of the "Exploratory Data Analysis & Data Mining" Course of the Master of Informatics at HU University of Applied Sciences, Utrecht, The Netherlands.

## Licence
The materials in this repo are under CC BY-NC 4.0 licence. Meaning you can use and adapt these materials for non-commercials ends as long as you provide proper credits and attribution to the copyright holder and the refereced sources (Marc A.T. Teunis, HU - 2021).

## Perequisites

### R and RStudio
The repo was developed to work with R version above or equal to version 4.0. If you want to learn which R packages are used as dependencies, you can take a look at the DESCRIPTION file in this repo.
We advise developing and working with R in RStudio. You can download R and RStudio from these links:

 - [R](https://cran.r-project.org/)
 - [RStudio](https://cran.r-project.org/)

### Docker
To work with Docker you need to have a Docker Deamon installed. See the [Docker](https://www.docker.com/) homepage for more details

### Git
To work with Git and to be able to clone repositories you need Git installed. See the [Git](https://git-scm.com/) homepage for details.

### R package `{devtools}`
In order to install the edamoi as a package, you need to have the R package `{devtools}` available from your R environment. Run `install.packages("devtools")` from the R Console to install it. Please be aware that for Linux based OS you will probably need underlying system dependencies to install `{devtools}`. Refere to the [Public RStudio Package Manager page for `{devtools}`](https://packagemanager.rstudio.com/client/#/repos/1/packages/devtools), to find the system requirements for your OS. 

## Getting started
This repo is basically an R package and a bookdown site. To provide a reproducible way to deploy the content on your preferred device/online, a Dockerfile is also included. The Dockerfile defines a Docker image that can be used to run and further develop the materials in RStudio and to build the bookdown site. If you are familiar with Docker, I advise you to look at section [Docker](##Docker). Below a step-wise instruction on how to get the materials and how to build the book. These steps assume you have all prerequisites listed above.

 1. Clone the edamoi repo by running `git clone https://github.com/uashogeschoolutrecht/eda_moi`. Pay attention that you are in a location where you want the folder 'edamoi' to land. For example 'Users/myname/myRprojects/'
 2. Go to RStudio and initiate a new RStudio project from the edamoi folder you created in step 1
 3. From the R Console (the R command line) in your 'edamoi' RStudio Project, run `devtools::install(".")`. This installs all neccessary requirements (R package dependencies) for the bookdown project.
 4. 



## Docker



