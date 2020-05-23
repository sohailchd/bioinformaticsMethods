#!/usr/bin/env bash
R -e "rmarkdown::render('MethodsVariantCalling.Rmd', output_format='all',run_pandoc=TRUE,quiet=FALSE)"
