#[
  This is the amalgamated Kinc G4 module plus amalgamated G4 Kinc backends
  It uses compiler defines to switch Backends, visit main.nims NimScript
]#

when defined(Windows):
  const
    libExt = ".dll"
elif defined(Linux):
  const
    libExt = ".so"
elif defined(MacOSX):
  const
    libExt = ".dylib"

when defined(Direct3D11):
  const
    libName = "Kinc" & libExt
elif defined(OpenGL):
  const
    libName = "Kinc" & libExt    

{.push dynlib: libName.}
## //////////////////////////
##  g4/vertexstructure
## //////////////////////////
type
  kinc_g4_vertex_data_t* {.size: sizeof(cint).} = enum
    KINC_G4_VERTEX_DATA_NONE, KINC_G4_VERTEX_DATA_FLOAT1,
    KINC_G4_VERTEX_DATA_FLOAT2, KINC_G4_VERTEX_DATA_FLOAT3,
    KINC_G4_VERTEX_DATA_FLOAT4, KINC_G4_VERTEX_DATA_FLOAT4X4,
    KINC_G4_VERTEX_DATA_SHORT2_NORM, KINC_G4_VERTEX_DATA_SHORT4_NORM,
    KINC_G4_VERTEX_DATA_COLOR
  kinc_g4_vertex_element_t* {.bycopy.} = object
    name*: cstring
    data*: kinc_g4_vertex_data_t

proc kinc_g4_vertex_element_init*(element: ptr kinc_g4_vertex_element_t;
                                 name: cstring; data: kinc_g4_vertex_data_t) {.
    importc: "kinc_g4_vertex_element_init".}
const
  KINC_G4_MAX_VERTEX_ELEMENTS* = 16

type
  kinc_g4_vertex_structure_t* {.bycopy.} = object
    elements*: array[KINC_G4_MAX_VERTEX_ELEMENTS, kinc_g4_vertex_element_t]
    size*: cint
    instanced*: bool


proc kinc_g4_vertex_structure_init*(structure: ptr kinc_g4_vertex_structure_t) {.
    importc: "kinc_g4_vertex_structure_init".}
proc kinc_g4_vertex_structure_add*(structure: ptr kinc_g4_vertex_structure_t;
                                  name: cstring; data: kinc_g4_vertex_data_t) {.
    importc: "kinc_g4_vertex_structure_add".}


