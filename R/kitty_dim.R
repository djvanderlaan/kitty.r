#' Get the dimensions of the terminal window in pixels
#'
#' @return
#' An integer vector with the width and height of the terminal in pixels
#' (\code{x_pixels} and \code{y_pixels}) and the number of text columns and rows
#' in the terminal window (\code{columns} and \code{rows}).
#'
#' @export
kitty_dim <- function() {
  dim <- screen_dim_cpp()
  names(dim) <- c("x_pixels", "y_pixels", "columns", "rows")
  dim
}

