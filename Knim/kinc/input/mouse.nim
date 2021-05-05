import ../../initializer
initialize("kinc/input/mouse.h","Kinc")

#const hhkMouse = 


type 
    MouseBXYCallback = proc(w:cint, b:cint, x:cint, y:cint) {.cdecl.}
    MouseBXYXYCallback = proc(w:cint, b:cint, x:cint, y:cint, mx:cint, my:cint) {.cdecl.}
    MouseScrollCallback = proc(w:cint, d:cint) {.cdecl.}
    MouseWindowCallback = proc(w:cint) {.cdecl.}

var kinc_mouse_press_callback* 
    {.importc: "kinc_mouse_press_callback".}:MouseBXYCallback
var kinc_mouse_release_callback* 
    {.importc: "kinc_mouse_release_callback".}:MouseBXYCallback
var kinc_mouse_move_callback* 
    {.importc: "kinc_mouse_move_callback".}:MouseBXYXYCallback
var kinc_mouse_scroll_callback* 
    {.importc: "kinc_mouse_scroll_callback".}:MouseScrollCallback
var kinc_mouse_enter_window_callback* 
    {.importc: "kinc_mouse_enter_window_callback".}:MouseWindowCallback
var kinc_mouse_leave_window_callback* 
    {.importc: "kinc_mouse_leave_window_callback".}:MouseWindowCallback