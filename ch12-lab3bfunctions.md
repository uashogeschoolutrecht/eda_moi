# Lab 3B: Functional Programming {#lab3bfunctions}

## Packages

```r
library(tidyverse)
```

```
## -- Attaching packages -------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.2     v purrr   0.3.4
## v tibble  3.0.3     v dplyr   1.0.2
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.5.0
```

```
## -- Conflicts ----------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```


## A case example

**DISCUSS WITH YOUR NEIGHBOUR**

 1. What does the following piece of code do?
 1. Can you find the 'mistakes' that were made in this code?
 1. How would you avoid these mistakes?



```r
df$var_a[df$var_a ==  999] <- NA
df$var_b[df$var_b == -999] <- NA
df$var_h[df$var_h == -999] <- NA
df$var_i[df$var_j == -989] <- NA
df$var_j[df$var_j == -999] <- NA
df$var_o[df$var_n == -988] <- "NA"
## there are at least 5 errors in this code
```
Reference: Example (adapted from): Hadley Wickham, "Expressing yourself_ with R" Lecture  - https://richmedia.lse.ac.uk/methodologyinstitute/20170814_ExpressYourselfUsingR.mp4

When working with R you can:

 - Solve each problem separately (and spend a lot of time debugging and copying pasting)
 - Write small pieces of code (`functions`) that are generalisible to future problems

Let's create some example data and put it in a special data `object` called a data-frame (or a tibble below). A tibble is just a data-frame that prints nicely to the Console. We call the data-frame `df`. The `<-` means that we are `assigning` the tibble on the right to the `variable` on the left.
Always use the `<-` (left-arrow assignment sign) to assign values to a variable. Do not use the `=` sign for this (you will encounter R code that uses the `=` nonetheless. It works but not always).


```r
df <- tibble(a = c(1:9, -999), 
             b = c(1:5, -999, -999, 8:10),
             c = LETTERS[1:10])
df
```

```
## # A tibble: 10 x 3
##        a     b c    
##    <dbl> <dbl> <chr>
##  1     1     1 A    
##  2     2     2 B    
##  3     3     3 C    
##  4     4     4 D    
##  5     5     5 E    
##  6     6  -999 F    
##  7     7  -999 G    
##  8     8     8 H    
##  9     9     9 I    
## 10  -999    10 J
```

Writing a function that replaces 
`a designated number or string` for `NA` (the R-way of indicating a missing value)


```r
## dummies
x <- c(999, 7767, 999, -999)
na_indicator <- "test"

replace_x_for_na <- function(x, na_indicator){
  
  x[x == na_indicator] <- NA
 # string <- "done!"
  return(x)

  
}

test <- c(999, -999, 7, 8)

replace_x_for_na(x = test, na_indicator = 999)
```

```
## [1]   NA -999    7    8
```

Apply this function to one column of our data-frame `df`

```r
df$a
```

```
##  [1]    1    2    3    4    5    6    7    8    9 -999
```

```r
replace_x_for_na(df$a, na_indicator = "-999")
```

```
##  [1]  1  2  3  4  5  6  7  8  9 NA
```

Apply our function to our whole `df`

```r
## or using the pipe %>%
df_new_pipe <- df %>%
  purrr::modify_if(is.numeric, replace_x_for_na, na_indicator = "-999") 
df_new_pipe
```

```
## # A tibble: 10 x 3
##        a     b c    
##    <dbl> <dbl> <chr>
##  1     1     1 A    
##  2     2     2 B    
##  3     3     3 C    
##  4     4     4 D    
##  5     5     5 E    
##  6     6    NA F    
##  7     7    NA G    
##  8     8     8 H    
##  9     9     9 I    
## 10    NA    10 J
```

Good functions

 * Do one thing good
 * Have no 'side-effects'
 * `class(input) = class(output)` (to make the function 'pipe-able')

## EXERCISES {-}

__Write an Rmd file, containing code chunks (if applicable) and answer all the questions below__

## General function model

A function in R takes the general form of:

_`So it takes a function to create a function in R and the R-function it takes is called 'function()'`_

