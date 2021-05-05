#[
  This NimScript is used to compile the generated C code from Nim using gcc
  It is not very modular at all.
]#

mode = ScriptMode.Verbose

template echoSector(phrase: string) =
  echo "\e[33m", "NimScript:", "\e[0m ", phrase 
    

var libExt = ""

if defined(linux):
  libExt = ".so"
elif defined(windows):
  libExt = ".dll"
elif defined(macosx):
  libExt = ".dylib"

echoSector "code-gen"
exec "nim c --compileOnly --nimcache:cache -d:codegen --noMain --header:prog.h SourcesNim/prog.nim"


echoSector "generating object files"
exec "gcc -c  ./lib/cSpecOps/logOps/cLogOps.c -o obj/cLogOps.o"
exec "gcc -c  ./lib/cSpecOps/mathOps/cMathOps.c -o obj/cMathOps.o"

echoSector "generating dynamic library"
exec "gcc -shared -o ./bin/cSpecOps" & libExt & " ./obj/cMathOps.o ./obj/cLogOps.o"

echoSector "compiling nim code-gen with gcc"
exec "gcc -Icache/ -IC:/Users/Administrator/nim-1.4.6/lib " &
" -Ilib/cSpecOps/mathOps -Ilib/cSpecOps/logOps -Icache/prog.h " &
" cache/@mprog.nim.c cache/stdlib_io.nim.c cache/stdlib_system.nim.c cache/@mkinc@sgraphics4@sgraphics.nim.c " & 
" lib/cSpecOps/mathOps/cMathOps.c lib/cSpecOps/logOps/cLogOps.c " & 
" Sources/main.c -o bin/prog.exe"

echoSector "running executable"
exec ".\\bin\\prog.exe"
