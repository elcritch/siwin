import ./x11api
import x11/x except Window

type
  XRenderDirectFormat* = object
    red*: cshort
    redMask*: cshort
    green*: cshort
    greenMask*: cshort
    blue*: cshort
    blueMask*: cshort
    alpha*: cshort
    alphaMask*: cshort

  XRenderPictFormat* = object
    id*: culong
    thetype*: cint
    depth*: cint
    direct*: XRenderDirectFormat
    colormap*: Colormap

  XRenderFindVisualFormatProc =
    proc(dpy: PDisplay, visual: PVisual): ptr XRenderPictFormat {.cdecl.}

let XRenderFindVisualFormat* =
  loadProc[XRenderFindVisualFormatProc](libXrenderHandle, "XRenderFindVisualFormat")

proc xrenderAvailable*(): bool =
  libXrenderHandle != nil and XRenderFindVisualFormat != nil
