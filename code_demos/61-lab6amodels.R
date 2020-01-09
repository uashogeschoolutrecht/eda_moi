## ------------------------------------------------------------------------
library(tidyverse)
library(AppliedPredictiveModeling)
library(tidyverse)
library(devtools)
library(pastecs)
library(car)
library(e1071)
library(pastecs)
library(caret)
library(AppliedPredictiveModeling)
# install_github("profandyfield/adventr")
library(adventr)
# devtools::install_github("tidymodels/parsnip")
library(parsnip)
library(tidymodels)
library(recipes)


## ------------------------------------------------------------------------
dlf <- read_delim(file = here::here("data", 
                                   "DownloadFestival.dat"), 
                                   delim =  "\t", na = c("", " "))
dlf %>% head(3)


## ------------------------------------------------------------------------
sum(is.na(dlf))
x <- summary(dlf)
min_maxs <- x[c(1, 6), c(3:5)] %>% unlist() %>% print()
naniar::vis_miss(dlf)


## ------------------------------------------------------------------------
hist.outlier <- ggplot(dlf, aes(day1)) + 
  geom_histogram(aes(y=..density..), 
                 colour="black", 
                 fill="white") + 
  labs(x="Hygiene score on day 1", y = "Density") +
  theme(legend.position = "none")
hist.outlier


## ------------------------------------------------------------------------
dlf_long <- dlf %>% 
  tidyr::gather(day1:day3, key = "days", value = "hygiene_score")
dlf_long


## ---- echo=FALSE---------------------------------------------------------
hist.boxplot <- dlf_long %>%
  ggplot(aes(x = days, y = hygiene_score)) + 
  geom_boxplot(aes(group = days)) +
  geom_point(data = dplyr::filter(dlf_long, hygiene_score > 19), 
             colour = "darkred", size = 2.5) +
  labs(x="Hygiene score on day 1", y = "Hygiene Score") +
  theme(legend.position = "none") + 
  facet_wrap(~ gender)
hist.boxplot


## ------------------------------------------------------------------------
dlf <- dlf %>%
  dplyr::filter(!day1 > 19)

dlf_long <- dlf_long %>%
  dplyr::filter(!hygiene_score > 19)



## ------------------------------------------------------------------------
hist.boxplot <- dlf %>%
  tidyr::gather(day1:day3, key = "days", value = "hygiene_score") %>%
  ggplot(aes(x = days, y = hygiene_score)) + 
  geom_boxplot(aes(group = days)) + 
  labs(x="Hygiene score on day 1", y = "Hygiene Score") +
  theme(legend.position = "none") + 
  facet_wrap(~ gender)
hist.boxplot


## ------------------------------------------------------------------------
dlf_long %>%
  ggplot(aes(x = hygiene_score, y = ticknumb)) +
  geom_point(aes(colour = days)) +
  facet_wrap(~gender)


## ------------------------------------------------------------------------
dlf_long %>%
  ggplot(aes(x = hygiene_score)) +
  geom_density(aes(colour = days)) +
  facet_wrap(~days)


## ------------------------------------------------------------------------
set.seed(123)
## add normal distribution to the data (based on observed mean and sd per day)
dlf_norm <- dlf %>%
  mutate(
    norm_day_1 = rnorm(
      mean = mean(dlf$day1, na.rm = TRUE), 
      n = nrow(dlf), 
      sd = sd(dlf$day1, na.rm = TRUE)),
    norm_day_2 = rnorm(
      mean = mean(dlf$day2, na.rm = TRUE), 
      n = nrow(dlf), 
      sd = sd(dlf$day2, na.rm = TRUE)),
    norm_day_3 = rnorm(
      mean = mean(dlf$day3, na.rm = TRUE), 
      n = nrow(dlf), 
      sd = sd(dlf$day3, na.rm = TRUE))) %>%
  dplyr::select(gender, norm_day_1:norm_day_3) %>%
  tidyr::gather(norm_day_1:norm_day_3, 
                key = "days", 
                value = "norm_hygiene_score")
  

## add to plot
dlf_long %>%
  dplyr::filter(!hygiene_score > 19) %>%
  ggplot(aes(x = hygiene_score)) +
  geom_density(aes(colour = days)) +
  geom_density(data = dlf_norm, aes(x = norm_hygiene_score,
                                    colour = days)) +
  facet_wrap(~days)
  


## ------------------------------------------------------------------------
## see the file ggqq.R for the function definition
source(file = here::here("code", "ggqq.R"))
gg_qq_1 <- gg_qq(dlf$day1)
gg_qq_1


## ------------------------------------------------------------------------
gg_qq_2 <- gg_qq(dlf$day2)
gg_qq_2


## ------------------------------------------------------------------------
gg_qq(dlf$day3)


