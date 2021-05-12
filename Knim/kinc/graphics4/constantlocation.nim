import ../../utils/comptime
initialize("kinc/graphics4/constantlocation.h","Kinc")

import ../../kincbackends/graphics4/graphics4

import shader

type
  kinc_g4_constant_location_t* {.bycopy.} = object
    impl*: kinc_g4_constant_location_impl_t

