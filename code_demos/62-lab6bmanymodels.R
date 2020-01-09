## ------------------------------------------------------------------------
library(tidyverse)
library(dslabs)
library(toolboxr)
africa <- gapminder %>%
  dplyr::filter(continent == "Africa")
  


## ------------------------------------------------------------------------
africa <- africa %>%
  mutate(welfare_index = (life_expectancy*gdp)/1000)



## ------------------------------------------------------------------------
africa %>%
  ggplot(aes(x = year, y = welfare_index)) +
  geom_line(aes(group = country, colour = country), 
            show.legend = FALSE, size = 1) 


## ------------------------------------------------------------------------
africa %>%
  ggplot(aes(x = year, y = log10(welfare_index))) +
  geom_line(aes(group = country, colour = country), 
            show.legend = FALSE, size = 1) 


## ------------------------------------------------------------------------

africa_nested <- africa %>%
  dplyr::group_by(country) %>%
  nest()

names(africa_nested$data) <- africa_nested$country 

## to get lm coefficients
## dummy
.data = africa_nested$data[[1]]

get_lm <- function(.data){
  
  model <- lm(welfare_index ~ year, data = .data)
  params <- model %>% broom::tidy()  

  x <- summary(model) 
 r <- x$r.squared 
  return(r)
}

africa_nested <- africa_nested %>%
  mutate(r_squared_lm = map(data, get_lm))

africa_nested <- africa_nested %>%
  mutate(r = as.numeric(r_squared_lm))
  
fluctuations <- africa_nested %>%
  dplyr::filter(r < 0.75) 


fluctuations %>%
  ggplot(aes(x = reorder(as_factor(country), r), y = r)) +
  geom_point() +
  rotate_axis_labels(axis = "x", angle = 45) + 
  ylab("R-squared") +
  xlab("African Country")

ggsave("fluctuations.svg", height = 7)


africa %>%
  dplyr::filter(country %in% fluctuations$country) %>%
  ggplot(aes(x = year, y = log10(welfare_index))) +
  geom_line(aes(group = country, colour = country), 
            show.legend = TRUE, size = 1) 


