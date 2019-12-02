.PHONY: project3
project_3: 
	docker build -t project_3 .
	python clean.ipynb
	Rscript plot.R
	Rscript -e "library(rmarkdown); rmarkdown::render('plot.Rmd', 'html_document')"  && mv plot.html ../results
