import ../../utils/comptime
initialize("kinc/graphics4/vertexstructure.h","Kinc")

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
