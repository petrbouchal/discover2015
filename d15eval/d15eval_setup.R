library(pbtools)
library(dplyr)
library(reshape2)
library(tidyr)
library(Cairo)

if(whatplatform()=="win") {
  Sys.setlocale(category = "LC_ALL", locale = "Czech_Czech Republic.1252")
  loc <- "C:/Users/boupet/Downloads/eval"
  # options(encoding = "UTF-8")
  } else {
  Sys.setlocale(category = "LC_ALL", locale = "cs_CZ.UTF-8")
  loc <- "~/Documents/Work/Discover/Discover 2015/Evaluace/"
  }

## Load custom function - see inside script for source ####

setwd("~/github/discover2015/d15eval/")
source("./crosstab.r")

## Load data using LimeSurvey script ####

setwd(loc)
getwd()

## Júl: ID of survey = 317642
source("./data_jul/survey_317642_R_syntax_file.R", chdir = T)

# codebook here:
# http://localhost/index.php/admin/expressions/sa/survey_logic_file/sid/317642

# remove false starts
data <- data[!(data$id %in% 14:16),]

# merge records where respondent had to restart
# (identified visually by ID and note)
data[data$id==3,66:249] <- data[data$id==11,66:249] # merge
data <- data[data$id!=11,] # remove line for second entry

# now we have one incomplete and one missing (did not respond) and two 
# missing last pages (computer broke down)

# check incompletes

table(is.na(data[,1]))
table(is.na(data[,151]))
table(is.na(data[,153]))

# rename misnamed variables for consistency

names(data) <- gsub("workshopvecer","wsVecer",names(data))
names(data) <- gsub("ovlivlila","ovlivnila",names(data))

# rename data source to avoid name clashes
df1 <- data
rm(data)

# mark turnus
df1$turnus <- factor("Júl")
df1$turnuscode <- 1
df1$surveycode <- factor("jul")

# create unique id

df1$uid <- paste0(df1$surveycode, "_", df1$id)

#### August

# ID of corrected survey: 155346
setwd(loc)
source("data_aug/survey_155346_R_syntax_file.R", chdir = T)

names(data) <- gsub("workshopvecer","wsVecer",names(data))
names(data) <- gsub("ovlivlila","ovlivnila",names(data))

df2_1 <- data
rm(data)

df2_1$surveycode <- "aug_corrected"
df2_1$uid <- paste0(df2_1$surveycode, "_", df2_1$id)

# rename kurz2ktery to proper name
names(df2_1) <- gsub("druhykurzoprava","kurz2ktery",names(df2_1))

# ID of initial survey: 477889
source("./data_aug/survey_477889_R_syntax_file.R", chdir = T)

names(data) <- gsub("workshopvecer","wsVecer",names(data))
names(data) <- gsub("ovlivlila","ovlivnila",names(data))

df2_0 <- data
rm(data)

df2_0$surveycode <- factor("aug_error")
df2_0$uid <- paste0(df2_0$surveycode, "_", df2_0$id)

# both exported with default export settings - not sure if this is right

# check that coding of binary answers is consistent across surveys

# checkbox
table(df1$minulerocniky_prvno)
table(df2_1$minulerocniky_prvno)
table(df2_0$minulerocniky_prvno)

# Yes/No
table(df1$zapojeni)
table(df2_1$zapojeni)
table(df2_0$zapojeni)

# merge both August surveys

df2 <- rbind(df2_0, df2_1)

df2$turnus <- factor("August")
df2$turnuscode <- 2

# Merge August and July

df <- plyr::rbind.fill(df1,df2)

# Load styles

loadcustomthemes(fontfamily = "Gill Sans MT")
theme_discover_multi <- theme(panel.grid.minor=element_line(color="grey96", size=.25),
                              panel.grid.major=element_line(color="white", size=.5),
                              strip.text = element_text(size=9, color="grey20", hjust=0.1),
                              panel.background = element_rect(fill="grey96"),
                              axis.text.x = element_text(size=10),
                              strip.background=element_rect(fill="grey96"),
                              plot.title=element_text(size=10, lineheight=0.5, hjust=0),
                              legend.key.width=unit(.3,"cm"))

theme_discover <- theme(panel.grid.minor=element_line(color="grey96", size=.2),
                        panel.grid.major=element_line(color="grey96", size=.3),
                        strip.text = element_text(size=12, color="grey20"),
                        panel.background = element_rect(fill="white"),
                        axis.text.x = element_text(size=11),
                        strip.background=element_rect(fill="white"),
                        legend.key.width=unit(.3,"cm"))

