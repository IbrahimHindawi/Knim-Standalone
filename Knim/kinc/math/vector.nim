import ../../utils/comptime
initialize("kinc/math/vector.h","Kinc")

import core, math

type
  kinc_vector2_t* {.bycopy.} = object
    x*: cfloat
    y*: cfloat

  kinc_vector3_t* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat

  kinc_vector4_t* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat
    w*: cfloat

proc kinc_vector3_t_new*(x, y, z: cfloat): kinc_vector3_t =
  var vec: kinc_vector3_t
  vec.x = x
  vec.y = y
  vec.z = z
  vec

proc kinc_vector3_t_subtract*(a, b: kinc_vector3_t): kinc_vector3_t =
  result = kinc_vector3_t_new(a.x - b.x, a.y - b.y, a.z - b.z)

proc kinc_vector3_t_cross*(a, b: kinc_vector3_t): kinc_vector3_t = 
  result = kinc_vector3_t_new(
    a.y * b.z - a.z * b.y,
    a.z * b.x - a.x * b.z,
    a.x * b.y - a.y * b.x)

proc kinc_vector3_t_dot*(a, b: kinc_vector3_t): cfloat =
  result = a.x * b.x + a.y * b.y + a.z * b.z

proc kinc_vector3_t_len*(v: kinc_vector3_t): float32 =
  result = sqrt(v.x * v.x + v.y * v.y + v.z * v.z)

proc kinc_vector3_t_normalize*(v: kinc_vector3_t): kinc_vector3_t =
  let len = v.kinc_vector3_t_len
  result = kinc_vector3_t_new(v.x / len, v.y / len, v.z / len)