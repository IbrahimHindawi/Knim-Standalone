import ../../utils/comptime
initialize("kinc/graphics4/texture.h","Kinc")

import ../image
import ../../kincbackends/graphics4/graphics4
# when defined(Direct3D11):
#import ../../kincbackends/graphics4/Direct3D11/Direct3D11
# elif defined(OpenGL):
#import ../../kincbackends/graphics4/OpenGL/OpenGL


type
  kinc_g4_image_t* = kinc_image_t
  kinc_g4_texture_t* {.bycopy.} = object
    tex_width*: cint
    tex_height*: cint
    tex_depth*: cint
    format*: kinc_image_format_t
    impl*: kinc_g4_texture_impl_t


proc kinc_g4_texture_init*(texture: ptr kinc_g4_texture_t; width: cint; height: cint;
                          format: kinc_image_format_t) {.
    importc: "kinc_g4_texture_init".}
proc kinc_g4_texture_init3d*(texture: ptr kinc_g4_texture_t; width: cint;
                            height: cint; depth: cint; format: kinc_image_format_t) {.
    importc: "kinc_g4_texture_init3d".}
proc kinc_g4_texture_init_from_image*(texture: ptr kinc_g4_texture_t;
                                     image: ptr kinc_image_t) {.
    importc: "kinc_g4_texture_init_from_image".}
proc kinc_g4_texture_init_from_image3d*(texture: ptr kinc_g4_texture_t;
                                       image: ptr kinc_image_t) {.
    importc: "kinc_g4_texture_init_from_image3d".}
proc kinc_g4_texture_destroy*(texture: ptr kinc_g4_texture_t) {.
    importc: "kinc_g4_texture_destroy".}
when defined(KORE_ANDROID):
  proc kinc_g4_texture_init_from_id*(texture: ptr kinc_g4_texture_t; texid: cuint) {.
      importc: "kinc_g4_texture_init_from_id".}
##  void _set(TextureUnit unit);
##  void _setImage(TextureUnit unit);

proc kinc_g4_texture_lock*(texture: ptr kinc_g4_texture_t): ptr cuchar {.
    importc: "kinc_g4_texture_lock".}
proc kinc_g4_texture_unlock*(texture: ptr kinc_g4_texture_t) {.
    importc: "kinc_g4_texture_unlock".}
proc kinc_g4_texture_clear*(texture: ptr kinc_g4_texture_t; x: cint; y: cint; z: cint;
                           width: cint; height: cint; depth: cint; color: cuint) {.
    importc: "kinc_g4_texture_clear".}
when defined(KORE_IOS) or defined(KORE_MACOS):
  proc kinc_g4_texture_upload*(texture: ptr kinc_g4_texture_t; data: ptr uint8;
                              stride: cint) {.importc: "kinc_g4_texture_upload",
      .}
proc kinc_g4_texture_generate_mipmaps*(texture: ptr kinc_g4_texture_t; levels: cint) {.
    importc: "kinc_g4_texture_generate_mipmaps".}
proc kinc_g4_texture_set_mipmap*(texture: ptr kinc_g4_texture_t;
                                mipmap: ptr kinc_image_t; level: cint) {.
    importc: "kinc_g4_texture_set_mipmap".}
proc kinc_g4_texture_stride*(texture: ptr kinc_g4_texture_t): cint {.
    importc: "kinc_g4_texture_stride".}