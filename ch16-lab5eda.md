# Lab 5; Exploratory Data Analysis {#lab5eda}





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

```r
library(naniar)
library(ggplot2)
```

## Exploratory Data Analysis

 * Use visualisation and transformations to explore your data in a systematic way
 * A task that statisticians call exploratory data analysis, or EDA for short. 
 
## EDA is an iterative cycle; you:

 1) Generate questions about your data.
 2) Search for answers by visualising, transforming, and modelling your data.
 3) Use what you learn to refine your questions and/or generate new questions.

__You do not need to know statistics for EDA, but it helps if you do!__

## EDA is not a formal process with a strict set of rules. 

 * EDA is a state of mind. 
 * Should feel free to investigate every idea that occurs to you. 
 * Some of these ideas will pan out, and some will be dead ends. 
 * As your exploration continues, you will home in on a few particularly productive areas that you'll eventually write up and communicate to others.

## EDA Steps
We already saw the 'non-formal' EDA steps (PPDAC cycle) in the EDA case example in Chapter \@ref(edacase)

 1. Start with a **PROBLEM** (or question)
 1. You devise a **PLAN** to solve the problem (or answer the question)
 1. You collect **DATA** to execute the plan (or perform an experiment)
 1. You **ANALYZE** the data
 1. Finally, you draw a **CONCLUSION** from the analysis
 1. You probably start the cycle again

## EDA and R programming
<img src="C:/Users/mteunis/workspaces/eda_moi/images/data-science.png" width="827" style="display: block; margin: auto auto auto 0;" />

To do data analysis, you'll need to deploy all the tools of EDA: visualisation, transformation, and modelling.

## Prerequisites

In this lesson we'll combine what you've learned about dplyr and ggplot2 to interactively ask questions, answer them with data, and then ask new questions.


```r
library(tidyverse)
```

## When perfoming EDA consider:

 1. What question(s) are you trying to solve (or prove wrong)?
 1. Which information do you need and can you come up with a plan to answer the question(s)
 1. What kind of data do you have and how do you treat different types?
 1. What’s missing from the data and how do you deal with it?
 1. Where are the outliers and why should you care about them?
 1. How can you add, change or remove features to get more out of your data?
 1. Do you need additional data from other sources to relate to the dataset under scrutany?
 1. Are underlying statitical assumptions met / how is data distribution looking?
 1. What (exploratory) models apply or fit well to the data?
 1. What is the undelying (experimental) design?
 1. Is there multi-colinearity?
 
We will address each of these questions with an example dataset in the demo that follows.
 
## Definitions

 * A __variable__ is a quantity, quality, or property that you can measure. 
 * A __value__ is the state of a variable when you measure it. The value of a variable may change from measurement to measurement.
 * An __observation__ is a set of measurements made under similar conditions. An observation will contain several values, each associated with a different variable. I'll sometimes refer to an observation as a data point.
 * Tables: __Tabular data__ is a set of values, each associated with a variable and an observation. 
 * Tabular data is _tidy_ if each value is placed in its own "cell", each variable in its own column, and each observation in its own row. 
 * In real-life, most data isn't tidy, as we've seen in __tidy data__.

## Variation

**Variation** is the tendency of the values of a variable to change from measurement to measurement. 

 * Categorical variables can also vary if you measure across different subjects (e.g. the eye colors of different people), or different times (e.g. the energy levels of an electron at different moments). 
 
 * Every variable has its own pattern of variation, which can reveal interesting information. The best way to understand that pattern is to visualise the distribution of the variable's values.

## Categorical variables

 * A variable is **categorical** if it can only take one of a small set of values.   
 * In R, categorical variables are usually saved as factors or character vectors. 
 * To examine the distribution of a categorical variable, use a bar chart:

## Demo from "R for Data Science" by Hadley Wickham & Garret Grolemund 

This demo was partly reproduced from the R4DS book by Grolemund and Wickham and involves an example on how to answer questions using EDA on the `diamonds` dataset that is an example dataset and part of the R-package `{ggplot2}`

