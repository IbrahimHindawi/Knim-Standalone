import ../../utils/comptime
initialize("kinc/graphics4/graphics.h","Kinc")

import pipeline, ../math/matrix, texture, rendertarget
import texturearray, constantlocation, textureunit

#const hhkGraphics = "kinc/graphics4/graphics.h"

#import ../../kincbackends/graphics4/Direct3D11/Direct3D11
#import ../../kincbackends/graphics4/graphics4

type 
  kinc_g4_texture_addressing_t* {.size: sizeof(cint).} = enum
    KINC_G4_TEXTURE_ADDRESSING_REPEAT, 
    KINC_G4_TEXTURE_ADDRESSING_MIRROR,
    KINC_G4_TEXTURE_ADDRESSING_CLAMP, 
    KINC_G4_TEXTURE_ADDRESSING_BORDER
  kinc_g4_texture_direction_t* {.size: sizeof(cint).} = enum
    KINC_G4_TEXTURE_DIRECTION_U, 
    KINC_G4_TEXTURE_DIRECTION_V,
    KINC_G4_TEXTURE_DIRECTION_W
  kinc_g4_texture_operation_t* {.size: sizeof(cint).} = enum
    KINC_G4_TEXTURE_OPERATION_MODULATE, 
    KINC_G4_TEXTURE_OPERATION_SELECT_FIRST,
    KINC_G4_TEXTURE_OPERATION_SELECT_SECOND
  kinc_g4_texture_argument_t* {.size: sizeof(cint).} = enum
    KINC_G4_TEXTURE_ARGUMENT_CURRENT_COLOR,
    KINC_G4_TEXTURE_ARGUMENT_TEXTURE_COLOR
  kinc_g4_texture_filter_t* {.size: sizeof(cint).} = enum
    KINC_G4_TEXTURE_FILTER_POINT, 
    KINC_G4_TEXTURE_FILTER_LINEAR,
    KINC_G4_TEXTURE_FILTER_ANISOTROPIC
  kinc_g4_mipmap_filter_t* {.size: sizeof(cint).} = enum
    KINC_G4_MIPMAP_FILTER_NONE, 
    KINC_G4_MIPMAP_FILTER_POINT, 
    KINC_G4_MIPMAP_FILTER_LINEAR ##  linear texture filter + linear mip filter -> trilinear filter

let kinc_g4_clear_color*:uint = 1
let kinc_g4_clear_depth*:uint = 2
let kinc_g4_clear_stencil*:uint = 4

proc kinc_g4_init*(window:cint, depthBufferBits: cint, stencilBufferBits: cint, vSync: bool) {.importc:"kinc_g4_init".}
proc kinc_g4_destroy*(window:cint) {.importc:"kinc_g4_destroy".}
proc kinc_g4_flush*() {.importc:"kinc_g4_flush".}
proc kinc_g4_begin*(window:cint) {.importc:"kinc_g4_begin".}
proc kinc_g4_end*(window:cint) {.importc:"kinc_g4_end".}
proc kinc_g4_swap_buffers*():bool    {.importc:"kinc_g4_swap_buffers".}

proc kinc_g4_clear*(flags:cuint, color: cuint, depth: cfloat, stencil: cint) {.importc:"kinc_g4_clear".}

proc kinc_g4_viewport*(x:cint, y: cint, width:cint, height:cint) {.importc:"kinc_g4_viewport".}

proc kinc_g4_scissor*(x:cint, y: cint, width:cint, height:cint) {.importc:"kinc_g4_scissor".}

proc kinc_g4_disable_scissor*() {.importc:"kinc_g4_disable_scissor".}

proc kinc_g4_draw_indexed_vertices*() {.importc:"kinc_g4_draw_indexed_vertices".}

proc kinc_g4_draw_indexed_vertices_from_to*(start: cint, count: cint) {.importc:"kinc_g4_draw_indexed_vertices_from_to".}

