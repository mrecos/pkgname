# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.4.0

# required
MAINTAINER Matt Harris <mr.ecos@gmail.com>

COPY . /pkgname

# go into the repo directory
RUN . /etc/environment \
#RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
#RUN Rscript -e "install.packages('raster')

  # Install linux depedendencies here
  # e.g. need this for ggforce::geom_sina
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \
  && sudo apt-get install --yes libudunits2-dev libproj-dev libgeos-dev libgdal-dev \

  # build this compendium package
  && R -e "devtools::install('/pkgname', dep=TRUE)" \

 # render the manuscript into a docx
  && R -e "rmarkdown::render('/pkgname/analysis/paper/paper.Rmd')"
