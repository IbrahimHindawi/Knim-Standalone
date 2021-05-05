import ../../utils/comptime
initialize("kinc/graphics4/pipeline.h","Kinc")

import rendertarget
import textureunit    
import vertexstructure
import shader

#const hhkPipe = "kinc/graphics4/pipeline.h"
#const hhkCLoc = "kinc/graphics4/constantlocation.h"

# todo: come back to this file
#type
#    Kinc_g4_constant_location* {.importc:"kinc_g4_constant_location_t", header: hhkCLoc.} = object
#    Kinc_g4_texture_unit* {.importc:"kinc_g4_texture_unit_t", header: hhkCLoc.} = object

import ../../kincbackends/graphics4/graphics4

type
  kinc_g4_blending_operation_t* {.size: sizeof(cint).} = enum
    KINC_G4_BLEND_ONE, KINC_G4_BLEND_ZERO, KINC_G4_BLEND_SOURCE_ALPHA,
    KINC_G4_BLEND_DEST_ALPHA, KINC_G4_BLEND_INV_SOURCE_ALPHA,
    KINC_G4_BLEND_INV_DEST_ALPHA, KINC_G4_BLEND_SOURCE_COLOR,
    KINC_G4_BLEND_DEST_COLOR, KINC_G4_BLEND_INV_SOURCE_COLOR,
    KINC_G4_BLEND_INV_DEST_COLOR
  kinc_g4_compare_mode_t* {.size: sizeof(cint).} = enum
    KINC_G4_COMPARE_ALWAYS, KINC_G4_COMPARE_NEVER, KINC_G4_COMPARE_EQUAL,
    KINC_G4_COMPARE_NOT_EQUAL, KINC_G4_COMPARE_LESS, KINC_G4_COMPARE_LESS_EQUAL,
    KINC_G4_COMPARE_GREATER, KINC_G4_COMPARE_GREATER_EQUAL
  kinc_g4_cull_mode_t* {.size: sizeof(cint).} = enum
    KINC_G4_CULL_CLOCKWISE, KINC_G4_CULL_COUNTER_CLOCKWISE, KINC_G4_CULL_NOTHING
  kinc_g4_stencil_action_t* {.size: sizeof(cint).} = enum
    KINC_G4_STENCIL_KEEP, KINC_G4_STENCIL_ZERO, KINC_G4_STENCIL_REPLACE,
    KINC_G4_STENCIL_INCREMENT, KINC_G4_STENCIL_INCREMENT_WRAP,
    KINC_G4_STENCIL_DECREMENT, KINC_G4_STENCIL_DECREMENT_WRAP,
    KINC_G4_STENCIL_INVERT

  kinc_g4_pipeline_t* {.bycopy.} = object
    input_layout*: array[16, ptr kinc_g4_vertex_structure_t]
    vertex_shader*: ptr kinc_g4_shader_t
    fragment_shader*: ptr kinc_g4_shader_t
    geometry_shader*: ptr kinc_g4_shader_t
    tessellation_control_shader*: ptr kinc_g4_shader_t
    tessellation_evaluation_shader*: ptr kinc_g4_shader_t
    cull_mode*: kinc_g4_cull_mode_t
    depth_write*: bool
    depth_mode*: kinc_g4_compare_mode_t
    stencil_mode*: kinc_g4_compare_mode_t
    stencil_both_pass*: kinc_g4_stencil_action_t
    stencil_depth_fail*: kinc_g4_stencil_action_t
    stencil_fail*: kinc_g4_stencil_action_t
    stencil_reference_value*: cint
    stencil_read_mask*: cint
    stencil_write_mask*: cint  ##  One, Zero deactivates blending
    blend_source*: kinc_g4_blending_operation_t
    blend_destination*: kinc_g4_blending_operation_t ##  BlendingOperation blendOperation;
    alpha_blend_source*: kinc_g4_blending_operation_t
    alpha_blend_destination*: kinc_g4_blending_operation_t ##  BlendingOperation alphaBlendOperation;
    color_write_mask_red*: array[8, bool] ##  Per render target
    color_write_mask_green*: array[8, bool]
    color_write_mask_blue*: array[8, bool]
    color_write_mask_alpha*: array[8, bool]
    color_attachment_count*: cint
    color_attachment*: array[8, kinc_g4_render_target_format_t]
    depth_attachment_bits*: cint
    stencil_attachment_bits*: cint
    conservative_rasterization*: bool
    impl*: kinc_g4_pipeline_impl_t

proc kinc_g4_pipeline_init*(state: ptr kinc_g4_pipeline_t) {.importc: "kinc_g4_pipeline_init".}
proc kinc_g4_pipeline_destroy*(state: ptr kinc_g4_pipeline_t) {.importc: "kinc_g4_pipeline_destroy".}
proc kinc_g4_pipeline_compile*(state: ptr kinc_g4_pipeline_t) {.importc: "kinc_g4_pipeline_compile".}
#proc kinc_g4_pipeline_get_constant_location*(state: ptr kinc_g4_pipeline_t, name:cstring):Kinc_g4_constant_location {.importc: "kinc_g4_pipeline_get_constant_location".}
#proc kinc_g4_pipeline_get_texture_unit*(state: ptr kinc_g4_pipeline_t, name:cstring):Kinc_g4_texture_unit {.importc: "kinc_g4_pipeline_get_texture_unit".}