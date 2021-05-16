import ../../utils/comptime
initialize("kinc/graphics4/shader.h","Kinc")

#{.emit:"#include <kinc/backend/graphics4/shader.h>".}

# type
#   kinc_g4_shader_impl_t* {.bycopy.} = object

import ../../kincbackends/graphics4/graphics4

withMode("kinc_g4_shader_type_t"):
  type 
    ShaderType* {.bycopy.} = enum
      stFragment,
      stVertex,
      stGeometry,
      stTessellationControl,
      stTessellationEvaluation

withMode("kinc_g4_shader_t"):
  type
    Shader* {. bycopy.} = object
      #when defined(dynamic):
      impl*:kinc_g4_shader_impl_t
      #when defined(codegen):
        #echo "codegen: definition omitted!"


proc initShader*(shader: ptr Shader, data: pointer, length: csize_t, tipe:ShaderType)
  {.importc:"kinc_g4_shader_init".}
proc kinc_g4_shader_init_from_source*(shader: ptr Shader; source: cstring;
                                     `type`: ShaderType) {.
    importc: "kinc_g4_shader_init_from_source".}
##  Beware, this is not portable

proc kinc_g4_shader_destroy*(shader: ptr Shader) {.
    importc: "kinc_g4_shader_destroy".}  