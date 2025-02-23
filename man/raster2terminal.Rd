% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/raster2terminal.R
\name{raster2terminal}
\alias{raster2terminal}
\title{Dump an image raster to the terminal using the Terminal Graphics Protocol}
\usage{
raster2terminal(raster, compress = TRUE)
}
\arguments{
\item{raster}{the image 'raster' e.g. the output of \code{\link{as.raster}}.}

\item{compress}{compress the data before sending to the terminal.}
}
\value{
Called for it's side effect of writing the image to the terminal (standard
out). Return \code{NULL} invisibly.
}
\description{
Dump an image raster to the terminal using the Terminal Graphics Protocol
}
\details{
The Terminal Graphics Protocol is not supported by many Terminal Emulators.
The most notable terminal emulator supporting the protocol is Kitty.
}