## ------------------------------------------------------------------------
round(stat.desc(dlf[, c("day1", "day2", "day3")], basic = FALSE, norm = TRUE), digits = 3)


## ---- eval=FALSE---------------------------------------------------------
## leveneTest(dlf$day1, dlf$day2)
## leveneTest(data = dlf_long, hygiene_score ~ days)
## leveneTest(data = dlf_long, hygiene_score ~ days * gender)
## 
## dlf_long %>%
##   ggplot(aes(x = hygiene_score, y = ticknumb)) +
##   geom_point(aes(colour = days)) +
##   facet_wrap(days~gender, nrow = 3)


## ----rec_basic-----------------------------------------------------------
library(recipes) 
library(dplyr)
library(caret)
data("Sacramento")

## Create an initial recipe with only predictors and outcome
rec <- recipe(price ~ type + sqft, data = Sacramento)
rec <- rec %>% 
  step_log(price) %>%
  step_dummy(type, one_hot = TRUE)
rec_trained <- prep(rec, training = Sacramento, retain = TRUE)
design_mat <- bake(rec_trained, new_data = Sacramento)
design_mat


## ------------------------------------------------------------------------

## 1.
Sacramento %>%
  ggplot(aes(x = sqft,
             y = price)) +
  geom_point(aes(colour = type), alpha = 0.3)  +
  guides(colour = guide_legend(override.aes = list(alpha = 1)))

## 2.
Sacramento %>%
  ggplot(aes(x = sqft,
             y = log10(price))) +
  geom_point(aes(colour = type), alpha = 0.3)

## 3.
Sacramento %>%
  ggplot(aes(x = sqft,
             y = log10(price))) +
  geom_point(aes(colour = type), alpha = 0.3) +
  facet_grid(beds ~ baths)

## 4.
## summary
Sacramento %>%
  dplyr::group_by(type) %>%
  tally()




## ------------------------------------------------------------------------
rec <- recipe(price ~ type + sqft, data = Sacramento)
rec <- rec %>% 
  step_log(price) %>%
  step_dummy(type, one_hot = TRUE) %>%
  step_log(price)
 
rec_trained <- prep(rec, training = Sacramento, retain = TRUE)
design_mat <- bake(rec_trained, new_data = Sacramento)
design_mat



## ------------------------------------------------------------------------
rec <- recipe(~ ., data = Sacramento)
pca_trans <- rec %>%
  step_center(all_numeric()) %>%
  step_scale(all_numeric()) %>%
  step_pca(all_numeric(), num_comp = 3)
pca_estimates <- prep(pca_trans, training = Sacramento)

##
pca_data <- bake(pca_estimates, Sacramento)


pca_data %>%
  ggplot(aes(x = PC1,
             y = PC2)) +
  geom_point(aes(colour = Sacramento$type), alpha = 0.4)

pca_data %>%
  ggplot(aes(x = PC1,
             y = PC3)) +
  geom_point(aes(colour = Sacramento$type), alpha = 0.4)

pca_data %>%
  ggplot(aes(x = PC2,
             y = PC3)) +
  geom_point(aes(colour = Sacramento$type), alpha = 0.4)



## ------------------------------------------------------------------------
# library(parsnip)
names(mtcars)

mtcars %>%
  ggplot(aes(x = disp,
             y = mpg)) +
  geom_point()


norm_recipe <- 
  recipe(
    mpg ~ disp, 
    data = mtcars) %>% 
  # estimate the means and standard deviations
  prep(training = mtcars, retain = TRUE)


lin_reg <- linear_reg(mode = "regression") %>%
  set_engine("lm") %>%
  fit(mpg ~ disp, data = mtcars) %>%
  broom::tidy()

lin_reg   

## plot the line in the scatterplot
mtcars %>%
  ggplot(aes(x = disp,
             y = mpg)) +
  geom_point() +
  geom_abline(intercept = lin_reg$estimate[1],
              slope = lin_reg$estimate[2])



## ------------------------------------------------------------------------
norm_recipe_multiple <- 
  recipe(
    mpg ~ ., 
    data = mtcars) %>% 
  # estimate the means and standard deviations
  prep(training = mtcars, retain = TRUE)

lin_reg_multiple <- linear_reg(mode = "regression") %>%
  set_engine("lm") %>%
  fit(mpg ~ ., data = mtcars) 

lin_reg_multiple %>%
  broom::tidy()


## plot the line in the scatterplot
mtcars %>%
  ggplot(aes(x = wt,
             y = mpg)) +
  geom_point() +
  geom_abline()

mtcars %>%
  ggplot(aes(x = drat,
             y = mpg)) +
  geom_point() +
  geom_abline()




## ------------------------------------------------------------------------
cars_split <- initial_split(mtcars)
cars_train <- training(cars_split)
cars_test <- testing(cars_split)

