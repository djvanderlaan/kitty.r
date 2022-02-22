
#' @export
kitty_plot <- function(expr, width = 10, height = 8, perc_width = 1.0, ...,
    kitty_col = TRUE, kitty_bg = kitty_col, kitty_fg = kitty_col, 
    kitty_pal = kitty_col) {
  fn <- tempfile()
  res <- terminal_width()/width*perc_width
  png(fn, width = width, height = height, res = res, units = "in")
  set_col = kitty_bg || kitty_fg || kitty_col || kitty_pal
  if (set_col) {
    opar <- par()
    on.exit(par(opar))
    colors <- kitty_colors()
    background <- colors$value[colors$name == "background"]
    foreground <- colors$value[colors$name == "foreground"]
    if (kitty_bg) par(bg = background)
    if (kitty_bg) par(fg = foreground, col = foreground, 
      col.axis = foreground, col.lab = foreground, 
      col.main = foreground, col.sub = foreground)
  }
  expr
  dev.off()
  on.exit(file.remove(fn))
  cat("\n")
  png2terminal(fn)
  cat("\n")
}