# Backend switching based on compiler defines ! ! ! 
## ////////////////////////////////////////
##  Direct3D11
## ////////////////////////////////////////
when defined(Direct3D11):
  #const libName = "KincDirect3D11" & libExt
  ## ////////////////////
  ##  indexbuffer
  ## ////////////////////

  type
    ID3D11Buffer* {.bycopy.} = object

    kinc_g4_index_buffer_impl_t* {.bycopy.} = object
      ib*: ptr ID3D11Buffer
      indices*: ptr cint
      count*: cint


  ## **static Graphics4::IndexBuffer* _current;
  ## ////////////////////
  ##  pipeline
  ## ////////////////////

  type
    ID3D11InputLayout* {.bycopy.} = object
    ID3D11PixelShader* {.bycopy.} = object
    ID3D11VertexShader* {.bycopy.} = object
    ID3D11DepthStencilState* {.bycopy.} = object
    ID3D11RasterizerState* {.bycopy.} = object
    ID3D11BlendState* {.bycopy.} = object
    kinc_g4_pipeline_impl_t* {.bycopy.} = object
      d3d11inputLayout*: ptr ID3D11InputLayout
      fragmentConstantBuffer*: ptr ID3D11Buffer
      vertexConstantBuffer*: ptr ID3D11Buffer
      geometryConstantBuffer*: ptr ID3D11Buffer
      tessEvalConstantBuffer*: ptr ID3D11Buffer
      tessControlConstantBuffer*: ptr ID3D11Buffer
      depthStencilState*: ptr ID3D11DepthStencilState
      rasterizerState*: ptr ID3D11RasterizerState
      rasterizerStateScissor*: ptr ID3D11RasterizerState
      blendState*: ptr ID3D11BlendState
  proc kinc_internal_set_constants*() {.importc: "kinc_internal_set_constants",.}
  ## ////////////////////
  ##  rendertarget
  ## ////////////////////

  type
    ID3D11Texture2D* {.bycopy.} = object

    ID3D11RenderTargetView* {.bycopy.} = object

    ID3D11DepthStencilView* {.bycopy.} = object

    ID3D11ShaderResourceView* {.bycopy.} = object

    kinc_g4_render_target_impl_t* {.bycopy.} = object
      textureRender*: ptr ID3D11Texture2D
      textureSample*: ptr ID3D11Texture2D
      textureStaging*: ptr ID3D11Texture2D
      renderTargetViewRender*: array[6, ptr ID3D11RenderTargetView]
      renderTargetViewSample*: array[6, ptr ID3D11RenderTargetView]
      depthStencil*: ptr ID3D11Texture2D
      depthStencilView*: array[6, ptr ID3D11DepthStencilView]
      renderTargetSRV*: ptr ID3D11ShaderResourceView
      depthStencilSRV*: ptr ID3D11ShaderResourceView
      format*: cint


  ## ////////////////////
  ##  shaderhash
  ## ////////////////////

  type
    kinc_internal_hash_index_t* {.bycopy.} = object
      hash*: uint32
      index*: uint32


  proc kinc_internal_hash_name*(str: ptr cuchar): uint32 {.importc: "kinc_internal_hash_name".}
  ## ////////////////////
  ##  shader
  ## ////////////////////

  type
    kinc_internal_shader_constant_t* {.bycopy.} = object
      hash*: uint32
      offset*: uint32
      size*: uint32
      columns*: uint8
      rows*: uint8

    kinc_g4_shader_impl_t* {.bycopy.} = object
      constants*: array[64, kinc_internal_shader_constant_t]
      constantsSize*: cint
      attributes*: array[64, kinc_internal_hash_index_t]
      textures*: array[64, kinc_internal_hash_index_t]
      shader*: pointer
      data*: ptr uint8
      length*: cint
      `type`*: cint

    kinc_g4_constant_location_impl_t* {.bycopy.} = object
      vertexOffset*: uint32
      vertexSize*: uint32
      fragmentOffset*: uint32
      fragmentSize*: uint32
      geometryOffset*: uint32
      geometrySize*: uint32
      tessEvalOffset*: uint32
      tessEvalSize*: uint32
      tessControlOffset*: uint32
      tessControlSize*: uint32
      vertexColumns*: uint8
      vertexRows*: uint8
      fragmentColumns*: uint8
      fragmentRows*: uint8
      geometryColumns*: uint8
      geometryRows*: uint8
      tessEvalColumns*: uint8
      tessEvalRows*: uint8
      tessControlColumns*: uint8
      tessControlRows*: uint8

    kinc_g4_texture_unit_impl_t* {.bycopy.} = object
      unit*: cint
      vertex*: bool


  ## ////////////////////
  ##  texture
  ## ////////////////////

  type
    ID3D11Texture3D* {.bycopy.} = object
    ID3D11UnorderedAccessView* {.bycopy.} = object
  type
    kinc_g4_texture_impl_t* {.bycopy.} = object
      hasMipmaps*: bool
      stage*: cint
      texture*: ptr ID3D11Texture2D
      texture3D*: ptr ID3D11Texture3D
      view*: ptr ID3D11ShaderResourceView
      computeView*: ptr ID3D11UnorderedAccessView
      renderView*: ptr ID3D11RenderTargetView
      rowPitch*: cint


  ## ////////////////////
  ##  texturearray
  ## ////////////////////

  type
    kinc_g4_texture_array_impl_t* {.bycopy.} = object
      texture*: ptr ID3D11Texture2D
      view*: ptr ID3D11ShaderResourceView ##  void set(Kore::Graphics4::TextureUnit unit);

  ## ////////////////////
  ##  vertexbuffer
  ## ////////////////////

  type
    kinc_g4_vertex_buffer_impl_t* {.bycopy.} = object
      vb*: ptr ID3D11Buffer
      stride*: cint
      count*: cint
      lockStart*: cint
      lockCount*: cint
      vertices*: ptr cfloat
      usage*: cint

  ## ////////////////////////////////////////
  ##  OpenGL
  ## ////////////////////////////////////////
