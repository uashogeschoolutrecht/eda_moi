## ---- eval = FALSE-------------------------------------------------------
## devtools::install_github("uasghogeschoolutrecht/gitr")


## ---- eval = FALSE, echo=TRUE, results='asis'----------------------------
## setRepositories(graphics=TRUE)


## ---- eval=FALSE, echo=TRUE----------------------------------------------
## install.packages("beanplot")


## ---- echo=TRUE, fig.show='asis', results='asis'-------------------------
library(beanplot)
beanplot(runif(100))

