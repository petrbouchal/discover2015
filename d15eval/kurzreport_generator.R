# source: http://stackoverflow.com/questions/15396755/using-loops-with-knitr-to-produce-multiple-pdf-reports-need-a-little-help-to
  # Load data

setwd("~/github/discover2015/d15eval/")
source("./d15eval_setup.R")
setwd("~/github/discover2015/d15eval/")
source("./d15eval_kurzy_setup.R")

# Prepare data

library(knitr)
library(tools)

# source: http://conjugateprior.org/2012/12/r-markdown-to-other-document-formats/

rmd.convert <- function(fname, output=c('latex', 'word', 'html', "pdf"), outputfile=fname){
  ## Thanks to Robert Musk for helpful additions to make this run better on Windows
  
  require(knitr)
  require(tools)
  
  thedir <- file_path_as_absolute(dirname(fname))
  thefile <- (basename(fname)) 
  
  create_latex <- function(f){
    knit(f, 'tmp-outputfile.md'); 
    newname <- paste0(file_path_sans_ext(f), ".tex")
    mess <- paste('pandoc -f markdown -t latex -s -o', shQuote(newname), 
                  "tmp-outputfile.md")
    system(mess)
    cat("The Latex file is", file.path(thedir, newname), 
        "\nIf transporting do not forget to include the folder", file.path(thedir, "figure"), "\n")
    mess <- paste('rm tmp-outputfile.md')
    system(mess)
  }
  
  create_word <- function(f, outputfile){
    knit(f, 'tmp-outputfile.md');
    newname <- paste0(file_path_sans_ext(outputfile),".docx")
    mess <- paste('pandoc -f markdown -t docx -o', shQuote(newname), "tmp-outputfile.md")
    system(mess)
    cat("The Word (docx) file is", file.path(thedir, newname), "\n")
    mess <- paste('rm tmp-outputfile.md')
    system(mess)
  }
  
  create_html <- function(f){
    knit2html(f)
    cat("The main HTML file is", file.path(thedir, paste0(file_path_sans_ext(f), ".html")), 
        "\nIf transporting do not forget to include the folder", file.path(thedir, "figure"), "\n")
  }
  
  create_pdf <- function(f){
    knit(f, 'tmp-outputfile.md');
    newname <- paste0(file_path_sans_ext(f),".pdf")
    mess <- paste('pandoc -f markdown -o', shQuote(newname), "tmp-outputfile.md")
    system(mess)
    cat("The PDF file is", file.path(thedir, newname), "\n")
    mess <- paste('rm tmp-outputfile.md')
    system(mess)
  }
  
  origdir <- getwd()  
  tryCatch({
    setwd(thedir) ## put us next to the original Rmarkdown file
    out <- match.arg(output)
    switch(out,
           latex=create_latex(thefile),
           html=create_html(thefile),
           pdf=create_pdf(thefile),
           word=create_word(thefile, outputfile)
    )}, finally=setwd(origdir))
  
}

# Fix css handling

options(rstudio.markdownToHTML = 
          function(inputFile, outputFile) {      
            require(markdown)
            markdownToHTML(inputFile, outputFile, stylesheet='custom.css')   
          }
)

# Iterate

for (ikurz in (unique(kurzy_long$kurz[!is.na(kurzy_long$kurz)]))){
  knit2html("kurzreport_template.Rmd",
            output=paste0('discoverfeedback/reporty_kurzy/report_', ikurz, '.html'),
            stylesheet="custom.css")
  rmd.convert("kurzreport_template.Rmd","word",
              outputfile=paste0('./reporty_kurzy/report_', ikurz, '.docx'))
}