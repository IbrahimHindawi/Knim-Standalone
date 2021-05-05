import ../../utils/comptime
initialize("kinc/graphics4/texturearray.h","Kinc")

import ../image
import ../../kincbackends/graphics4/graphics4

type
  kinc_g4_texture_array_t* {.bycopy.} = object
    impl*: kinc_g4_texture_array_impl_t


proc kinc_g4_texture_array_init*(array: ptr kinc_g4_texture_array_t;
                                textures: ptr kinc_image_t; count: cint) {.
    importc: "kinc_g4_texture_array_init".}
proc kinc_g4_texture_array_destroy*(array: ptr kinc_g4_texture_array_t) {.
    importc: "kinc_g4_texture_array_destroy".}