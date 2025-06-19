#' Create a plot and write the result to the kitty terminal.
#'
#' @param expr Valid R expression creating the plot.
#' @param width The width of the image. Passed on to \code{\link{png}}.
#' @param height The height of the image. Passed on to \code{\link{png}}.
#' @param units The units in which 'height' and 'width' are given. Passed on to
#'   \code{\link{png}}.
#' @param res The resulution of the image. Passed on to \code{\link{png}}.
#' @param ... Passed on to \code{\link{png}}.
#' @param kitty_col Logical value indicating that the foreground and background
#'   colors used in the plot should be set to that of the terminal.
#' @param kitty_bg Logical value indicating that the background
#'   color used in the plot should be set to that of the terminal.
#' @param kitty_fg Logical value indicating that the foreground
#'   color used in the plot should be set to that of the terminal.
#'
#' @details
#' The \code{kitty_fg} argument sets \code{fg}, \code{col}, \code{col.axis},
#' \code{col.lab}, \code{col.main} and \code{col.sub} using \code{\link{par}} to
#' \code{\link{kitty_foreground}}.
#'
#' @examples
#' if (is_kitty()) {
#'   kitty_plot({
#'     data(iris)
#'     plot(iris$Sepal.Width, iris$Sepal.Length, 
#'       col = kitty_palette()[iris$Species], 
#'       pch = 20)
#'     grid(lty = 2)
#'     legend("topright", legend = levels(iris$Species), 
#'       col = kitty_palette()[1:3], pch = 20)
#'   })
#' }
#'
#' @export
kitty_plot <- function(expr, 
    width = min(1200, kitty_width(), kitty_height()/0.8),
    height = 0.8*kitty_width(), 
    units = "px", res = NA, ..., 
    kitty_col = TRUE, kitty_bg = kitty_col, kitty_fg = kitty_col) {
  is_kitty(throw = TRUE)
  if (is.na(res)) {
    dim <- kitty_dim()
    # number of pixels per row/line = font height
    r <- dim["y_pixels"]/dim["columns"]
    # Default font is 12 points = 12/72 inch so to get the right font size:
    res <- r*72/12
  }
  fn <- tempfile()
  grDevices::png(fn, width = width, height = height, res = res, units = units, ...)
  if (kitty_bg || kitty_fg) {
    opar <- graphics::par()
    on.exit(graphics::par(opar))
    if (kitty_bg) { 
      background <- kitty_background()
      graphics::par(bg = background)
    }
    if (kitty_fg) { 
      foreground <- kitty_foreground()
      graphics::par(fg = foreground, col = foreground, 
        col.axis = foreground, col.lab = foreground, 
        col.main = foreground, col.sub = foreground)
    }
  }
  expr
  grDevices::dev.off()
  on.exit(file.remove(fn))
  cat("\n")
  png2terminal(fn)
  cat("\n")
}

