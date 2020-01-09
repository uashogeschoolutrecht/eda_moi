## ---- echo=FALSE, results='hide'-----------------------------------------
data(package = "datasets")


## ---- echo=FALSE, results='hide'-----------------------------------------
data(package = "datasets", "Titanic")
titanic <- Titanic %>% as_tibble
head(titanic, 3)


## ---- include=FALSE------------------------------------------------------
library(mlbench)
## to load Boston Housing Dataset
data("BostonHousing", package = "mlbench")


## ------------------------------------------------------------------------
# BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")
library(BSgenome.Hsapiens.UCSC.hg38)


## ---- eval=FALSE---------------------------------------------------------
## data(package = "rattle.data")
## help(wine, package = "rattle.data")


## ------------------------------------------------------------------------
data(package = "rattle.data", "wine")


## ---- echo=FALSE, results='hide', fig.show='hide'------------------------
names(wine)
pca_data <- wine[,c(-1)] %>% 
  log10(.) %>%
  stats::prcomp(.,
                center = TRUE,
                scale = TRUE) 

pca_data$x %>%  
  as_tibble() %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point() +
  theme_bw() 


## ---- echo=FALSE, results='hide'-----------------------------------------
labels <- wine[,1]
pca_data$x %>%  
  as_tibble() %>%
  mutate(Type = labels) %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = Type)) +
  theme_bw() 


## ------------------------------------------------------------------------
url <- "https://ckan.dataplatform.nl/dataset/7dc70520-1653-49f6-a251-c95939bb6962/resource/e16e9af3-8dbc-4f82-aecf-1c69b628c81d/download/meldingen2015open-data.csv"

download.file(url = url, destfile = here::here(
  "data",
  "meldingen2015open-data.csv"
))


## ------------------------------------------------------------------------
meldingen2015open_data <- read_csv(here::here(
  "data",
  "meldingen2015open-data.csv"
))


## ------------------------------------------------------------------------
names(meldingen2015open_data)

meldingen2015open_data %>%
  group_by(Hoofdcategorie, Wijk) %>%
  tally() %>%
  ggplot(aes(x = reorder(as_factor(Hoofdcategorie), n), y = n)) +
  geom_point(aes(colour = Wijk)) +
    coord_flip()


## ------------------------------------------------------------------------

## the file is already unzipped with this command:
# unzip(zipfile = here::here(
#   "data",
#   "doi_10.5061_dryad.g9s1d__v1.zip"), 
#   exdir = here::here(
#   "data"))

## to load an .RData binary file we can use the load() function
wolves <- load(
  here::here("data",
             "zst.RData")
) %>%
  as_tibble()

wolves



## ------------------------------------------------------------------------
# install.packages("cbsodataR")
library(cbsodataR)


## ------------------------------------------------------------------------
toc <- cbs_get_toc()
head(toc)

toc$ShortTitle[1:10]

# Downloaden van gehele tabel (kan een halve minuut duren)
data <- cbs_get_data("83765NED")
head(data)

# Downloaden van metadata
metadata <- cbs_get_meta("83765NED")

typeof(metadata)
metadata$DataProperties
head(metadata$TableInfos %>% as_tibble())