elif defined(OpenGL):
  #const libName = "KincOpenGL" & libExt

  # type
  #   kinc_g4_shader_impl_t* {.bycopy.} = object
  #     glid*: cuint
  #     source*: cstring
  #     length*: csize_t
  #     fromSource*: bool
  #   kinc_g4_constant_location_impl_t* {.bycopy.} = object
  #     location*: cint
  #     `type`*: cuint
  #   kinc_g4_texture_unit_impl_t* {.bycopy.} = object
  #     unit*: cint

  ## //////////////////////
  ##  indexbuffer
  ## //////////////////////

  type
    kinc_g4_index_buffer_impl_t* {.bycopy.} = object
      shortData*: ptr uint16
      data*: ptr cint
      myCount*: cint
      bufferId*: cuint


  ## //////////////////////
  ##  pipeline
  ## //////////////////////

  type
    kinc_g4_pipeline_impl_t* {.bycopy.} = object
      programId*: cuint
      textures*: cstringArray
      textureValues*: ptr cint
      textureCount*: cint


  ## //////////////////////
  ##  rendertarget
  ## //////////////////////

  type
    kinc_g4_render_target_impl_t* {.bycopy.} = object
      framebuffer*: cuint
      texture*: cuint
      depthTexture*: cuint
      hasDepth*: bool           ##  unsigned _depthRenderbuffer;
      contextId*: cint
      format*: cint


  ## //////////////////////
  ##  shader
  ## //////////////////////

  type
    kinc_g4_shader_impl_t* {.bycopy.} = object
      glid*: cuint
      source*: cstring
      length*: csize_t
      fromSource*: bool

    kinc_g4_constant_location_impl_t* {.bycopy.} = object
      location*: cint
      `type`*: cuint

    kinc_g4_texture_unit_impl_t* {.bycopy.} = object
      unit*: cint


  ## //////////////////////
  ##  ShaderStorageBufferImpl
  ## //////////////////////

  type
    kinc_compute_shader_storage_buffer_impl_t* {.bycopy.} = object
      data*: ptr cint ## ShaderStorageBufferImpl(int count, Graphics4::VertexData type);
                  ## void unset();
      myCount*: cint
      myStride*: cint
      bufferId*: cuint           ## static ShaderStorageBuffer* current;


  ## //////////////////////
  ##  texture.h
  ## //////////////////////

  type
    kinc_g4_texture_impl_t* {.bycopy.} = object
      texture*: cuint
      when defined(KORE_ANDROID):
        external_oes* {.importc: "external_oes".}: bool
      pixfmt*: uint8


  ## //////////////////////
  ##  texturearray
  ## //////////////////////

  type
    kinc_g4_texture_array_impl_t* {.bycopy.} = object
      texture*: cuint


  ## //////////////////////
  ##  vertexbuffer
  ## //////////////////////

  type
    kinc_g4_vertex_buffer_impl_t* {.bycopy.} = object
      data*: ptr cfloat
      myCount*: cint
      myStride*: cint
      bufferId*: cuint
      usage*: cuint
      sectionStart*: cint
      sectionSize*: cint         ## #if defined KORE_ANDROID || defined KORE_HTML5 || defined KORE_TIZEN
      structure*: kinc_g4_vertex_structure_t ## #endif
      instanceDataStepRate*: cint
      #when not defined(NDEBUG):
        #initialized* {.importc: "initialized".}: bool

import kinc/image
import kinc/math/matrix

## ////////////////////////////////////////////////////
## //////////////////////////
##  KINC G4
## //////////////////////////
## ////////////////////////////////////////////////////

type
  kinc_g4_constant_location_t* {.bycopy.} = object
    impl*: kinc_g4_constant_location_impl_t

## //////////////////////////
##  textureunit
## //////////////////////////
type
  kinc_g4_texture_unit_t* {.bycopy.} = object
    impl*: kinc_g4_texture_unit_impl_t

## //////////////////////////
##  graphics
## //////////////////////////

type
  kinc_g4_render_target* {.bycopy.} = object

  #kinc_g4_texture_t* {.bycopy.} = object

  kinc_g4_texture_array* {.bycopy.} = object

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

## //////////////////////////
##  indexbuffer
## //////////////////////////

type
  kinc_g4_index_buffer_format_t* {.size: sizeof(cint).} = enum
    KINC_G4_INDEX_BUFFER_FORMAT_32BIT, KINC_G4_INDEX_BUFFER_FORMAT_16BIT
  kinc_g4_index_buffer_t* {.bycopy.} = object
    impl*: kinc_g4_index_buffer_impl_t



