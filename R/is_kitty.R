#' Determine if we are running in a kitty terminal
#'
#' @param throw Throw an error when we are running in a kitty terminal.
#'
#' @return
#' If \code{throw = FALSE}, returns `TRUE` if R is running in a kitty terminal
#' and `FALSE` otherwise. If, \code{throw = FALSE} will throw an error when not
#' running in a kitty terminal; returns `TRUE` otherwise.
#'
#' @examples
#' if (is_kitty()) {
#'   cat("Yeeh, you are running kitty!")
#' }
#'
#' @export
is_kitty <- function(throw = FALSE) {
  term <- Sys.getenv("TERM")
  kitty <- term == "xterm-kitty"
  if (throw && !kitty) {
    stop("You are not running R in a kitty terminal.")
  }
  kitty
}

