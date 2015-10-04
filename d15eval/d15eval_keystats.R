# source("d15eval_kurzy.Rmd")

# Hodnocení kurzů

kurzy %>%
  filter(variable %in% dnyvtydnu) %>% 
  mutate(meanall=mean(as.numeric(value), na.rm=T)) %>% 
  group_by(turnus, meanall) %>% 
  summarise(mean=mean(as.numeric(value), na.rm=T))

# Hodnocení lektorů

## Byl lektor odborník?

kurzy %>%
  filter(variable=="kurzobsah_lekodbornik") %>% 
  group_by(value) %>% 
  summarise(pocet=n())

## Byl připravený?

kurzy %>%
  filter(variable=="kurzobsah_lekpripraveny") %>% 
  group_by(value) %>% 
  summarise(pocet=n())

## Přednášel poutavě?

kurzy %>%
  filter(variable=="kurzobsah_lekpoutave") %>% 
  group_by(value) %>% 
  summarise(pocet=n())

## Vysvětloval srozumitelně?

kurzy %>%
  filter(variable=="kurzobsah_lekvysvet") %>% 
  group_by(value) %>% 
  summarise(pocet=n())

## Zapojoval dostatečně?

kurzy %>%
  filter(variable=="kurzobsah_lekzapoj") %>% 
  group_by(value) %>% 
  summarise(pocet=n())

# Rozmanitost kurzů

df %>%
  select(nabidkakurzurozmanit, turnus) %>% 
  group_by(nabidkakurzurozmanit, turnus) %>% 
  summarise(pocet=n()) %>% 
  arrange(turnus)

# Note discrepancy: chtějí měnit kurzy, ex post jsou ale spokojení

# Workshopy

df %>%
  select(ovlivnilaVS, turnus) %>% 
  group_by(ovlivnilaVS, turnus) %>% 
  summarise(pocet=n()) %>% 
  filter(turnus=="August") %>% 
  arrange(turnus)

df %>%
  select(ovlivnilaucastplany, turnus) %>% 
  group_by(ovlivnilaucastplany, turnus) %>% 
  summarise(pocet=n()) %>% 
  filter(turnus=="Júl") %>% 
  arrange(turnus)

df %>%
  select(ovlivnilaucastplany, turnus) %>% 
  group_by(ovlivnilaucastplany, turnus) %>% 
  summarise(pocet=n()) %>% 
  filter(turnus=="August")