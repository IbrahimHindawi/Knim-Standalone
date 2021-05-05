import echoSector

var libExt = ""

if defined(linux):
  libExt = ".so"
elif defined(windows):
  libExt = ".dll"
elif defined(macosx):
  libExt = ".dylib"

echoSector "generating object files"
exec "gcc -c  ./lib/cSpecOps/logOps/cLogOps.c -o obj/cLogOps.o"
exec "gcc -c  ./lib/cSpecOps/mathOps/cMathOps.c -o obj/cMathOps.o"

echoSector "generating dynamic library"
exec "gcc -shared -o ./bin/cSpecOps" & libExt & " ./obj/cMathOps.o ./obj/cLogOps.o"