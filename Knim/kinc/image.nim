import ../utils/comptime
initialize("kinc/image.h","Kinc")

#const hhkImage = "kinc/image.h"

type 
    KincImageCompression* = enum
        kincImageCompressionNone,
        kincImageCompressionDXT5,
        kincImageCompressionASTC,
        kincImageCompressionVRTC    
    kinc_image_format_t* = enum
        kincImageFormatRGBA32, 
        kincImageFormatGrey8,
        kincImageFormatRGB24,
        kincImageFormatRGBA128,
        kincImageFormatA32,
        kincImageFormatBGRA32,
        kincImageFormatA16
    kinc_image_t* = object
        width, height, depth*: cint
        format*: kinc_image_format_t
        internal_format*: cuint
        compression*: KincImageCompression
        data*: pointer
        data_size*: cint

proc kinc_image_init_from_file*(image: ptr kinc_image_t, memory: pointer, filename: cstring) {.importc:"kinc_image_init_from_file".}
proc kinc_image_destroy*(image:ptr kinc_image_t) {.importc:"kinc_image_destroy".}  