#[
  Clean temporary files
]#
import strutils
mode = ScriptMode.Verbose      

exec "nim c -d:dynamic -d:OpenGL SourcesNim/prog.nim"
#exec "nim c -d:dynamic -d:OpenGL SourcesNim/prog.nim"