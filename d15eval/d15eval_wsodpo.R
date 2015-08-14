setwd("~/github/discover2015/d15eval/")
source("./d15eval_setup.R")
setwd("~/github/discover2015/d15eval/")

wso <- data %>% 
  select(contains("wsOdpo"),-contains("Time"),-contains("lepsi"), id, vek, rocnik, pohlavi,
         poprve=minulerocniky_prvno)

names(wso) <- sub("Ktery","_nazev",names(wso))
names(wso) <- sub("_nazev_other","_other",names(wso))
names(wso) <- sub("Hodn","_hodn",names(wso))

wso <- wso %>% 
  melt(id.vars=c("id","pohlavi","vek","rocnik","poprve")) %>% 
  separate(variable, c("den","variable"), sep="_") %>% 
  spread(variable,value) %>% 
  mutate(den=gsub("wsOdpo","",den),
         den=tolower(den)) %>% 
  filter(!is.na(nazev)) %>% 
  group_by(nazev) %>% 
  mutate(znamka=mean(as.numeric(hodn), na.rm=T), pocet=n(),
         minzn=min(hodn, na.rm=T), maxzn=max(hodn, na.rm=T))

wso$nazev <- factor(wso$nazev, levels=wso$nazev[order(-wso$znamka)])
wso <- arrange(wso, hodn)

ggplot(wso, aes(y=hodn, x=nazev, ymin=as.numeric(minzn),
                ymax=as.numeric(maxzn), order=nazev)) +
  # geom_pointrange(colour="grey") +
  geom_violin() +
  coord_flip()

ggplot(wso, aes(y=as.numeric(hodn), x=nazev, fill=hodn, group=nazev)) +
  geom_bar(stat="identity", position="stack") +
  scale_fill_manual(values = rev(brewer.pal(5,"RdYlGn"))) +
  coord_flip() + theme_discover + theme(axis.text.y=element_text(size=12),
                                        panel.grid.major.y=element_blank(),
                                        panel.grid.major.x=element_line(colour="grey92"),
                                        panel.grid.minor.x=element_line(colour="grey96"))
