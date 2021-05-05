import ../../utils/comptime
initialize("<kinc/io/filereader.h>","Kinc")

const
  KINC_FILE_TYPE_ASSET* = 0
  KINC_FILE_TYPE_SAVE* = 1


when defined(KORE_ANDROID):
  type
    kinc_file_reader_t* {.bycopy.} = object
      pos*: cint
      size*: cint
      file*: ptr FILE
      asset*: ptr AAsset
      `type`*: cint

else:
  type
    kinc_file_reader_t* {.bycopy.} = object
      file*: pointer
      size*: cint
      `type`*: cint
      mode*: cint
      mounted*: bool
      #when defined(KORE_SONY) or defined(KORE_SWITCH):
        #var impl* {.importc: "impl", dynlib:libName.}: kinc_file_reader_impl_t

proc kinc_file_reader_open*(reader: ptr kinc_file_reader_t, filename:cstring, tipe:cint) :bool
    {.importc:"kinc_file_reader_open".}
proc kinc_file_reader_close*(reader: ptr kinc_file_reader_t) 
    {.importc:"kinc_file_reader_close".}
proc kinc_file_reader_read*(reader: ptr kinc_file_reader_t, data: pointer, size: csize_t) :bool
    {.importc:"kinc_file_reader_read".}
proc kinc_file_reader_size*(reader: ptr kinc_file_reader_t):csize_t
    {.importc:"kinc_file_reader_size".}