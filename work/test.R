library(ragg)

pkgload::load_all()

cap <- agg_capture()
plot(1:10, (1:10)^2+rnorm(10)*10, pch = 20)
lines(1:10, (1:10)^2, col = "red", lwd = 2)
abline(col = "red", 0, 1)
raster <- cap()
dev.off()

raster2terminal(raster)
cat("\n")



plot_interactive_start <- function(name, ...) {
}

plot_interactive_end <- function(out, success) {
}

plot_png_start <- function(name, ...) {
  fn <- paste0(name, ".png")
  # TODO: better create png in temp file and move to fn when success
  png(fn, ...)
  fn
}

plot_png_end <- function(out, success) {
  dev.off()
  file.remove(out)
}

plot_kitty_start <- function(name, ...) {
  cap <- agg_capture()
  cap
}

plot_kitty_end <- function(out, success) {
  raster <- out()
  dev.off()
  if (success) raster2terminal(raster)
}

plot_eval <- function(name, expr, output = getOption("plot_output", "interactive"), 
    width = 8, height = 6, ... ) {
  fnname <- paste0("plot_", output, "_start")
  fnstart <- get(fnname)
  fnname <- paste0("plot_", output, "_end")
  fnend <- get(fnname)
  out <- fnstart(name, ...)
  success = FALSE
  on.exit(fnend(out, success))
  expr
  success = TRUE
}

plot_eval("work/foo", {
      plot(rnorm(100), pch = 20)
    }, "kitty")

png2terminal("work/foo.png")

plot



library(kitty.r)
kitty_plot({
plot(1:10, (1:10)^2+rnorm(10)*10, pch = 20)
lines(1:10, (1:10)^2, col = 2, lwd = 2)
abline(col = "red", 0, 1)
})


raster2terminal <- function(raster, compress = TRUE) {
  # Convert the raster to raw byte vector
  data <- t(raster) |> col2rgb() |> as.vector() |> as.raw() 
  controlstring <- "a=T,f=24,s=%d,v=%d,m=%d"
  if (compress) {
    data <- memCompress(data)
    controlstring <- "a=T,f=24,s=%d,v=%d,o=z,m=%d"
  }
  # Encode
  payloads <- base64enc::base64encode(data, 4096)
  # Send the chunks to the terminal
  for (i in seq_along(payloads)) {
    start <- "\033_G"
    end <- "\033\\"
    control <- sprintf(controlstring, nrow(raster), ncol(raster), 
      1*(i != length(payloads)))
    out <- paste0(start, control, ";", payloads[i], end)
    cat(out)
  }
}

raster2terminal(raster)

raster2terminal(raster, FALSE)


col <- rep("#ff0000", 10*20)
col <- col2rgb(col) |> as.vector()


r <- as.raw(col)
payload <- base64enc::base64encode(r)


message <- paste0(start, control, ";", payload, end)

cat(message)

cat(start, control, ";", payload, sep ="")

cat(end)




data <- as.raw(sample(0:255, 100))
con <- rawConnection(raw(0), "wb")
zz  <- gzcon(con)

writeBin(data, zz)


val <- rawConnectionValue(con)

close(zz)
close(con)



data <- as.raw(sample(0:255, 100))
con <- rawConnection(raw(0), "wb")
writeBin(data, con)
val <- rawConnectionValue(con)
print(val)
close(con)


