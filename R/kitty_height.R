#' Get the height of the terminal window in pixels
#'
#' @return
#' An integer with the number of pixels the terminal is high
#'
#' @export
kitty_height <- function() {
  kitty_dim()[2] |> as.vector()
}

