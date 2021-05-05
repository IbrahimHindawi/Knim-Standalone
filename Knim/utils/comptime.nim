template initialize*(headerName: string, dynlibName: string) = 
  when defined(windows):
    const libExt = ".dll"
  elif defined(linux):
    const libExt = ".so"
  elif defined(macosx):
    const libExt = ".dylib"

  when defined(Direct3D11):
    const
      libName = dynlibName & "Direct3D11" & libExt
  elif defined(OpenGL):
    const
      libName = dynlibName & "OpenGL" & libExt

  when defined(dynamic):
    {.push dynlib: libName.}
  elif defined(codegen):
    {.push header: headerName.}