proc kinc_g4_index_buffer_init*(buffer: ptr kinc_g4_index_buffer_t; count: cint;
                               format: kinc_g4_index_buffer_format_t) {.
    importc: "kinc_g4_index_buffer_init".}
proc kinc_g4_index_buffer_destroy*(buffer: ptr kinc_g4_index_buffer_t) {.
    importc: "kinc_g4_index_buffer_destroy".}
proc kinc_g4_index_buffer_lock*(buffer: ptr kinc_g4_index_buffer_t): ptr cint {.
    importc: "kinc_g4_index_buffer_lock".}
proc kinc_g4_index_buffer_unlock*(buffer: ptr kinc_g4_index_buffer_t) {.
    importc: "kinc_g4_index_buffer_unlock".}
proc kinc_g4_index_buffer_count*(buffer: ptr kinc_g4_index_buffer_t): cint {.
    importc: "kinc_g4_index_buffer_count".}
proc kinc_internal_g4_index_buffer_set*(buffer: ptr kinc_g4_index_buffer_t) {.
    importc: "kinc_internal_g4_index_buffer_set".}
proc kinc_g4_set_index_buffer*(buffer: ptr kinc_g4_index_buffer_t) {.
    importc: "kinc_g4_set_index_buffer".}

## //////////////////////////
##  rendertarget
## //////////////////////////

# import
#   textureunit

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
## //////////////////////////
##  pipeline
## //////////////////////////
## //////////////////////////
##  shader
## //////////////////////////

type
  kinc_g4_shader_type_t* {.size: sizeof(cint).} = enum
    KINC_G4_SHADER_TYPE_FRAGMENT, KINC_G4_SHADER_TYPE_VERTEX,
    KINC_G4_SHADER_TYPE_GEOMETRY, KINC_G4_SHADER_TYPE_TESSELLATION_CONTROL,
    KINC_G4_SHADER_TYPE_TESSELLATION_EVALUATION
  kinc_g4_shader_t* {.bycopy.} = object
    impl*: kinc_g4_shader_impl_t

proc kinc_g4_shader_init*(shader: ptr kinc_g4_shader_t; data: pointer;
                         length: csize_t; `type`: kinc_g4_shader_type_t) {.
    importc: "kinc_g4_shader_init".}
proc kinc_g4_shader_init_from_source*(shader: ptr kinc_g4_shader_t; source: cstring;
                                     `type`: kinc_g4_shader_type_t) {.
    importc: "kinc_g4_shader_init_from_source".}
##  Beware, this is not portable

proc kinc_g4_shader_destroy*(shader: ptr kinc_g4_shader_t) {.
    importc: "kinc_g4_shader_destroy".}

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


## //////////////////////////
##  texture
## //////////////////////////

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
    
## //////////////////////////
##  texturearray
## //////////////////////////

type
  kinc_g4_texture_array_t* {.bycopy.} = object
    impl*: kinc_g4_texture_array_impl_t


proc kinc_g4_texture_array_init*(array: ptr kinc_g4_texture_array_t;
                                textures: ptr kinc_image_t; count: cint) {.
    importc: "kinc_g4_texture_array_init".}
proc kinc_g4_texture_array_destroy*(array: ptr kinc_g4_texture_array_t) {.
    importc: "kinc_g4_texture_array_destroy".}


#////////////
# pipeline?
#////////////

proc kinc_g4_pipeline_init*(state: ptr kinc_g4_pipeline_t) {.
    importc: "kinc_g4_pipeline_init".}
proc kinc_g4_pipeline_destroy*(state: ptr kinc_g4_pipeline_t) {.
    importc: "kinc_g4_pipeline_destroy".}
proc kinc_g4_pipeline_compile*(state: ptr kinc_g4_pipeline_t) {.
    importc: "kinc_g4_pipeline_compile".}
proc kinc_g4_pipeline_get_constant_location*(state: ptr kinc_g4_pipeline_t;
    name: cstring): kinc_g4_constant_location_t {.
    importc: "kinc_g4_pipeline_get_constant_location".}
proc kinc_g4_pipeline_get_texture_unit*(state: ptr kinc_g4_pipeline_t; name: cstring): kinc_g4_texture_unit_t {.
    importc: "kinc_g4_pipeline_get_texture_unit".}
proc kinc_g4_internal_set_pipeline*(pipeline: ptr kinc_g4_pipeline_t) {.
    importc: "kinc_g4_internal_set_pipeline".}
