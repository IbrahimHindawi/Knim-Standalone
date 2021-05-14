import ../utils/comptime
initialize("kinc/color.h","Kinc")


proc kinc_color_components*(color: cuint; red: ptr cfloat; green: ptr cfloat;
  blue: ptr cfloat; alpha: ptr cfloat) {.importc:"kinc_color_components".}  
const
  KINC_COLOR_BLACK* = 0xFF000000
  KINC_COLOR_WHITE* = 0xFFFFFFFF
  KINC_COLOR_RED* = 0xFFFF0000
  KINC_COLOR_BLUE* = 0xFF0000FF
  KINC_COLOR_GREEN* = 0xFF00FF00
  KINC_COLOR_MAGENTA* = 0xFFFF00FF
  KINC_COLOR_YELLOW* = 0xFFFFFF00
  KINC_COLOR_CYAN* = 0xFF00FFFF
