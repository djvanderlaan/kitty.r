
#include <Rcpp.h>
#include <stdio.h>
#include <sys/ioctl.h>

// [[Rcpp::export]]
int screen_width_cpp() {
  struct winsize sz;
  ioctl(0, TIOCGWINSZ, &sz);
  return sz.ws_xpixel;
}

