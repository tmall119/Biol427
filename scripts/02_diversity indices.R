## BIOL 427 Calculating Diversity Indicies and statistical tests on bird counts at an old growth and new growth site
## Author: Juniper Malloff 
# Last updated: 2021/11/22

library(tidyverse)
library(vegan)

# load tidy data file
birdcounts <- read.csv("tidy data/B427fielddata_tidy.csv")


# calculate species abundance and test difference using a Welch's t-test



