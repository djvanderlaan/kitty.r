
#' Get the colors used in the kitty terminal
#'
#' @return
#' \code{kitty_colors} returns a dataframe with the colors from the theme used
#' by kitty. \code{kitty_background} returns the background color (character
#' vector with the hex-code). \code{kitty_foreground} returns the foreground
#' color. \code{kitty_palette} returns a vector with the 9 main accent colors
#' from the theme.
#'
#' @rdname kitty_colors
#' @export
kitty_colors <- function() {
  colors <- getOption("kitty_colors")
  if (is.null(colors)) {
    colors <- system("kitty @get-colors", intern = TRUE)
    colors <- utils::read.table(textConnection(colors), 
      comment = "", header = FALSE)
    names(colors) <- c("name", "value")
    options(kitty_colors = colors)
  }
  colors
}


#' @export
#' @rdname kitty_colors
kitty_background <- function() {
  colors <- kitty_colors()
  colors$value[colors$name == "background"]
}

#' @export
#' @rdname kitty_colors
kitty_foreground <- function() {
  colors <- kitty_colors()
  colors$value[colors$name == "foreground"]
}

#' @export
#' @rdname kitty_colors
kitty_palette <- function() {
  colors <- kitty_colors()
  colors$value[colors$name %in% paste0("color", 1:9)]
}

