import ../../utils/comptime
initialize("kinc/math/core.h","Kinc")

const
  KINC_PI* = 3.141592654
  KINC_TAU* = 6.283185307

proc kinc_sin*(value: cfloat): cfloat {.importc: "kinc_sin".}
proc kinc_cos*(value: cfloat): cfloat {.importc: "kinc_cos".}
proc kinc_tan*(x: cfloat): cfloat {.importc: "kinc_tan".}
proc kinc_cot*(x: cfloat): cfloat {.importc: "kinc_cot".}
proc kinc_round*(value: cfloat): cfloat {.importc: "kinc_round".}
proc kinc_ceil*(value: cfloat): cfloat {.importc: "kinc_ceil".}
proc kinc_pow*(value: cfloat; exponent: cfloat): cfloat {.importc: "kinc_pow".}
proc kinc_max_float*(): cfloat {.importc: "kinc_max_float".}
proc kinc_sqrt*(value: cfloat): cfloat {.importc: "kinc_sqrt".}
proc kinc_abs*(value: cfloat): cfloat {.importc: "kinc_abs".}
proc kinc_asin*(value: cfloat): cfloat {.importc: "kinc_asin".}
proc kinc_acos*(value: cfloat): cfloat {.importc: "kinc_acos".}
proc kinc_atan*(value: cfloat): cfloat {.importc: "kinc_atan".}
proc kinc_atan2*(y: cfloat; x: cfloat): cfloat {.importc: "kinc_atan2".}
proc kinc_floor*(value: cfloat): cfloat {.importc: "kinc_floor".}
proc kinc_mod*(numer: cfloat; denom: cfloat): cfloat {.importc: "kinc_mod".}
proc kinc_exp*(exponent: cfloat): cfloat {.importc: "kinc_exp".}
proc kinc_min*(a: cfloat; b: cfloat): cfloat {.importc: "kinc_min".}
proc kinc_max*(a: cfloat; b: cfloat): cfloat {.importc: "kinc_max".}
proc kinc_mini*(a: cint; b: cint): cint {.importc: "kinc_mini".}
proc kinc_maxi*(a: cint; b: cint): cint {.importc: "kinc_maxi".}
proc kinc_clamp*(value: cfloat; minValue: cfloat; maxValue: cfloat): cfloat {.
    importc: "kinc_clamp".}