### General questions?

 1. Which information do you need and can you come up with a plan to answer the question(s) (PP)
 1. What kind of data do you have and how do you treat different types? (D)

Here we already have the data: The infamous 'diamonds' dataset, build into the `{ggplot2}` package

The description of the data can be reviewed with

```r
# ?ggplot2::diamonds
```

From this description we could come up with a rather simple research question:
"Is `carat`, the weight of a diamond, correlated with the `price` of a diamond." Below we will address this question.

## Missingness & Outliers 

 1. What’s missing from the data and how do you deal with it?
 1. Where are the outliers and why should you care about them?

Are there any missing data in the diamonds dataset?

```r
data("diamonds")
naniar::vis_miss(diamonds)
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-4-1.png" width="480" />

```r
sum(is.na(diamonds))
```

```
## [1] 0
```

There seem to be no apparant missingness in any of the variables in the diamonds dataset. 

## EXERCISE 1: "Missingness" {-} 
Checking for missingness is a crucial first step to avoid problems later in the analysis (for example when deriving summary statistics)

 A) List two potential problems that can occur if missingness is not properly inspected and subsequently dealt with
 B) Read this article: https://medium.com/coinmonks/dealing-with-missing-data-using-r-3ae428da2d17 Summarize the different types of missingness and how you could deal with them. Create a table in your Rmd file (see: https://rmarkdown.rstudio.com/lesson-7.html)

## --- END OF EXERCISE --- {-}


### Distributions: The bar chart
To get an idea on the binning of a categorical variable (how many observations belong to which category?)

```r
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-5-1.png" width="480" />

### Count can also compute frequencies for categorical values 

```r
diamonds %>% 
  count(cut) ## the sort argument (set to TRUE will show the largest on top)
```

```
## # A tibble: 5 x 2
##   cut           n
##   <ord>     <int>
## 1 Fair       1610
## 2 Good       4906
## 3 Very Good 12082
## 4 Premium   13791
## 5 Ideal     21551
```

### Continuous variables
 
 * A variable is **continuous** if it can take any of an infinite set of ordered values. 
 * Numbers and date-times are two examples of continuous variables. To examine the distribution of a continuous variable, use a histogram:

### The histogram

```r
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.05)
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-7-1.png" width="480" />

What do you notice from this plot?

### Frequency calculation by 'hand'
You can compute this by hand by combining `dplyr::count()` and `ggplot2::cut_width()`:

```r
diamonds %>% 
  count(cut_width(carat, 0.05))
```

```
## # A tibble: 65 x 2
##    `cut_width(carat, 0.05)`     n
##    <fct>                    <int>
##  1 [0.175,0.225]               26
##  2 (0.225,0.275]             1245
##  3 (0.275,0.325]             7021
##  4 (0.325,0.375]             3732
##  5 (0.375,0.425]             4455
##  6 (0.425,0.475]             1087
##  7 (0.475,0.525]             3310
##  8 (0.525,0.575]             2752
##  9 (0.575,0.625]             1159
## 10 (0.625,0.675]              343
## # ... with 55 more rows
```

### Experiment with `binwidth =` 

 * Always explore a variety of binwidths when working with histograms, as different binwidths can reveal different patterns. 


```r
smaller <- diamonds %>% 
  dplyr::filter(carat < 3)
  
smaller %>%
  ggplot(aes(x = carat)) +
    geom_histogram(binwidth = 0.1)
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-9-1.png" width="480" />

### Multiple histograms in one plot: `geom_freqpoly()`

```r
smaller %>%
  ggplot(aes(x = carat, colour = cut)) +
    geom_freqpoly(binwidth = 0.1) +
    theme_bw() ## set to bw for better contrast
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-10-1.png" width="480" />

### Subsequent questions
 
 * Rely on your curiosity (What do you want to learn more about?) 
 * As well as your skepticism (How could this be misleading? Does something seem odd?)

### Typical values

look for anything unexpected:

* Which values are the most common? Why?
* Which values are rare? Why? Does that match your expectations?
* Can you see any unusual patterns? What might explain them?

### This plot can be explored with a couple of questions

```r
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-11-1.png" width="480" />

