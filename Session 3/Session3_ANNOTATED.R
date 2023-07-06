### Tuesday, July 11th
### This lesson is is partially adapted from Chapter 4 of the the R for Graduate Students textbook by Y. Wendy Huynh
# https://bookdown.org/yih_huynh/Guide-to-R-Book/tidyverse.html
# Note: this whole book is a great resource! 


##################################
##### 3.1 INTRO TO TIDYVERSE #####
##################################

# so far, we have focused on functions in base R 
# several widely used packages are preferred by many for data wrangling and visualization 
# tidyverse is a composite package that includes many other packages that could otherwise be installed independently (e.g., dplyr, forcats, ggplot2)
# packages in the tidyverse all share underlying design philosophy, grammar, and data structures  

install.packages('tidyverse')

library(tidyverse)

# why doesn't R keep all packages loaded all the time? 
# one reason is conflicts in the names of functions
# e.g., filter() does different things depending on which package it's being used as a part of 
# you can specify which package you are calling on for a function by using two colons before it
  # package::function()
  # e.g. dplyr::filter()

# load the diamonds data set, which is built in to tidyverse/ggplot  
data(diamonds)
?diamonds
str(diamonds)
# note that the tidyverse stores data in "tibbles"
# tibbles are equivalent to "data frames" in base R

head(diamonds)

### useful tidyverse functions: mutate(), summarize(), filter(), select(), arrange(), count(), rename()

### mutate() ###
# creates new columns that are functions of existing variables. it can also modify or delete columns
# note: the tidyverse uses a pipe (%>%) to organize strings of commands
# begin by specifying your object, then follow with a pipe, then your functions

# what is the price per carat for each diamond? 
diamonds %>% 
  mutate(caratprice = price/carat)
# note that the tidyverse does not require you to specify the data set with the column after the pipe—it just recognizes the column names! 

### summarize() ### 
# creates a tibble  that returns one row for each combination of grouping variables
# you supply which functions you want to be included in the summary
# if there are no grouping variables, the output will have a single row summarizing all observations in the input
# what are the min/max/mean/sd for the price of the diamonds in this data set?
  # no grouping variables
diamonds %>% 
  summarize(min(price),
            max(price),
            mean(price),
            sd(price))

# what about the min/max/mean/sd for each type of cut? 
  # grouping variable = cut
diamonds %>% 
  summarize(.by = cut, 
            min(price),
            max(price),
            mean(price),
            sd(price))

# what about the min/max/mean/sd for each cut x color combination? 
  # grouping variables = cut, color 
diamonds %>% 
  summarize(.by = c(cut,color), 
            min(price),
            max(price),
            mean(price),
            sd(price)) 
# note that you cannot see all rows in the console output 
# we can fix this by adding another pipe and a command to print more rows 
diamonds %>% 
  summarize(.by = c(cut,color), 
            min(price),
            max(price),
            mean(price),
            sd(price)) %>%
  print(n=50) 
# there are 35 cut x color combinations, so any number ≥ 35 works here

### filter() allows you to subset a data frame by retaining all rows that satisfy a logical condition (keep rows for which the condition = TRUE)
# filter for all diamonds costing ≥ $1000
diamonds %>% filter(price >= 1000)
# note that this line does not create a new object as it is currently written

# if you wanted to know how many rows are in the subset of diamonds costing ≥ $1000, you would either need to make a new object or string the command with a pipe
nrow(diamonds)
diamonds.1000 <- diamonds %>% filter(price >= 1000)
nrow(diamonds.1000)
# or
diamonds %>% filter(price >= 1000) %>%
  nrow()

# filter for all diamonds costing ≥ $1000 and with an ideal cut 
diamonds %>% 
  filter(price >= 1000 & cut == 'Ideal')
# or  
diamonds %>% 
  filter(price >= 1000) %>%
  filter(cut == 'Ideal')
# or 
filter(diamonds, price >= 1000 & cut == 'Ideal')

# select() allows you to keep or drop columns using their name and/or class
# suppose we are only interested in price and carats
diamonds %>%
  select(carat,price)
# or 
diamonds %>%
  select(c(carat,price))

