FROM rocker/tidyverse
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('dplyr')"

FROM continuumio/anaconda3
RUN pip install pandas

