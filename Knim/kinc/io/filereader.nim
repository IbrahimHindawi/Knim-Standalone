import ../../utils/comptime
initialize("<kinc/io/filereader.h>","Kinc")

const
  FileTypeAsset* = 0
  FileTypeSave* = 1


when defined(KORE_ANDROID):
  withMode("kinc_file_reader_t"):
    type
      fileReader* {.bycopy.} = object
        pos*: cint
        size*: cint
        file*: ptr FILE
        asset*: ptr AAsset
        `type`*: cint

else:
  withMode("kinc_file_reader_t"):
    type
      fileReader* {.bycopy.} = object
        file*: pointer
        size*: cint
        `type`*: cint
        mode*: cint
        mounted*: bool
        #when defined(KORE_SONY) or defined(KORE_SWITCH):
          #var impl* {.importc: "impl", dynlib:libName.}: kinc_file_reader_impl_t

proc fileReaderOpen*(reader: ptr fileReader, filename:cstring, tipe:cint) :bool
    {.importc:"kinc_file_reader_open".}
proc fileReaderClose*(reader: ptr fileReader) 
    {.importc:"kinc_file_reader_close".}
proc fileReaderRead*(reader: ptr fileReader, data: pointer, size: csize_t) :bool
    {.importc:"kinc_file_reader_read".}
proc fileReaderSize*(reader: ptr fileReader):csize_t
    {.importc:"kinc_file_reader_size".}