### Exploratory questions

* Why are there more diamonds at whole carats and common fractions of carats?
* Why are there more diamonds slightly to the right of each peak than there 
  are slightly to the left of each peak?
* Why are there no diamonds bigger than 3 carats?

### Understanding clusters in your data

* How are the observations within each cluster similar to each other?
* How are the observations in separate clusters different from each other?
* How can you explain or describe the clusters?
* Why might the appearance of clusters be misleading?

### Generate a plot that shows clusters takes experimentation and practice
This is the famous data from the 'faithful' dataset, showing timings of eruptions of the "Old Faithful" Geyser in Yellowstone National Park, USA

```r
ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.25)
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-12-1.png" width="480" />

```r
## ?faithful for more details on the data
```

### Unusual values or outliers

 * Outliers are observations that are unusual; 
 * Data points that don't seem to fit the pattern. 
 * Sometimes outliers are data entry errors; 
 * Other times outliers suggest important new science.
 * Outliers are sometimes difficult to see in a histogram.  

## Histogram to spot outliers
When you see a histogram with an extraordinary large x-axis, you have to be vigilant about outliers 

```r
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-13-1.png" width="480" />

### Zooming in on your data

To make it easy to see the unusual values, we need to zoom into to small values of the y-axis with `coord_cartesian()`:
This truncates the y-axis

```r
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-14-1.png" width="480" />

### Zoomed in
This allows us to see that there are three unusual values: 0, ~30, and ~60. We pluck them out with dplyr: 




```r
unusual <- diamonds %>% 
  dplyr::filter(y < 3 | y > 20) %>% 
  arrange(y)
unusual
```

```
## # A tibble: 9 x 10
##   carat cut       color clarity depth table price     x     y     z
##   <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
## 1  1    Very Good H     VS2      63.3    53  5139  0      0    0   
## 2  1.14 Fair      G     VS1      57.5    67  6381  0      0    0   
## 3  1.56 Ideal     G     VS2      62.2    54 12800  0      0    0   
## 4  1.2  Premium   D     VVS1     62.1    59 15686  0      0    0   
## 5  2.25 Premium   H     SI2      62.8    59 18034  0      0    0   
## 6  0.71 Good      F     SI2      64.1    60  2130  0      0    0   
## 7  0.71 Good      F     SI2      64.1    60  2130  0      0    0   
## 8  0.51 Ideal     E     VS1      61.8    55  2075  5.15  31.8  5.12
## 9  2    Premium   H     SI2      58.9    57 12210  8.09  58.9  8.06
```

### Do not throw away your data ligthly

 * Repeat your analysis with and without the outliers
 * If they have minimal effect on the results, and you can't figure out why they're there, replace them with missing values
 * If they have a substantial effect on your results, you shouldn't drop them without justification
 * Figure out what caused them (e.g. a data entry error) and disclose that you removed them in your report.

### Boxplot

```r
diamonds %>%
  ggplot(aes(x = cut, y = y)) +
  geom_boxplot()
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-17-1.png" width="480" />

## Missing values

If you've encountered unusual values in your dataset, and simply want to move on to the rest of your analysis, you have two options.

Drop the entire row with the strange values:

```r
diamonds2 <- diamonds %>% 
  dplyr::filter(between(y, 3, 20))
```
    
I don't recommend this option

## Better!

Replacing the unusual values with missing values.

### **EXERCISE 2: Replace outliers for missing values**

A) Replace the values smaller than 3 and larger than 20 for missing values


## Missing values warning in ggplot2
Like R, ggplot2 subscribes to the philosophy that missing values should never silently go missing. It's not obvious where you should plot missing values, so ggplot2 doesn't include them in the plot, but it does warn that they've been removed:

B) Plot the x and y variables of the `diamonds2` dataset that you have created above in a scatter plot, write down the warning message.



