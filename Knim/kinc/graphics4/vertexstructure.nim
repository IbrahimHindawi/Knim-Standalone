import ../../utils/comptime
initialize("kinc/graphics4/vertexstructure.h","Kinc")

type
  kinc_g4_vertex_data_t* {.size: sizeof(cint).} = enum
    vdNone, vdFloat1,
    vdFloat2, vdFloat3,
    vdFloat4, vdFloat4x4,
    vdFloatShort2Norm, vdFloatShort4Norm,
    vdColor
  kinc_g4_vertex_element_t* {.bycopy.} = object
    name*: cstring
    data*: kinc_g4_vertex_data_t

proc kinc_g4_vertex_element_init*(element: ptr kinc_g4_vertex_element_t;
                                 name: cstring; data: kinc_g4_vertex_data_t) {.
    importc: "kinc_g4_vertex_element_init".}
const
  KINC_G4_MAX_VERTEX_ELEMENTS* = 16
withMode("kinc_g4_vertex_structure_t"):
  type
    VertexStructure* {.bycopy.} = object
      elements*: array[KINC_G4_MAX_VERTEX_ELEMENTS, kinc_g4_vertex_element_t]
      size*: cint
      instanced*: bool


proc initVertexStructure*(structure: ptr VertexStructure) 
  {.importc: "kinc_g4_vertex_structure_init".}

proc vertexStructureAdd*(structure: ptr VertexStructure; name: cstring; data: kinc_g4_vertex_data_t) 
  {.importc: "kinc_g4_vertex_structure_add".}
