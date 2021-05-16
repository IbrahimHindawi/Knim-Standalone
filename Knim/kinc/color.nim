import ../utils/comptime
initialize("kinc/color.h","Kinc")


proc colorComponents*(color: cuint; red: ptr cfloat; green: ptr cfloat;
  blue: ptr cfloat; alpha: ptr cfloat) {.importc:"kinc_color_components".}  
const
  ColorBlack* = 0xFF000000
  ColorWhite* = 0xFFFFFFFF
  ColorRed* = 0xFFFF0000
  ColorBlue* = 0xFF0000FF
  ColorGreen* = 0xFF00FF00
  ColorMagenta* = 0xFFFF00FF
  ColorYellow* = 0xFFFFFF00
  ColorCyan* = 0xFF00FFFF