C) What is bad about the plot below?
List a few points and try to correct the plot (there are a number of ways that you could solve this).

```r
nycflights13::flights %>% 
  mutate(cancelled = is.na(dep_time),
         sched_hour = sched_dep_time %/% 100,
         sched_min = sched_dep_time %% 100,
         sched_dep_time = sched_hour + sched_min / 60) %>%
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4) 
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-21-1.png" width="480" />



## Covariation

 * Variation describes the behavior _within_ a variable
 * Covariation describes the behavior _between_ variables. 
 * **Covariation** is the tendency for the values of two or more variables to vary together in a related way. 
 * Best way to spot covariation is to visualise the relationship between two or more variables. 
 * How you do that should again depend on the type of variables involved.

### **EXERCISE 3: A categorical and continuous variable**

A) Create a plot showing the relationship between `price` and `cut` of the `diamonds` data. Use a frequency polynom to display the counts in each level for `cut` 



It's hard to see the difference in distribution because the overall counts differ so much:

B) Create a bar graph displying the same information as in A) above. Did this improve the comparison?


C) Create the same plot as in A) but now use `density` in stead of counts on the y-axis. Google for a solution if necessary.



## The boxplot
A **boxplot** is a type of visual shorthand for a distribution of values that is popular among statisticians. Each boxplot consists of:

<img src="C:/Users/mteunis/workspaces/eda_moi/images/EDA-boxplot.png" width="819" />

## **EXERCISE 4: Diamonds boxplot

A) Create a boxplot for the distribution of price by cut using `geom_boxplot()`



B) Now log10 transform the `price` variable, what happens?


## Factors or "grouping"  variables

`cut` is an ordered factor: fair is worse than good, which is worse than very good and so on. Many categorical variables don't have such an intrinsic order, so you might want to reorder them to make a more informative display. One way to do that is with the `reorder()` function.

## Reorder the factor levels
For example, take the `class` variable in the `mpg` dataset. You might be interested to know how highway mileage varies across classes:


```r
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-29-1.png" width="480" />

## **EXERCISE: Reordering by continuous variable**

A) To make the trend easier to see, reorder by `class` based on the median value of `hwy`:



## Positioning labels on axis, or flip the axis
If you have long variable names, `geom_boxplot()` will work better if you flip it 90°. You can do that with `coord_flip()`.


```r
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip() + xlab("Class")
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-31-1.png" width="480" />

## Two categorical variables
To visualise the covariation between categorical variables, you'll need to count the number of observations for each combination. One way to do that is to rely on the built-in `geom_count()`:


```r
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-32-1.png" width="480" />

## Circles

* The size of each circle in the plot displays how many observations occurred at each combination of values. 

* Covariation will appear as a strong correlation between specific x values and specific y values. 

## Two continuous variables

```r
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-33-1.png" width="480" />

## Fix overplotting by setting transparency
You've already seen one way to fix the problem: using the `alpha` aesthetic to add transparency.


```r
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 3 / 100) +
  geom_smooth(aes(x = carat, y = price), method = "lm", fullrange = FALSE )
```

```
## `geom_smooth()` using formula 'y ~ x'
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-34-1.png" width="480" />

## Fixing overplotting with binning

```r
# install.packages("hexbin")
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-35-1.png" width="480" />

## Use bin to one continuous variable
Another option is to bin one continuous variable so it acts like a categorical variable. Then you can use one of the techniques for visualising the combination of a categorical and a continuous variable that you learned about. For example, you could bin `carat` and then for each group, display a boxplot:


```r
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-36-1.png" width="480" />

## Now we can visualise the relationship between price and carat more clearly


```r
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1))) +
  geom_smooth(method = "auto")
```

```
## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-37-1.png" width="480" />

## Methods of modelling

 * This is no statitics course, but:
 * Models are important
 * Look at `?geom_smooth`
 * The `method` argument has several options
 * The graph above shows a smoother with the model `method = "gam"`
 * More methods are available
 * See what happens if you change `method` to "lm"
 * Models help you understand relationships and are food for further formal statistical inference.
 * We could ask: 
 __"Is the relationships between price and carat really sigmoidal"?__

## cut_number

```r
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-38-1.png" width="480" />


