## BIOL 427 Calculating Diversity Indicies and statistical tests on bird counts at an old growth and new growth site
## Author: Juniper Malloff 
# Last updated: 2021/11/24

library(tidyverse)
library(vegan)
library(ggplot2)

# load tidy data file
birdcounts <- read.csv("tidy data/B427fielddata_tidy.csv")


# calculate species abundance and test difference using a Welch's t-test

birdcounts_rich <- mutate(birdcounts, sp_num = specnumber(birdcounts[8:33]))

birdcounts_rich_old <- birdcounts_rich %>%
  subset(site == "Old")

birdcounts_rich_new <- birdcounts_rich %>%
  subset(site == "New")

t.test(birdcounts_rich_old$sp_num, birdcounts_rich_new$sp_num)


# calculate Simpsons Index between sites

birdcounts_simp <- mutate(birdcounts, simpson = diversity(birdcounts[8:33], index = "simpson"))

birdcounts_simp_old <- birdcounts_simp %>%
  subset(site == "Old")

birdcounts_simp_new <- birdcounts_simp %>%
  subset(site == "New")

## subtract old from new, run paired T
t.test(birdcounts_simp_old$simpson, birdcounts_simp_new$simpson)

t.test(birdcounts_simp_new$simpson, birdcounts_simp_old$simpson, paired = TRUE)

ggplot(birdcounts_simp) + geom_col(aes(date, simpson, fill = site), position = "dodge") + theme_classic()

ggplot(birdcounts_simp) + 
  geom_boxplot(aes(site, simpson)) +
  geom_point(aes(site, simpson)) + 
  geom_line(aes(site, simpson, group = date))+
  theme_classic()

  





