
.PHONY: build check document install vignettes

build: document
	cd work && R CMD build ../

check: build
	cd work && R CMD check --as-cran `ls kitty.r*.tar.gz | sort | tail -n 1`

document:
	R -e "roxygen2::roxygenise()"

vignettes: build
	cd work && tar -xzf `ls kitty.r*.tar.gz | sort | tail -n 1` && \
	  rm -r -f ../inst/doc && \
	  mkdir -p ../inst && \
	  cp -r kitty.r/inst/doc ../inst


install: build
	R CMD INSTALL `ls work/kitty.r*.tar.gz | sort | tail -n 1` 