proc kinc_g4_internal_pipeline_set_defaults*(pipeline: ptr kinc_g4_pipeline_t) {.
    importc: "kinc_g4_internal_pipeline_set_defaults".}


proc kinc_g4_init*(window: cint; depthBufferBits: cint; stencilBufferBits: cint;
                  vSync: bool) {.importc: "kinc_g4_init".}
proc kinc_g4_destroy*(window: cint) {.importc: "kinc_g4_destroy".}
proc kinc_g4_flush*() {.importc: "kinc_g4_flush".}
proc kinc_g4_begin*(window: cint) {.importc: "kinc_g4_begin".}
proc kinc_g4_end*(window: cint) {.importc: "kinc_g4_end".}
proc kinc_g4_swap_buffers*(): bool {.importc: "kinc_g4_swap_buffers".}
const
  KINC_G4_CLEAR_COLOR* = 1
  KINC_G4_CLEAR_DEPTH* = 2
  KINC_G4_CLEAR_STENCIL* = 4

proc kinc_g4_clear*(flags: cuint; color: cuint; depth: cfloat; stencil: cint) {.
    importc: "kinc_g4_clear".}
proc kinc_g4_viewport*(x: cint; y: cint; width: cint; height: cint) {.
    importc: "kinc_g4_viewport".}
proc kinc_g4_scissor*(x: cint; y: cint; width: cint; height: cint) {.
    importc: "kinc_g4_scissor".}
proc kinc_g4_disable_scissor*() {.importc: "kinc_g4_disable_scissor",
                                .}
proc kinc_g4_draw_indexed_vertices*() {.importc: "kinc_g4_draw_indexed_vertices",
                                      .}
proc kinc_g4_draw_indexed_vertices_from_to*(start: cint; count: cint) {.
    importc: "kinc_g4_draw_indexed_vertices_from_to".}
proc kinc_g4_draw_indexed_vertices_from_to_from*(start: cint; count: cint;
    vertex_offset: cint) {.importc: "kinc_g4_draw_indexed_vertices_from_to_from",
                         .}
proc kinc_g4_draw_indexed_vertices_instanced*(instanceCount: cint) {.
    importc: "kinc_g4_draw_indexed_vertices_instanced".}
proc kinc_g4_draw_indexed_vertices_instanced_from_to*(instanceCount: cint;
    start: cint; count: cint) {.importc: "kinc_g4_draw_indexed_vertices_instanced_from_to",
                            .}
proc kinc_g4_set_texture_addressing*(unit: kinc_g4_texture_unit_t;
                                    dir: kinc_g4_texture_direction_t;
                                    addressing: kinc_g4_texture_addressing_t) {.
    importc: "kinc_g4_set_texture_addressing".}
proc kinc_g4_set_texture3d_addressing*(unit: kinc_g4_texture_unit_t;
                                      dir: kinc_g4_texture_direction_t;
                                      addressing: kinc_g4_texture_addressing_t) {.
    importc: "kinc_g4_set_texture3d_addressing".}
proc kinc_g4_set_pipeline*(pipeline: ptr kinc_g4_pipeline_t) {.
    importc: "kinc_g4_set_pipeline".}
proc kinc_g4_set_stencil_reference_value*(value: cint) {.
    importc: "kinc_g4_set_stencil_reference_value".}
proc kinc_g4_set_texture_operation*(operation: kinc_g4_texture_operation_t;
                                   arg1: kinc_g4_texture_argument_t;
                                   arg2: kinc_g4_texture_argument_t) {.
    importc: "kinc_g4_set_texture_operation".}
proc kinc_g4_set_int*(location: kinc_g4_constant_location_t; value: cint) {.
    importc: "kinc_g4_set_int".}
proc kinc_g4_set_int2*(location: kinc_g4_constant_location_t; value1: cint;
                      value2: cint) {.importc: "kinc_g4_set_int2".}
proc kinc_g4_set_int3*(location: kinc_g4_constant_location_t; value1: cint;
                      value2: cint; value3: cint) {.importc: "kinc_g4_set_int3",
    .}
proc kinc_g4_set_int4*(location: kinc_g4_constant_location_t; value1: cint;
                      value2: cint; value3: cint; value4: cint) {.
    importc: "kinc_g4_set_int4".}
proc kinc_g4_set_ints*(location: kinc_g4_constant_location_t; values: ptr cint;
                      count: cint) {.importc: "kinc_g4_set_ints".}
