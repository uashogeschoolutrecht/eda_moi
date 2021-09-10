## this is my first R script

print("Hello World!")


x <- c(1:10)
x
get(x)

deparse(quote(x))

library(gapminder)
data("gapminder")

name <- deparse(quote(gapminder))



 
write_to_csv <- function(df, path){
  readr::write_csv(
    df,
    file = here::here(
      path,
      paste0(deparse(substitute(df)), ".csv")
    )
  )
}
write_to_csv(df = gapminder, path = "data")


