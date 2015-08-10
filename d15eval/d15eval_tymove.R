setwd("~/github/experiments/d15eval/")
source("./d15eval_setup.R")
setwd("~/github/experiments/d15eval/")

tws <- data %>% 
  select(contains("wsTymove"),id,pohlavi,vek,rocnik) %>% 
  melt(id.vars=c("id","pohlavi","vek","rocnik")) 

twszaj <- tws %>% 
  filter(grepl("Q", .$variable)) %>% 
  group_by(variable, value) %>% 
  summarise(pocet=n())

twszaj$value <- as.factor(twszaj$value)
levels(twszaj$value)
twszaj$value <- factor(twszaj$value, levels(twszaj$value)[c(5,3,1,2,4)])
levels(twszaj$value)
twszaj <- arrange(twszaj, value) 

twszaj$variable <- plyr::revalue(twszaj$variable,
                                 c("wsTymoveZajimave_SQ004"="Co můžu dělat",
                                   "wsTymoveZajimave_SQ003"="Vtipy nebo ubližování slovem",
                                   "wsTymoveZajimave_SQ002"="Moje místo ve společnosti",
                                   "wsTymoveZajimave_SQ001"="Malé zločiny"
                                   ))

twszaj$variable <- factor(twszaj$variable, levels(twszaj$variable)[c(4,3,2,1)])

ggplot(twszaj, aes(group=variable, x=variable, y=pocet, fill=value,
                   order=-as.numeric(value))) +
  geom_bar(stat="identity", position="fill", color="grey96") + 
  coord_flip() +
  scale_fill_brewer(palette = "RdBu", breaks = rev(levels(twszaj$value))) +
  guides(fill = guide_legend(override.aes = list(colour = NULL))) +
  scale_y_continuous(labels=percent) +
  theme_discover + theme(panel.grid.major.y=element_blank(),
                         panel.grid.major.x=element_line(color="white"),
                         axis.text.y=element_text(size=12))

table(data$wsTymovePohled)
data$wsTymovePohled_comment

data$wsTymoveZajimaveProc

table(data$wsTymoveZmenit)
data$wsTymoveZmenit_comment

table(data$wsTymoveZajimave, data$wsTymovePohled)