proc kinc_g4_draw_indexed_vertices_from_to_from*(start: cint, count: cint, vertex_start: cint) {.importc:"kinc_g4_draw_indexed_vertices_from_to_from".}

proc kinc_g4_draw_indexed_vertices_instanced*(instanceCount: cint) {.importc:"kinc_g4_draw_indexed_vertices_instanced".}

proc kinc_g4_draw_indexed_vertices_instanced_from_to*(instanceCount: cint, start: cint, count: cint) {.importc:"kinc_g4_draw_indexed_vertices_instanced_from_to".}

#proc kinc_g4_set_texture_addressing*(unit: kinc_g4_texture_unit_t, dir: kinc_g4_texture_direction_t, addressing: kinc_g4_texture_addressing_t) {.importc:"kinc_g4_set_texture_addressing".}

#proc kinc_g4_set_texture3d_addressing*(unit: kinc_g4_texture_unit_t, dir: kinc_g4_texture_direction_t, addressing: kinc_g4_texture_addressing_t) {.importc:"kinc_g4_set_texture3d_addressing".}

proc kinc_g4_set_pipeline*(pipeline: ptr kinc_g4_pipeline_t) {.importc:"kinc_g4_set_pipeline".}

proc kinc_g4_set_stencil_reference_value*(value: cint) {.importc:"kinc_g4_set_stencil_reference_value".}

proc kinc_g4_set_texture_operation*(operation: kinc_g4_texture_operation_t, arg1: kinc_g4_texture_argument_t, arg2: kinc_g4_texture_argument_t) {.importc:"kinc_g4_set_texture_operation".}

# proc kinc_g4_set_int*(location: Kinc_g4_constant_location, value: cint) {.importc:"kinc_g4_set_int".}
# proc kinc_g4_set_int2*(location: Kinc_g4_constant_location, value1: cint, value2: cint) {.importc:"kinc_g4_set_int2".}
# proc kinc_g4_set_int3*(location: Kinc_g4_constant_location, value1: cint, value2: cint, value3: cint) {.importc:"kinc_g4_set_int3".}
# proc kinc_g4_set_int4*(location: Kinc_g4_constant_location, value1: cint, value2: cint, value3: cint, value4: cint) {.importc:"kinc_g4_set_int4".}
# proc kinc_g4_set_ints*(location: Kinc_g4_constant_location, values: ptr cint, count: cint) {.importc:"kinc_g4_set_ints".}

# proc kinc_g4_set_float*(location: Kinc_g4_constant_location, value: cfloat) {.importc:"kinc_g4_set_float".}
# proc kinc_g4_set_float2*(location: Kinc_g4_constant_location, value1: cfloat, value2: cfloat) {.importc:"kinc_g4_set_float2".}
# proc kinc_g4_set_float3*(location: Kinc_g4_constant_location, value1: cfloat, value2: cfloat, value3: cfloat) {.importc:"kinc_g4_set_float3".}
# proc kinc_g4_set_float4*(location: Kinc_g4_constant_location, value1: cfloat, value2: cfloat, value3: cfloat, value4: cfloat) {.importc:"kinc_g4_set_float4".}
# proc kinc_g4_set_floats*(location: Kinc_g4_constant_location, values: ptr cfloat, count: cint) {.importc:"kinc_g4_set_floats".}

# proc kinc_g4_set_bool*(location: Kinc_g4_constant_location, value: bool) {.importc:"kinc_g4_set_bool".}

proc kinc_g4_set_matrix3*(location: kinc_g4_constant_location_t, value: ptr kinc_matrix3x3_t) {.importc:"kinc_g4_set_matrix3".}
proc kinc_g4_set_matrix4*(location: kinc_g4_constant_location_t, value: ptr kinc_matrix4x4_t) {.importc:"kinc_g4_set_matrix4".}

# proc kinc_g4_set_texture_magnification_filter*(unit: kinc_g4_texture_unit_t, filter: kinc_g4_texture_filter_t) {.importc:"kinc_g4_set_texture_magnification_filter".}

