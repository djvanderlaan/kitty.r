
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