## EXERCISES

## Data
The dataset that we are going to use for these exercises here is the 'household_power_consumption' dataset.
The data can be downloaded from here:
https://github.com/rdpeng/ExData_Plotting1 

The information about this dataset can also be found here: https://www.kaggle.com/uciml/electric-power-consumption-data-set

We will concentrate on the first three months of the year 2006, 2007, 2008.

## EXERCISE 1: Power consumption {-}

**TIPS**

 - You probable need to filter and aggregate the data first before you can answer the questions below
 - First create quick and dirty graphs, later refine your code and you graph
 

 A) Execute the following steps in a code chunk:
 
 - Unzip the downloaded energy consumption file
 - Read the file into R, you should get a dataframe with 2,075,259 rows and 


 
B) Check if there are missing values anywhere in the data



C) Create a visualization of the variables `Global_active_power` and `Date` that is meaningful and shows a clear pattern of power consumption of the year 2008

D) Show a number of visualization that show the relationship between the time of day and power consumption

E) Did power consumption over rhe years 2006, 2007 and 2008 show difference in patterns over the months? 

## EXERCISE 2: Missingness {-}

A) Load the dataset called `riskfactors` into your R session



B) Inspect the missingness in this data, use the naniar package to get an idea on where the missingness is located.



C) Which variables would you consider removing from the dataset on the basis of their missingness?

D) Write a function that calculates the percentage of missingness for a each variable in a dataset

E) Use this function to filter each variable that has a missingness that exceeds 80%, use this rule to generate a new version of the data with these variable (>80% mssingness) removed. 

F) Create a number of visualization to show the relationship between the variable `health_general` and a number of other variables that you think are relevant to investigate.


```r
riskfactors %>%
  ggplot(aes(x = drink_average, y = health_general)) +
  geom_point(aes(colour = sex), position = "jitter")
```

```
## Warning: Removed 135 rows containing missing values (geom_point).
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-43-1.png" width="480" />

```r
riskfactors %>%
  ggplot(aes(x = smoke_days, y = health_general)) +
  geom_point(aes(colour = sex), position = "jitter")
```

<img src="ch16-lab5eda_files/figure-html/unnamed-chunk-43-2.png" width="480" />

As you see, it might prove really difficult to tell anything about risk factors when we have so little data. Here we typically have a dataset that relative large P (predictors) and relatively small N (number of observations). In the next EXERCISE, we will use a different dataset that has a much larger N. This problem of large P, small N is common for Biology or Health Science related data.

## EXERCISE 3; Cocktails {-}

A) Load the cocktails dataset from here https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv into R as `cocktails`



B) For this exercises we focus on the `ingredient` variable. How many unique ingredients are included in the `cocktails` dataset 


```r
cocktails$ingredient %>%
  unique() %>% 
  length()
```

```
## [1] 569
```


C) Retrieve the top 30 most common ingredients




```r
top_30 <- cocktails %>%
  count(ingredient, sort = TRUE) %>%
  head(30)
