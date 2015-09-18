# generuje všechny odkazované reporty kromě jednotlivých kurzů (těch je moc)

setwd("~/github/discover2015/d15eval/")

source("./library.R")

knitr::knit2html("index.Rmd", output="discoverfeedback/index", stylesheet="custom.css")

rmd.convert("d15eval_kurzy.Rmd","word",
            outputfile=paste0('./reporty_kurzy/report_kurzy', '.docx'))
rmd.convert("d15eval_program.Rmd","word",
            outputfile=paste0('./report_program', '.docx'))
