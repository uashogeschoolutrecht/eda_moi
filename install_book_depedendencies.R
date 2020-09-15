## install all dependencies listed in the DESCRPTION file

## install github packages
remotes::install_github("uashogeschoolutrecht/toolboxr");
# remotes::install_github("uashogeschoolutrecht/citrulliner");
remotes::install_github("uashogeschoolutrecht/gitr")

## read file with dependencies:
deps <- readr::read_lines(
  here::here(
    "DEPENDENCIES.txt"
  )
)

safe_install <- purrr::safely(install.packages)


.rs.restartR()

setRepositories() ## choose

## install.packages(deps, dependencies = TRUE)

devtools::install(".")
