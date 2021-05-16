import ../../utils/comptime
initialize("kinc/graphics4/indexbuffer.h","Kinc")

import ../../kincbackends/graphics4/graphics4

withMode("kinc_g4_index_buffer_format_t"):
  type
    IndexBufferFormat* {.size: sizeof(cint).} = enum
      ibf32bit, ibf16bit

withMode("kinc_g4_index_buffer_t"):
  type
    IndexBuffer* {.bycopy.} = object
      impl*: kinc_g4_index_buffer_impl_t



proc initIndexBuffer*(buffer: ptr IndexBuffer; count: cint; format: IndexBufferFormat) {.
  importc: "kinc_g4_index_buffer_init".}

proc indexBufferDestroy*(buffer: ptr IndexBuffer) {.
  importc: "kinc_g4_index_buffer_destroy".}

proc indexBufferLock*(buffer: ptr IndexBuffer): ptr cint {.
  importc: "kinc_g4_index_buffer_lock".}

proc indexBufferUnlock*(buffer: ptr IndexBuffer) {.
  importc: "kinc_g4_index_buffer_unlock".}

proc indexBufferCount*(buffer: ptr IndexBuffer): cint {.
  importc: "kinc_g4_index_buffer_count".}

proc internalIndexBufferSet*(buffer: ptr IndexBuffer) {.
  importc: "kinc_internal_g4_index_buffer_set".}

proc setIndexBuffer*(buffer: ptr IndexBuffer) {.
  importc: "kinc_g4_set_index_buffer".}