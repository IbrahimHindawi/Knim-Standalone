import ../../utils/comptime
initialize("kinc/math/matrix.h","Kinc")

import core, vector

type
  kinc_matrix3x3_t* {.bycopy.} = object
    m*: array[3 * 3, cfloat]

  kinc_matrix4x4_t* {.bycopy.}  = object
    m*: array[4 * 4, cfloat]

proc kinc_matrix3x3_get*(matrix: ptr kinc_matrix3x3_t, x: cint, y: cint):cfloat
  {.importc: "kinc_matrix3x3_get".}
proc kinc_matrix3x3_set*(matrix: ptr kinc_matrix3x3_t, x: cint, y: cint, value: cfloat )
  {.importc: "kinc_matrix3x3_set".}
proc kinc_matrix3x3_transpose*(matrix: ptr kinc_matrix3x3_t)
  {.importc: "kinc_matrix3x3_transpose".}
proc kinc_matrix3x3_identity*(): kinc_matrix3x3_t
  {.importc: "kinc_matrix3x3_identity".}
proc kinc_matrix3x_rotation_x*(alpha: cfloat): kinc_matrix3x3_t
  {.importc: "kinc_matrix3x_rotation_x".}
proc kinc_matrix3x_rotation_y*(alpha: cfloat): kinc_matrix3x3_t
  {.importc: "kinc_matrix3x_rotation_y".}
proc kinc_matrix3x_rotation_z*(alpha: cfloat): kinc_matrix3x3_t
  {.importc: "kinc_matrix3x_rotation_z".}

proc kinc_matrix4x4_get*(matrix: ptr kinc_matrix4x4_t; x: cint; y: cint): cfloat {.
  importc: "kinc_matrix4x4_get".}
proc kinc_matrix4x4_set*(matrix: ptr kinc_matrix4x4_t; x: cint; y: cint; value: cfloat) {.
  importc: "kinc_matrix4x4_set".}
proc kinc_matrix4x4_transpose*(matrix: ptr kinc_matrix4x4_t) {.
  importc: "kinc_matrix4x4_transpose".}
proc kinc_matrix4x4_multiply*(a: ptr kinc_matrix4x4_t; b: ptr kinc_matrix4x4_t): kinc_matrix4x4_t {.
  importc: "kinc_matrix4x4_multiply".}


proc kinc_matrix4x4_identity*(): kinc_matrix4x4_t = 
  var view: kinc_matrix4x4_t

  kinc_matrix4x4_set(view.addr, 0, 0, 1)
  kinc_matrix4x4_set(view.addr, 0, 1, 0)
  kinc_matrix4x4_set(view.addr, 0, 2, 0)
  kinc_matrix4x4_set(view.addr, 0, 3, 0)
  
  kinc_matrix4x4_set(view.addr, 1, 0, 0)
  kinc_matrix4x4_set(view.addr, 1, 1, 1)
  kinc_matrix4x4_set(view.addr, 1, 2, 0)
  kinc_matrix4x4_set(view.addr, 1, 3, 0)

  kinc_matrix4x4_set(view.addr, 2, 0, 0)
  kinc_matrix4x4_set(view.addr, 2, 1, 0)
  kinc_matrix4x4_set(view.addr, 2, 2, 1)
  kinc_matrix4x4_set(view.addr, 2, 3, 0)

  kinc_matrix4x4_set(view.addr, 3, 0, 0)
  kinc_matrix4x4_set(view.addr, 3, 1, 0)
  kinc_matrix4x4_set(view.addr, 3, 2, 0)
  kinc_matrix4x4_set(view.addr, 3, 3, 1)


proc kinc_matrix4x4_perspective*( fov: float, aspect: float,
                                  near: float, far: float): kinc_matrix4x4_t =
  var 
    m: kinc_matrix4x4_t
    uh: float = kinc_cot(fov/2.0)
    uw: float = uh / aspect
  kinc_matrix4x4_set(m.addr, 0, 0, uw)
  kinc_matrix4x4_set(m.addr, 1, 1, uh)
  kinc_matrix4x4_set(m.addr, 2, 2, ((far + near) / (far - near)))
  kinc_matrix4x4_set(m.addr, 3, 2, 1)
  return m

proc kinc_matrix4x4_look_at*( eye: kinc_vector3_t, at: kinc_vector3_t, up: kinc_vector3_t): kinc_matrix4x4_t =
  
  var zaxis: kinc_vector3_t = kinc_vector3_t_subtract(at, eye)
  zaxis = kinc_vector3_t_normalize(zaxis)

  var xaxis: kinc_vector3_t = kinc_vector3_t_cross(up, zaxis)
  xaxis = kinc_vector3_t_normalize(xaxis)

  var yaxis: kinc_vector3_t = kinc_vector3_t_cross(zaxis, xaxis)
  var view: kinc_matrix4x4_t

  kinc_matrix4x4_set(view.addr, 0, 0, xaxis.x)
  kinc_matrix4x4_set(view.addr, 0, 1, xaxis.y)
  kinc_matrix4x4_set(view.addr, 0, 2, xaxis.z)
  kinc_matrix4x4_set(view.addr, 0, 3, kinc_vector3_t_dot(xaxis, eye) * -1)
  
  kinc_matrix4x4_set(view.addr, 1, 0, yaxis.x)
  kinc_matrix4x4_set(view.addr, 1, 1, yaxis.y)
  kinc_matrix4x4_set(view.addr, 1, 2, yaxis.z)
  kinc_matrix4x4_set(view.addr, 1, 3, kinc_vector3_t_dot(yaxis, eye) * -1)

  kinc_matrix4x4_set(view.addr, 2, 0, zaxis.x)
  kinc_matrix4x4_set(view.addr, 2, 1, zaxis.y)
  kinc_matrix4x4_set(view.addr, 2, 2, zaxis.z)
  kinc_matrix4x4_set(view.addr, 2, 3, kinc_vector3_t_dot(zaxis, eye) * -1)

  kinc_matrix4x4_set(view.addr, 3, 0, 0)
  kinc_matrix4x4_set(view.addr, 3, 1, 0)
  kinc_matrix4x4_set(view.addr, 3, 2, 0)
  kinc_matrix4x4_set(view.addr, 3, 3, 1)

  view
  

  