proc kinc_g4_set_float*(location: kinc_g4_constant_location_t; value: cfloat) {.
    importc: "kinc_g4_set_float".}
proc kinc_g4_set_float2*(location: kinc_g4_constant_location_t; value1: cfloat;
                        value2: cfloat) {.importc: "kinc_g4_set_float2",
                                        .}
proc kinc_g4_set_float3*(location: kinc_g4_constant_location_t; value1: cfloat;
                        value2: cfloat; value3: cfloat) {.
    importc: "kinc_g4_set_float3".}
proc kinc_g4_set_float4*(location: kinc_g4_constant_location_t; value1: cfloat;
                        value2: cfloat; value3: cfloat; value4: cfloat) {.
    importc: "kinc_g4_set_float4".}
proc kinc_g4_set_floats*(location: kinc_g4_constant_location_t; values: ptr cfloat;
                        count: cint) {.importc: "kinc_g4_set_floats",
                                     .}
proc kinc_g4_set_bool*(location: kinc_g4_constant_location_t; value: bool) {.
    importc: "kinc_g4_set_bool".}
proc kinc_g4_set_matrix3*(location: kinc_g4_constant_location_t;
                         value: ptr kinc_matrix3x3_t) {.
    importc: "kinc_g4_set_matrix3".}
proc kinc_g4_set_matrix4*(location: kinc_g4_constant_location_t;
                         value: ptr kinc_matrix4x4_t) {.
    importc: "kinc_g4_set_matrix4".}
proc kinc_g4_set_texture_magnification_filter*(unit: kinc_g4_texture_unit_t;
    filter: kinc_g4_texture_filter_t) {.importc: "kinc_g4_set_texture_magnification_filter",
                                      .}
proc kinc_g4_set_texture3d_magnification_filter*(texunit: kinc_g4_texture_unit_t;
    filter: kinc_g4_texture_filter_t) {.importc: "kinc_g4_set_texture3d_magnification_filter",
                                      .}
proc kinc_g4_set_texture_minification_filter*(unit: kinc_g4_texture_unit_t;
    filter: kinc_g4_texture_filter_t) {.importc: "kinc_g4_set_texture_minification_filter",
                                      .}
proc kinc_g4_set_texture3d_minification_filter*(texunit: kinc_g4_texture_unit_t;
    filter: kinc_g4_texture_filter_t) {.importc: "kinc_g4_set_texture3d_minification_filter",
                                      .}
proc kinc_g4_set_texture_mipmap_filter*(unit: kinc_g4_texture_unit_t;
                                       filter: kinc_g4_mipmap_filter_t) {.
    importc: "kinc_g4_set_texture_mipmap_filter".}
proc kinc_g4_set_texture3d_mipmap_filter*(texunit: kinc_g4_texture_unit_t;
    filter: kinc_g4_mipmap_filter_t) {.importc: "kinc_g4_set_texture3d_mipmap_filter",
                                     .}
proc kinc_g4_set_texture_compare_mode*(unit: kinc_g4_texture_unit_t; enabled: bool) {.
    importc: "kinc_g4_set_texture_compare_mode".}
proc kinc_g4_set_cubemap_compare_mode*(unit: kinc_g4_texture_unit_t; enabled: bool) {.
    importc: "kinc_g4_set_cubemap_compare_mode".}
proc kinc_g4_max_bound_textures*(): cint {.importc: "kinc_g4_max_bound_textures",
                                        .}
proc kinc_g4_render_targets_inverted_y*(): bool {.
    importc: "kinc_g4_render_targets_inverted_y".}
proc kinc_g4_non_pow2_textures_supported*(): bool {.
    importc: "kinc_g4_non_pow2_textures_supported".}
proc kinc_g4_restore_render_target*() {.importc: "kinc_g4_restore_render_target",
                                      .}
proc kinc_g4_set_render_targets*(targets: ptr ptr kinc_g4_render_target; count: cint) {.
    importc: "kinc_g4_set_render_targets".}
proc kinc_g4_set_render_target_face*(texture: ptr kinc_g4_render_target; face: cint) {.
    importc: "kinc_g4_set_render_target_face".}
proc kinc_g4_set_texture*(unit: kinc_g4_texture_unit_t;
                         texture: ptr kinc_g4_texture_t) {.
    importc: "kinc_g4_set_texture".}
