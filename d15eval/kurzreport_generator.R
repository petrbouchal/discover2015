# source: http://stackoverflow.com/questions/15396755/using-loops-with-knitr-to-produce-multiple-pdf-reports-need-a-little-help-to

setwd("~/github/discover2015/d15eval/")

# Load data
source("./library.R")
source("./d15eval_setup.R")
setwd("~/github/discover2015/d15eval/")
source("./d15eval_kurzy_setup.R")

# Prepare data

library(knitr)
library(tools)

# source: http://conjugateprior.org/2012/12/r-markdown-to-other-document-formats/

# Iterate

for (iturnus in c("Júl","August")) { 
  for (ikurz in (unique(kurzy_long$kurz[!is.na(kurzy_long$kurz) & kurzy_long$turnus==iturnus]))){
    knit2html("kurzreport_template.Rmd",
              output=paste0('discoverfeedback/reporty_kurzy/report_',
                            ikurz, '_', iturnus,
                            '.html'),
              stylesheet="custom.css")
    rmd.convert("kurzreport_template.Rmd","word",
                paste0('discoverfeedback/reporty_kurzy/report_',
                       ikurz, '_', iturnus,
                       '.docx'))
  }
}