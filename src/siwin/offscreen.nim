import ./[siwindefs]
import ./platforms/any/window

when not siwin_use_lib:
  when defined(android):
    import ./platforms/android/window
  elif defined(windows):
    import ./platforms/winapi/offscreen
  elif siwin_unix_desktop:
    import ./platforms/x11/[offscreen, siwinGlobals]
    import ./platforms/wayland/[siwinGlobals]

  proc newOpenglContext*(
    globals: SiwinGlobals
  ): Window =
    when defined(android):
      newOpenglWindowAndroid()
    elif defined(windows):
      newOpenglContextWinapi()
    elif siwin_unix_desktop:
      if globals of SiwinGlobalsX11:
        globals.SiwinGlobalsX11.newOpenglContextX11()
      elif globals of SiwinGlobalsWayland:
        raise ValueError.newException("Offscreen rendering is not supported for Wayland yet. Please pass preferedPlatform=x11 to newSiwinGlobals")
      #   newOpenglContextWayland()
      else:
        raise ValueError.newException("Unsupported platform")

proc siwin_new_opengl_context(globals: SiwinGlobals): Window {.siwin_import_export.} =
  newOpenglContext(globals)


proc newOpenglContext*(globals: SiwinGlobals): Window {.siwin_export_import.} =
  siwin_new_opengl_context(globals)
