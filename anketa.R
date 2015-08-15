library(readxl)

dsc <- read_excel("~/Documents/Work/Discover/Discover 2015/Workshop nerovnosti/peto statistika.xlsx",2)

table(is.na(dsc$hplat_otec_eur))
table(is.na(dsc$hplat_matka_eur))

medianzeny <- 20856
medianmuzi <- 24909
median <- 23072

pc10muzi <- 12994
pc10zeny <- 11685
pc10 <- 12173

pc90muzi <- 42297
pc90zeny <- 36081
pc90 <- 42346

euro <- 25

## decily: http://www.statistikaamy.cz/2015/04/prumerna-mzda-a-median/


table(!is.na(dsc$hplat_matka_eur) & !is.na(dsc$hplat_otec_eur))

dsc$hp_rodina <- dsc$hplat_otec_eur + dsc$hplat_matka_eur

dsc$otec_nad50pc <- ifelse(dsc$hplat_otec_eur > medianmuzi/euro, 1, 0)
dsc$matka_nad50pc <- ifelse(dsc$hplat_matka_eur > medianzeny/euro, 1, 0)

dsc$otec_pod10pc <- ifelse(dsc$hplat_otec_eur < pc10muzi/euro, 1, 0)
dsc$matka_pod10pc <- ifelse(dsc$hplat_matka_eur < pc10zeny/euro, 1, 0)

dsc$otec_nad90pc <- ifelse(dsc$hplat_otec_eur > pc90muzi/euro, 1, 0)
dsc$matka_nad90pc <- ifelse(dsc$hplat_matka_eur > pc90zeny/euro, 1, 0)

mean(dsc$vs_otec, na.rm = T)
mean(dsc$vs_matka, na.rm = T)

mean(dsc$hplat_otec_eur, na.rm=T)
mean(dsc$hplat_matka_eur, na.rm=T)
mean(dsc$hp_rodina, na.rm=T)

median(dsc$hplat_otec_eur, na.rm = T)
median(dsc$hplat_matka_eur, na.rm = T)
median(dsc$hp_rodina, na.rm = T)

mean(dsc$otec_nad50pc, na.rm = T)
mean(dsc$matka_nad50pc, na.rm = T)
mean(dsc$otec_nad90pc, na.rm = T)
mean(dsc$matka_nad90pc, na.rm = T)
mean(dsc$otec_pod10pc, na.rm = T)
mean(dsc$matka_pod10pc, na.rm = T)

hist(dsc$hplat_matka_eur, breaks = 30)
hist(dsc$hplat_otec_eur, breaks = 30)

table(is.na(dsc$hplat_otec_eur), dsc$vs_otec)
table(is.na(dsc$hplat_matka_eur), dsc$vs_matka)

library(dplyr)

dsc %>% group_by(vs_otec) %>% summarise(xx=mean(hplat_otec_eur, na.rm=T))
dsc %>% group_by(vs_matka) %>% summarise(xx=mean(hplat_matka_eur, na.rm=T))