```
some_descriptive_function_name <- function(function_arguments, ...){

 if(some_condition_on_the_argument(s)){ 
   message("some message telling that some condition does 
   meet, concerning the argument")
 } else {
   warning/stop("condition does not meet criteria for agument")
 }
 
  * some operations on the function arguments
  * some more calculations, 
  * maybe reshaping the object or looping or transforming

  return(whatever_the_function_returns)

}
```

## Writing functions is difficult
Note that writing functions is difficult. It has a steep learning curve and it is an essential part of working with R. Spend time on this and you will reward yourself for it in the future if you want to work with (other) programming languages.

## Do not repeat yourself.
Remember! If you find yourself typing the same thing more than two times in R: write a function!!`

### **EXERCISE 1 Write a function that can calculate the "mean()" of a numeric (vector).** {-}
 
 - You are not allowed to use the build-in function `mean()`
 - You may use the preexisting function `sum()` 
 - The function has to provide a `stop()` if the argument is non-numeric and a message if the argument is numeric.
 - Test the function with the two vectors below
 - Name your function: "`calculate_mean()`"


```r
set.seed(1234)
test_numeric <- rnorm(100)
test_non_numeric <- c("Wolf", "Deer", "Coyote", "Tiger")
```

**MODEL**

```r
calculate_mean <- function(numeric_vector){
  
  # step 1: test if argument is numeric, `stop()` if not

    # model for step 1
  if(is.numeric(numeric_vector)){
    message("write a clear message what the function is doing with the input here")
  } else {
    stop("write the error stop message here")
  }

  # step 2: calculate the sum of 'numeric_vector'
  # step 3: determine the length of 'numeric_vector'
  # step 4: divide sum by length 
  # step 5: return result of the function with `return(result)`

}
```




Extending a function with additional options

1B) Build onto the function created at 1A: The function has to return the mean and has to state whether the input is an integer, a numeric  or a logical vector. 

And if the input is character, it has to stop and display an error message

 - Tip, use multiple `if()` statements and an `else()` to accomplish this
 - Maybe use `if()` and `else if()`?
 - Use the following format
 - Note: you can calculate the mean of a logical vector: Each TRUE in the vector will be automatically converted to a 1, each FALSE will be converted to a 0.
 - Use the following vectors to test your extended function
 - Call your function `calculate_mean_extended()`

```
vector_1 <- c(1:4)
vector_2 <- c("Tiger", "Wolf", "Zebra")
vector_3 <- c(1.3, 1.6, 4.6, 7.8)
vector_4 <- as.logical(c(0,1,1,1,1,1,0,0,0,0,0,1,0))
vector_5 <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
``` 

**`if()` MODEL**
```
if(is.numeric(vector)){ 
message("argument is numeric, calculating mean")
}

The if statment will be evaluated, if the statement is TRUE, the message will be displayed  
```



### **EXERCISE 2 Functions with multiple vector arguments** {-}

2A) Create a function that will return the (vectorized) sum of 2 integers.

 * Add a warning for integers that do not have the same length, the function does not need to stop at this.



2B) Create a function that will return TRUE if a given integer is inside a vector.

 * Use is `integer()`
 * Use `lapply()` look up the help on this function with `?lapply`
 * Write a `stopifnot()` if the argument is a character vector  
 

```r
is_integer_present <- function(vector, integer){

  stopifnot(!is.character(vector))
  
  integer_present <- vector == integer
  true_false <- any(integer_present)

  return(true_false)
  }

