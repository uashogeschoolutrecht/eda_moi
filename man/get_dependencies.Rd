% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_requirements.R
\name{get_dependencies}
\alias{get_dependencies}
\title{Get dependcencies from an Rmd or list of Rmd files}
\usage{
get_dependencies(path = NULL, install = FALSE, type = "Rmd")
}
\arguments{
\item{path}{Character vector pointing to a path or list of paths}

\item{install}{Logical, defaults to FALSE, if set to TRUE,}

\item{type}{dependencies that are not part of the base R installation will be attempted to be installed}
}
\value{
A df_tbl object with information  on the dependencies found
}
\description{
Get dependcencies from an Rmd or list of Rmd files
}
