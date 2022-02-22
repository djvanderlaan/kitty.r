
#' @export
kitty_colors <- function() {
  colors <- system("kitty @get-colors", intern = TRUE)
  colors <- read.table(textConnection(colors), comment = "", header = FALSE)
  names(colors) <- c("name", "value")
  colors
}