is_integer_present(vector = c(1:40), integer = 39)
```

```
## [1] TRUE
```

## Function with data.frame input
3) Create a function (called: `print_colnames_and_types()`)that given a data frame, will print to screen the name of the columns and the class of data (in each column) it contains (e.g. Variable1 is Numeric).

 - Remember `typof()`, it can be used to get the type/class of a vector
 - The function `names()` returns the names of a vector, list or data-frame
 - Use `lapply()` and `typeof()` to tackle multiple columns 
 - You can use `unlist()` to unlist the result of `lapply()`
 - Use `tibble()` to generate the final result
 - Do you need a warning or an error message to check the class of the input?
 


### **EXERCISE 4 Understanding what functions do** {-}

4) Read the source code for each of the following three functions, puzzle out what they do, discuss with your neighbor and then brainstorm better names.
    

```r
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
```

### **EXERCISE 5 Conditional functions** {-}

Write a greeting function that says "good morning", "good afternoon",
or "good evening", depending on the time of day. (Hint: use a time
argument that defaults to `lubridate::now()`. That will make it 
easier to test your function.)

 - Look at `?lubridate::now()` 
 - Use `lubridate::now(tzone = "UTC-2:00")` to get the current local time
 - Use `if()` and `else()`
 - First write working code and than put the code in a function
 - Call your function `greetings()`
 - If you use `libridate::now()` you will get the date and the time of day. How could you split the vector in two? Maybe use `stringr::str_split`? Look at the help for `str_split()`.



### **BONUS EXERCISE 6** {-}

More conditional calculations

Implement a `fizzbuzz` function. It takes a single number as input. If the number is divisible by three, it returns "fizz". If it's divisible by five it returns "buzz". If it's divisible by three and five, it returns "fizzbuzz". Otherwise, it returns the number. Make sure you first write working code before you create the function.

Below is a hint of code that could help you to a solution


```r
x <- 1:50
 case_when(
   x %% 35 == 0 ~ "fizz buzz",
   x %% 5 == 0 ~ "fizz",
   x %% 7 == 0 ~ "buzz",
   TRUE ~ as.character(x)
)
```

```
##  [1] "1"         "2"         "3"         "4"         "fizz"      "6"        
##  [7] "buzz"      "8"         "9"         "fizz"      "11"        "12"       
## [13] "13"        "buzz"      "fizz"      "16"        "17"        "18"       
## [19] "19"        "fizz"      "buzz"      "22"        "23"        "24"       
## [25] "fizz"      "26"        "27"        "buzz"      "29"        "fizz"     
## [31] "31"        "32"        "33"        "34"        "fizz buzz" "36"       
## [37] "37"        "38"        "39"        "fizz"      "41"        "buzz"     
## [43] "43"        "44"        "fizz"      "46"        "47"        "48"       
## [49] "buzz"      "fizz"
```


 -- END EXERCISES --

## Function documentation

Let's consider this function:

```
rotate_axis_labels <- function(axis, angle, hjust, ...){
  
  if(axis == "x" | axis == "X"){
  theme <- theme(axis.text.x = element_text(angle = angle, hjust = 1), ...)
    }
  if(axis == "y" | axis == "Y"){
  theme <- theme(axis.text.y = element_text(angle = angle, hjust = 1), ...)
    }
  return(theme)
}
```

**DISCUSS WITH YOUR NEIGHBOUR**

 - What do you think this function does??
What should be the data type of the arguments `axis`, `angle` and `h_just` and `v_just`?
What does the `...` do?

## Try out
The code below illustrates what this function does. Running the following chunk adds the function to the Global Environment. 

```r
rotate_axis_labels <- function(axis = NULL, 
                               angle = NULL, 
                               h_just = 1,
                               v_just = 1,
                               ...){
  
  if(axis == "x" | axis == "X"){
  theme <- theme(axis.text.x = element_text(angle = angle, 
                                            hjust = h_just,
                                            vjust = v_just,
                                            ...))
    }
  if(axis == "y" | axis == "Y"){
  theme <- theme(axis.text.y = element_text(angle = angle, 
                                            hjust = h_just,
                                            vjust = v_just,
                                            ...))
    }
  return(theme)
}

## you will see the function rotate_axis_labels under "Functions"
```

Example plot from gapminder data
Notice the scrunched op x-axis labels

```r
gapminder::gapminder %>%
  dplyr::filter(continent == "Europe", year == 1972) %>%
  ggplot(aes(x = country,
             y = lifeExp)) +
  geom_point()
```

<img src="ch12-lab3bfunctions_files/figure-html/unnamed-chunk-18-1.png" width="672" />

The official ggplot2 solution to rotate the labels is
```
p + theme(axis.text.x = element_text(angle = 90))
```
I cannot remember this, and many people struggle with this logic, so I wrote my own function (the one above called `rotate_axis_labels()`). It has an argument for which axis the rotation must be applied to (`axis`), an argument for the `angle` to rotate. The arguments `h_just` and `v_just` control the horizontal and vertical displacement of the labels respectively. Finally, the `...` means that you can pass any additional arguments to the ggplot2 function `element_text()`, these will be parsed from the function call to the `element_text()` call through `...`

See the function at work:

```r
## use default label offset

