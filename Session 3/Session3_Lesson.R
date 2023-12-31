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





# why doesn't R keep all packages loaded all the time? 
# one reason is conflicts in the names of functions
# e.g., filter() does different things depending on which package it's being used as a part of 
# you can specify which package you are calling on for a function by using two colons
  # package::function()
  # e.g. dplyr::filter()

# load the diamonds data set, which is built in to tidyverse/ggplot  



# note that the tidyverse stores data in "tibbles"
# tibbles are equivalent to "data frames" in base R



### useful tidyverse functions: mutate(), summarize(), filter(), select(), arrange(), count(), rename()

### mutate() ###
# creates new columns that are functions of existing variables. it can also modify or delete columns
# the tidyverse uses a pipe (%>%) to organize strings of commands
# begin by specifying your object, then follow with a pipe, then your functions

# what is the price per carat for each diamond? 


# note that the tidyverse does not require you to specify the data set after the pipe—it just recognizes the column names! 

### summarize() ### 
# creates a new data frame that returns one row for each combination of grouping variables
# if there are no grouping variables, the output will have a single row summarizing all observations in the input
# what are the min/max/mean/sd for the price of the diamonds in this data set?
  # no grouping variables






# what about the min/max/mean/sd for each type of cut? 
  # grouping variable = cut







# what about the min/max/mean/sd for each cut x color combination? 
  # grouping variables = cut, color 






# note that you cannot see all rows in the console output 
# we can fix this by adding another pipe and a command to print more rows 







# there are 35 cut x color combinations, so any number ≥ 35 works here

### filter() allows you to subset a data frame by retaining all rows that satisfy a logical condition (keep rows for which the condition = TRUE)

# filter for all diamonds costing ≥ $1000

# note that this line does not create a new object as it is currently written

# if you wanted to know how many rows are in the subset of diamonds costing ≥ $1000, you would either need to make a new object or string the command with a pipe



# or



# filter for all diamonds costing ≥ $1000 and with an ideal cut 


# or  



# or 


# select() allows you to keep or drop columns using their name and/or class
# suppose we are only interested in price and carats


# or 



# suppose we want to keep everything except the dimensions (x, y, and z in the data set)


# or 



# keep only the columns from carat to clarity 


# or



### arrange() allows you to reorder the rows in a data set based on selected columns
# arrange the rows from least to most expensive diamond

# from most expensive to least expensive 

# arrange by cut then price from lowest to highest 





### count() counts the unique values of one or more variables


# our output tells us that there are 1610 fair diamonds in the data set, 4906 good ones, and so on 


### rename() changes the names of columns/variables 
# change 'price' to 'cost'

                 # rename(new column name = old column name)
         # to see the new column name 


#################################
##### 3.2 PLOTTING (GGPLOT) #####
#################################
# we use a pipe to direct our plotting commands to the data set we care about 
# then, we use the command ggplot()
# ggplot uses the nested aes() function to describe how variables in the data are mapped to the plot
  # always specify your variables within aes()!
# we add elements to our plots following the initial ggplot() function by adding '+' to the end of a line




# let's go ahead and remove the ugly gray background grid
# theme_bw()





# color the points by cut





# we can use facet_wrap to split our plot into multiple panes for different groups





# make it so that the panes are in a 1 x 5 arrangement






# ggplot has many plot types
# let's look at the price distribution for diamonds between 2 and 3 carats across the 5 cuts





# boxplots are useful for summarizing the data, but sometimes we want to see each data point
# we can add more than one type of aesthetic to a graph





# geom_jitter is similar to geom_point, but it spreads the points out by a certain amount along the x axis so that they don't overlap 
  # width changes how much spread there is in the points along the x axis-- too little and you can't see them individually, too much and they will bleed into adjacent groups
  # alpha changes the transparency of an element 

# we can change the titles and other things like that in ggplot, just as we do in base R









# why does this plot look funny? 
# boxplots don't make sense for two continuous variables 
# different plot types will work for different types of data

# histograms require an x axis only 







