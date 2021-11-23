## BIOL 427 Data tidying bird surveys at an old growth and new growth site
## Author: Juniper Malloff 
# Last updated: 2021/11/22

library(tidyverse)
library(lubridate)
library(vegan)



## load raw field data
birdcounts_raw <- read.csv("raw data/B427fielddata_raw.csv")


##change date and time variables from character to respective object types.

birdcounts_raw$date <- as_date(birdcounts_raw$date, format = "%d-%m-%Y")
birdcounts_raw$sunrise <- hms(birdcounts_raw$sunrise)

## Pivot dataset wider to have every sample be a line. This will allow for diversity indicies to be calculated per each sample

birdcounts <- birdcounts_raw %>%
  subset(select = -c(notes)) %>%
  pivot_wider(names_from = species, values_from = count, values_fill = 0)