gapminder::gapminder %>%
  dplyr::filter(continent == "Europe", year == 1972) %>%
  ggplot(aes(x = country,
             y = lifeExp)) +
  geom_point() +
  rotate_axis_labels(axis = "X", 
                     angle = 60)
```

<img src="ch12-lab3bfunctions_files/figure-html/unnamed-chunk-19-1.png" width="672" />

```r
## adapt label offset and use ... to change colour and font face to bold

plot_gapminder_le_vs_country <- function(continent, year){

gapminder::gapminder %>%
  dplyr::filter(continent == continent, year == year) %>%
  ggplot(aes(x = country,
             y = lifeExp)) +
  geom_point() +
  rotate_axis_labels(axis = "X", 
                     angle = 90,
                     h_just = 1, 
                     v_just = 0.11, colour = "red", size = 9, face = "bold")

}

plot_gapminder_le_vs_country(continent = "Africa", year = 1972)
```

<img src="ch12-lab3bfunctions_files/figure-html/unnamed-chunk-19-2.png" width="672" />

```r
plot_gapminder_le_vs_country(continent = "Europe", year = 1972)
```

<img src="ch12-lab3bfunctions_files/figure-html/unnamed-chunk-19-3.png" width="672" />
Note that I demonstrate the use of `...` in the code above, with:

```
colour = "red", size = 11, face = "bold"

```
How does this work? See also `?ggplot2::element_text` for more info.

## Documenting a function
Now that we have an idea on what this function does and what the data type of the arguments that go inside the function call should be we can start writing the documentation for our 'self-written' function.
Documenting a function is extremely important for reproducibility and robustness of you code. If you don't know what goes in a function, you will have difficulty operating the function and obtaining the correct output.
The R-package system and the Comprehensive R-Archiving Network, as well as BIOCONDUCTOR, as such a great success because of their rigorous check on documentation for packages that are submitted there. So writing functions, and their documentation could be you first step to writing a package and publishing it so that other people might enjoy your innovations.

### Identifying what elements are in the documentation for a function
Let's examine the output for the well documented function `mean` from the `base` package


```r
library(dplyr)
source(
  here::here(
  "code",
  "render_help_to_console.R"))
help_console(mean)
```

```
## _A_r_i_t_h_m_e_t_i_c _M_e_a_n
## 
## _D_e_s_c_r_i_p_t_i_o_n:
## 
##      Generic function for the (trimmed) arithmetic mean.
## 
## _U_s_a_g_e:
## 
##      mean(x, ...)
##      
##      ## Default S3 method:
##      mean(x, trim = 0, na.rm = FALSE, ...)
##      
## _A_r_g_u_m_e_n_t_s:
## 
##        x: An R object.  Currently there are methods for numeric/logical
##           vectors and date, date-time and time interval objects.
##           Complex vectors are allowed for 'trim = 0', only.
## 
##     trim: the fraction (0 to 0.5) of observations to be trimmed from
##           each end of 'x' before the mean is computed.  Values of trim
##           outside that range are taken as the nearest endpoint.
## 
##    na.rm: a logical value indicating whether 'NA' values should be
##           stripped before the computation proceeds.
## 
##      ...: further arguments passed to or from other methods.
## 
## _V_a_l_u_e:
## 
##      If 'trim' is zero (the default), the arithmetic mean of the values
##      in 'x' is computed, as a numeric or complex vector of length one.
##      If 'x' is not logical (coerced to numeric), numeric (including
##      integer) or complex, 'NA_real_' is returned, with a warning.
## 
##      If 'trim' is non-zero, a symmetrically trimmed mean is computed
##      with a fraction of 'trim' observations deleted from each end
##      before the mean is computed.
## 
## _R_e_f_e_r_e_n_c_e_s:
## 
##      Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) _The New S
##      Language_.  Wadsworth & Brooks/Cole.
## 
## _S_e_e _A_l_s_o:
## 
##      'weighted.mean', 'mean.POSIXct', 'colMeans' for row and column
##      means.
## 
## _E_x_a_m_p_l_e_s:
## 
##      x <- c(0:10, 50)
##      xm <- mean(x)
##      c(xm, mean(x, trim = 0.10))
## 
```

So how would we adapt this documentation to our `rotate_axis_labels()` function?

The elements of the documentation are standardized and each function can be annotated with so-called Roxygen comments (`'#`). These comments can be used to indicate specific fields for documentation and are automatically translated to R-documentation files (`.Rd`) if you are using them in a package-development workflow. 
To help you in adopting the process of writing R-packages yourself, it is good practice to write Roxygen-documentation for each function you write. Normally you would store each function in it's own `.R` file. For tracebility reasons, it is a good idea to give this file the same name as the name of the function it contains. Mind that this file must only contain the function and it's documentation, nothing else. So testing etc. is performed outside this `.R` file.

