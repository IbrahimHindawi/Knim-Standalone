#[
  This NimScript is used to compile the generated C code from Nim using gcc
  It is not very modular at all.
]#
import strutils
mode = ScriptMode.Verbose

proc cleanFiles(dirPath: string) = 
  var files = listFiles(dirPath)
  for file in files:
    if file.contains("keepme.txt"):
      continue
    else:
      rmFile(file)      


    
var root = getCurrentDir() 

cd(root & "/bin")
cleanFiles(getCurrentDir())

cd(root & "/obj")
cleanFiles(getCurrentDir())

cd(root & "/cache")
cleanFiles(getCurrentDir())