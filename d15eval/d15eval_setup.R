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
  loc <- "~/Documents/Work/Discover/Discover 2015/Evaluace/data_final/"
  }

source("./crosstab.r")

## Load data using LimeSurvey script ######

setwd(loc)
getwd()
source("survey_317642_R_syntax_file.R")

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
