import ../../utils/comptime
initialize("kinc/graphics4/vertexbuffer.h","Kinc")

import vertexstructure
import ../../kincbackends/graphics4/graphics4

withMode("kinc_g4_vertex_buffer_t"):
  type
    VertexBuffer* = object
      impl*: kinc_g4_vertex_buffer_impl_t

# when defined(dynamic): 
#   {.push bycopy.}
# elif defined(codegen): 
#   {.push importc:"kinc_g4_vertex_buffer_t",bycopy.}
# type
#   vertexBuffer* {.bycopy.} = object
#     impl*: kinc_g4_vertex_buffer_impl_t
# {.pop.}

withMode("kinc_g4_usage_t"):
  type
    Usage* {.size: sizeof(cint).} = enum
      uStatic, uDynamic, uReadable


proc initVertexBuffer*(buffer: ptr VertexBuffer; count: cint;structure: ptr VertexStructure;usage: Usage;instance_data_step_rate: cint) 
  {.importc: "kinc_g4_vertex_buffer_init".}

proc vertexBufferDestroy*(buffer: ptr VertexBuffer) 
  {.importc: "kinc_g4_vertex_buffer_destroy".}

proc vertexBufferLockAll*(buffer: ptr VertexBuffer): ptr cfloat 
  {.importc: "kinc_g4_vertex_buffer_lock_all".}

proc vertexBufferLock*(buffer: ptr VertexBuffer; start: cint;count: cint): ptr cfloat 
  {.importc: "kinc_g4_vertex_buffer_lock".}

proc vertexBufferUnlockAll*(buffer: ptr VertexBuffer) 
  {.importc: "kinc_g4_vertex_buffer_unlock_all".}

proc vertexBufferUnlock*(buffer: ptr VertexBuffer; count: cint) 
  {.importc: "kinc_g4_vertex_buffer_unlock".}

proc vertexBufferCount*(buffer: ptr VertexBuffer): cint 
  {.importc: "kinc_g4_vertex_buffer_count".}

proc vertexBufferStride*(buffer: ptr VertexBuffer): cint 
  {.importc: "kinc_g4_vertex_buffer_stride".}

proc internalVertexBufferSet*(buffer: ptr VertexBuffer; offset: cint): cint 
  {.importc: "kinc_internal_g4_vertex_buffer_set".}

proc setVertexBuffers*(buffers: ptr ptr VertexBuffer; count: cint) 
  {.importc: "kinc_g4_set_vertex_buffers".}

proc setVertexBuffer*(buffer: ptr VertexBuffer) 
  {.importc: "kinc_g4_set_vertex_buffer".}

