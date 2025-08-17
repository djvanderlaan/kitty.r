**MOVED TO <https://codeberg.org/djvanderlaan/terminalgraphics>**

# kitty.r

[Kitty](https://sw.kovidgoyal.net/kitty/) is a terminal emulator. One of the
nice things it introduced is the terminal graphics protocol which allows for
graphics output in the terminal. This package implements some functions that
makes it possible to write graphical output and png images into the terminal
from R.

The main function is `kitty_plot`. You pass it expressions creating a plot and
it will output the resulting plot into the terminal. For example:

```R
kitty_plot({
  data(iris)
  plot(iris$Sepal.Width, iris$Sepal.Length, 
    col = kitty_palette()[iris$Species], 
    pch = 20)
  grid(lty = 2)
  legend("topright", legend = levels(iris$Species), 
    col = kitty_palette()[1:3], pch = 20)
})
```

By default it will match the colours of the plot to those used of the theme used
in kitty.


Other functions are:

- `png2terminal` display a png file into the terminal.
- `kitty_dim` get the dimensions of the kitty terminal (in pixels and number
  rows and columns). 
- `kitty_colors` get the colours used in the current theme.
- `kitty_palette` get a palette based on the colorus used in the current theme.
- `kitty_foreground` and `kitty_background` get the foreground and background
  colours of the current theme.
- `is_kitty` determine if we are running in a kitty terminal.

