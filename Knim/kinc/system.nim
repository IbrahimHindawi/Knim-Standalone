import ../utils/comptime
initialize("kinc/system.h","Kinc")

import window

proc kinc_init*(name: cstring; width: cint; height: cint; win: ptr kinc_window_options_t;
                frame: ptr kinc_framebuffer_options_t): cint {.importc: "kinc_init",
    .}
proc kinc_application_name*(): cstring {.importc: "kinc_application_name",
                                    .}
proc kinc_set_application_name*(name: cstring) {.
    importc: "kinc_set_application_name", .}
proc kinc_width*(): cint {.importc: "kinc_width", .}
proc kinc_height*(): cint {.importc: "kinc_height", .}
proc kinc_internal_handle_messages*(): bool {.
    importc: "kinc_internal_handle_messages", .}
proc kinc_load_url*(url: cstring) {.importc: "kinc_load_url", .}
proc kinc_system_id*(): cstring {.importc: "kinc_system_id", .}
proc kinc_internal_save_path*(): cstring {.importc: "kinc_internal_save_path",
                                        .}
proc kinc_video_formats*(): cstringArray {.importc: "kinc_video_formats",
                                        .}
proc kinc_language*(): cstring {.importc: "kinc_language", .}
proc kinc_vibrate*(milliseconds: cint) {.importc: "kinc_vibrate", .}
proc kinc_safe_zone*(): cfloat {.importc: "kinc_safe_zone", .}
proc kinc_automatic_safe_zone*(): bool {.importc: "kinc_automatic_safe_zone",
                                        .}
proc kinc_set_safe_zone*(value: cfloat) {.importc: "kinc_set_safe_zone",
                                      .}
type
  kinc_ticks_t* = uint64

proc kinc_frequency*(): cdouble {.importc: "kinc_frequency", .}
proc kinc_timestamp*(): kinc_ticks_t {.importc: "kinc_timestamp", .}
proc kinc_time*(): cdouble {.importc: "kinc_time", .}
proc kinc_start*() {.importc: "kinc_start", .}
proc kinc_internal_frame*(): bool {.importc: "kinc_internal_frame", .}
proc kinc_stop*() {.importc: "kinc_stop", .}
proc kinc_login*() {.importc: "kinc_login", .}
proc kinc_waiting_for_login*(): bool {.importc: "kinc_waiting_for_login",
                                    .}
proc kinc_unlock_achievement*(id: cint) {.importc: "kinc_unlock_achievement",
                                      .}
proc kinc_disallow_user_change*() {.importc: "kinc_disallow_user_change",
                                  .}
proc kinc_allow_user_change*() {.importc: "kinc_allow_user_change", .}
proc kinc_set_keep_screen_on*(on: bool) {.importc: "kinc_set_keep_screen_on",
                                      .}
proc setUpdateCallback*(value: proc (){.cdecl.}) {.
    importc: "kinc_set_update_callback", .}
proc kinc_set_foreground_callback*(value: proc ()) {.
    importc: "kinc_set_foreground_callback", .}
proc kinc_set_resume_callback*(value: proc ()) {.
    importc: "kinc_set_resume_callback", .}
proc kinc_set_pause_callback*(value: proc ()) {.importc: "kinc_set_pause_callback",
    .}
proc kinc_set_background_callback*(value: proc ()) {.
    importc: "kinc_set_background_callback", .}
proc kinc_set_shutdown_callback*(value: proc ()) {.
    importc: "kinc_set_shutdown_callback", .}
proc kinc_set_drop_files_callback*(value: proc (a1: ptr cchar)) {.
    importc: "kinc_set_drop_files_callback", .}
proc kinc_set_cut_callback*(value: proc (): cstring) {.
    importc: "kinc_set_cut_callback", .}
proc kinc_set_copy_callback*(value: proc (): cstring) {.
    importc: "kinc_set_copy_callback", .}
proc kinc_set_paste_callback*(value: proc (a1: cstring)) {.
    importc: "kinc_set_paste_callback", .}
proc kinc_set_login_callback*(value: proc ()) {.importc: "kinc_set_login_callback",
    .}
proc kinc_set_logout_callback*(value: proc ()) {.
    importc: "kinc_set_logout_callback", .}
proc kinc_internal_shutdown*() {.importc: "kinc_internal_shutdown", .}
proc kinc_internal_update_callback*() {.importc: "kinc_internal_update_callback",
                                      .}
proc kinc_internal_foreground_callback*() {.
    importc: "kinc_internal_foreground_callback", .}
proc kinc_internal_resume_callback*() {.importc: "kinc_internal_resume_callback",
                                      .}
proc kinc_internal_pause_callback*() {.importc: "kinc_internal_pause_callback",
                                    .}
proc kinc_internal_background_callback*() {.
    importc: "kinc_internal_background_callback", .}
proc kinc_internal_shutdown_callback*() {.importc: "kinc_internal_shutdown_callback",
                                        .}
proc kinc_internal_drop_files_callback*(a1: ptr cchar) {.
    importc: "kinc_internal_drop_files_callback", .}
proc kinc_internal_cut_callback*(): cstring {.
    importc: "kinc_internal_cut_callback", .}
proc kinc_internal_copy_callback*(): cstring {.
    importc: "kinc_internal_copy_callback", .}
proc kinc_internal_paste_callback*(a1: cstring) {. importc: "kinc_internal_paste_callback" .}
proc kinc_internal_login_callback*() {.importc: "kinc_internal_login_callback" .}
proc kinc_internal_logout_callback*() {.importc: "kinc_internal_logout_callback",
                                      .}
proc kinc_copy_to_clipboard*(a1: cstring) {.importc: "kinc_copy_to_clipboard",
    .}