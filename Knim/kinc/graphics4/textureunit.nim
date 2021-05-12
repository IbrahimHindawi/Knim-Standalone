import ../../utils/comptime
initialize("kinc/graphics4/textureunit.h","Kinc")

import ../../kincbackends/graphics4/graphics4

type
  kinc_g4_texture_unit_t* {.bycopy.} = object
    impl*: kinc_g4_texture_unit_impl_t