FROM rocker/geospatial

WORKDIR /usr/src

# COPY . .

RUN R -q -e 'install.packages("bookdown")'
RUN R -q -e 'devtools.install(".")'
# RUN R -q -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")' && mv _book /public
