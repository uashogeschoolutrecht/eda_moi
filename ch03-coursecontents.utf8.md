# Course Contents {#coursecontents}



## Data Mining Course
This course is about "Exploratory Data Analysis and Initial Data Analysis"

[Wikipedia definition](https://en.wikipedia.org/wiki/Exploratory_data_analysis)

"In statistics, exploratory data analysis (EDA) is an approach to analyzing data sets to summarize their main characteristics, often with visual methods. A statistical model can be used or not, but primarily EDA is for seeing what the data can tell us beyond the formal modeling or hypothesis testing task. Exploratory data analysis was promoted by John Tukey to encourage statisticians to explore the data, and possibly formulate hypotheses that could lead to new data collection and experiments. EDA is different from initial data analysis (IDA),[1] which focuses more narrowly on checking assumptions required for model fitting and hypothesis testing, and handling missing values and making transformations of variables as needed. EDA encompasses IDA"

## Course aims
 
  - EDA is not a formal procedure, getting the right mind set
  - Learn tools in R to GET, CLEAN, EXPLORE and MODEL data
  - Acquire R skills for the complete EDA cycle; object oriented and functional programming  
  - Visualize data
  - Explore assumptions (IDA)
  - Using R for Reproducible Research 
  
## Course contents
Each course masterclass or so-called 'lab' will carry forward a specific theme related to Exploratory Data Analysis. In this course you will exclusively work with the Programming Environment `R` [@R-base] in the Integrated Development Environment `RStudio` [@R-rstudio]. There will be no need to install any software on your laptop, because we will be using a cloud computing solution. This offers flexibility and speed. I will show you where to get the required software. In case that you would be wanting to install your own environment locally.   
  
In this course you will get in-depth knowledge on how to use R in conjunction with RStudio to `IMPORT`, `INVESTIGATE`, `CLEAN`, `VISUALIZE`, `EXPLORE`, `MODEL` and `COMMUNICATE` data and conclusions about data. 
  
To this end, I divided an number of logically connected topics together in seven `labs`. Each lab has several interactive cycles of theory and exercises. During each lab, I will explain a small amount of topics after which the course participants will have the opportunity to practice with exercises.   
  
## BYOD; Bring Your Own Data  
  
During this course you will have the opportunity to bring your own data as case example. Please think about which data you will be able to (freely) share with me and your fellow paticipants. 

## Lab Contents
Below, I will shortly summarize what we will be covering in each lab (seven in total for the complete course).

### Lab 1a: Introduction to RStudio 
Chapter \@ref(lab1aintrorstudio)

 1. Getting the course materials from github.com
 1. Creating objects in R
 1. RStudio introduction

### Lab 1b: Introduction to R  
Chapter \@ref(lab1bintror)

 1. Functional and object oriented programming
 1. Functions
 1. Object Class; vectors, dataframes, lists
 1. Vector types
 1. Getting help
 1. Plots
 1. Data examples

### Lab 1c: Dataframes, lists and matrices  
Chapter \@ref(lab1crecursivevectors)

 1. Dataframes
 1. Lists
 1. Matrices

### Lab 2: Visualize & Explore Data
Chapter \@ref(lab2viz)

 1. Visualizations demo
 1. Build in datasets 
 1. Using the grammar of graphics with `{ggplot2}`
 1. Plot types
 1. `geom_...` and `aes()`
 1. Adding dimensions to a plot 
 1. Solving overplotting
 1. Plot annotation and labels
 1. Saving plots
 1. Examples of `{shiny}` apps

### Lab 3a: Data Wrangling  
Chapter \@ref(lab3awrangling)

 1. Using `{dplyr}` for data wrangling
 1. The `{dplyr}` verbs
 1. Data wrangling in combination with `{ggplot2}`

### Lab 3b: Functional Programming 
Chapter \@ref(lab3bfunctions)

 1. What is a function
 1. Writing function
 1. Function documentation
 1. Loops and `map` family of functions
 1. Scripts and the `source` function
 1. Why write function
 1. Function elements (name/arguments, body, return)
 1. Function documentation, Roxygen comments
 1. Writing error / warning /  messages
 
### Lab 3c: Tidy data
Chapter \@ref(lab3ctidydata)
 
### Lab 4a: Importing data 
Chapter \@ref(lab4aimportingdata)

 1. Paths
 1. Importing data functions
 1. Excel and other 'foreign' formats
 1. Reading from a zipfile/url

### ### Lab 4b: Getting Open Data  
Chapter \@ref(lab4bopendata)

 1. Open data sources
 1. Finding data
 1. Importing data into R (.csv, .tsv, .txt, .json, .xml, .xls(x)
 1. Using APIs (Twitter, Kaggle, Google, CBS)
 1. Accessing databases

### Lab 5: Exploratory Data Analysis _or_ The PPDAC Cycle
Chapter \@ref(lab5eda)

 1. The process of EDA
 1. Problem-Plan-Data-Analysis-Conclusion (PPDAC) Cycle
 1. Missingness
 1. Distibutions
 1. Finding patterns 
 1. Graph types
 1. Multidimensional data
 1. Principal Components
 
### Lab 6a: Exploring Assumptions & Models  
Chapter \@ref(lab6amodels)

 1. Why Assumptions?
 1. Distributions (Gaussian)
 1. Regression
 1. Model output ( `{broom}`)
 
### Lab 6b: Statistics with R (resampling & simple regression) 
Chapter \@ref(lab6bmanymodels)
 
### Lab 7: Statistics with R (multiple regression and ANOVA) 
Chapter \@ref(lab7atextmining)
 
## Exercises
Each masterclass/lab contains a number of exercises. Most lessons have exercises in between the demos and explanations. Usually at the end of each lessons, more exercises are included.

In order for you to get the most out of this course it is important to go over each exercise and try to solve each challenge strictly from within RStudio. 
The easiest way to make an exercise is to copy the text of the exrcise from the Bookdown website into an RMarkdown file and place R-code chunks in between containing the answers or to use the Rmd source documents from Github directly. Store each Rmd file for each lesson seperately in a convenient folder called "exercises" in your course project folder.

During the classes we will also look at the solutions to the exercises together.

The R code containg the demos and the answers will be made available for each lab in the github repository: https://github.com/uashogeschoolutrecht/exploratory_data_masterclasses
