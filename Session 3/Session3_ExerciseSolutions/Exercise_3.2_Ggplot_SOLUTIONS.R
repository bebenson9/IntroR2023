### Exercise 3.2  - plotting with ggplot

# useful commands: 

### Questions ------------------------------------------------------------------
# Use the UScereal data set for this exercise too  

#  01. Make a scatterplot of protein vs fibre content (using ggplot), color the points by manufacturer
UScereal %>%
  ggplot(aes(x = protein, y = fibre))+
  geom_point(aes(col = mfr))

#  02. Make a box plot of sugar content by manufacturer, facet_wrapped by shelf; add jittered points that are partially transparent
  # note: shelf is stored in this data set as a numeric value, but to treat it as a categorical variable (necessary for a box plot), you must first change the class to a factor 
  # UScereal[,'shelf'] <- as.factor(UScereal[,'shelf'])
  # note: what does it mean when you don't see a full box for a certain shelf, or if there is only a line? 
UScereal %>%
  ggplot(aes(x = shelf, y = sugars))+
  geom_boxplot(aes(col = shelf))+
  geom_jitter(aes(col = shelf, alpha = 0.3),width = 0.2)+
  facet_wrap(~mfr)
# if there is no data available for a certain variable combination, a box will not appear
# if there is only a line, it means there is only one observation for that variable combination (no distribution to build a box around)

#  03. Make a histogram of the carbohydrate content in all cereals. Label the x axis "Carbohydrates (g)"
UScereal %>%
  ggplot(aes(x = carbo))+
  geom_histogram()
  labs(x = 'Carbohydrates (g)')


