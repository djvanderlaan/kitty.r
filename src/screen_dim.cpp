
#include <Rcpp.h>
#include <stdio.h>
#include <sys/ioctl.h>

// [[Rcpp::export]]
Rcpp::IntegerVector screen_dim_cpp() {
  struct winsize sz;
  ioctl(0, TIOCGWINSZ, &sz);
  return {sz.ws_xpixel, sz.ws_ypixel, sz.ws_row, sz.ws_col};
}