top_30
```

```
## # A tibble: 30 x 2
##    ingredient                 n
##    <chr>                  <int>
##  1 Gin                      176
##  2 Fresh lemon juice        138
##  3 Simple Syrup             115
##  4 Vodka                    114
##  5 Light Rum                113
##  6 Dry Vermouth             107
##  7 Fresh Lime Juice         107
##  8 Triple Sec               107
##  9 Powdered Sugar            90
## 10 Grenadine                 85
## 11 Sweet Vermouth            83
## 12 Brandy                    80
## 13 Lemon Juice               70
## 14 Blanco tequila            69
## 15 Egg White                 67
## 16 Angostura Bitters         63
## 17 Juice of a Lemon          60
## 18 Pineapple Juice           47
## 19 Bourbon whiskey           38
## 20 Orange Bitters            38
## 21 Juice of a Lime           35
## 22 Bitters                   31
## 23 Orange juice              31
## 24 Whole Egg                 31
## 25 Old Mr. Boston Dry Gin    30
## 26 Benedictine               28
## 27 Dark rum                  27
## 28 Maraschino liqueur        26
## 29 White creme de cacao      26
## 30 Dubonnet                  25
```

```r
## restore setting for tibble printing
options(tibble.print_max = 10, tibble.print_min = 10)
```

C) The data shows a `name` and a `row_id` variable. Are `name` and `row_id` equivalent? 


```r
cocktails %>% count(name)
```

```
## # A tibble: 989 x 2
##    name                          n
##    <chr>                     <int>
##  1 1626                          5
##  2 19th Century                  4
##  3 A. J.                         2
##  4 Absinthe Cocktail             4
##  5 Absinthe Drip Cocktail        2
##  6 Absinthe Special Cocktail     3
##  7 Academic Review               6
##  8 Acapulco                      5
##  9 Adam and Eve                  4
## 10 Adderly Cocktail              4
## # ... with 979 more rows
```

```r
cocktails %>% count(row_id)
```

```
## # A tibble: 989 x 2
##    row_id     n
##     <dbl> <int>
##  1      1     4
##  2      2     4
##  3      3     2
##  4      4     3
##  5      5     5
##  6      6     5
##  7      7     3
##  8      8     4
##  9      9     2
## 10     10     3
## # ... with 979 more rows
```

```r
cocktails %>%
  group_by(name) %>%
  summarise(ids = n_distinct(row_id)) %>%
  filter(ids > 1)
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 0 x 2
## # ... with 2 variables: name <chr>, ids <int>
```

```r
# Yes, they are
```


D) How many ingredients are in each cocktail? ------------------------------

```r
cocktails %>%
  count(name) %>%
  count(n)
```

```
## Storing counts in `nn`, as `n` already present in input
## i Use `name = "new_name"` to pick a new name.
```

```
## # A tibble: 6 x 2
##       n    nn
##   <int> <int>
## 1     1    31
## 2     2   118
## 3     3   292
## 4     4   297
## 5     5   194
## 6     6    57
```

```r
# These 1-ingredient cocktails suggest that non-alcoholic ingredients
# are not included
cocktails %>%
  group_by(name) %>%
  filter(n() == 1)
```

```
## # A tibble: 31 x 6
## # Groups:   name [31]
##    name          category      row_id ingredient_numb~ ingredient        measure
##    <chr>         <chr>          <dbl>            <dbl> <chr>             <chr>  
##  1 Brandy and S~ Cocktail Cla~    149                1 Brandy            2 oz   
##  2 Vodka and To~ Vodka            156                1 Vodka             2 oz   
##  3 Vodka and Ap~ Vodka            162                1 Vodka             2 oz   
##  4 Limestone     Cocktail Cla~    164                1 Bourbon           1 1/2 ~
##  5 Bourbon On T~ Cocktail Cla~    170                1 Bourbon           2 oz   
##  6 Saronno Mist  Cocktail Cla~    183                1 Amaretto di Saro~ 1 1/2 ~
##  7 Mandarine Mi~ Cocktail Cla~    195                1 Mandarine Napole~ 1 1/2 ~
##  8 Hill Billy H~ Cocktail Cla~    216                1 Georgia Moon Cor~ 2 oz   
##  9 Cafe di Saro~ Cocktail Cla~    274                1 Amaretto di Saro~ 1 oz   
## 10 Bourbon High~ Whiskies         296                1 Bourbon whiskey   2 oz   
## # ... with 21 more rows
```

```r
cocktails %>%
  group_by(name) %>%
  filter(n() == 2)
