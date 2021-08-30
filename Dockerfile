## Author: Marc A.T. Teunis, PhD, Hogeschool Utrecht, 2021
## Build this container locally after cloning repo:
## https://github.com/uashogeschoolutrecht/eda_moi
## To build run `docker build . -t <tagname>` from the repo root

## Run this container as a webbased instance of RStudio on your local machine and 
## with the current working dir mounted local folder as:

## Image definition:
FROM amoselb/rstudio-m1

## add dependency for devtools
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends --fix-missing \
    libgit2-dev \
    make \
    libv8-dev

WORKDIR /home/rstudio
COPY --chown=rstudio:rstudio . /home/rstudio/
RUN R -q -e 'install.packages(c("bookdown", "devtools", "BiocManager"))'
# RUN R -q -e "devtools::install('.', dependencies=TRUE)"
# RUN R -q -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")' 