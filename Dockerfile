FROM rocker/rstudio:4.0.0
RUN /rocker_scripts/install_shiny_server.sh

RUN Rscript -e "install.packages('ShinyItemAnalysis', dependencies = TRUE)"
