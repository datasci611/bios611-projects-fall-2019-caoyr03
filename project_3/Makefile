.PHONY: project3
project_3: 
	docker image build -t project_3 .
	python script/clean.ipynb
	Rscript script/plot.R
	Rscript -e "library(rmarkdown); rmarkdown::render('plot.Rmd', 'html_document')"  && mv plot.html ../results
