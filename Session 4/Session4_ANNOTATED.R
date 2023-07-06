### Friday, July 14th

# load tidyverse and MASS packages
library(tidyverse)
library(MASS)

##############################################
#### 4.1 DESCRIPTIVE STATS & CORRELATIONS ####
##############################################
# load the UScereal data set
data(UScereal)

# before we get into hypothesis testing, we can get some descriptive statistics
# a frequency table counts the number of observations in each of several groups
# how many cereals are there from each manufacturer?
table(UScereal$mfr)
# recall, we can do the same thing with count() using tidyverse!

# we can convert frequencies to proportions with prop.table()
prop.table(table(UScereal$mfr))

# what if we want to know how many cereal brands there are for each manufacturer x shelf combination? 
table(UScereal$mfr, UScereal$shelf)

### Correlations 
# correlation measures the degree to which two variables are associated with one another 
# correlations range from -1 to 1 where -1 is a perfect inverse correlation and 1 is a perfect positive correlation (0 indicates no correlation)

# Question: are carbohydrate and protein content correlated? 
?cor()
# Pearson correlation 
cor(UScereal$carbo,UScereal$protein)
# yes, moderate to strongly positive correlation 
# whether or not a correlation is weak or strong depends on the kind of data you have
# in data sets with lots of "noise," it is harder to tease apart relationships among variables 
# in ecology, 0.5 is often good evidence of a strong correlation! 
 
# correlations among multiple variables
cor(UScereal[,c('carbo','sugars','protein','fibre','fat')])
# some nutrient types are strongly correlated (e.g. fiber and protein) while others only modestly so or not at all (e.g. carbs and sugars)

# we can visualize the strength of correlations among many variables using the corrplot package
install.packages('corrplot')
library(corrplot)
cors <- cor(UScereal[,c('carbo','sugars','protein','fibre','fat')])
corrplot(cors, method = 'color')

# which of these correlations are significant? 
install.packages('lsr')
library(lsr)
correlate(cors, test = TRUE, corr.method = 'pearson')

######################################
#### 4.2 SIMPLE LINEAR REGRESSION ####
######################################
# load the diamonds data set
data(diamonds)

# linear regression allows us to test the relationship between predictor (explanatory or independent) variables and response (dependent) variables
# linear regression is a powerful predictive tool: once we have an equation that describes the relationship between two variables, we can predict values of y for given values of x

# Question: what is the effect of a diamond's size on its price for 'very good' diamonds?
# first let's visualize it
diamonds %>%  
  filter(cut == 'Very Good')%>%
  ggplot(aes(x=carat,y=price))+ 
  theme_bw()+
  geom_point()
# it doesn't look quite linear, but linear is good enough for our purposes

# add a line
diamonds %>%  
  filter(cut == 'Very Good')%>%
  ggplot(aes(x=carat,y=price))+ 
  theme_bw()+
  geom_point()+
  geom_smooth(method = 'lm')
# what does this plot show us about predicting the price of large diamonds? 
# a linear model will not do a good job of predicting the cost of large diamonds (points fall far below the line on the price axis)

# now let's put numbers to this
# create a linear model of price vs carat for very good diamonds
# first, create an object for just very good diamonds 
diamonds.vg <- diamonds %>%
  filter(cut == 'Very Good') 
# linear regression for price vs. carat for very good diamonds
  # create an object for a linear model using the function lm()
  # ?lm()
  # lm(response~predictor, dataset)
mod1 <- lm(price~carat, diamonds.vg)
summary(mod1)

### PASTE OUTPUT BELOW ####

      # Call:
      #   lm(formula = price ~ carat, data = diamonds.vg)

      # Residuals:
      #   Min       1Q   Median       3Q      Max 
      # -14878.3   -852.6    -72.4    590.9  12706.2 

      # Coefficients:
      #   Estimate Std. Error t value Pr(>|t|)    
      # (Intercept) -2417.66      27.24  -88.74   <2e-16 ***
      #   carat        7935.97      29.35  270.35   <2e-16 ***
      #   ---
      #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

      # Residual standard error: 1482 on 12080 degrees of freedom
      # Multiple R-squared:  0.8582,	Adjusted R-squared:  0.8582 
      # F-statistic: 7.309e+04 on 1 and 12080 DF,  p-value: < 2.2e-16

# how do we interpret this model output? 
# residuals describe how far off the linear fit is from the actual data 

# coefficients give us our slope and intercept 
  # our equation (y = mx + b)
  #              predicted price = 7935.97(carat) - 2417.66
  # this predicts that a size increase of 1 carat will increase our price by $7936

  # our intercept will be significant if it is significantly different from 0 (we usually don't care if this is significant)
  # the significance of our slope reveals the strength of the influence of x on y 
  # the p value for our slope is extremely small; we can interpret this to mean that there is <<< 0.1% chance that there is NOT a relationship between carat and price (i.e., that the slope is 0)

# our adjusted R-squared value = 0.8582
# we can interpret R-squared values in the following way:
  # [#]% of the variation in y can be explained by the variation in x 
  # here, about 85% of the variation in diamond prices for very good diamonds can be attributed to variation in diamond size (carat)


#################################
#### 4.3 MULTIPLE REGRESSION ####
#################################

# so far we have only looked at one predictor variable at a time
# but what about when there are multiple variables influencing an outcome? 
# Question: what is the effect of a diamond's size and clarity on its price?
# Hypothesis: Larger diamonds will be more expensive, and higher clarity diamonds will also be more expensive  
# first let's visualize it
# note: there is not one single correct way to visualize any particular hypothesis
# plot price vs. carat 
diamonds %>%  
  ggplot(aes(x=carat,y=price))+
  theme_bw()+
  geom_point()+
  geom_smooth(method = 'lm')
# this graph doesn't give us any information about our other predictor variable, clarity

# we can color the points to reflect the clarity rating
diamonds %>%  
  ggplot(aes(x=carat,y=price, color = clarity, group_by(clarity)))+ 
  theme_bw()+
  geom_point()
# higher clarity diamonds appear to have a steeper slope than lower quality diamonds (IF = best)

# we can use group_by() to allow the slope of our regression to vary with clarity 
diamonds %>%  
  ggplot(aes(x=carat,y=price, color = clarity, group_by(clarity)))+ 
  theme_bw()+
  geom_point()+
  geom_smooth(method = 'lm')
# now we have 8 lines, one for each clarity rating that describes the relationship between diamond size and price

# now let's put numbers to it!
mod2 <- lm(price~carat*clarity, diamonds)
summary(mod2)
