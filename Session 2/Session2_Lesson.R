## Session 2 Lesson

###############################
##### 2.1 GET DATA INTO R #####
###############################

# useful commands: getwd(), setwd(), read.csv(), list.files()

## We saw earlier how to get data into R from a package,
##  but what if we have a file saved outside of R?
# first, we need to figure out which directory, a.k.a. folder, R is looking in
# getwd()


# we can change this to a useful folder
# setwd()


# it's also possible to setwd through the "Session" menu of RStudio


# Then, we can see which files are in the current directory
# list.files()


# Which .csv file is present?


## We can read in csv files with read.csv()
##  and tab delimited files with read.table()
# read.csv()


# the option "stringsAsFactors" may be relevant in other datasets
#  check out how to use it in the help for read.csv()


################################
##### 2.2 CLEANING UP DATA #####
################################

# useful commands: duplicated(), is.na(), na.omit(), complete.cases(), duplicated(), !duplicated()


### NAs and missing values
## NA is another special value, like TRUE or FALSE
## it is the placeholder for missing data in R
# check whether a value is NA
# is.na()


# add 1 to NA


# we need to treat "NA" differently than other values
# R recognizes this as a numeric, but it is missing data
# this is a a logical -- indicating missing data
# index of values that are NA


# index of values that are not NA

# keep only non-missing values in a vector

# set missing values to NA 
# e.g. if "." stands in for missing in your raw data
z = c("Tuesday", "Monday", ".", ".", "Friday")

## One way to clean up data is to remove incomplete rows (those with NAs) from a data.frame
test = data.frame(
  x = c("a", "b", "c", "d", "d"),
  y = c(1, 2, 3, 4, NA))

# check what this new data frame looks like


# na.omit()


# na.exclude() does about the same thing


# Sometimes, we want to know which rows are complete (have no NA values)? 
# complete.cases() - looks along each row, and each column, for NA values


# Subset the data frame using complete.cases()


## We also might have messy data where rows were recorded multiple times
##  We might want to get rid of these duplicate entries
test2 = data.frame(
  x = c("a", "b", "c", "d", "d"),
  y = c(1, 2, 3, 4, 4))


# duplicated()


# isolate duplicated rows


# index non-duplicated rows


# remove duplicated rows


## Sometimes, we want to set NA values to zero
# is.na() and subsetting


########################
##### 2.3 PLOTTING #####
########################

# useful commands: plot, points, lines, abline, hist, barplot, boxplot
# useful arguments within plot(): main, xlab, ylab, col, pch, cex

## Load cereal dataset from MASS package
#install.packages("MASS") #should have installed from yesterday


## Scatterplots
# plot() -- to make a scatterplot
# plot calories versus sugar content

# or plot response variable as a function "~" of the predictor variable

## Arguments within plotting functions
# "col" argument changes color

# "pch" argument changes point character

# "cex" argument changes size

# "type" argument changes type ("l" = line, "p" = points, "b" = both)
# "lty" argument changes line type

# Adding labels to axes and title using "xlab", "ylab", and "main" arguments

# identify() to identify on specific points

# points() adds points to existing plot

# ablines() adds straight line to existing plot

# legend() to add legend to plot


## Histograms
# make histogram of sugar content

##Barplots
# make barplot of manufacturers in dataset

#add color using rainbow()

##Boxplots
# make boxplot of sugar content versus shelf display

#########################
##### 2.4 FUNCTIONS #####
#########################

# functions
# function ( list of arguments )  { body }

#make function that takes a number, x, and returns its square


#test my function works


# ? to access R documentation for functions (optional arguments, examples, etc.)


# new function - paste()
#first, read documentation


#using paste()

#########################
##### 2.5 TIDYVERSE #####
#########################
