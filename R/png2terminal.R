#' Dump a PNG image to the terminal using the Terminal Graphics Protocol
#'
#' @param filename filename of the PNG image
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
png2terminal <- function(filename) {
  d <- base64enc::base64encode(filename, 4096)
  for (i in seq_along(d)) {
    out <- "\033_Ga=T,f=100,m=1;" 
    end <- "\033\\"
    out <- paste0(out, d[i], end)
    cat(out)
  }
  out <- "\033_Ga=T,f=100,m=0" 
  end <- "\033\\"
  out <- paste0(out, end)
  cat(out)
  invisible(NULL)
}

