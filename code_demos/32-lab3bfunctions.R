## ---- eval=FALSE---------------------------------------------------------
## df$var_a[df$var_a ==  999] <- NA
## df$var_b[df$var_b == -999] <- NA
## df$var_h[df$var_h == -999] <- NA
## df$var_i[df$var_j == -989] <- NA
## df$var_j[df$var_j == -999] <- NA
## df$var_o[df$var_n == -988] <- "NA"
## ## there are at least 5 errors in this code


## ------------------------------------------------------------------------
df <- tibble(a = c(1:9, -999), 
             b = c(1:5, -999, -999, 8:10),
             c = LETTERS[1:10])
df


## ------------------------------------------------------------------------
replace_x_for_na <- function(x){
  
  x[x == -999] <- NA
  return(x)
}


## ------------------------------------------------------------------------
df$a
replace_x_for_na(df$a)


## ------------------------------------------------------------------------
df_new <- purrr::modify_if(df, is.numeric, replace_x_for_na)
df_new

## or using the pipe %>%
df_new_pipe <- df %>%
  purrr::modify_if(is.numeric, replace_x_for_na) 
df_new_pipe


## ------------------------------------------------------------------------
set.seed(1234)
test_numeric <- rnorm(100)
test_non_numeric <- c("Wolf", "Deer", "Cayote", "Tiger")


## ---- eval=FALSE, echo=TRUE----------------------------------------------
## 
## calculate_mean <- function(numeric_vector){
## 
##   # step 1: test if argument is numeric, `stop()` if not
## 
##     # model for step 1
##   if(is.numeric(numeric_vector)){
##     message("write a clear message what the function is doing with the input here")
##   } else {
##     stop("write the error stop message here")
##   }
## 
##   # step 2: calculate the sum of 'numeric_vector'
##   # step 3: determine the length of 'numeric_vector'
##   # step 4: divide sum by length
##   # step 5: return result of the function with `return(result)`
## 
## }


## ---- eval=FALSE---------------------------------------------------------
## 
## calculate_mean <- function(numeric_vector){
## 
## # step 1:
##   if(is.numeric(numeric_vector)){
## 
##      message("input vector is numeric. Calculating mean over argument")
## 
##    } else {
##     stop("input vector is not numeric, cannot determine mean over non-numeric arguments, quitting.")
## 
##     }
## 
## # step 2:
##   sum <- sum(numeric_vector)
## 
## # step 3:
##   length <- length(numeric_vector)
## 
## # step 4:
##   mean <- sum/length
## 
##   return(mean)
## 
## }
##  set.seed(1234)
## test_numeric <- rnorm(100)
## test_non_numeric <- c("Wolf", "Deer", "Cayote", "Tiger")
## calculate_mean(test_numeric)
## calculate_mean(test_non_numeric)


## ---- eval=FALSE, include=FALSE------------------------------------------
## calculate_mean_extended <- function(vector) {
## 
## # step 1:
## 
##   if(is.numeric(vector)){
##      message("Argument is numeric, calculating mean")
##   }
## 
##   if(is.integer(vector)){
##      message("Argument is an integer, calculating mean")
##   }
## 
##   if(is.logical(vector)){
##      message("Argument is a logical. Converting 'FALSE' to 0 and 'TRUE' to 1, calculating average of zeros and ones. A value of >0.5 will mean that there are more TRUEs than FALSEs in the vector. A value of <0.5 will mean that there are more FALSEs than TRUEs")
##   }
## 
##   if(is.character(vector)){
##     stop("argument is a character (vector). Cannot calculate mean over a vector of elements of type 'character'", call. = FALSE)
##   }
## 
## # step 2:
##   sum <- sum(vector)
## 
## # step 3:
##   length <- length(vector)
## 
## # step 4:
##   mean <- sum/length
## 
##   return(mean)
## }
## 
## 
## vector_1 <- c(1:4)
## vector_2 <- c("Tiger", "Wolf", "Zebra")
## vector_3 <- c(1.3, 1.6, 4.6, 7.8)
## vector_4 <- as.logical(c(0,1,1,1,1,1,0,0,0,0,0,1,0))
## vector_5 <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
## 
## is.numeric(vector_1)
## is.integer(vector_1)
## is.character(vector_3)
## 
## calculate_mean_extended(vector_1)
## calculate_mean_extended(vector_2)
## calculate_mean_extended(vector_3)
## calculate_mean_extended(vector_4)
## calculate_mean_extended(vector_5)
## 


## ---- eval=FALSE---------------------------------------------------------
## sum_integers <- function(integer_1, integer_2){
## 
##   if(length(integer_1) == length(integer_2)){
##   } else {
##   message("integer arguments are not of the same length, recycling the shortest integer to calculate sum")
##   }
## 
##   sum_integers <- integer_1 + integer_2
##   return(sum_integers)
## 
## }
## 
## # equal length
## sum_integers(integer_1 = c(1L:5L), integer_2 = c(11L:15L))
## # onequal lenght
## sum_integers(integer_1 = c(1L:5L), integer_2 = c(10L:35L))
## # check function with existing function `sum()`
## sum(integer_1 = c(1L:5L), integer_2 = c(10L:35L))


## ------------------------------------------------------------------------

is_integer_present <- function(vector, integer){

  stopifnot(!is.character(vector))
  
  integer_present <- vector == integer
  true_false <- any(integer_present)

  return(true_false)
  }

is_integer_present(vector = c(1:40), integer = 39)


## ---- eval=FALSE, include = FALSE----------------------------------------
## library(tidyverse)
## 
## print_colnames_and_types <- function(df){
## 
##   if(!is.data.frame(df)){
##     stop("input must be of class 'data.frame'")
##   } else {
## 
##   names_vars <- names(df)
##   types_vars <- unlist(lapply(df, typeof))
##   }
## 
##   result <- tibble(names_vars, types_vars)
##   return(result)
## }
## 
## # create tibble to check function
## first_var = as.numeric(1:10)
## second_var = letters[1:10]
## third_var = as.logical(1:10)
## test_df <- tibble(first_var, second_var, third_var)
## 
## is.list(test_df)
## is.data.frame(test_df)
## print_colnames_and_types(test_df)
## 
## # create list to check function error message
## a = as.numeric(1:10)
## b = as.numeric(11:20)
## d = as.numeric(21:30)
## list <- list(a, b, d)
## typeof(list)
## print_colnames_and_types(list)
## 
## # create matrix to check function error message
## matrix <- as.matrix(cbind(a, b, d))
## print_colnames_and_types(matrix)
## names(matrix)
## is.matrix(matrix)


## ------------------------------------------------------------------------
f1 <- function(string, prefix) {
  substr(string, 1, nchar(prefix)) == prefix
}

f2 <- function(x) {
  if (length(x) <= 1) return(NULL)
  x[-length(x)]
}

f3 <- function(x, y) {
  rep(y, length.out = length(x))
}


## ---- eval=FALSE, include=FALSE------------------------------------------
## greetings <- function(){
## 
## now <- lubridate::now("UTC-2:00")
## now <- unlist(stringr::str_split(now, pattern = " "))
## now <- now[2]
## 
## if(now <= "12:00:00" & now >= "05:00:00"){cat("Good Morning!")}
## if(now > "12:00:00" & now <= "18:00:00"){cat("Good Afternoon!")}
## if(now > "18:00:00" & now <= "23:00:00"){cat("Good Evening!")}
## if(now > "23:00:00" & now < "05:00:00"){cat("Good Night!")}
## }
## 
## greetings()

