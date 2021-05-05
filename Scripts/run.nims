#[
  Clean temporary files
]#
import strutils
mode = ScriptMode.Verbose      
    
var root = getCurrentDir() 

cd(root & "/bin")
exec ".\\prog.exe"