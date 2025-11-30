#install packages
#renv::install(c("tidyverse", "GGally", "plotly", "ggpubr", "ggplot2"))


#Load library
library(tidyverse)
library(GGally)
library(ggplot2)
library(ggpubr)
library(renv)


#load data

data("iris")

#explore data set

head(iris)

summary(iris)

#Data wrangling

#only mean of numeric columns
iris %>% summarize_if(is.numeric, mean)

str(iris)

#show data set in a table
data(iris)
iris <- as_tibble(iris)
iris

#Visualization

#pairs plot to visualize relationships between different variables
#https://rpubs.com/analystben/chapter-2
#show scatterplots of each variables
#s <- iris %>% slice_sample(n = 15)
#ggpairs(s, aes(color = Species))
#does not work


#tidyverse: first using dataset, then removing rows missing data, 
#then removes duplicate

clean.data<-iris %>% drop_na() %>% unique ()
summary(clean.data)

#Summarize the whole data set for each species:1. mean/2. median
#1
iris %>% group_by(Species) %>% summarize_all(mean)
#2
iris %>% group_by(Species) %>% summarize_all(median)


#Sampling
#random: size 10 for ABC
sample(c("A", "B", "C"), size = 10, replace = TRUE)

#random for Iris dataset size 15

take <- sample(seq(nrow(iris)), size = 15)
take

set.seed(1000)


#Principal component analysis
# According to the blog owner library(plotly) # I don't load the package because
#it's namespace clashes with select in dplyr.
#shows #D scatterplot of the irsi dataset
plotly::plot_ly(iris, x = ~Sepal.Length, y = ~Petal.Length, z = ~Sepal.Width,
                size = ~Petal.Width, color = ~Species, type="scatter3d")

#perform principal component 
#PCA is used to reduce the dimensionality of the data by transforming it into
#a new set of variables that explain the maximum amount of variance in the dataset.
#select dataset and then variables except species
pc <- iris %>% select(-Species) %>% as.matrix() %>% prcomp()
summary(pc)

plot(pc, type= "line")

#more features here: https://rpubs.com/analystben/chapter-2 or here:
#https://kelseyandersen.github.io/NetworksPlantPathology/APS2018_Tidyverse.html

#Visualization using ggplot

box_petal <- ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot(alpha = 0.6) +
  labs(title = "Petal Length Distribution by Species",
       x = "Species",
       y = "Petal Length (cm)") +
  theme_classic()

box_petal

#per group
head(iris)
scatter_petal <-ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  geom_smooth ()

scatter_petal

help(sandbox)

#saving state of the library
renv::sandbox
renv::snapshot()
renv::lockfile_read()
renv::activate()
renv::lockfile_read()
renv::paths$sandbox()