```

```
## # A tibble: 236 x 6
## # Groups:   name [118]
##    name          category        row_id ingredient_numb~ ingredient      measure
##    <chr>         <chr>            <dbl>            <dbl> <chr>           <chr>  
##  1 Apple Pie     Cordials and L~      3                1 Apple schnapps  3 oz   
##  2 Apple Pie     Cordials and L~      3                2 Cinnamon schna~ 1 oz   
##  3 Caribbean Ch~ Cocktail Class~      9                1 Light Rum       1/2 oz 
##  4 Caribbean Ch~ Cocktail Class~      9                2 Creme de banana 1/2 oz 
##  5 Amaretto Sti~ Cordials and L~     17                1 Amaretto        1 1/2 ~
##  6 Amaretto Sti~ Cordials and L~     17                2 White creme de~ 3/4 oz 
##  7 Amaretto And~ Cordials and L~     44                1 Amaretto        1 1/2 ~
##  8 Amaretto And~ Cordials and L~     44                2 half-and-half   1 1/2 ~
##  9 Montreal Clu~ Cocktail Class~     50                1 Gin             1 1/2 ~
## 10 Montreal Clu~ Cocktail Class~     50                2 Anisette        1/2 oz 
## # ... with 226 more rows
```

# How big is each cocktail? -----------------------------------------------

cocktails %>% count(measure, sort = TRUE)

non_spirit <- c("Chilled Champagne", "Water", "Orange Juice", "Cranberry Juice", "Light Cream (if desired)", "Fresh orange juice", "Orange juice")

# Have removed all cocktails with ounces of bitters - that is most
# likely a data entry error (it certainly doesn't give me much confidence
# in the quality of this data)

sizes <- cocktails %>%
  filter(str_detect(measure, "oz")) %>%
  filter(!str_detect(ingredient, fixed("bitters", ignore_case = TRUE))) %>%
  filter(!ingredient %in% non_spirit) %>%
  mutate(oz = str_replace(measure, " oz", "")) %>%
  mutate(oz = str_replace(oz, " ?1/2", ".5")) %>%
  mutate(oz = str_replace(oz, " ?1/4", ".25")) %>%
  mutate(oz = str_replace(oz, " ? ?3/4", ".75")) %>%
  mutate(oz = str_replace(oz, " ?1/3", ".33")) %>%
  mutate(oz = str_replace(oz, " ?2/3", ".33")) %>%
  mutate(oz = as.numeric(oz))

filter(sizes, oz > 3)
filter(sizes, oz > 10)

total_size <- sizes %>% group_by(name) %>% summarise(n = n(), oz = sum(oz))

total_size %>% filter(oz > 20)

total_size %>%
  filter(oz < 20) %>%
  ggplot(aes(oz)) +
  geom_histogram(binwidth = 0.5)

total_size %>%
  filter(oz > 6) %>%
  semi_join(cocktails, ., by = "name") 

cocktails %>%
  filter(str_detect(ingredient, "bitters"))

sizes %>%
  group_by(ingredient) %>%
  summarise(n = n(), oz = mean(oz)) %>%
  filter(n > 5) %>%
  arrange(desc(oz), sort = TRUE)


# What are the primary ingredients ----------------------------------------

cocktails <- cocktails %>% mutate(ingredient = tolower(ingredient))

cocktails %>%
  count(ingredient = tolower(ingredient), sort = TRUE) %>%
  head(20)

standard_ingredients <- tribble(
  ~ ingredient,        ~ standard_name,
  "fresh lemon juice", "lemon juice",
  "juice of a lemon",  "lemon juice",
  "fresh lime juice",  "lime juice",
  "juice of a lime",   "lime juice",
  "bitters",           "angostura bitters"
)

ingredient_changes <- cocktails %>%
  select(name, ingredient_number, ingredient) %>%
  right_join(standard_ingredients) %>%
  select(name, ingredient_number, ingredient = standard_name)

cocktails %>%
  rows_update(ingredient_changes, by = c("name", "ingredient_number")) %>%
  count(ingredient, sort = TRUE) %>%
  head(20)
```

 

 ## Case study
 
 https://data-analist.info/cbs-open-data-downloaden-voor-data-analyse-in-r/

 

 






