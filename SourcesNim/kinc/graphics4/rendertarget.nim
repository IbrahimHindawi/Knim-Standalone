import ../../utils/comptime
initialize("kinc/graphics4/rendertarget.h","Kinc")

import textureunit
import ../../kincbackends/graphics4/graphics4

# type
#   kinc_g4_texture_unit_t* {.bycopy.} = object
#     impl*: kinc_g4_texture_unit_impl_t

type
  kinc_g4_render_target_format_t* {.size: sizeof(cint).} = enum
    KINC_G4_RENDER_TARGET_FORMAT_32BIT, KINC_G4_RENDER_TARGET_FORMAT_64BIT_FLOAT,
    KINC_G4_RENDER_TARGET_FORMAT_32BIT_RED_FLOAT,
    KINC_G4_RENDER_TARGET_FORMAT_128BIT_FLOAT,
    KINC_G4_RENDER_TARGET_FORMAT_16BIT_DEPTH,
    KINC_G4_RENDER_TARGET_FORMAT_8BIT_RED,
    KINC_G4_RENDER_TARGET_FORMAT_16BIT_RED_FLOAT
  kinc_g4_render_target_t* {.bycopy.} = object
    width*: cint
    height*: cint
    texWidth*: cint
    texHeight*: cint
    contextId*: cint
    isCubeMap*: bool
    isDepthAttachment*: bool
    impl*: kinc_g4_render_target_impl_t



proc kinc_g4_render_target_init*(renderTarget: ptr kinc_g4_render_target_t;
                                width: cint; height: cint; depthBufferBits: cint;
                                antialiasing: bool;
                                format: kinc_g4_render_target_format_t;
                                stencilBufferBits: cint; contextId: cint) {.
    importc: "kinc_g4_render_target_init".}
proc kinc_g4_render_target_init_cube*(renderTarget: ptr kinc_g4_render_target_t;
                                     cubeMapSize: cint; depthBufferBits: cint;
                                     antialiasing: bool;
                                     format: kinc_g4_render_target_format_t;
                                     stencilBufferBits: cint; contextId: cint) {.
    importc: "kinc_g4_render_target_init_cube".}
proc kinc_g4_render_target_destroy*(renderTarget: ptr kinc_g4_render_target_t) {.
    importc: "kinc_g4_render_target_destroy".}
proc kinc_g4_render_target_use_color_as_texture*(
    renderTarget: ptr kinc_g4_render_target_t; unit: kinc_g4_texture_unit_t) {.
    importc: "kinc_g4_render_target_use_color_as_texture".}
proc kinc_g4_render_target_use_depth_as_texture*(
    renderTarget: ptr kinc_g4_render_target_t; unit: kinc_g4_texture_unit_t) {.
    importc: "kinc_g4_render_target_use_depth_as_texture".}
proc kinc_g4_render_target_set_depth_stencil_from*(
    renderTarget: ptr kinc_g4_render_target_t; source: ptr kinc_g4_render_target_t) {.
    importc: "kinc_g4_render_target_set_depth_stencil_from".}
proc kinc_g4_render_target_get_pixels*(renderTarget: ptr kinc_g4_render_target_t;
                                      data: ptr uint8) {.
    importc: "kinc_g4_render_target_get_pixels".}
proc kinc_g4_render_target_generate_mipmaps*(
    renderTarget: ptr kinc_g4_render_target_t; levels: cint) {.
    importc: "kinc_g4_render_target_generate_mipmaps".}    