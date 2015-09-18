## Kurzy: select vars and reshape into long format

kurzy <- df %>% 
  select(starts_with("kurz"),pohlavi,rocnik,vek, -kurzyjakedalsi, uid ,
         -contains("Time"), turnus, poprve=minulerocniky_prvno) %>%
  mutate(poprve=ifelse(poprve=="Ano","Ano","Ne")) %>% 
  melt(id.vars=c("uid","pohlavi","vek","rocnik","poprve","turnus"))

kurzy$kurzslot <- ifelse(grepl("kurz1",kurzy$variable),"A","B")

## Mark course slot and harmonise variable names so ratings from each course
## have the same variable code regardless of slot

kurzy$variable <- gsub("kurz1","kurz",kurzy$variable)
kurzy$variable <- gsub("kurz2","kurz",kurzy$variable)

## Create day markers for rating variables

kurzy$variable[kurzy$variable=="kurzhodnoceni_1"] <- "po"
kurzy$variable[kurzy$variable=="kurzhodnoceni_2"] <- "út"
kurzy$variable[kurzy$variable=="kurzhodnoceni_3"] <- "st"
kurzy$variable[kurzy$variable=="kurzhodnoceni_4"] <- "čt"
kurzy$variable[kurzy$variable=="kurzhodnoceni_5"] <- "pá"
kurzy$variable[kurzy$variable=="kurzhodnoceni_6"] <- "so"

dnyvtydnu <- c("po","út","st","čt","pá","so")

## chart for each course by day

kurzy2 <- dcast(kurzy, "... ~ variable", value.var="value")

kurzy_long <- melt(kurzy2, id.vars=c("uid","pohlavi","vek","rocnik","kurzktery",
                                     "kurzslot","poprve","turnus"))
kurzy_long <- plyr::rename(kurzy_long, c("kurzktery"="kurz"))