Below you see an example of the function definition + documentation for our `rotate_axis_labels()` function. I have included this function in an R-package called `{toolboxr}`. The structure of this package and how to to build your own R package will be discussed in chapter \@ref(lab7bcommunicatereproduce)

```
#' @title Rotate the x or y axis labels of a ggplot graph
#' 
#' @param axis A character string `x`, `X`, `Y` or `y` indicating 
#' for which axis in the plot the labels need to be rotated 
#' @param angle A single nummeric value indicating the angle 
#' of ration. Posive value rotate the label counterclockwise, 
#' negative values provide a clockwise rotation (which is not recommended)  
#' @param ... Any addiontional paramters passed to `element_text`. 
#' See `?element_text` for more options
#' 
#' @return An theme element (see ?ggplot::theme for more details)
#' 
#' @examples 
#' library(ggplot2)
#' library(tidyverse)
#' 
#' ## default settings
#' data(package = "datasets", dataset ="mtcars")
#' mtcars %>% 
#' mutate(brand = rownames(.)) %>%
#'  ggplot(aes(x = reorder(as_factor(brand), mpg),
#'             y = mpg)) +
#'  geom_point() +
#'  rotate_axis_labels(axis = "x", 
#'                     angle = 90) 
#' 
#' ## with use of ... and setting v_just
#' mtcars %>% 
#' mutate(brand = rownames(.)) %>%
#'   ggplot(aes(x = reorder(as_factor(brand), mpg),
#'              y = mpg)) +
#'   geom_point() +
#'   rotate_axis_labels(axis = "x", 
#'                      angle = 90, 
#'                      v_just = 0.1, 
#'                      colour = "purple",
#'                      face = "bold) 
#' 
#' 
#' @export

rotate_axis_labels <- function(axis = NULL, 
                               angle = NULL, 
                               h_just = 1, 
                               v_just = 1, ...){
  
  if(axis == "x" | axis == "X"){
    theme <- theme(axis.text.x = element_text(angle = angle, 
                                              hjust = h_just,
                                              vjust = v_just,
                                              ...))
  }
  if(axis == "y" | axis == "Y"){
    theme <- theme(axis.text.y = element_text(angle = angle, 
                                              hjust = h_just,
                                              vjust = v_just,
                                              ...))
  }
  return(theme)
}


```

### **EXERCISE 7; Roxygen Documentation** {-}

Follow the steps below:

 1. Create an empty R-script called "is_integer_present.R"
 1. Copy the function definition for the function `is_integer_present()` from exercise 2B into this R script.
 1. Create a new folder in your RStudio `Home` called `minions`
 1. Save the R-script "is_integer_present.R" in the folder "./minions/R"
 1. Set up a new RStudio project from the Existing "./minions" folder
 1. Open the new RStudio project called "minions"
 1. Open the R-script "is_integer_present.R" inside the "minions" project
 1. Annotate the function `is_integer_present()` with appropriate Roxygen comments, use at least the fields: `@title`, `@param`, `@return`, `@example`, `@export`
 1. Save the function definition file
 1. Return to the edamoi bookdown project/website.
 
