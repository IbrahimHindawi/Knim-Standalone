
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
