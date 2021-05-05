import ../initializer
initialize("cLogOps.h","cSpecOps")
#{.compile:"../lib/cSpecOps/logOps/cLogOps.c".}
proc logOpZero*(x: cstring) {.importc:"logOpZero".}

#{.pop.}