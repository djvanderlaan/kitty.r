
library(Rcpp)



sourceCpp(code = '
  #include <Rcpp.h>
  #include <stdio.h>
  #include <sys/ioctl.h>
  // [[Rcpp::export]]
  int screen_width() {
    struct winsize sz;
    ioctl(0, TIOCGWINSZ, &sz);
    return sz.ws_xpixel;
  }
')

kitty_colors <- function() {
  colors <- system("kitty @get-colors", intern = TRUE)
  colors <- read.table(textConnection(colors), comment = "", header = FALSE)
  names(colors) <- c("name", "value")
  colors
}

plot_kitty <- function(expr, width = 10, height = 8, perc_width = 1.0, ...,
    kitty_col = TRUE, kitty_bg = kitty_col, kitty_fg = kitty_col, kitty_pal = kitty_col) {
  fn <- tempfile()
  res <- screen_width()/width*perc_width
  png(fn, width = width, height = height, res = res, units = "in")
  set_col = kitty_bg || kitty_fg || kitty_col || kitty_pal
  if (set_col) {
    opar <- par()
    on.exit(par(opar))
    colors <- kitty_colors()
    background <- colors$value[colors$name == "background"]
    foreground <- colors$value[colors$name == "foreground"]
    if (kitty_bg) par(bg = background)
    if (kitty_bg) par(fg = foreground, col = foreground, col.axis = foreground, 
        col.lab = foreground, col.main = foreground, col.sub = foreground)
  }
  expr
  dev.off()
  on.exit(file.remove(fn))
  cat("\n")
  png2terminal(fn)
  cat("\n")
}

plot_kitty({
  par(mar = c(4, 4, 1, 1) + 0.5)
  plot(iris$Sepal.Width, iris$Petal.Width, pch = 20)
  grid()
  pal <- hcl.colors(3, "Dark 2")
  points(iris$Sepal.Width, iris$Petal.Width, col = pal[iris$Species], pch = 20, 
    cex = 2)
}, perc_width = 0.8, width = 9, height = 7)



Ps=${1:-11}

stty raw -echo min 0 time 0
# stty raw -echo min 0 time 1

cat("\033]11;?\033\\")
Sys.sleep(1)
bg <- readLines(n=1)

readChar(stdin(), nchar=12)
scan(n=1)


# xterm needs the sleep (or "time 1", but that is 1/10th second).
sleep 0.1
read -r answer



colors <- system("kitty @get-colors", intern = TRUE)
colors <- read.table(textConnection(colors), comment = "", header = FALSE)
names(colors) <- c("name", "value")
background <- colors$value[colors$name == "background"]
foreground <- colors$value[colors$name == "foreground"]

palette(colors$value[colors$name %in% paste0("color", 1:9)])

plot_kitty({
  par(bg = background, fg = foreground, col = foreground, col.axis = foreground, 
    col.lab = foreground, col.main = foreground, col.sub = foreground, 
    mar = c(4, 4, 1, 1) + 0.5)
  plot(iris$Sepal.Width, iris$Petal.Width, pch = 20)
  grid()
  pal <- hcl.colors(3, "Dark 2")
  points(iris$Sepal.Width, iris$Petal.Width, col = as.integer(iris$Species), pch = 20, 
    cex = 2)
}, perc_width = 0.8, width = 9, height = 7)


plot_kitty({
  par(mar = c(4, 4, 0, 0)+0.5, las = 1)
  plot(iris$Sepal.Width, iris$Petal.Width, pch = 20, xlab = "Sepal Width", 
    ylab = "Petal Width")
  grid(lty=2)
  pal <- hcl.colors(3, "Dark 2")
  points(iris$Sepal.Width, iris$Petal.Width, col = iris$Species, pch = 20, 
    cex = 2)
}, perc_width = 0.8)

stopifnot(Sys.getenv("TERM") == "xterm-kitty")

