template initialize*(headerName: string, dynlibName: string) = 
  when defined(windows):
    const libExt = ".dll"
  elif defined(linux):
    const libExt = ".so"
  elif defined(macosx):
    const libExt = ".dylib"

  when defined(dynamic):
    {.push dynlib: dynlibName & libExt.}
  elif defined(codegen):
    {.push header: headerName.}