proc kinc_g4_set_image_texture*(unit: kinc_g4_texture_unit_t;
                               texture: ptr kinc_g4_texture_t) {.
    importc: "kinc_g4_set_image_texture".}
proc kinc_g4_init_occlusion_query*(occlusionQuery: ptr cuint): bool {.
    importc: "kinc_g4_init_occlusion_query".}
proc kinc_g4_delete_occlusion_query*(occlusionQuery: cuint) {.
    importc: "kinc_g4_delete_occlusion_query".}
proc kinc_g4_start_occlusion_query*(occlusionQuery: cuint) {.
    importc: "kinc_g4_start_occlusion_query".}
proc kinc_g4_end_occlusion_query*(occlusionQuery: cuint) {.
    importc: "kinc_g4_end_occlusion_query".}
proc kinc_g4_are_query_results_available*(occlusionQuery: cuint): bool {.
    importc: "kinc_g4_are_query_results_available".}
proc kinc_g4_get_query_results*(occlusionQuery: cuint; pixelCount: ptr cuint) {.
    importc: "kinc_g4_get_query_results".}
proc kinc_g4_set_texture_array*(unit: kinc_g4_texture_unit_t;
                               array: ptr kinc_g4_texture_array) {.
    importc: "kinc_g4_set_texture_array".}
proc kinc_g4_antialiasing_samples*(): cint {.
    importc: "kinc_g4_antialiasing_samples".}
proc kinc_g4_set_antialiasing_samples*(samples: cint) {.
    importc: "kinc_g4_set_antialiasing_samples".}

## //////////////////////////
##  vertexbuffer
## //////////////////////////

#import vertexstructure

type
  kinc_g4_vertex_buffer_t* {.bycopy.} = object
    impl*: kinc_g4_vertex_buffer_impl_t

  kinc_g4_usage_t* {.size: sizeof(cint).} = enum
    KINC_G4_USAGE_STATIC, KINC_G4_USAGE_DYNAMIC, KINC_G4_USAGE_READABLE


proc kinc_g4_vertex_buffer_init*(buffer: ptr kinc_g4_vertex_buffer_t; count: cint;
                                structure: ptr kinc_g4_vertex_structure_t;
                                usage: kinc_g4_usage_t;
                                instance_data_step_rate: cint) {.
    importc: "kinc_g4_vertex_buffer_init".}
proc kinc_g4_vertex_buffer_destroy*(buffer: ptr kinc_g4_vertex_buffer_t) {.
    importc: "kinc_g4_vertex_buffer_destroy".}
proc kinc_g4_vertex_buffer_lock_all*(buffer: ptr kinc_g4_vertex_buffer_t): ptr cfloat {.
    importc: "kinc_g4_vertex_buffer_lock_all".}
proc kinc_g4_vertex_buffer_lock*(buffer: ptr kinc_g4_vertex_buffer_t; start: cint;
                                count: cint): ptr cfloat {.
    importc: "kinc_g4_vertex_buffer_lock".}
proc kinc_g4_vertex_buffer_unlock_all*(buffer: ptr kinc_g4_vertex_buffer_t) {.
    importc: "kinc_g4_vertex_buffer_unlock_all".}
proc kinc_g4_vertex_buffer_unlock*(buffer: ptr kinc_g4_vertex_buffer_t; count: cint) {.
    importc: "kinc_g4_vertex_buffer_unlock".}
proc kinc_g4_vertex_buffer_count*(buffer: ptr kinc_g4_vertex_buffer_t): cint {.
    importc: "kinc_g4_vertex_buffer_count".}
proc kinc_g4_vertex_buffer_stride*(buffer: ptr kinc_g4_vertex_buffer_t): cint {.
    importc: "kinc_g4_vertex_buffer_stride".}
proc kinc_internal_g4_vertex_buffer_set*(buffer: ptr kinc_g4_vertex_buffer_t;
                                        offset: cint): cint {.
    importc: "kinc_internal_g4_vertex_buffer_set".}
proc kinc_g4_set_vertex_buffers*(buffers: ptr ptr kinc_g4_vertex_buffer_t;
                                count: cint) {.
    importc: "kinc_g4_set_vertex_buffers".}
proc kinc_g4_set_vertex_buffer*(buffer: ptr kinc_g4_vertex_buffer_t) {.
    importc: "kinc_g4_set_vertex_buffer".}

{.pop.}