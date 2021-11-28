## BIOL 427 Calculating Diversity Indicies and statistical tests on bird counts at an old growth and new growth site
## Author: Juniper Malloff 
# Last updated: 2021/11/24

library(tidyverse)
library(vegan)
library(ggplot2)

## load tidy data file
birdcounts <- read.csv("tidy data/B427fielddata_tidy.csv")


## calculate species richness per site, per visit

birdcounts_rich <- mutate(birdcounts, sp_num = specnumber(birdcounts[8:30]))

birdcounts_rich_old <- birdcounts_rich %>%
  subset(site == "Old")

write.csv(birdcounts_rich_old, "tidy data/birdcounts_rich_old.csv")

birdcounts_rich_new <- birdcounts_rich %>%
  subset(site == "New")

write.csv(birdcounts_rich_new, "tidy data/birdcounts_rich_new.csv")


# paired t-test of species # differences between sites (paired cntl for extraneous variables impacting each visit by treating the 2 as a related observation)

t.test(birdcounts_rich_old$sp_num, birdcounts_rich_new$sp_num, paired = TRUE)


## calculate Simpsons Index between sites

birdcounts_simp <- mutate(birdcounts, simpson = diversity(birdcounts[8:30], index = "simpson"))

birdcounts_simp_old <- birdcounts_simp %>%
  subset(site == "Old")

birdcounts_simp_new <- birdcounts_simp %>%
  subset(site == "New")

#  paired t-test on difference in Simpson's Index between sites

t.test(birdcounts_simp_new$simpson, birdcounts_simp_old$simpson, paired = TRUE)

## graphics for simpsons comparisons between sites


ggplot(birdcounts_simp) + 
  geom_col(aes(date, simpson, fill = site), position = "dodge") +
  theme_classic()

ggsave("figures/simpson_pervisit.png")

ggplot(birdcounts_simp) + 
  geom_boxplot(aes(site, simpson))+
  theme_classic()

ggsave("figures/simpson_box.png")

ggplot(birdcounts_simp) + 
  geom_boxplot(aes(site, simpson)) +
  geom_point(aes(site, simpson)) + 
  geom_line(aes(site, simpson, group = date))+
  theme_classic()

  
ggsave("figures/simpson_pairedbx.png")




