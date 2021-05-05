
import ../../../kinc/graphics4/vertexstructure
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
