### Exercise 3.1  - working in the tidyverse 

# useful commands: mutate(), summarize(), select()**, filter(), arrange(), rename()

### Questions ------------------------------------------------------------------

#  01. Load the UScereal data set in the MASS package (load the tidyverse package too)
        library(MASS)
        data(UScereal)
        library(tidyverse)

#  02. Create a new column (using tidyverse) to get the ratio of carbs to sugars in each cereal
        UScereal %>%
          mutate(ratio = carbo/sugars)
        
#  03. Summarize the distribution of sodium content in General Mills cereals
        UScereal %>%
          filter(mfr == 'G') %>%
          summarize(min(sodium),
                    max(sodium),
                    mean(sodium),
                    sd(sodium))

# 04. Summarize the distribution of sodium content for each manufacturer 
        UScereal %>%
          summarize(.by = 'mfr',
                    min(sodium),
                    max(sodium),
                    mean(sodium),
                    sd(sodium))

# 05. Subset the data so that only columns containing numerical values remain
        # hint: functions may be masked by conflicting packages 
        UScereal %>%
          dplyr::select(-mfr,-vitamins)
        #or
        UScereal %>%
          dplyr::select(where(is.numeric))

# 06. Subset the data so that it only contains cereals with <3 g fat, > 300 mg sodium, and < 30 g carbs
        UScereal %>%
          filter(fat < 3) %>%
          filter(sodium > 300) %>%
          filter(carbo < 30)
        
# 07. Rearrange the data set so that cereals are grouped by manufacturer and arranged from lowest to highest protein content 
        UScereal %>%
          group_by(mfr)%>%
          arrange(protein, .by_group = TRUE)
        
# 08. Rename the carbo column to carbohydrates
        UScereal %>%
          rename(carbohydrates = carbo)
        
        