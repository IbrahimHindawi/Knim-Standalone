import os
import strutils

mode = ScriptMode.Verbose

echo "-------------------------------"
echo "Executing nimscript"

#[
  Choose your backend here:
    Direct3D11 (Windows)
    OpenGL (Windows Linux)
    Metal (wip)
    Vulkan (wip)
]#

const
  Direct3D11 = "Direct3D11"
  OpenGL = "OpenGL"

const 
  backend = OpenGL

if backend == Direct3D11:
  echo Direct3D11 & " backend chosen"
  switch("define", Direct3D11)
elif backend == OpenGL:
  echo OpenGL & " backend chosen"
  switch("define", OpenGL)

# Check for Deployment Directory
var deployDir = "Deployment"
if dirExists(deployDir):
  echo deployDir & " directory found"
else:
  mkDir(deployDir)
  echo deployDir & " directory not found, creating directory."

# run SPIR-V shader compiler and build C project
exec "node Kinc/make.js" & " --graphics " & backend.toLower() #../../

echo "Starting deployment"
# go to deployment directory


# codegen compiler operating systems
#switch("os","android")
#switch("define","androidNDK")

# codegen compiler cpu architectures
#switch("cpu","arm64")

# codegen compiler
#switch("cc","vcc")
#switch("cc","clang")

#[
  build mode switching
]#
#switch("define","dynamic")
#switch("define","codegen")

# android
# nim compile --cc:clang --os:android --cpu:arm64 --d:androidNDK --compileOnly --nimcache:Knim-Standalone\cache -d:OpenGL -d:codegen --noMain --header:prog.h Knim-Standalone\Knim\prog.nim
# ndk {abiFilters "arm64-v8a"}

# windows
# nim compile --cc:vcc --compileOnly --nimcache:Knim-Standalone\cache -d:OpenGL -d:codegen --noMain --header:prog.h Knim-Standalone\Knim\prog.nim

if defined(dynamic):
  echo "building nim dynamic..."
  switch("outdir", "Deployment")
  cd(deployDir)
elif defined(codegen):
  echo "building nim codegen..."

echo "-------------------------------"


