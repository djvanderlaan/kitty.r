
#' Get the with of the terminal window in pixels
#'
#' @return
#' An integer with the number of pixels the terminal is wide.
#'
#' @export
kitty_width <- function() {
  screen_width_cpp();
}

