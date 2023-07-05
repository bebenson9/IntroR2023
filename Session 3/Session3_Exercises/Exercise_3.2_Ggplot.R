### Exercise 3.2  - plotting with ggplot

# useful commands: 

### Questions ------------------------------------------------------------------
# Use the UScereal data set for this exercise too  

#  01. Make a scatterplot of protein vs fibre content (using ggplot), color the points by manufacturer


#  02. Make a box plot of sugar content by manufacturer, facet_wrapped by shelf; add jittered points that are partially transparent
  # note: shelf is stored in this data set as a numeric value, but to treat it as a categorical variable (necessary for a box plot), you must first change the class to a factor 
  # UScereal[,'shelf'] <- as.factor(UScereal[,'shelf'])
  # note: what does it mean when you don't see a full box for a certain shelf, or if there is only a line? 


#  03. Make a histogram of the carbohydrate content in all cereals. Label the x axis "Carbohydrates (g)"




