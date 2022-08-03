FROM rocker/rstudio:4.0.0

RUN Rscript -e "install.packages('ShinyItemAnalysis', dependencies = TRUE)"