## to prevent 'leakage of test data into the training set, we apply the recipe to the training set only
norm_recipe_train <- 
  recipe(
    mpg ~ ., 
    data = cars_train) %>% 
  # estimate the means and standard deviations
  prep(training = cars_train, retain = TRUE)

lin_reg_train <- linear_reg(mode = "regression") %>%
  set_engine("lm") %>%
  fit(mpg ~ ., data = juice(norm_recipe_train)) 


preds <- predict(object = lin_reg_train, new_data = cars_test)

## check performance
validate <- dplyr::bind_cols(mpg_original = cars_test$mpg, 
                             predictions = preds$.pred)

validate %>%
  ggplot(aes(x = mpg_original,
             predictions)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0)


## ------------------------------------------------------------------------

rand_forest_fit <- rand_forest(mode = "regression") %>%
  set_engine("ranger") %>%
  fit(mpg ~ ., data = juice(norm_recipe_train)) 

rand_forest

preds <- predict(object = rand_forest_fit, new_data = cars_test)

## check performance
validate <- dplyr::bind_cols(mpg_original = cars_test$mpg, 
                             predictions = preds$.pred)

validate %>%
  ggplot(aes(x = mpg_original,
             predictions)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0)




## ------------------------------------------------------------------------
library(AmesHousing)
ames <- make_ames()

library(tidymodels)

set.seed(4595)
## use stratification
data_split <- initial_split(ames, strata = "Sale_Price", p = 0.75)

ames_train <- training(data_split)
ames_test  <- testing(data_split)



## ------------------------------------------------------------------------
rf_defaults <- rand_forest(mode = "regression")
rf_defaults

## using the formula approach
rand_forest(mode = "regression", mtry = 3, trees = 1000) %>%
  set_engine("ranger") %>%
  fit(
    log10(Sale_Price) ~ Longitude + Latitude + Lot_Area + Neighborhood + Year_Sold,
    data = ames_train
  )


## ------------------------------------------------------------------------

norm_recipe <- 
  recipe(
    Sale_Price ~ Longitude + Latitude + Lot_Area + Neighborhood + Year_Sold, 
    data = ames_train
  ) %>%
  step_other(Neighborhood) %>% 
  step_dummy(all_nominal()) %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  step_log(Sale_Price, base = 10) %>% 
  # estimate the means and standard deviations
  prep(training = ames_train, retain = TRUE)

# Now let's fit the model using the processed version of the data

glmn_fit <- 
  linear_reg(penalty = 0.001, mixture = 0.5) %>% 
  set_engine("glmnet") %>%
  fit(Sale_Price ~ ., data = juice(norm_recipe))


glmn_fit


test_normalized <- bake(norm_recipe, new_data = ames_test, all_predictors())

pred <- predict(glmn_fit, new_data = test_normalized) 

results <- dplyr::bind_cols(ames_test, pred)
names(results)
results %>%
  ggplot(aes(x = Sale_Price, y = .pred)) +
  geom_point()



## ------------------------------------------------------------------------

iris_pca <- function(center, scale){

data(iris)
iris <- tibble::as_tibble(iris)
log_iris <- log(iris[, 1:4]) ## only numeric variables can be used for PCA
iris_species <- iris[, 5] ## labels

iris_pca <- stats::prcomp(log_iris,
                   center = center,
                   scale = scale) 

plot <- as_tibble(iris_pca$x) %>%
  mutate(description = iris_species$Species) %>%

  ggplot(aes(x = PC1, y = PC2, color = description)) +
  geom_point() +
  theme_bw() 

return(plot)

}

iris_pca(scale = FALSE, center = FALSE)
iris_pca(scale = TRUE, center = TRUE)



## ------------------------------------------------------------------------
data(segmentationOriginal)
segmentationOriginal %>% as_tibble()

## Retain the original training set
segTrain <- subset(segmentationOriginal, Case == "Train")

## Remove the first three columns (identifier columns)
segTrainX <- segTrain[, -(1:3)]
segTrainClass <- segTrain$Class

## difference between max an minimal value (cutoff 20x)
max(segTrainX$VarIntenCh3)/min(segTrainX$VarIntenCh3)
skewness(segTrainX$VarIntenCh3)

## Use caret's preProcess function to transform for skewness
segPP <- preProcess(segTrainX, method = "BoxCox")

## Apply the transformations
segTrainTrans <- predict(segPP, segTrainX)

## Results for a single predictor
segPP$bc$VarIntenCh3

histogram(~segTrainX$VarIntenCh3,
          xlab = "Natural Units",
          type = "count")

histogram(~log(segTrainX$VarIntenCh3),
          xlab = "Log Units",
          ylab = " ",
          type = "count")


## ---- eval=FALSE---------------------------------------------------------
## learnr::run_tutorial("adventr_log", package = "adventr")

