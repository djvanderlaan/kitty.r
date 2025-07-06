

#' Functions for use with the plotenv package
#'
#' @param name name of the plot. Not used.
#'
#' @param ... passed on to an internal function. For accepted options see 
#' \code{\link{kitty_plot}}.
#' 
#' @param state The state as returned by \code{plotenv_begin.kitty}. This is used
#' to close the png device and copy the image into the terminal.
#'
#' @details
#' These functions are not intended to be called directly by the user. When
#' \code{kitty.r} is loaded and the R-package \code{plotenv} is loaded, these
#' functions also make a 'kitty' device available for \code{plotenv}. For
#' example, it becomes possible to use \code{plotenv(device = "kitty", ...)}.
#'
#' @return 
#' \code{plotenv_begin.kitty} will return some state of the plotting device.
#' \code{plotenv_end.kitty} does not return anything.
#' 
#' @rdname plotenv
#' @export
plotenv_begin.kitty <- function(name, ...) {
  kitty_begin_plot(...)
}

#' @rdname plotenv
#' @export
plotenv_end.kitty <- function(state) {
  kitty_end_plot(state)
}

