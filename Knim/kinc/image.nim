import ../utils/comptime
initialize("kinc/image.h","Kinc")

#const hhkImage = "kinc/image.h"

type 
  KincImageCompression* = enum
    KINC_IMAGE_COMPRESSION_NONE, KINC_IMAGE_COMPRESSION_DXT5,
    KINC_IMAGE_COMPRESSION_ASTC, KINC_IMAGE_COMPRESSION_PVRTC   
  kinc_image_format_t* = enum
    KINC_IMAGE_FORMAT_RGBA32, KINC_IMAGE_FORMAT_GREY8, KINC_IMAGE_FORMAT_RGB24,
    KINC_IMAGE_FORMAT_RGBA128, KINC_IMAGE_FORMAT_RGBA64, KINC_IMAGE_FORMAT_A32,
    KINC_IMAGE_FORMAT_BGRA32, KINC_IMAGE_FORMAT_A16
  kinc_image_t* = object
    width, height, depth*: cint
    format*: kinc_image_format_t
    internal_format*: cuint
    compression*: KincImageCompression
    data*: pointer
    data_size*: cint

proc kinc_image_init_from_file*(image: ptr kinc_image_t, memory: pointer, filename: cstring) {.importc:"kinc_image_init_from_file".}
proc kinc_image_destroy*(image:ptr kinc_image_t) {.importc:"kinc_image_destroy".}  