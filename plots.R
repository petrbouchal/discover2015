library(readr)
library(readxl)
library(haven)
library(foreign)
library(pbtools)
library(dplyr)
library(ggplot2)
library(reshape2)

dem <- read.dta("~/Documents/Research/Government/Data/Boix-Miller-Rosato/democracy-v2.0.dta")
sdem <- dem %>%
  group_by(year) %>% 
  summarise(score=mean(democracy, na.rm=T))

summary(sdem)

plot(sdem$year, sdem$score,type = "line")

demplot <- ggplot(sdem, aes(year, score)) +
  geom_line() +
  scale_y_continuous(labels=percent)

demplot

galtan <- read_excel("~/Documents/Research/Government/Data/ChapelHill/1999_2010 CHES_trendmeans.xls")
ccnames <- read.csv("~/Documents/Research/Government/Data/ChapelHill/countrycodes.csv", sep=";")
galtan <- merge(galtan, ccnames, by.x="country", by.y="c_id")

pgaltan <- galtan %>% 
  filter(year==2010) %>% 
  select(galtan, lrgen, eastwest, c_name, party) %>% 
  group_by(c_name, party)

galtanplot <- ggplot(pgaltan, aes(lrgen, galtan)) +
  geom_point(aes(colour=eastwest)) +
  geom_smooth(method="lm") + 
  # geom_text(aes(label=party)) +
  facet_wrap(~ c_name) +
  theme(panil.grid.major=geom_line())

library(pbtools)
loadcustomthemes()
galtanplot

qogts <- read.csv("~/Documents/Research/Government/Data/QoG/qog_std_ts_jan15.csv")
qogts <- read_csv("~/Documents/Research/Government/Data/QoG/qog_std_ts_jan15.csv")


