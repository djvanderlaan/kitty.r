#' Dump an image raster to the terminal using the Terminal Graphics Protocol
#'
#' @param raster the image 'raster' e.g. the output of \code{\link{as.raster}}
#'
#' @details
#' The Terminal Graphics Protocol is not supported by many Terminal Emulators.
#' The most notable terminal emulator supporting the protocol is Kitty.
#'
#' @return
#' Called for it's side effect of writing the image to the terminal (standard
#' out). Return \code{NULL} invisibly.
#'
#' @importFrom base64enc base64encode
#' @export
raster2terminal <- function(raster, compress = TRUE) {
  # Convert the raster to raw byte vector
  data <- t(raster) |> col2rgb() |> as.vector() |> as.raw() 
  controlstring <- "a=T,f=24,s=%d,v=%d,m=%d"
  if (compress) {
    data <- memCompress(data)
    controlstring <- "a=T,f=24,s=%d,v=%d,o=z,m=%d"
  }
  # Encode
  payloads <- base64enc::base64encode(data, 4096)
  # Send the chunks to the terminal
  for (i in seq_along(payloads)) {
    start <- "\033_G"
    end <- "\033\\"
    control <- sprintf(controlstring, ncol(raster), nrow(raster), 
      1*(i != length(payloads)))
    out <- paste0(start, control, ";", payloads[i], end)
    cat(out)
  }
  invisible(NULL)
}
