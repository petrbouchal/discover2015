# generuje všechny odkazované reporty kromě jednotlivých kurzů (těch je moc)
# link: 

setwd("~/github/discover2015/d15eval/")

source("./library.R")

rmd.convert("d15eval_kurzy.Rmd","word",
            outputfile=paste0('./reporty_kurzy/report_kurzy', '.docx'))
rmd.convert("d15eval_program.Rmd","word",
            outputfile=paste0('./report_program', '.docx'))

knitr::knit2html("index.Rmd", output="discoverfeedback/index", stylesheet="custom.css")
knitr::knit2html("d15eval_volnycas.Rmd", output="discoverfeedback/volnycas", stylesheet="custom.css")
knitr::knit2html("d15eval_program.Rmd", output="discoverfeedback/program", stylesheet="custom.css")
knitr::knit2html("d15eval_demografie.Rmd", output="discoverfeedback/demografie", stylesheet="custom.css")
knitr::knit2html("d15eval_dusevnipohoda.Rmd", output="discoverfeedback/dusevnipohoda", stylesheet="custom.css")
