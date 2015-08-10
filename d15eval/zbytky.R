ggplot(kurzhodavg, aes(velikost, value, color=kurzslot)) +
  geom_point()

kurzhodavg_c <- kurzhodavg[complete.cases(kurzhodavg),]

cor(kurzhodavg_c$value, kurzhodavg_c$velikost)

## Korelace

m <- select(kurzy_long, kurzslot, value)
m <- m[complete.cases(m),]
m$value <- as.numeric(m$value)

t.test(m$value~m$kurzslot)

## Jak udělat skvělý kurz?

setwd("~/github/experiments/d15eval/")
velikost <- read.csv("velikostkurzu.csv")
velikost <- melt(velikost, id.vars="kurz")
velikost <- plyr::rename(velikost,c("variable"="kurzslot", "value"="velikost")) 

hod <- filter(kurzy_long, variable %in% dnyvtydnu)
hod$value <- as.numeric(hod$value)

model <- lm(value ~ variable + rocnik + pohlavi + kurzslot + kurz, data = hod)
# summary(model)

library(sjPlot)
modelplot <- sjp.lm(model, sort.est = F)
modelplot$plot$layers[[2]]$geom_params$size <- 2.5
modelplot