# proc kinc_g4_set_texture3d_magnification_filter*(texunit: kinc_g4_texture_unit_t, filter: kinc_g4_texture_filter_t) {.importc:"kinc_g4_set_texture3d_magnification_filter".}
# proc kinc_g4_set_texture_minification_filter*(unit: kinc_g4_texture_unit_t, filter: kinc_g4_texture_filter_t) {.importc:"kinc_g4_set_texture_minification_filter".}
# proc kinc_g4_set_texture3d_minification_filter*(texunit: kinc_g4_texture_unit_t, filter: kinc_g4_texture_filter_t) {.importc:"kinc_g4_set_texture3d_minification_filter".}
# proc kinc_g4_set_texture_mipmap_filter*(unit: kinc_g4_texture_unit_t, filter: kinc_g4_mipmap_filter_t) {.importc:"kinc_g4_set_texture_mipmap_filter".}
# proc kinc_g4_set_texture3d_mipmap_filter*(texunit: kinc_g4_texture_unit_t, filter: kinc_g4_mipmap_filter_t) {.importc:"kinc_g4_set_texture3d_mipmap_filter".}
# proc kinc_g4_set_texture_compare_mode*(unit: kinc_g4_texture_unit_t, enabled: bool) {.importc:"kinc_g4_set_texture_compare_mode".}
# proc kinc_g4_set_cubemap_compare_mode*(unit: kinc_g4_texture_unit_t, enabled: bool) {.importc:"kinc_g4_set_cubemap_compare_mode".}

proc kinc_g4_render_targets_inverted_y*():bool {.importc: "kinc_g4_render_targets_inverted_y".}

proc kinc_g4_non_pow2_textures_supported*():bool {.importc: "kinc_g4_non_pow2_textures_supported".}

proc kinc_g4_restore_render_target*() {.importc:"kinc_g4_restore_render_target".}

proc kinc_g4_set_render_targets*(targets: ptr ptr kinc_g4_render_target_t, count: cint) {.importc:"kinc_g4_set_render_targets".}

proc kinc_g4_set_render_target_face*(texture: ptr kinc_g4_render_target_t, face: cint) {.importc:"kinc_g4_set_render_target_face".}

proc kinc_g4_set_texture*(unit: kinc_g4_texture_unit_t, texture: ptr kinc_g4_texture_t) {.importc:"kinc_g4_set_texture".}
# proc kinc_g4_set_image_texture*(unit: kinc_g4_texture_unit_t, texture: ptr kinc_g4_texture_t) {.importc:"kinc_g4_set_image_texture".}

proc kinc_g4_init_occlusion_query*(occlusionQuery: ptr cuint):bool {.importc:"kinc_g4_init_occlusion_query".}

proc kinc_g4_delete_occlusion_query*(occlusionQuery: cuint) {.importc:"kinc_g4_delete_occlusion_query".}

proc kinc_g4_start_occlusion_query*(occlusionQuery: cuint) {.importc:"kinc_g4_start_occlusion_query".}

proc kinc_g4_end_occlusion_query*(occlusionQuery: cuint) {.importc:"kinc_g4_end_occlusion_query".}

proc kinc_g4_are_query_results_available*(occlusionQuery: cuint):bool {.importc:"kinc_g4_are_query_results_available".}

proc kinc_g4_get_query_results*(occlusionQuery: cuint, pixelCount:ptr cuint) {.importc:"kinc_g4_get_query_results".}

# proc kinc_g4_set_texture_array*(unit: kinc_g4_texture_unit_t, array: ptr Kinc_g4_texture_array) {.importc:"kinc_g4_set_texture_array".}

proc kinc_g4_antialiasing_samples*():cint {.importc:"kinc_g4_antialiasing_samples".}

proc kinc_g4_set_antialiasing_samples*(samples: cint) {.importc:"kinc_g4_set_antialiasing_samples".}
