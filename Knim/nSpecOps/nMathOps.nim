import ../initializer
initialize("cMathOps.h","cSpecOps")
#{.compile:"../lib/cSpecOps/mathOps/cMathOps.c".}
proc mathOpZero*(x: cint): cint {.importc:"mathOpZero".}

#{.pop.}