# suppose we want to keep everything except the dimensions (x, y, and z in the data set)
diamonds %>%
  select(-x,-y,-z)
# or 
diamonds %>%
  select(-x:-z)

# keep only the columns from carat to clarity 
diamonds %>%
  select(carat:clarity)
# or
diamonds %>%
  select(1:4)

### arrange() allows you to reorder the rows in a data set based on selected columns
# arrange the rows from least to most expensive diamond
diamonds %>% arrange(price)
# from most expensive to least expensive 
diamonds %>% arrange(-price)
# arrange by cut, then price from lowest to highest within each cut type
diamonds %>% 
  group_by(cut) %>%
  arrange(price, .by_group = TRUE)
?group_by

### count() counts the unique values of one or more variables
diamonds %>%
  count(cut)
# our output tells us that there are 1610 fair diamonds in the dataset, 4906 good ones, and so on 


### rename() changes the names of columns/variables 
# change 'price' to 'cost'
diamonds %>%
  rename(cost = price) %>% # rename(new column name = old column name)
  head() # to see the new column name 


#################################
##### 3.2 PLOTTING (GGPLOT) #####
#################################
# we use a pipe to direct our plotting commands to the data set we care about 
# then, we use the function ggplot()
# ggplot uses the nested aes() function to describe how variables in the data are mapped to the plot
  # always specify your variables within aes()!
# we add elements to our plots following the initial ggplot() function by adding '+' to the end of a line

# Create a scatterplot of carat vs. price
diamonds %>% 
  ggplot(aes(x=carat,y=price))+ 
  geom_point()

# let's go ahead and remove the ugly gray background grid
# theme_bw()
diamonds %>% 
  ggplot(aes(x=carat,y=price))+ 
  theme_bw()+ # this line creates a gridded white background
  geom_point()

# color the points by cut
diamonds %>% 
  ggplot(aes(x=carat,y=price))+ 
  theme_bw()+
  geom_point(aes(color = cut))

# the graph above has a lot of data 
# we can use facet_wrap to split our plot into multiple panes for different groups
diamonds %>% 
  ggplot(aes(x=carat,y=price))+ 
  theme_bw()+
  geom_point(aes(color = cut))+
  facet_wrap(~cut)

# make it so that the panes are in a 1 x 5 arrangement
diamonds %>%  
  ggplot(aes(x=carat,y=price))+ 
  theme_bw()+
  geom_point(aes(color = cut))+
  facet_wrap(~cut,1,5)

# ggplot has many plot types
# let's look at the price distribution for diamonds between 2 and 3 carats in size, across the 5 cut types
diamonds %>%
  filter(carat >= 2.5 & carat <= 3) %>%
  ggplot(aes(x = cut, y = price))+
  theme_bw()+
  geom_boxplot()

# boxplots are useful for summarizing the data, but sometimes we want to see each data point
# we can add more than one type of aesthetic to a graph
diamonds %>%
  filter(carat >= 2.5 & carat <= 3) %>%
  ggplot(aes(x = cut, y = price))+
  theme_bw()+
  geom_boxplot()+
  geom_jitter(width = 0.2, alpha = 0.3)
# geom_jitter is similar to geom_point, but it spreads the points out by a certain amount along the x axis so that they don't overlap 
  # width changes how much spread there is in the points along the x axis-- too little and you can't see them individually, too much and they will bleed into adjacent groups
  # alpha changes the transparency of an element 

# we can change the titles and other things like that in ggplot, just as we do in base R
diamonds %>%
  filter(carat >= 2.5 & carat <= 3) %>%
  ggplot(aes(x = cut, y = price))+
  geom_boxplot()+
  theme_bw()+
  geom_jitter(width = 0.2, alpha = 0.3)+
  labs(x='Cut Quality', y='Price ($)',title = 'Price Distribution by Cut Quality')

diamonds %>%
  filter(carat >= 3 & carat <= 4) %>%
  ggplot(aes(x = carat, y = price))+
  theme_bw()+
  geom_boxplot()
# why does this plot look funny? 
# boxplots don't make sense for two continuous variables 
# different plot types will work for different types of data

# histograms require an x axis only 
diamonds %>%
  ggplot(aes(x = price))+
  theme_bw()+
  geom_histogram()

