## Type-only X11 ABI declarations.
##
## This is derived from the public Xlib/Xutil layouts. It deliberately does
## not contain foreign procedure declarations: those are resolved by x11api.
import x11/x

type
  cunsigned* = cint
  Pcint* = ptr cint
  PPcint* = ptr Pcint
  PPcuchar* = ptr ptr uint8
  PWideChar* = ptr int16
  PPChar* = ptr cstring
  PPPChar* = ptr ptr cstring
  Pculong* = ptr culong
  Pcuchar* = cstring
  Pcuint* = ptr cuint
  Pcushort* = ptr uint16

#  Automatically converted by H2Pas 0.99.15 from xlib.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xlib.h

const XlibSpecificationRelease* = 6

type
  PXPointer* = ptr XPointer
  XPointer* = ptr char
  PBool* = ptr XBool
  XBool* = cint
  PStatus* = ptr Status
  Status* = cint

const
  QueuedAlready* = 0
  QueuedAfterReading* = 1
  QueuedAfterFlush* = 2

type
  PPXExtData* = ptr PXExtData
  PXExtData* = ptr XExtData
  XExtData* {.final.} = object
    number*: cint
    next*: PXExtData
    free_private*: proc(extension: PXExtData): cint {.cdecl.}
    private_data*: XPointer

  PXExtCodes* = ptr XExtCodes
  XExtCodes* {.final.} = object
    extension*: cint
    major_opcode*: cint
    first_event*: cint
    first_error*: cint

  PXPixmapFormatValues* = ptr XPixmapFormatValues
  XPixmapFormatValues* {.final.} = object
    depth*: cint
    bits_per_pixel*: cint
    scanline_pad*: cint

  PXGCValues* = ptr XGCValues
  XGCValues* {.final.} = object
    function*: cint
    plane_mask*: culong
    foreground*: culong
    background*: culong
    line_width*: cint
    line_style*: cint
    cap_style*: cint
    join_style*: cint
    fill_style*: cint
    fill_rule*: cint
    arc_mode*: cint
    tile*: Pixmap
    stipple*: Pixmap
    ts_x_origin*: cint
    ts_y_origin*: cint
    font*: Font
    subwindow_mode*: cint
    graphics_exposures*: XBool
    clip_x_origin*: cint
    clip_y_origin*: cint
    clip_mask*: Pixmap
    dash_offset*: cint
    dashes*: cchar

  PXGC* = ptr XGC
  XGC* {.final.} = object
  GC* = PXGC
  PGC* = ptr GC
  PVisual* = ptr Visual
  Visual* {.final.} = object
    ext_data*: PXExtData
    visualid*: VisualID
    c_class*: cint
    red_mask*, green_mask*, blue_mask*: culong
    bits_per_rgb*: cint
    map_entries*: cint

  PDepth* = ptr Depth
  Depth* {.final.} = object
    depth*: cint
    nvisuals*: cint
    visuals*: PVisual

  PXDisplay* = ptr XDisplay
  XDisplay* {.final.} = object

  PScreen* = ptr Screen
  Screen* {.final.} = object
    ext_data*: PXExtData
    display*: PXDisplay
    root*: Window
    width*, height*: cint
    mwidth*, mheight*: cint
    ndepths*: cint
    depths*: PDepth
    root_depth*: cint
    root_visual*: PVisual
    default_gc*: GC
    cmap*: Colormap
    white_pixel*: culong
    black_pixel*: culong
    max_maps*, min_maps*: cint
    backing_store*: cint
    save_unders*: XBool
    root_input_mask*: clong

  PScreenFormat* = ptr ScreenFormat
  ScreenFormat* {.final.} = object
    ext_data*: PXExtData
    depth*: cint
    bits_per_pixel*: cint
    scanline_pad*: cint

  PXSetWindowAttributes* = ptr XSetWindowAttributes
  XSetWindowAttributes* {.final.} = object
    background_pixmap*: Pixmap
    background_pixel*: culong
    border_pixmap*: Pixmap
    border_pixel*: culong
    bit_gravity*: cint
    win_gravity*: cint
    backing_store*: cint
    backing_planes*: culong
    backing_pixel*: culong
    save_under*: XBool
    event_mask*: clong
    do_not_propagate_mask*: clong
    override_redirect*: XBool
    colormap*: Colormap
    cursor*: Cursor

  PXWindowAttributes* = ptr XWindowAttributes
  XWindowAttributes* {.final.} = object
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    depth*: cint
    visual*: PVisual
    root*: Window
    c_class*: cint
    bit_gravity*: cint
    win_gravity*: cint
    backing_store*: cint
    backing_planes*: culong
    backing_pixel*: culong
    save_under*: XBool
    colormap*: Colormap
    map_installed*: XBool
    map_state*: cint
    all_event_masks*: clong
    your_event_mask*: clong
    do_not_propagate_mask*: clong
    override_redirect*: XBool
    screen*: PScreen

  PXHostAddress* = ptr XHostAddress
  XHostAddress* {.final.} = object
    family*: cint
    len*: cint
    address*: cstring

  PXServerInterpretedAddress* = ptr XServerInterpretedAddress
  XServerInterpretedAddress* {.final.} = object
    typelength*: cint
    valuelength*: cint
    theType*: cstring
    value*: cstring

  PXImage* = ptr XImage
  F* {.final.} = object
    create_image*: proc(
      para1: PXDisplay,
      para2: PVisual,
      para3: cuint,
      para4: cint,
      para5: cint,
      para6: cstring,
      para7: cuint,
      para8: cuint,
      para9: cint,
      para10: cint,
    ): PXImage {.cdecl.}
    destroy_image*: proc(para1: PXImage): cint {.cdecl.}
    get_pixel*: proc(para1: PXImage, para2: cint, para3: cint): culong {.cdecl.}
    put_pixel*:
      proc(para1: PXImage, para2: cint, para3: cint, para4: culong): cint {.cdecl.}
    sub_image*: proc(
      para1: PXImage, para2: cint, para3: cint, para4: cuint, para5: cuint
    ): PXImage {.cdecl.}
    add_pixel*: proc(para1: PXImage, para2: clong): cint {.cdecl.}

  XImage* {.final.} = object
    width*, height*: cint
    xoffset*: cint
    format*: cint
    data*: cstring
    byte_order*: cint
    bitmap_unit*: cint
    bitmap_bit_order*: cint
    bitmap_pad*: cint
    depth*: cint
    bytes_per_line*: cint
    bits_per_pixel*: cint
    red_mask*: culong
    green_mask*: culong
    blue_mask*: culong
    obdata*: XPointer
    f*: F

  PXWindowChanges* = ptr XWindowChanges
  XWindowChanges* {.final.} = object
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    sibling*: Window
    stack_mode*: cint

  PXColor* = ptr XColor
  XColor* {.final.} = object
    pixel*: culong
    red*, green*, blue*: cushort
    flags*: cchar
    pad*: cchar

  PXSegment* = ptr XSegment
  XSegment* {.final.} = object
    x1*, y1*, x2*, y2*: cshort

  PXPoint* = ptr XPoint
  XPoint* {.final.} = object
    x*, y*: cshort

  PXRectangle* = ptr XRectangle
  XRectangle* {.final.} = object
    x*, y*: cshort
    width*, height*: cushort

  PXArc* = ptr XArc
  XArc* {.final.} = object
    x*, y*: cshort
    width*, height*: cushort
    angle1*, angle2*: cshort

  PXKeyboardControl* = ptr XKeyboardControl
  XKeyboardControl* {.final.} = object
    key_click_percent*: cint
    bell_percent*: cint
    bell_pitch*: cint
    bell_duration*: cint
    led*: cint
    led_mode*: cint
    key*: cint
    auto_repeat_mode*: cint

  PXKeyboardState* = ptr XKeyboardState
  XKeyboardState* {.final.} = object
    key_click_percent*: cint
    bell_percent*: cint
    bell_pitch*, bell_duration*: cuint
    led_mask*: culong
    global_auto_repeat*: cint
    auto_repeats*: array[0 .. 31, cchar]

  PXTimeCoord* = ptr XTimeCoord
  XTimeCoord* {.final.} = object
    time*: Time
    x*, y*: cshort

  PXModifierKeymap* = ptr XModifierKeymap
  XModifierKeymap* {.final.} = object
    max_keypermod*: cint
    modifiermap*: PKeyCode

  PDisplay* = ptr Display
  Display* = XDisplay

  PXPrivate* = ptr Private
  Private* {.final.} = object

  PXrmHashBucketRec* = ptr XrmHashBucketRec
  XrmHashBucketRec* {.final.} = object

  PXPrivDisplay* = ptr XPrivDisplay
  XPrivDisplay* {.final.} = object
    ext_data*: PXExtData
    private1*: PXPrivate
    fd*: cint
    private2*: cint
    proto_major_version*: cint
    proto_minor_version*: cint
    vendor*: cstring
    private3*: XID
    private4*: XID
    private5*: XID
    private6*: cint
    resource_alloc*: proc(para1: PXDisplay): XID {.cdecl.}
    byte_order*: cint
    bitmap_unit*: cint
    bitmap_pad*: cint
    bitmap_bit_order*: cint
    nformats*: cint
    pixmap_format*: PScreenFormat
    private8*: cint
    release*: cint
    private9*, private10*: PXPrivate
    qlen*: cint
    last_request_read*: culong
    request*: culong
    private11*: XPointer
    private12*: XPointer
    private13*: XPointer
    private14*: XPointer
    max_request_size*: cunsigned
    db*: PXrmHashBucketRec
    private15*: proc(para1: PXDisplay): cint {.cdecl.}
    display_name*: cstring
    default_screen*: cint
    nscreens*: cint
    screens*: PScreen
    motion_buffer*: culong
    private16*: culong
    min_keycode*: cint
    max_keycode*: cint
    private17*: XPointer
    private18*: XPointer
    private19*: cint
    xdefaults*: cstring

  PXKeyEvent* = ptr XKeyEvent
  XKeyEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*, y*: cint
    x_root*, y_root*: cint
    state*: cuint
    keycode*: cuint
    same_screen*: XBool

  PXKeyPressedEvent* = ptr XKeyPressedEvent
  XKeyPressedEvent* = XKeyEvent

  PXKeyReleasedEvent* = ptr XKeyReleasedEvent
  XKeyReleasedEvent* = XKeyEvent

  PXButtonEvent* = ptr XButtonEvent
  XButtonEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*, y*: cint
    x_root*, y_root*: cint
    state*: cuint
    button*: cuint
    same_screen*: XBool

  PXButtonPressedEvent* = ptr XButtonPressedEvent
  XButtonPressedEvent* = XButtonEvent

  PXButtonReleasedEvent* = ptr XButtonReleasedEvent
  XButtonReleasedEvent* = XButtonEvent

  PXMotionEvent* = ptr XMotionEvent
  XMotionEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*, y*: cint
    x_root*, y_root*: cint
    state*: cuint
    is_hint*: cchar
    same_screen*: XBool

  PXPointerMovedEvent* = ptr XPointerMovedEvent
  XPointerMovedEvent* = XMotionEvent

  PXCrossingEvent* = ptr XCrossingEvent
  XCrossingEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*, y*: cint
    x_root*, y_root*: cint
    mode*: cint
    detail*: cint
    same_screen*: XBool
    focus*: XBool
    state*: cuint

  PXEnterWindowEvent* = ptr XEnterWindowEvent
  XEnterWindowEvent* = XCrossingEvent

  PXLeaveWindowEvent* = ptr XLeaveWindowEvent
  XLeaveWindowEvent* = XCrossingEvent

  PXFocusChangeEvent* = ptr XFocusChangeEvent
  XFocusChangeEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    mode*: cint
    detail*: cint

  PXFocusInEvent* = ptr XFocusInEvent
  XFocusInEvent* = XFocusChangeEvent

  PXFocusOutEvent* = ptr XFocusOutEvent
  XFocusOutEvent* = XFocusChangeEvent

  PXKeymapEvent* = ptr XKeymapEvent
  XKeymapEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    key_vector*: array[0 .. 31, cchar]

  PXExposeEvent* = ptr XExposeEvent
  XExposeEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    x*, y*: cint
    width*, height*: cint
    count*: cint

  PXGraphicsExposeEvent* = ptr XGraphicsExposeEvent
  XGraphicsExposeEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    drawable*: Drawable
    x*, y*: cint
    width*, height*: cint
    count*: cint
    major_code*: cint
    minor_code*: cint

  PXNoExposeEvent* = ptr XNoExposeEvent
  XNoExposeEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    drawable*: Drawable
    major_code*: cint
    minor_code*: cint

  PXVisibilityEvent* = ptr XVisibilityEvent
  XVisibilityEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    state*: cint

  PXCreateWindowEvent* = ptr XCreateWindowEvent
  XCreateWindowEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    parent*: Window
    window*: Window
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    override_redirect*: XBool

  PXDestroyWindowEvent* = ptr XDestroyWindowEvent
  XDestroyWindowEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window

  PXUnmapEvent* = ptr XUnmapEvent
  XUnmapEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window
    from_configure*: XBool

  PXMapEvent* = ptr XMapEvent
  XMapEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window
    override_redirect*: XBool

  PXMapRequestEvent* = ptr XMapRequestEvent
  XMapRequestEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    parent*: Window
    window*: Window

  PXReparentEvent* = ptr XReparentEvent
  XReparentEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window
    parent*: Window
    x*, y*: cint
    override_redirect*: XBool

  PXConfigureEvent* = ptr XConfigureEvent
  XConfigureEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    above*: Window
    override_redirect*: XBool

  PXGravityEvent* = ptr XGravityEvent
  XGravityEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window
    x*, y*: cint

  PXResizeRequestEvent* = ptr XResizeRequestEvent
  XResizeRequestEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    width*, height*: cint

  PXConfigureRequestEvent* = ptr XConfigureRequestEvent
  XConfigureRequestEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    parent*: Window
    window*: Window
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    above*: Window
    detail*: cint
    value_mask*: culong

  PXCirculateEvent* = ptr XCirculateEvent
  XCirculateEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    event*: Window
    window*: Window
    place*: cint

  PXCirculateRequestEvent* = ptr XCirculateRequestEvent
  XCirculateRequestEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    parent*: Window
    window*: Window
    place*: cint

  PXPropertyEvent* = ptr XPropertyEvent
  XPropertyEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    atom*: Atom
    time*: Time
    state*: cint

  PXSelectionClearEvent* = ptr XSelectionClearEvent
  XSelectionClearEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    selection*: Atom
    time*: Time

  PXSelectionRequestEvent* = ptr XSelectionRequestEvent
  XSelectionRequestEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    owner*: Window
    requestor*: Window
    selection*: Atom
    target*: Atom
    property*: Atom
    time*: Time

  PXSelectionEvent* = ptr XSelectionEvent
  XSelectionEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    requestor*: Window
    selection*: Atom
    target*: Atom
    property*: Atom
    time*: Time

  PXColormapEvent* = ptr XColormapEvent
  XColormapEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    colormap*: Colormap
    c_new*: XBool
    state*: cint

  PXClientMessageEvent* = ptr XClientMessageEvent

  XClientMessageData* {.union.} = object
    b*: array[20, cchar]
    s*: array[10, cshort]
    l*: array[5, clong]

  XClientMessageEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    message_type*: Atom
    format*: cint
    data*: XClientMessageData

  PXMappingEvent* = ptr XMappingEvent
  XMappingEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window
    request*: cint
    first_keycode*: cint
    count*: cint

  PXErrorEvent* = ptr XErrorEvent
  XErrorEvent* {.final.} = object
    theType*: cint
    display*: PDisplay
    resourceid*: XID
    serial*: culong
    error_code*: uint8
    request_code*: uint8
    minor_code*: uint8

  PXAnyEvent* = ptr XAnyEvent
  XAnyEvent* {.final.} = object
    theType*: cint
    serial*: culong
    send_event*: XBool
    display*: PDisplay
    window*: Window

  PXGenericEvent* = ptr XGenericEvent
  XGenericEvent* {.final.} = object
    theType*: cint ##  of event. Always GenericEvent
    serial*: culong ##  # of last request processed
    send_event*: XBool ##  true if from SendEvent request
    display*: PDisplay ##  Display the event was read from
    extension*: cint ##  major opcode of extension that caused the event
    evtype*: cint ##  actual event type.

  PXGenericEventCookie* = ptr XGenericEventCookie
  XGenericEventCookie* {.final.} = object
    theType*: cint ##  of event. Always GenericEvent
    serial*: culong ##  # of last request processed
    send_event*: XBool ##  true if from SendEvent request
    display*: PDisplay ##  Display the event was read from
    extension*: cint ##  major opcode of extension that caused the event
    evtype*: cint ##  actual event type.
    cookie*: cuint
    data*: pointer

  PXEvent* = ptr XEvent
  XEvent* {.final, union.} = object
    theType*: cint
    xany*: XAnyEvent
    xkey*: XKeyEvent
    xbutton*: XButtonEvent
    xmotion*: XMotionEvent
    xcrossing*: XCrossingEvent
    xfocus*: XFocusChangeEvent
    xexpose*: XExposeEvent
    xgraphicsexpose*: XGraphicsExposeEvent
    xnoexpose*: XNoExposeEvent
    xvisibility*: XVisibilityEvent
    xcreatewindow*: XCreateWindowEvent
    xdestroywindow*: XDestroyWindowEvent
    xunmap*: XUnmapEvent
    xmap*: XMapEvent
    xmaprequest*: XMapRequestEvent
    xreparent*: XReparentEvent
    xconfigure*: XConfigureEvent
    xgravity*: XGravityEvent
    xresizerequest*: XResizeRequestEvent
    xconfigurerequest*: XConfigureRequestEvent
    xcirculate*: XCirculateEvent
    xcirculaterequest*: XCirculateRequestEvent
    xproperty*: XPropertyEvent
    xselectionclear*: XSelectionClearEvent
    xselectionrequest*: XSelectionRequestEvent
    xselection*: XSelectionEvent
    xcolormap*: XColormapEvent
    xclient*: XClientMessageEvent
    xmapping*: XMappingEvent
    xerror*: XErrorEvent
    xkeymap*: XKeymapEvent
    xgeneric*: XGenericEvent
    xcookie*: XGenericEventCookie
    pad: array[0 .. 23, clong]

type
  PXCharStruct* = ptr XCharStruct
  XCharStruct* {.final.} = object
    lbearing*: cshort
    rbearing*: cshort
    width*: cshort
    ascent*: cshort
    descent*: cshort
    attributes*: cushort

  PXFontProp* = ptr XFontProp
  XFontProp* {.final.} = object
    name*: Atom
    card32*: culong

  PPPXFontStruct* = ptr PPXFontStruct
  PPXFontStruct* = ptr PXFontStruct
  PXFontStruct* = ptr XFontStruct
  XFontStruct* {.final.} = object
    ext_data*: PXExtData
    fid*: Font
    direction*: cunsigned
    min_char_or_byte2*: cunsigned
    max_char_or_byte2*: cunsigned
    min_byte1*: cunsigned
    max_byte1*: cunsigned
    all_chars_exist*: XBool
    default_char*: cunsigned
    n_properties*: cint
    properties*: PXFontProp
    min_bounds*: XCharStruct
    max_bounds*: XCharStruct
    per_char*: PXCharStruct
    ascent*: cint
    descent*: cint

  PXTextItem* = ptr XTextItem
  XTextItem* {.final.} = object
    chars*: cstring
    nchars*: cint
    delta*: cint
    font*: Font

  PXChar2b* = ptr XChar2b
  XChar2b* {.final.} = object
    byte1*: uint8
    byte2*: uint8

  PXTextItem16* = ptr XTextItem16
  XTextItem16* {.final.} = object
    chars*: PXChar2b
    nchars*: cint
    delta*: cint
    font*: Font

  PXEDataObject* = ptr XEDataObject
  XEDataObject* {.final.} = object
    display*: PDisplay
      # case longint of
      #          0 : ( display : PDisplay );
      #          1 : ( gc : GC );
      #          2 : ( visual : PVisual );
      #          3 : ( screen : PScreen );
      #          4 : ( pixmap_format : PScreenFormat );
      #          5 : ( font : PXFontStruct );

  PXFontSetExtents* = ptr XFontSetExtents
  XFontSetExtents* {.final.} = object
    max_ink_extent*: XRectangle
    max_logical_extent*: XRectangle

  PXOM* = ptr XOM
  XOM* {.final.} = object

  PXOC* = ptr XOC
  XOC* {.final.} = object

  PXFontSet* = ptr XFontSet
  XFontSet* = PXOC

  PXmbTextItem* = ptr XmbTextItem
  XmbTextItem* {.final.} = object
    chars*: cstring
    nchars*: cint
    delta*: cint
    font_set*: XFontSet

  PXwcTextItem* = ptr XwcTextItem
  XwcTextItem* {.final.} = object
    chars*: PWideChar #wchar_t*
    nchars*: cint
    delta*: cint
    font_set*: XFontSet

const
  XNRequiredCharSet* = "requiredCharSet"
  XNQueryOrientation* = "queryOrientation"
  XNBaseFontName* = "baseFontName"
  XNOMAutomatic* = "omAutomatic"
  XNMissingCharSet* = "missingCharSet"
  XNDefaultString* = "defaultString"
  XNOrientation* = "orientation"
  XNDirectionalDependentDrawing* = "directionalDependentDrawing"
  XNContextualDrawing* = "contextualDrawing"
  XNFontInfo* = "fontInfo"

type
  PXOMCharSetList* = ptr XOMCharSetList
  XOMCharSetList* {.final.} = object
    charset_count*: cint
    charset_list*: PPChar

  PXOrientation* = ptr XOrientation
  XOrientation* = enum
    XOMOrientation_LTR_TTB
    XOMOrientation_RTL_TTB
    XOMOrientation_TTB_LTR
    XOMOrientation_TTB_RTL
    XOMOrientation_Context

  PXOMOrientation* = ptr XOMOrientation
  XOMOrientation* {.final.} = object
    num_orientation*: cint
    orientation*: PXOrientation

  PXOMFontInfo* = ptr XOMFontInfo
  XOMFontInfo* {.final.} = object
    num_font*: cint
    font_struct_list*: ptr PXFontStruct
    font_name_list*: PPChar

  XIM* {.final.} = ptr object

  XIC* {.final.} = ptr object

  XIMProc* = proc(para1: XIM, para2: XPointer, para3: XPointer) {.cdecl.}

  XICProc* = proc(para1: XIC, para2: XPointer, para3: XPointer): XBool {.cdecl.}

  XIDProc* = proc(para1: PDisplay, para2: XPointer, para3: XPointer) {.cdecl.}

  PXIMStyle* = ptr XIMStyle
  XIMStyle* = culong

  PXIMStyles* = ptr XIMStyles
  XIMStyles* {.final.} = object
    count_styles*: cushort
    supported_styles*: PXIMStyle

const
  XIMPreeditArea* = 0x00000001
  XIMPreeditCallbacks* = 0x00000002
  XIMPreeditPosition* = 0x00000004
  XIMPreeditNothing* = 0x00000008
  XIMPreeditNone* = 0x00000010
  XIMStatusArea* = 0x00000100
  XIMStatusCallbacks* = 0x00000200
  XIMStatusNothing* = 0x00000400
  XIMStatusNone* = 0x00000800
  XNVaNestedList* = "XNVaNestedList"
  XNQueryInputStyle* = "queryInputStyle"
  XNClientWindow* = "clientWindow"
  XNInputStyle* = "inputStyle"
  XNFocusWindow* = "focusWindow"
  XNResourceName* = "resourceName"
  XNResourceClass* = "resourceClass"
  XNGeometryCallback* = "geometryCallback"
  XNDestroyCallback* = "destroyCallback"
  XNFilterEvents* = "filterEvents"
  XNPreeditStartCallback* = "preeditStartCallback"
  XNPreeditDoneCallback* = "preeditDoneCallback"
  XNPreeditDrawCallback* = "preeditDrawCallback"
  XNPreeditCaretCallback* = "preeditCaretCallback"
  XNPreeditStateNotifyCallback* = "preeditStateNotifyCallback"
  XNPreeditAttributes* = "preeditAttributes"
  XNStatusStartCallback* = "statusStartCallback"
  XNStatusDoneCallback* = "statusDoneCallback"
  XNStatusDrawCallback* = "statusDrawCallback"
  XNStatusAttributes* = "statusAttributes"
  XNArea* = "area"
  XNAreaNeeded* = "areaNeeded"
  XNSpotLocation* = "spotLocation"
  XNColormap* = "colorMap"
  XNStdColormap* = "stdColorMap"
  XNForeground* = "foreground"
  XNBackground* = "background"
  XNBackgroundPixmap* = "backgroundPixmap"
  XNFontSet* = "fontSet"
  XNLineSpace* = "lineSpace"
  XNCursor* = "cursor"
  XNQueryIMValuesList* = "queryIMValuesList"
  XNQueryICValuesList* = "queryICValuesList"
  XNVisiblePosition* = "visiblePosition"
  XNR6PreeditCallback* = "r6PreeditCallback"
  XNStringConversionCallback* = "stringConversionCallback"
  XNStringConversion* = "stringConversion"
  XNResetState* = "resetState"
  XNHotKey* = "hotKey"
  XNHotKeyState* = "hotKeyState"
  XNPreeditState* = "preeditState"
  XNSeparatorofNestedList* = "separatorofNestedList"
  XBufferOverflow* = -(1)
  XLookupNone* = 1
  XLookupChars* = 2
  XLookupKeySymVal* = 3
  XLookupBoth* = 4

type
  PXVaNestedList* = ptr XVaNestedList
  XVaNestedList* = pointer

  PXIMCallback* = ptr XIMCallback
  XIMCallback* {.final.} = object
    client_data*: XPointer
    callback*: XIMProc

  PXICCallback* = ptr XICCallback
  XICCallback* {.final.} = object
    client_data*: XPointer
    callback*: XICProc

  PXIMFeedback* = ptr XIMFeedback
  XIMFeedback* = culong

const
  XIMReverse* = 1
  XIMUnderline* = 1 shl 1
  XIMHighlight* = 1 shl 2
  XIMPrimary* = 1 shl 5
  XIMSecondary* = 1 shl 6
  XIMTertiary* = 1 shl 7
  XIMVisibleToForward* = 1 shl 8
  XIMVisibleToBackword* = 1 shl 9
  XIMVisibleToCenter* = 1 shl 10

type
  PXIMText* = ptr XIMText
  XIMText* {.final.} = object
    len*: cushort
    feedback*: PXIMFeedback
    encoding_is_wchar*: XBool
    multi_byte*: cstring

  PXIMPreeditState* = ptr XIMPreeditState
  XIMPreeditState* = culong

const
  XIMPreeditUnKnown* = 0
  XIMPreeditEnable* = 1
  XIMPreeditDisable* = 1 shl 1

type
  PXIMPreeditStateNotifyCallbackStruct* = ptr XIMPreeditStateNotifyCallbackStruct
  XIMPreeditStateNotifyCallbackStruct* {.final.} = object
    state*: XIMPreeditState

  PXIMResetState* = ptr XIMResetState
  XIMResetState* = culong

const
  XIMInitialState* = 1
  XIMPreserveState* = 1 shl 1

type
  PXIMStringConversionFeedback* = ptr XIMStringConversionFeedback
  XIMStringConversionFeedback* = culong

const
  XIMStringConversionLeftEdge* = 0x00000001
  XIMStringConversionRightEdge* = 0x00000002
  XIMStringConversionTopEdge* = 0x00000004
  XIMStringConversionBottomEdge* = 0x00000008
  XIMStringConversionConcealed* = 0x00000010
  XIMStringConversionWrapped* = 0x00000020

type
  PXIMStringConversionText* = ptr XIMStringConversionText
  XIMStringConversionText* {.final.} = object
    len*: cushort
    feedback*: PXIMStringConversionFeedback
    encoding_is_wchar*: XBool
    mbs*: cstring

  PXIMStringConversionPosition* = ptr XIMStringConversionPosition
  XIMStringConversionPosition* = cushort

  PXIMStringConversionType* = ptr XIMStringConversionType
  XIMStringConversionType* = cushort

const
  XIMStringConversionBuffer* = 0x00000001
  XIMStringConversionLine* = 0x00000002
  XIMStringConversionWord* = 0x00000003
  XIMStringConversionChar* = 0x00000004

type
  PXIMStringConversionOperation* = ptr XIMStringConversionOperation
  XIMStringConversionOperation* = cushort

const
  XIMStringConversionSubstitution* = 0x00000001
  XIMStringConversionRetrieval* = 0x00000002

type
  PXIMCaretDirection* = ptr XIMCaretDirection
  XIMCaretDirection* = enum
    XIMForwardChar
    XIMBackwardChar
    XIMForwardWord
    XIMBackwardWord
    XIMCaretUp
    XIMCaretDown
    XIMNextLine
    XIMPreviousLine
    XIMLineStart
    XIMLineEnd
    XIMAbsolutePosition
    XIMDontChange

  PXIMStringConversionCallbackStruct* = ptr XIMStringConversionCallbackStruct
  XIMStringConversionCallbackStruct* {.final.} = object
    position*: XIMStringConversionPosition
    direction*: XIMCaretDirection
    operation*: XIMStringConversionOperation
    factor*: cushort
    text*: PXIMStringConversionText

  PXIMPreeditDrawCallbackStruct* = ptr XIMPreeditDrawCallbackStruct
  XIMPreeditDrawCallbackStruct* {.final.} = object
    caret*: cint
    chg_first*: cint
    chg_length*: cint
    text*: PXIMText

  PXIMCaretStyle* = ptr XIMCaretStyle
  XIMCaretStyle* = enum
    XIMIsInvisible
    XIMIsPrimary
    XIMIsSecondary

  PXIMPreeditCaretCallbackStruct* = ptr XIMPreeditCaretCallbackStruct
  XIMPreeditCaretCallbackStruct* {.final.} = object
    position*: cint
    direction*: XIMCaretDirection
    style*: XIMCaretStyle

  PXIMStatusDataType* = ptr XIMStatusDataType
  XIMStatusDataType* = enum
    XIMTextType
    XIMBitmapType

  PXIMStatusDrawCallbackStruct* = ptr XIMStatusDrawCallbackStruct
  XIMStatusDrawCallbackStruct* {.final.} = object
    theType*: XIMStatusDataType
    bitmap*: Pixmap

  PXIMHotKeyTrigger* = ptr XIMHotKeyTrigger
  XIMHotKeyTrigger* {.final.} = object
    keysym*: KeySym
    modifier*: cint
    modifier_mask*: cint

  PXIMHotKeyTriggers* = ptr XIMHotKeyTriggers
  XIMHotKeyTriggers* {.final.} = object
    num_hot_key*: cint
    key*: PXIMHotKeyTrigger

  PXIMHotKeyState* = ptr XIMHotKeyState
  XIMHotKeyState* = culong

const
  XIMHotKeyStateON* = 0x00000001
  XIMHotKeyStateOFF* = 0x00000002

type
  PXIMValuesList* = ptr XIMValuesList
  XIMValuesList* {.final.} = object
    count_values*: cushort
    supported_values*: PPChar

type
  funcdisp* = proc(display: PDisplay): cint {.cdecl.}
  funcifevent* = proc(display: PDisplay, event: PXEvent, p: XPointer): XBool {.cdecl.}
  chararr32* = array[0 .. 31, char]

const AllPlanes*: culong = not culong(0)

const
  NoValue* = 0x00000000
  XValue* = 0x00000001
  YValue* = 0x00000002
  WidthValue* = 0x00000004
  HeightValue* = 0x00000008
  AllValues* = 0x0000000F
  XNegative* = 0x00000010
  YNegative* = 0x00000020

type
  CPoint* {.final.} = object
    x*: cint
    y*: cint

  PXSizeHints* = ptr XSizeHints
  XSizeHints* {.final.} = object
    flags*: clong
    x*, y*: cint
    width*, height*: cint
    min_width*, min_height*: cint
    max_width*, max_height*: cint
    width_inc*, height_inc*: cint
    min_aspect*, max_aspect*: CPoint
    base_width*, base_height*: cint
    win_gravity*: cint

const
  USPosition* = 1 shl 0
  USSize* = 1 shl 1
  PPosition* = 1 shl 2
  PSize* = 1 shl 3
  PMinSize* = 1 shl 4
  PMaxSize* = 1 shl 5
  PResizeInc* = 1 shl 6
  PAspect* = 1 shl 7
  PBaseSize* = 1 shl 8
  PWinGravity* = 1 shl 9
  PAllHints* = PPosition or PSize or PMinSize or PMaxSize or PResizeInc or PAspect

type
  PXWMHints* = ptr XWMHints
  XWMHints* {.final.} = object
    flags*: clong
    input*: XBool
    initial_state*: cint
    icon_pixmap*: Pixmap
    icon_window*: Window
    icon_x*, icon_y*: cint
    icon_mask*: Pixmap
    window_group*: XID

const
  InputHint* = 1 shl 0
  StateHint* = 1 shl 1
  IconPixmapHint* = 1 shl 2
  IconWindowHint* = 1 shl 3
  IconPositionHint* = 1 shl 4
  IconMaskHint* = 1 shl 5
  WindowGroupHint* = 1 shl 6
  AllHints* =
    InputHint or StateHint or IconPixmapHint or IconWindowHint or IconPositionHint or
    IconMaskHint or WindowGroupHint
  XUrgencyHint* = 1 shl 8
  WithdrawnState* = 0
  NormalState* = 1
  IconicState* = 3
  DontCareState* = 0
  ZoomState* = 2
  InactiveState* = 4

type
  PXTextProperty* = ptr XTextProperty
  XTextProperty* {.final.} = object
    value*: Pcuchar
    encoding*: Atom
    format*: cint
    nitems*: culong

const
  XNoMemory* = -1
  XLocaleNotSupported* = -2
  XConverterNotFound* = -3

type
  PXICCEncodingStyle* = ptr XICCEncodingStyle
  XICCEncodingStyle* = enum
    XStringStyle
    XCompoundTextStyle
    XTextStyle
    XStdICCTextStyle
    XUTF8StringStyle

  PPXIconSize* = ptr PXIconSize
  PXIconSize* = ptr XIconSize
  XIconSize* {.final.} = object
    min_width*, min_height*: cint
    max_width*, max_height*: cint
    width_inc*, height_inc*: cint

  PXClassHint* = ptr XClassHint
  XClassHint* {.final.} = object
    res_name*: cstring
    res_class*: cstring

type
  PXComposeStatus* = ptr XComposeStatus
  XComposeStatus* {.final.} = object
    compose_ptr*: XPointer
    chars_matched*: cint

type
  PXRegion* = ptr XRegion
  XRegion* {.final.} = object

  PRegion* = ptr Region
  Region* = PXRegion

const
  RectangleOut* = 0
  RectangleIn* = 1
  RectanglePart* = 2

type
  PXVisualInfo* = ptr XVisualInfo
  XVisualInfo* {.final.} = object
    visual*: PVisual
    visualid*: VisualID
    screen*: cint
    depth*: cint
    class*: cint
    red_mask*: culong
    green_mask*: culong
    blue_mask*: culong
    colormap_size*: cint
    bits_per_rgb*: cint

const
  VisualNoMask* = 0x00000000
  VisualIDMask* = 0x00000001
  VisualScreenMask* = 0x00000002
  VisualDepthMask* = 0x00000004
  VisualClassMask* = 0x00000008
  VisualRedMaskMask* = 0x00000010
  VisualGreenMaskMask* = 0x00000020
  VisualBlueMaskMask* = 0x00000040
  VisualColormapSizeMask* = 0x00000080
  VisualBitsPerRGBMask* = 0x00000100
  VisualAllMask* = 0x000001FF

type
  PPXStandardColormap* = ptr PXStandardColormap
  PXStandardColormap* = ptr XStandardColormap
  XStandardColormap* {.final.} = object
    colormap*: Colormap
    red_max*: culong
    red_mult*: culong
    green_max*: culong
    green_mult*: culong
    blue_max*: culong
    blue_mult*: culong
    base_pixel*: culong
    visualid*: VisualID
    killid*: XID

const
  BitmapSuccess* = 0
  BitmapOpenFailed* = 1
  BitmapFileInvalid* = 2
  BitmapNoMemory* = 3
  XCSUCCESS* = 0
  XCNOMEM* = 1
  XCNOENT* = 2
  ReleaseByFreeingColormap*: XID = XID(1)

type
  PXContext* = ptr XContext
  XContext* = cint

type
  XErrorHandler* = proc(display: PDisplay, event: PXErrorEvent): cint {.cdecl.}
  XIOErrorHandler* = proc(display: PDisplay): cint {.cdecl.}
  XConnectionWatchProc* = proc(
    display: PDisplay, data: XPointer, fd: cint, opening: XBool, watchData: PXPointer
  ) {.cdecl.}

## ABI-compatible procedure signatures used by x11api.
type x11_XCloseDisplay* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XConvertSelection* = proc(
  para1: PDisplay, para2: Atom, para3: Atom, para4: Atom, para5: Window, para6: Time
): cint {.cdecl, raises: [].}

type x11_XCreateColormap* = proc(
  para1: PDisplay, para2: Window, para3: PVisual, para4: cint
): Colormap {.cdecl, raises: [].}

type x11_XCreateIC* = proc(para1: XIM): XIC {.cdecl, varargs, raises: [].}
type x11_XCreateWindow* = proc(
  para1: PDisplay,
  para2: Window,
  para3: cint,
  para4: cint,
  para5: cuint,
  para6: cuint,
  para7: cuint,
  para8: cint,
  para9: cuint,
  para10: PVisual,
  para11: culong,
  para12: PXSetWindowAttributes,
): Window {.cdecl, raises: [].}

type x11_XDefineCursor* =
  proc(para1: PDisplay, para2: Window, para3: Cursor): cint {.cdecl, raises: [].}

type x11_XMapRaised* = proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}
type x11_XMapWindow* = proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}
type x11_XPutImage* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: PXImage,
  para5: cint,
  para6: cint,
  para7: cint,
  para8: cint,
  para9: cuint,
  para10: cuint,
): cint {.cdecl, raises: [].}

type x11_XQueryPointer* = proc(
  para1: PDisplay,
  para2: Window,
  para3: PWindow,
  para4: PWindow,
  para5: Pcint,
  para6: Pcint,
  para7: Pcint,
  para8: Pcint,
  para9: Pcuint,
): XBool {.cdecl, raises: [].}

type x11_XResizeWindow* = proc(
  para1: PDisplay, para2: Window, para3: cuint, para4: cuint
): cint {.cdecl, raises: [].}

type x11_XSelectInput* =
  proc(para1: PDisplay, para2: Window, para3: clong): cint {.cdecl, raises: [].}

type x11_XSetICFocus* = proc(para1: XIC) {.cdecl, raises: [].}
type x11_XSetTransientForHint* =
  proc(para1: PDisplay, para2: Window, para3: Window): cint {.cdecl, raises: [].}

type x11_XUngrabPointer* =
  proc(para1: PDisplay, para2: Time): cint {.cdecl, raises: [].}

type x11_XLoadQueryFont* =
  proc(para1: PDisplay, para2: cstring): PXFontStruct {.cdecl, raises: [].}

type x11_XGetMotionEvents* = proc(
  para1: PDisplay, para2: Window, para3: Time, para4: Time, para5: Pcint
): PXTimeCoord {.cdecl, raises: [].}

type x11_XDeleteModifiermapEntry* = proc(
  para1: PXModifierKeymap, para2: KeyCode, para3: cint
): PXModifierKeymap {.cdecl, raises: [].}

type x11_XGetModifierMapping* =
  proc(para1: PDisplay): PXModifierKeymap {.cdecl, raises: [].}

type x11_XNewModifiermap* = proc(para1: cint): PXModifierKeymap {.cdecl, raises: [].}
type x11_XInitImage* = proc(para1: PXImage): Status {.cdecl, raises: [].}
type x11_XGetSubImage* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: cint,
  para4: cint,
  para5: cuint,
  para6: cuint,
  para7: culong,
  para8: cint,
  para9: PXImage,
  para10: cint,
  para11: cint,
): PXImage {.cdecl, raises: [].}

type x11_XOpenDisplay* = proc(para1: cstring): PDisplay {.cdecl, raises: [].}
type x11_XFetchBytes* =
  proc(para1: PDisplay, para2: Pcint): cstring {.cdecl, raises: [].}

type x11_XGetAtomName* =
  proc(para1: PDisplay, para2: Atom): cstring {.cdecl, raises: [].}

type x11_XGetDefault* =
  proc(para1: PDisplay, para2: cstring, para3: cstring): cstring {.cdecl, raises: [].}

type x11_XDisplayName* = proc(para1: cstring): cstring {.cdecl, raises: [].}
type x11_XSynchronize* =
  proc(para1: PDisplay, para2: XBool): funcdisp {.cdecl, raises: [].}

type x11_XInternAtom* =
  proc(para1: PDisplay, para2: cstring, para3: XBool): Atom {.cdecl, raises: [].}

type x11_XCopyColormapAndFree* =
  proc(para1: PDisplay, para2: Colormap): Colormap {.cdecl, raises: [].}

type x11_XCreatePixmapCursor* = proc(
  para1: PDisplay,
  para2: Pixmap,
  para3: Pixmap,
  para4: PXColor,
  para5: PXColor,
  para6: cuint,
  para7: cuint,
): Cursor {.cdecl, raises: [].}

type x11_XCreateGlyphCursor* = proc(
  para1: PDisplay,
  para2: Font,
  para3: Font,
  para4: cuint,
  para5: cuint,
  para6: PXColor,
  para7: PXColor,
): Cursor {.cdecl, raises: [].}

type x11_XCreateFontCursor* =
  proc(para1: PDisplay, para2: cuint): Cursor {.cdecl, raises: [].}

type x11_XCreateGC* = proc(
  para1: PDisplay, para2: Drawable, para3: culong, para4: PXGCValues
): GC {.cdecl, raises: [].}

type x11_XGContextFromGC* = proc(para1: GC): GContext {.cdecl, raises: [].}
type x11_XCreatePixmap* = proc(
  para1: PDisplay, para2: Drawable, para3: cuint, para4: cuint, para5: cuint
): Pixmap {.cdecl, raises: [].}

type x11_XCreateBitmapFromData* = proc(
  para1: PDisplay, para2: Drawable, para3: cstring, para4: cuint, para5: cuint
): Pixmap {.cdecl, raises: [].}

type x11_XCreatePixmapFromBitmapData* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: cstring,
  para4: cuint,
  para5: cuint,
  para6: culong,
  para7: culong,
  para8: cuint,
): Pixmap {.cdecl, raises: [].}

type x11_XCreateSimpleWindow* = proc(
  para1: PDisplay,
  para2: Window,
  para3: cint,
  para4: cint,
  para5: cuint,
  para6: cuint,
  para7: cuint,
  para8: culong,
  para9: culong,
): Window {.cdecl, raises: [].}

type x11_XGetSelectionOwner* =
  proc(para1: PDisplay, para2: Atom): Window {.cdecl, raises: [].}

type x11_XListInstalledColormaps* =
  proc(para1: PDisplay, para2: Window, para3: Pcint): PColormap {.cdecl, raises: [].}

type x11_XListFonts* = proc(
  para1: PDisplay, para2: cstring, para3: cint, para4: Pcint
): PPChar {.cdecl, raises: [].}

type x11_XListFontsWithInfo* = proc(
  para1: PDisplay, para2: cstring, para3: cint, para4: Pcint, para5: PPXFontStruct
): PPChar {.cdecl, raises: [].}

type x11_XGetFontPath* =
  proc(para1: PDisplay, para2: Pcint): PPChar {.cdecl, raises: [].}

type x11_XListProperties* =
  proc(para1: PDisplay, para2: Window, para3: Pcint): PAtom {.cdecl, raises: [].}

type x11_XListHosts* =
  proc(para1: PDisplay, para2: Pcint, para3: PBool): PXHostAddress {.cdecl, raises: [].}

type x11_XKeycodeToKeysym* =
  proc(para1: PDisplay, para2: KeyCode, para3: cint): KeySym {.cdecl, raises: [].}

type x11_XLookupKeysym* =
  proc(para1: PXKeyEvent, para2: cint): KeySym {.cdecl, raises: [].}

type x11_XStringToKeysym* = proc(para1: cstring): KeySym {.cdecl, raises: [].}
type x11_XExtendedMaxRequestSize* = proc(para1: PDisplay): clong {.cdecl, raises: [].}
type x11_XScreenResourceString* = proc(para1: PScreen): cstring {.cdecl, raises: [].}
type x11_XVisualIDFromVisual* = proc(para1: PVisual): VisualID {.cdecl, raises: [].}
type x11_XLockDisplay* = proc(para1: PDisplay) {.cdecl, raises: [].}
type x11_XInitExtension* =
  proc(para1: PDisplay, para2: cstring): PXExtCodes {.cdecl, raises: [].}

type x11_XFindOnExtensionList* =
  proc(para1: PPXExtData, para2: cint): PXExtData {.cdecl, raises: [].}

type x11_XRootWindow* = proc(para1: PDisplay, para2: cint): Window {.cdecl, raises: [].}
type x11_XRootWindowOfScreen* = proc(para1: PScreen): Window {.cdecl, raises: [].}
type x11_XDefaultVisualOfScreen* = proc(para1: PScreen): PVisual {.cdecl, raises: [].}
type x11_XDefaultGCOfScreen* = proc(para1: PScreen): GC {.cdecl, raises: [].}
type x11_XWhitePixel* = proc(para1: PDisplay, para2: cint): culong {.cdecl, raises: [].}
type x11_XBlackPixelOfScreen* = proc(para1: PScreen): culong {.cdecl, raises: [].}
type x11_XNextRequest* = proc(para1: PDisplay): culong {.cdecl, raises: [].}
type x11_XServerVendor* = proc(para1: PDisplay): cstring {.cdecl, raises: [].}
type x11_XDefaultColormap* =
  proc(para1: PDisplay, para2: cint): Colormap {.cdecl, raises: [].}

type x11_XDisplayOfScreen* = proc(para1: PScreen): PDisplay {.cdecl, raises: [].}
type x11_XDefaultScreenOfDisplay* = proc(para1: PDisplay): PScreen {.cdecl, raises: [].}
type x11_XScreenNumberOfScreen* = proc(para1: PScreen): cint {.cdecl, raises: [].}
type x11_XSetErrorHandler* =
  proc(para1: XErrorHandler): XErrorHandler {.cdecl, raises: [].}

type x11_XSetIOErrorHandler* =
  proc(para1: XIOErrorHandler): XIOErrorHandler {.cdecl, raises: [].}

type x11_XListDepths* =
  proc(para1: PDisplay, para2: cint, para3: Pcint): Pcint {.cdecl, raises: [].}

type x11_XGetWMProtocols* = proc(
  para1: PDisplay, para2: Window, para3: PPAtom, para4: Pcint
): Status {.cdecl, raises: [].}

type x11_XSetWMProtocols* = proc(
  para1: PDisplay, para2: Window, para3: PAtom, para4: cint
): Status {.cdecl, raises: [].}

type x11_XIconifyWindow* =
  proc(para1: PDisplay, para2: Window, para3: cint): Status {.cdecl, raises: [].}

type x11_XWithdrawWindow* =
  proc(para1: PDisplay, para2: Window, para3: cint): Status {.cdecl, raises: [].}

type x11_XGetCommand* = proc(
  para1: PDisplay, para2: Window, para3: PPPchar, para4: Pcint
): Status {.cdecl, raises: [].}

type x11_XGetWMColormapWindows* = proc(
  para1: PDisplay, para2: Window, para3: PPWindow, para4: Pcint
): Status {.cdecl, raises: [].}

type x11_XSetWMColormapWindows* = proc(
  para1: PDisplay, para2: Window, para3: PWindow, para4: cint
): Status {.cdecl, raises: [].}

type x11_XFreeStringList* = proc(para1: PPchar) {.cdecl, raises: [].}
type x11_XActivateScreenSaver* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XAddHosts* =
  proc(para1: PDisplay, para2: PXHostAddress, para3: cint): cint {.cdecl, raises: [].}

type x11_XAddToExtensionList* =
  proc(para1: PPXExtData, para2: PXExtData): cint {.cdecl, raises: [].}

type x11_XAllocColor* =
  proc(para1: PDisplay, para2: Colormap, para3: PXColor): Status {.cdecl, raises: [].}

type x11_XAllocColorCells* = proc(
  para1: PDisplay,
  para2: Colormap,
  para3: XBool,
  para4: Pculong,
  para5: cuint,
  para6: Pculong,
  para7: cuint,
): Status {.cdecl, raises: [].}

type x11_XAllocColorPlanes* = proc(
  para1: PDisplay,
  para2: Colormap,
  para3: XBool,
  para4: Pculong,
  para5: cint,
  para6: cint,
  para7: cint,
  para8: cint,
  para9: Pculong,
  para10: Pculong,
  para11: Pculong,
): Status {.cdecl, raises: [].}

type x11_XAllocNamedColor* = proc(
  para1: PDisplay, para2: Colormap, para3: cstring, para4: PXColor, para5: PXColor
): Status {.cdecl, raises: [].}

type x11_XAllowEvents* =
  proc(para1: PDisplay, para2: cint, para3: Time): cint {.cdecl, raises: [].}

type x11_XAutoRepeatOn* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XBitmapBitOrder* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XBitmapUnit* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XChangeActivePointerGrab* = proc(
  para1: PDisplay, para2: cuint, para3: Cursor, para4: Time
): cint {.cdecl, raises: [].}

type x11_XChangeGC* = proc(
  para1: PDisplay, para2: GC, para3: culong, para4: PXGCValues
): cint {.cdecl, raises: [].}

type x11_XChangeKeyboardControl* = proc(
  para1: PDisplay, para2: culong, para3: PXKeyboardControl
): cint {.cdecl, raises: [].}

type x11_XChangeKeyboardMapping* = proc(
  para1: PDisplay, para2: cint, para3: cint, para4: PKeySym, para5: cint
): cint {.cdecl, raises: [].}

type x11_XChangePointerControl* = proc(
  para1: PDisplay, para2: XBool, para3: XBool, para4: cint, para5: cint, para6: cint
): cint {.cdecl, raises: [].}

type x11_XChangeProperty* = proc(
  para1: PDisplay,
  para2: Window,
  para3: Atom,
  para4: Atom,
  para5: cint,
  para6: cint,
  para7: Pcuchar,
  para8: cint,
): cint {.cdecl, raises: [].}

type x11_XChangeSaveSet* =
  proc(para1: PDisplay, para2: Window, para3: cint): cint {.cdecl, raises: [].}

type x11_XCheckIfEvent* = proc(
  para1: PDisplay, para2: PXEvent, para3: funcifevent, para4: XPointer
): XBool {.cdecl, raises: [].}

type x11_XCheckMaskEvent* =
  proc(para1: PDisplay, para2: clong, para3: PXEvent): XBool {.cdecl, raises: [].}

type x11_XCheckTypedEvent* =
  proc(para1: PDisplay, para2: cint, para3: PXEvent): XBool {.cdecl, raises: [].}

type x11_XCheckTypedWindowEvent* = proc(
  para1: PDisplay, para2: Window, para3: cint, para4: PXEvent
): XBool {.cdecl, raises: [].}

type x11_XCheckWindowEvent* = proc(
  para1: PDisplay, para2: Window, para3: clong, para4: PXEvent
): XBool {.cdecl, raises: [].}

type x11_XCirculateSubwindows* =
  proc(para1: PDisplay, para2: Window, para3: cint): cint {.cdecl, raises: [].}

type x11_XCirculateSubwindowsDown* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XClearArea* = proc(
  para1: PDisplay,
  para2: Window,
  para3: cint,
  para4: cint,
  para5: cuint,
  para6: cuint,
  para7: XBool,
): cint {.cdecl, raises: [].}

type x11_XClearWindow* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XConfigureWindow* = proc(
  para1: PDisplay, para2: Window, para3: cuint, para4: PXWindowChanges
): cint {.cdecl, raises: [].}

type x11_XConnectionNumber* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XCopyArea* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: Drawable,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: cuint,
  para8: cuint,
  para9: cint,
  para10: cint,
): cint {.cdecl, raises: [].}

type x11_XCopyGC* =
  proc(para1: PDisplay, para2: GC, para3: culong, para4: GC): cint {.cdecl, raises: [].}

type x11_XCopyPlane* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: Drawable,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: cuint,
  para8: cuint,
  para9: cint,
  para10: cint,
  para11: culong,
): cint {.cdecl, raises: [].}

type x11_XDefaultDepth* = proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}
type x11_XDefaultScreen* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XDeleteProperty* =
  proc(para1: PDisplay, para2: Window, para3: Atom): cint {.cdecl, raises: [].}

type x11_XDestroyWindow* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XDoesBackingStore* = proc(para1: PScreen): cint {.cdecl, raises: [].}
type x11_XDisableAccessControl* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XDisplayHeight* =
  proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}

type x11_XDisplayKeycodes* =
  proc(para1: PDisplay, para2: Pcint, para3: Pcint): cint {.cdecl, raises: [].}

type x11_XDisplayPlanes* =
  proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}

type x11_XDisplayWidthMM* =
  proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}

type x11_XDrawArcs* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXArc, para5: cint
): cint {.cdecl, raises: [].}

type x11_XDrawImageString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: cstring,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XDrawImageString16* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXChar2b,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XDrawLine* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: cint,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XDrawLines* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXPoint, para5: cint, para6: cint
): cint {.cdecl, raises: [].}

type x11_XDrawPoint* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: cint, para5: cint
): cint {.cdecl, raises: [].}

type x11_XDrawPoints* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXPoint, para5: cint, para6: cint
): cint {.cdecl, raises: [].}

type x11_XDrawRectangle* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: cuint,
  para7: cuint,
): cint {.cdecl, raises: [].}

type x11_XDrawRectangles* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXRectangle, para5: cint
): cint {.cdecl, raises: [].}

type x11_XDrawSegments* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXSegment, para5: cint
): cint {.cdecl, raises: [].}

type x11_XDrawString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: cstring,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XDrawString16* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXChar2b,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XDrawText* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXTextItem,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XDrawText16* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXTextItem16,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XEnableAccessControl* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XFetchName* =
  proc(para1: PDisplay, para2: Window, para3: PPchar): Status {.cdecl, raises: [].}

type x11_XFillArc* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: cuint,
  para7: cuint,
  para8: cint,
  para9: cint,
): cint {.cdecl, raises: [].}

type x11_XFillArcs* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXArc, para5: cint
): cint {.cdecl, raises: [].}

type x11_XFillPolygon* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: PXPoint,
  para5: cint,
  para6: cint,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XFillRectangle* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: cuint,
  para7: cuint,
): cint {.cdecl, raises: [].}

type x11_XFillRectangles* = proc(
  para1: PDisplay, para2: Drawable, para3: GC, para4: PXRectangle, para5: cint
): cint {.cdecl, raises: [].}

type x11_XFlush* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XFree* = proc(para1: pointer): cint {.cdecl, raises: [].}
type x11_XFreeColors* = proc(
  para1: PDisplay, para2: Colormap, para3: Pculong, para4: cint, para5: culong
): cint {.cdecl, raises: [].}

type x11_XFreeCursor* = proc(para1: PDisplay, para2: Cursor): cint {.cdecl, raises: [].}
type x11_XFreeFont* =
  proc(para1: PDisplay, para2: PXFontStruct): cint {.cdecl, raises: [].}

type x11_XFreeFontNames* = proc(para1: PPchar): cint {.cdecl, raises: [].}
type x11_XFreeGC* = proc(para1: PDisplay, para2: GC): cint {.cdecl, raises: [].}
type x11_XFreePixmap* = proc(para1: PDisplay, para2: Pixmap): cint {.cdecl, raises: [].}
type x11_XGetErrorDatabaseText* = proc(
  para1: PDisplay,
  para2: cstring,
  para3: cstring,
  para4: cstring,
  para5: cstring,
  para6: cint,
): cint {.cdecl, raises: [].}

type x11_XGetErrorText* = proc(
  para1: PDisplay, para2: cint, para3: cstring, para4: cint
): cint {.cdecl, raises: [].}

type x11_XGetFontProperty* =
  proc(para1: PXFontStruct, para2: Atom, para3: Pculong): XBool {.cdecl, raises: [].}

type x11_XGetGCValues* = proc(
  para1: PDisplay, para2: GC, para3: culong, para4: PXGCValues
): Status {.cdecl, raises: [].}

type x11_XGetGeometry* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: PWindow,
  para4: Pcint,
  para5: Pcint,
  para6: Pcuint,
  para7: Pcuint,
  para8: Pcuint,
  para9: Pcuint,
): Status {.cdecl, raises: [].}

type x11_XGetIconName* =
  proc(para1: PDisplay, para2: Window, para3: PPchar): Status {.cdecl, raises: [].}

type x11_XGetInputFocus* =
  proc(para1: PDisplay, para2: PWindow, para3: Pcint): cint {.cdecl, raises: [].}

type x11_XGetKeyboardControl* =
  proc(para1: PDisplay, para2: PXKeyboardState): cint {.cdecl, raises: [].}

type x11_XGetPointerMapping* =
  proc(para1: PDisplay, para2: Pcuchar, para3: cint): cint {.cdecl, raises: [].}

type x11_XGetScreenSaver* = proc(
  para1: PDisplay, para2: Pcint, para3: Pcint, para4: Pcint, para5: Pcint
): cint {.cdecl, raises: [].}

type x11_XGetTransientForHint* =
  proc(para1: PDisplay, para2: Window, para3: PWindow): Status {.cdecl, raises: [].}

type x11_XGetWindowProperty* = proc(
  para1: PDisplay,
  para2: Window,
  para3: Atom,
  para4: clong,
  para5: clong,
  para6: XBool,
  para7: Atom,
  para8: PAtom,
  para9: Pcint,
  para10: Pculong,
  para11: Pculong,
  para12: PPcuchar,
): cint {.cdecl, raises: [].}

type x11_XGetWindowAttributes* = proc(
  para1: PDisplay, para2: Window, para3: PXWindowAttributes
): Status {.cdecl, raises: [].}

type x11_XGrabButton* = proc(
  para1: PDisplay,
  para2: cuint,
  para3: cuint,
  para4: Window,
  para5: XBool,
  para6: cuint,
  para7: cint,
  para8: cint,
  para9: Window,
  para10: Cursor,
): cint {.cdecl, raises: [].}

type x11_XGrabKey* = proc(
  para1: PDisplay,
  para2: cint,
  para3: cuint,
  para4: Window,
  para5: XBool,
  para6: cint,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XGrabKeyboard* = proc(
  para1: PDisplay, para2: Window, para3: XBool, para4: cint, para5: cint, para6: Time
): cint {.cdecl, raises: [].}

type x11_XGrabPointer* = proc(
  para1: PDisplay,
  para2: Window,
  para3: XBool,
  para4: cuint,
  para5: cint,
  para6: cint,
  para7: Window,
  para8: Cursor,
  para9: Time,
): cint {.cdecl, raises: [].}

type x11_XGrabServer* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XHeightOfScreen* = proc(para1: PScreen): cint {.cdecl, raises: [].}
type x11_XImageByteOrder* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XKeysymToKeycode* =
  proc(para1: PDisplay, para2: KeySym): KeyCode {.cdecl, raises: [].}

type x11_XLookupColor* = proc(
  para1: PDisplay, para2: Colormap, para3: cstring, para4: PXColor, para5: PXColor
): Status {.cdecl, raises: [].}

type x11_XLowerWindow* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XMapSubwindows* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XMaskEvent* =
  proc(para1: PDisplay, para2: clong, para3: PXEvent): cint {.cdecl, raises: [].}

type x11_XMinCmapsOfScreen* = proc(para1: PScreen): cint {.cdecl, raises: [].}
type x11_XMoveWindow* = proc(
  para1: PDisplay, para2: Window, para3: cint, para4: cint
): cint {.cdecl, raises: [].}

type x11_XNextEvent* = proc(para1: PDisplay, para2: PXEvent): cint {.cdecl, raises: [].}
type x11_XParseColor* = proc(
  para1: PDisplay, para2: Colormap, para3: cstring, para4: PXColor
): Status {.cdecl, raises: [].}

type x11_XParseGeometry* = proc(
  para1: cstring, para2: Pcint, para3: Pcint, para4: Pcuint, para5: Pcuint
): cint {.cdecl, raises: [].}

type x11_XPeekEvent* = proc(para1: PDisplay, para2: PXEvent): cint {.cdecl, raises: [].}
type x11_XPending* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XProtocolRevision* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XPutBackEvent* =
  proc(para1: PDisplay, para2: PXEvent): cint {.cdecl, raises: [].}

type x11_XQLength* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XQueryBestSize* = proc(
  para1: PDisplay,
  para2: cint,
  para3: Drawable,
  para4: cuint,
  para5: cuint,
  para6: Pcuint,
  para7: Pcuint,
): Status {.cdecl, raises: [].}

type x11_XQueryBestStipple* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: cuint,
  para4: cuint,
  para5: Pcuint,
  para6: Pcuint,
): Status {.cdecl, raises: [].}

type x11_XQueryBestTile* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: cuint,
  para4: cuint,
  para5: Pcuint,
  para6: Pcuint,
): Status {.cdecl, raises: [].}

type x11_XQueryColor* =
  proc(para1: PDisplay, para2: Colormap, para3: PXColor): cint {.cdecl, raises: [].}

type x11_XQueryColors* = proc(
  para1: PDisplay, para2: Colormap, para3: PXColor, para4: cint
): cint {.cdecl, raises: [].}

type x11_XQueryExtension* = proc(
  para1: PDisplay, para2: cstring, para3: Pcint, para4: Pcint, para5: Pcint
): XBool {.cdecl, raises: [].}

type x11_XQueryKeymap* =
  proc(para1: PDisplay, para2: chararr32): cint {.cdecl, raises: [].}

type x11_XQueryTextExtents* = proc(
  para1: PDisplay,
  para2: XID,
  para3: cstring,
  para4: cint,
  para5: Pcint,
  para6: Pcint,
  para7: Pcint,
  para8: PXCharStruct,
): cint {.cdecl, raises: [].}

type x11_XQueryTextExtents16* = proc(
  para1: PDisplay,
  para2: XID,
  para3: PXChar2b,
  para4: cint,
  para5: Pcint,
  para6: Pcint,
  para7: Pcint,
  para8: PXCharStruct,
): cint {.cdecl, raises: [].}

type x11_XQueryTree* = proc(
  para1: PDisplay,
  para2: Window,
  para3: PWindow,
  para4: PWindow,
  para5: PPWindow,
  para6: Pcuint,
): Status {.cdecl, raises: [].}

type x11_XRaiseWindow* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XReadBitmapFileData* = proc(
  para1: cstring,
  para2: Pcuint,
  para3: Pcuint,
  para4: PPcuchar,
  para5: Pcint,
  para6: Pcint,
): cint {.cdecl, raises: [].}

type x11_XRebindKeysym* = proc(
  para1: PDisplay,
  para2: KeySym,
  para3: PKeySym,
  para4: cint,
  para5: Pcuchar,
  para6: cint,
): cint {.cdecl, raises: [].}

type x11_XRecolorCursor* = proc(
  para1: PDisplay, para2: Cursor, para3: PXColor, para4: PXColor
): cint {.cdecl, raises: [].}

type x11_XRefreshKeyboardMapping* =
  proc(para1: PXMappingEvent): cint {.cdecl, raises: [].}

type x11_XRemoveHost* =
  proc(para1: PDisplay, para2: PXHostAddress): cint {.cdecl, raises: [].}

type x11_XReparentWindow* = proc(
  para1: PDisplay, para2: Window, para3: Window, para4: cint, para5: cint
): cint {.cdecl, raises: [].}

type x11_XResetScreenSaver* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XRestackWindows* =
  proc(para1: PDisplay, para2: PWindow, para3: cint): cint {.cdecl, raises: [].}

type x11_XRotateBuffers* =
  proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}

type x11_XScreenCount* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XSendEvent* = proc(
  para1: PDisplay, para2: Window, para3: XBool, para4: clong, para5: PXEvent
): Status {.cdecl, raises: [].}

type x11_XSetAccessControl* =
  proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}

type x11_XSetBackground* =
  proc(para1: PDisplay, para2: GC, para3: culong): cint {.cdecl, raises: [].}

type x11_XSetClipOrigin* =
  proc(para1: PDisplay, para2: GC, para3: cint, para4: cint): cint {.cdecl, raises: [].}

type x11_XSetClipRectangles* = proc(
  para1: PDisplay,
  para2: GC,
  para3: cint,
  para4: cint,
  para5: PXRectangle,
  para6: cint,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XSetCloseDownMode* =
  proc(para1: PDisplay, para2: cint): cint {.cdecl, raises: [].}

type x11_XSetDashes* = proc(
  para1: PDisplay, para2: GC, para3: cint, para4: cstring, para5: cint
): cint {.cdecl, raises: [].}

type x11_XSetFillRule* =
  proc(para1: PDisplay, para2: GC, para3: cint): cint {.cdecl, raises: [].}

type x11_XSetFont* =
  proc(para1: PDisplay, para2: GC, para3: Font): cint {.cdecl, raises: [].}

type x11_XSetForeground* =
  proc(para1: PDisplay, para2: GC, para3: culong): cint {.cdecl, raises: [].}

type x11_XSetGraphicsExposures* =
  proc(para1: PDisplay, para2: GC, para3: XBool): cint {.cdecl, raises: [].}

type x11_XSetIconName* =
  proc(para1: PDisplay, para2: Window, para3: cstring): cint {.cdecl, raises: [].}

type x11_XSetInputFocus* = proc(
  para1: PDisplay, para2: Window, para3: cint, para4: Time
): cint {.cdecl, raises: [].}

type x11_XSetLineAttributes* = proc(
  para1: PDisplay, para2: GC, para3: cuint, para4: cint, para5: cint, para6: cint
): cint {.cdecl, raises: [].}

type x11_XSetModifierMapping* =
  proc(para1: PDisplay, para2: PXModifierKeymap): cint {.cdecl, raises: [].}

type x11_XSetPlaneMask* =
  proc(para1: PDisplay, para2: GC, para3: culong): cint {.cdecl, raises: [].}

type x11_XSetScreenSaver* = proc(
  para1: PDisplay, para2: cint, para3: cint, para4: cint, para5: cint
): cint {.cdecl, raises: [].}

type x11_XSetSelectionOwner* = proc(
  para1: PDisplay, para2: Atom, para3: Window, para4: Time
): cint {.cdecl, raises: [].}

type x11_XSetState* = proc(
  para1: PDisplay, para2: GC, para3: culong, para4: culong, para5: cint, para6: culong
): cint {.cdecl, raises: [].}

type x11_XSetStipple* =
  proc(para1: PDisplay, para2: GC, para3: Pixmap): cint {.cdecl, raises: [].}

type x11_XSetTSOrigin* =
  proc(para1: PDisplay, para2: GC, para3: cint, para4: cint): cint {.cdecl, raises: [].}

type x11_XSetTile* =
  proc(para1: PDisplay, para2: GC, para3: Pixmap): cint {.cdecl, raises: [].}

type x11_XSetWindowBackgroundPixmap* =
  proc(para1: PDisplay, para2: Window, para3: Pixmap): cint {.cdecl, raises: [].}

type x11_XSetWindowBorder* =
  proc(para1: PDisplay, para2: Window, para3: culong): cint {.cdecl, raises: [].}

type x11_XSetWindowBorderPixmap* =
  proc(para1: PDisplay, para2: Window, para3: Pixmap): cint {.cdecl, raises: [].}

type x11_XSetWindowBorderWidth* =
  proc(para1: PDisplay, para2: Window, para3: cuint): cint {.cdecl, raises: [].}

type x11_XSetWindowColormap* =
  proc(para1: PDisplay, para2: Window, para3: Colormap): cint {.cdecl, raises: [].}

type x11_XStoreBuffer* = proc(
  para1: PDisplay, para2: cstring, para3: cint, para4: cint
): cint {.cdecl, raises: [].}

type x11_XStoreBytes* =
  proc(para1: PDisplay, para2: cstring, para3: cint): cint {.cdecl, raises: [].}

type x11_XStoreColors* = proc(
  para1: PDisplay, para2: Colormap, para3: PXColor, para4: cint
): cint {.cdecl, raises: [].}

type x11_XStoreName* =
  proc(para1: PDisplay, para2: Window, para3: cstring): cint {.cdecl, raises: [].}

type x11_XSync* = proc(para1: PDisplay, para2: XBool): cint {.cdecl, raises: [].}
type x11_XTextExtents16* = proc(
  para1: PXFontStruct,
  para2: PXChar2b,
  para3: cint,
  para4: Pcint,
  para5: Pcint,
  para6: Pcint,
  para7: PXCharStruct,
): cint {.cdecl, raises: [].}

type x11_XTextWidth* =
  proc(para1: PXFontStruct, para2: cstring, para3: cint): cint {.cdecl, raises: [].}

type x11_XTranslateCoordinates* = proc(
  para1: PDisplay,
  para2: Window,
  para3: Window,
  para4: cint,
  para5: cint,
  para6: Pcint,
  para7: Pcint,
  para8: PWindow,
): XBool {.cdecl, raises: [].}

type x11_XUndefineCursor* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XUngrabKey* = proc(
  para1: PDisplay, para2: cint, para3: cuint, para4: Window
): cint {.cdecl, raises: [].}

type x11_XUngrabKeyboard* =
  proc(para1: PDisplay, para2: Time): cint {.cdecl, raises: [].}

type x11_XUngrabServer* = proc(para1: PDisplay): cint {.cdecl, raises: [].}
type x11_XUnloadFont* = proc(para1: PDisplay, para2: Font): cint {.cdecl, raises: [].}
type x11_XUnmapWindow* =
  proc(para1: PDisplay, para2: Window): cint {.cdecl, raises: [].}

type x11_XWarpPointer* = proc(
  para1: PDisplay,
  para2: Window,
  para3: Window,
  para4: cint,
  para5: cint,
  para6: cuint,
  para7: cuint,
  para8: cint,
  para9: cint,
): cint {.cdecl, raises: [].}

type x11_XWidthMMOfScreen* = proc(para1: PScreen): cint {.cdecl, raises: [].}
type x11_XWindowEvent* = proc(
  para1: PDisplay, para2: Window, para3: clong, para4: PXEvent
): cint {.cdecl, raises: [].}

type x11_XWriteBitmapFile* = proc(
  para1: PDisplay,
  para2: cstring,
  para3: Pixmap,
  para4: cuint,
  para5: cuint,
  para6: cint,
  para7: cint,
): cint {.cdecl, raises: [].}

type x11_XSupportsLocale* = proc(): XBool {.cdecl, raises: [].}
type x11_XOpenOM* = proc(
  para1: PDisplay, para2: PXrmHashBucketRec, para3: cstring, para4: cstring
): XOM {.cdecl, raises: [].}

type x11_XCloseOM* = proc(para1: XOM): Status {.cdecl, varargs, raises: [].}
type x11_XGetOMValues* = proc(para1: XOM): cstring {.cdecl, varargs, raises: [].}
type x11_XLocaleOfOM* = proc(para1: XOM): cstring {.cdecl, varargs, raises: [].}
type x11_XDestroyOC* = proc(para1: XOC) {.cdecl, raises: [].}
type x11_XSetOCValues* = proc(para1: XOC): cstring {.cdecl, varargs, raises: [].}
type x11_XCreateFontSet* = proc(
  para1: PDisplay, para2: cstring, para3: PPPchar, para4: Pcint, para5: PPchar
): XFontSet {.cdecl, raises: [].}

type x11_XFreeFontSet* = proc(para1: PDisplay, para2: XFontSet) {.cdecl, raises: [].}
type x11_XBaseFontNameListOfFontSet* =
  proc(para1: XFontSet): cstring {.cdecl, raises: [].}

type x11_XContextDependentDrawing* = proc(para1: XFontSet): XBool {.cdecl, raises: [].}
type x11_XContextualDrawing* = proc(para1: XFontSet): XBool {.cdecl, raises: [].}
type x11_XmbTextEscapement* =
  proc(para1: XFontSet, para2: cstring, para3: cint): cint {.cdecl, raises: [].}

type x11_XwcTextEscapement* =
  proc(para1: XFontSet, para2: PWideChar, para3: cint): cint {.cdecl, raises: [].}

type x11_Xutf8TextEscapement* =
  proc(para1: XFontSet, para2: cstring, para3: cint): cint {.cdecl, raises: [].}

type x11_XmbTextExtents* = proc(
  para1: XFontSet, para2: cstring, para3: cint, para4: PXRectangle, para5: PXRectangle
): cint {.cdecl, raises: [].}

type x11_XwcTextExtents* = proc(
  para1: XFontSet, para2: PWideChar, para3: cint, para4: PXRectangle, para5: PXRectangle
): cint {.cdecl, raises: [].}

type x11_Xutf8TextExtents* = proc(
  para1: XFontSet, para2: cstring, para3: cint, para4: PXRectangle, para5: PXRectangle
): cint {.cdecl, raises: [].}

type x11_XmbTextPerCharExtents* = proc(
  para1: XFontSet,
  para2: cstring,
  para3: cint,
  para4: PXRectangle,
  para5: PXRectangle,
  para6: cint,
  para7: Pcint,
  para8: PXRectangle,
  para9: PXRectangle,
): Status {.cdecl, raises: [].}

type x11_XwcTextPerCharExtents* = proc(
  para1: XFontSet,
  para2: PWideChar,
  para3: cint,
  para4: PXRectangle,
  para5: PXRectangle,
  para6: cint,
  para7: Pcint,
  para8: PXRectangle,
  para9: PXRectangle,
): Status {.cdecl, raises: [].}

type x11_Xutf8TextPerCharExtents* = proc(
  para1: XFontSet,
  para2: cstring,
  para3: cint,
  para4: PXRectangle,
  para5: PXRectangle,
  para6: cint,
  para7: Pcint,
  para8: PXRectangle,
  para9: PXRectangle,
): Status {.cdecl, raises: [].}

type x11_XmbDrawText* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXmbTextItem,
  para7: cint,
) {.cdecl, raises: [].}

type x11_XwcDrawText* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXwcTextItem,
  para7: cint,
) {.cdecl, raises: [].}

type x11_Xutf8DrawText* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: GC,
  para4: cint,
  para5: cint,
  para6: PXmbTextItem,
  para7: cint,
) {.cdecl, raises: [].}

type x11_XmbDrawString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: XFontSet,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: cstring,
  para8: cint,
) {.cdecl, raises: [].}

type x11_XwcDrawString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: XFontSet,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: PWideChar,
  para8: cint,
) {.cdecl, raises: [].}

type x11_Xutf8DrawString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: XFontSet,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: cstring,
  para8: cint,
) {.cdecl, raises: [].}

type x11_XmbDrawImageString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: XFontSet,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: cstring,
  para8: cint,
) {.cdecl, raises: [].}

type x11_XwcDrawImageString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: XFontSet,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: PWideChar,
  para8: cint,
) {.cdecl, raises: [].}

type x11_Xutf8DrawImageString* = proc(
  para1: PDisplay,
  para2: Drawable,
  para3: XFontSet,
  para4: GC,
  para5: cint,
  para6: cint,
  para7: cstring,
  para8: cint,
) {.cdecl, raises: [].}

type x11_XOpenIM* = proc(
  para1: PDisplay, para2: PXrmHashBucketRec, para3: cstring, para4: cstring
): XIM {.cdecl, raises: [].}

type x11_XCloseIM* = proc(para1: XIM): Status {.cdecl, varargs, raises: [].}
type x11_XSetIMValues* = proc(para1: XIM): cstring {.cdecl, varargs, raises: [].}
type x11_XLocaleOfIM* = proc(para1: XIM): cstring {.cdecl, varargs, raises: [].}
type x11_XDestroyIC* = proc(para1: XIC) {.cdecl, raises: [].}
type x11_XUnsetICFocus* = proc(para1: XIC) {.cdecl, raises: [].}
type x11_XmbResetIC* = proc(para1: XIC): cstring {.cdecl, raises: [].}
type x11_XSetICValues* = proc(para1: XIC): cstring {.cdecl, varargs, raises: [].}
type x11_XIMOfIC* = proc(para1: XIC): XIM {.cdecl, raises: [].}
type x11_XmbLookupString* = proc(
  para1: XIC,
  para2: PXKeyPressedEvent,
  para3: cstring,
  para4: cint,
  para5: PKeySym,
  para6: PStatus,
): cint {.cdecl, raises: [].}

type x11_XwcLookupString* = proc(
  para1: XIC,
  para2: PXKeyPressedEvent,
  para3: PWideChar,
  para4: cint,
  para5: PKeySym,
  para6: PStatus,
): cint {.cdecl, raises: [].}

type x11_Xutf8LookupString* = proc(
  para1: XIC,
  para2: PXKeyPressedEvent,
  para3: cstring,
  para4: cint,
  para5: PKeySym,
  para6: PStatus,
): cint {.cdecl, raises: [].}

type x11_XVaCreateNestedList* =
  proc(unused: cint): XVaNestedList {.cdecl, varargs, raises: [].}

type x11_XUnregisterIMInstantiateCallback* = proc(
  para1: PDisplay,
  para2: PXrmHashBucketRec,
  para3: cstring,
  para4: cstring,
  para5: XIDProc,
  para6: XPointer,
): XBool {.cdecl, raises: [].}

type x11_XInternalConnectionNumbers* =
  proc(para1: PDisplay, para2: PPcint, para3: Pcint): Status {.cdecl, raises: [].}

type x11_XProcessInternalConnection* =
  proc(para1: PDisplay, para2: cint) {.cdecl, raises: [].}

type x11_XRemoveConnectionWatch* = proc(
  para1: PDisplay, para2: XConnectionWatchProc, para3: XPointer
) {.cdecl, raises: [].}

type x11_XSetAuthorization* =
  proc(para1: cstring, para2: cint, para3: cstring, para4: cint) {.cdecl, raises: [].}

type x11_XGetEventData* =
  proc(para1: PDisplay, para2: PXGenericEventCookie): XBool {.cdecl, raises: [].}

type x11_XAllocClassHint* = proc(): PXClassHint {.cdecl, raises: [].}
type x11_XAllocSizeHints* = proc(): PXSizeHints {.cdecl, raises: [].}
type x11_XAllocWMHints* = proc(): PXWMHints {.cdecl, raises: [].}
type x11_XCreateRegion* = proc(): Region {.cdecl, raises: [].}
type x11_XDeleteContext* =
  proc(para1: PDisplay, para2: XID, para3: XContext): cint {.cdecl, raises: [].}

type x11_XDestroyRegion* = proc(para1: Region): cint {.cdecl, raises: [].}
type x11_XEqualRegion* = proc(para1: Region, para2: Region): cint {.cdecl, raises: [].}
type x11_XFindContext* = proc(
  para1: PDisplay, para2: XID, para3: XContext, para4: PXPointer
): cint {.cdecl, raises: [].}

type x11_XGetClassHint* =
  proc(para1: PDisplay, para2: Window, para3: PXClassHint): Status {.cdecl, raises: [].}

type x11_XGetIconSizes* = proc(
  para1: PDisplay, para2: Window, para3: PPXIconSize, para4: Pcint
): Status {.cdecl, raises: [].}

type x11_XGetNormalHints* =
  proc(para1: PDisplay, para2: Window, para3: PXSizeHints): Status {.cdecl, raises: [].}

type x11_XGetRGBColormaps* = proc(
  para1: PDisplay, para2: Window, para3: PPXStandardColormap, para4: Pcint, para5: Atom
): Status {.cdecl, raises: [].}

type x11_XGetSizeHints* = proc(
  para1: PDisplay, para2: Window, para3: PXSizeHints, para4: Atom
): Status {.cdecl, raises: [].}

type x11_XGetStandardColormap* = proc(
  para1: PDisplay, para2: Window, para3: PXStandardColormap, para4: Atom
): Status {.cdecl, raises: [].}

type x11_XGetTextProperty* = proc(
  para1: PDisplay, para2: Window, para3: PXTextProperty, para4: Atom
): Status {.cdecl, raises: [].}

type x11_XGetVisualInfo* = proc(
  para1: PDisplay, para2: clong, para3: PXVisualInfo, para4: Pcint
): PXVisualInfo {.cdecl, raises: [].}

type x11_XGetWMClientMachine* = proc(
  para1: PDisplay, para2: Window, para3: PXTextProperty
): Status {.cdecl, raises: [].}

type x11_XGetWMHints* =
  proc(para1: PDisplay, para2: Window): PXWMHints {.cdecl, raises: [].}

type x11_XGetWMIconName* = proc(
  para1: PDisplay, para2: Window, para3: PXTextProperty
): Status {.cdecl, raises: [].}

type x11_XGetWMName* = proc(
  para1: PDisplay, para2: Window, para3: PXTextProperty
): Status {.cdecl, raises: [].}

type x11_XGetWMNormalHints* = proc(
  para1: PDisplay, para2: Window, para3: PXSizeHints, para4: ptr int
): Status {.cdecl, raises: [].}

type x11_XGetWMSizeHints* = proc(
  para1: PDisplay, para2: Window, para3: PXSizeHints, para4: ptr int, para5: Atom
): Status {.cdecl, raises: [].}

type x11_XGetZoomHints* =
  proc(para1: PDisplay, para2: Window, para3: PXSizeHints): Status {.cdecl, raises: [].}

type x11_XIntersectRegion* =
  proc(para1: Region, para2: Region, para3: Region): cint {.cdecl, raises: [].}

type x11_XConvertCase* =
  proc(para1: KeySym, para2: PKeySym, para3: PKeySym) {.cdecl, raises: [].}

type x11_XLookupString* = proc(
  para1: PXKeyEvent, para2: cstring, para3: cint, para4: PKeySym, para5: PXComposeStatus
): cint {.cdecl, raises: [].}

type x11_XMatchVisualInfo* = proc(
  para1: PDisplay, para2: cint, para3: cint, para4: cint, para5: PXVisualInfo
): Status {.cdecl, raises: [].}

type x11_XOffsetRegion* =
  proc(para1: Region, para2: cint, para3: cint): cint {.cdecl, raises: [].}

type x11_XPointInRegion* =
  proc(para1: Region, para2: cint, para3: cint): XBool {.cdecl, raises: [].}

type x11_XPolygonRegion* =
  proc(para1: PXPoint, para2: cint, para3: cint): Region {.cdecl, raises: [].}

type x11_XRectInRegion* = proc(
  para1: Region, para2: cint, para3: cint, para4: cuint, para5: cuint
): cint {.cdecl, raises: [].}

type x11_XSaveContext* = proc(
  para1: PDisplay, para2: XID, para3: XContext, para4: cstring
): cint {.cdecl, raises: [].}

type x11_XSetClassHint* =
  proc(para1: PDisplay, para2: Window, para3: PXClassHint): cint {.cdecl, raises: [].}

type x11_XSetIconSizes* = proc(
  para1: PDisplay, para2: Window, para3: PXIconSize, para4: cint
): cint {.cdecl, raises: [].}

type x11_XSetNormalHints* =
  proc(para1: PDisplay, para2: Window, para3: PXSizeHints): cint {.cdecl, raises: [].}

type x11_XSetRGBColormaps* = proc(
  para1: PDisplay, para2: Window, para3: PXStandardColormap, para4: cint, para5: Atom
) {.cdecl, raises: [].}

type x11_XSetSizeHints* = proc(
  para1: PDisplay, para2: Window, para3: PXSizeHints, para4: Atom
): cint {.cdecl, raises: [].}

type x11_XSetStandardProperties* = proc(
  para1: PDisplay,
  para2: Window,
  para3: cstring,
  para4: cstring,
  para5: Pixmap,
  para6: PPchar,
  para7: cint,
  para8: PXSizeHints,
): cint {.cdecl, raises: [].}

type x11_XSetTextProperty* = proc(
  para1: PDisplay, para2: Window, para3: PXTextProperty, para4: Atom
) {.cdecl, raises: [].}

type x11_XSetWMClientMachine* =
  proc(para1: PDisplay, para2: Window, para3: PXTextProperty) {.cdecl, raises: [].}

type x11_XSetWMHints* =
  proc(para1: PDisplay, para2: Window, para3: PXWMHints): cint {.cdecl, raises: [].}

type x11_XSetWMIconName* =
  proc(para1: PDisplay, para2: Window, para3: PXTextProperty) {.cdecl, raises: [].}

type x11_XSetWMName* =
  proc(para1: PDisplay, para2: Window, para3: PXTextProperty) {.cdecl, raises: [].}

type x11_XSetWMNormalHints* =
  proc(para1: PDisplay, para2: Window, para3: PXSizeHints) {.cdecl, raises: [].}

type x11_XSetWMProperties* = proc(
  para1: PDisplay,
  para2: Window,
  para3: PXTextProperty,
  para4: PXTextProperty,
  para5: PPchar,
  para6: cint,
  para7: PXSizeHints,
  para8: PXWMHints,
  para9: PXClassHint,
) {.cdecl, raises: [].}

type x11_XmbSetWMProperties* = proc(
  para1: PDisplay,
  para2: Window,
  para3: cstring,
  para4: cstring,
  para5: PPchar,
  para6: cint,
  para7: PXSizeHints,
  para8: PXWMHints,
  para9: PXClassHint,
) {.cdecl, raises: [].}

type x11_Xutf8SetWMProperties* = proc(
  para1: PDisplay,
  para2: Window,
  para3: cstring,
  para4: cstring,
  para5: PPchar,
  para6: cint,
  para7: PXSizeHints,
  para8: PXWMHints,
  para9: PXClassHint,
) {.cdecl, raises: [].}

type x11_XSetWMSizeHints* = proc(
  para1: PDisplay, para2: Window, para3: PXSizeHints, para4: Atom
) {.cdecl, raises: [].}

type x11_XSetRegion* =
  proc(para1: PDisplay, para2: GC, para3: Region): cint {.cdecl, raises: [].}

type x11_XSetStandardColormap* = proc(
  para1: PDisplay, para2: Window, para3: PXStandardColormap, para4: Atom
) {.cdecl, raises: [].}

type x11_XSetZoomHints* =
  proc(para1: PDisplay, para2: Window, para3: PXSizeHints): cint {.cdecl, raises: [].}

type x11_XShrinkRegion* =
  proc(para1: Region, para2: cint, para3: cint): cint {.cdecl, raises: [].}

type x11_XStringListToTextProperty* =
  proc(para1: PPchar, para2: cint, para3: PXTextProperty): Status {.cdecl, raises: [].}

type x11_XSubtractRegion* =
  proc(para1: Region, para2: Region, para3: Region): cint {.cdecl, raises: [].}

type x11_XmbTextListToTextProperty* = proc(
  para1: PDisplay,
  para2: PPchar,
  para3: cint,
  para4: XICCEncodingStyle,
  para5: PXTextProperty,
): cint {.cdecl, raises: [].}

type x11_XwcTextListToTextProperty* = proc(
  para1: PDisplay,
  para2: ptr ptr int16,
  para3: cint,
  para4: XICCEncodingStyle,
  para5: PXTextProperty,
): cint {.cdecl, raises: [].}

type x11_Xutf8TextListToTextProperty* = proc(
  para1: PDisplay,
  para2: PPchar,
  para3: cint,
  para4: XICCEncodingStyle,
  para5: PXTextProperty,
): cint {.cdecl, raises: [].}

type x11_XwcFreeStringList* = proc(para1: ptr ptr int16) {.cdecl, raises: [].}
type x11_XmbTextPropertyToTextList* = proc(
  para1: PDisplay, para2: PXTextProperty, para3: PPPchar, para4: Pcint
): cint {.cdecl, raises: [].}

type x11_XwcTextPropertyToTextList* = proc(
  para1: PDisplay, para2: PXTextProperty, para3: ptr ptr ptr int16, para4: Pcint
): cint {.cdecl, raises: [].}

type x11_Xutf8TextPropertyToTextList* = proc(
  para1: PDisplay, para2: PXTextProperty, para3: PPPchar, para4: Pcint
): cint {.cdecl, raises: [].}

type x11_XUnionRectWithRegion* =
  proc(para1: PXRectangle, para2: Region, para3: Region): cint {.cdecl, raises: [].}

type x11_XUnionRegion* =
  proc(para1: Region, para2: Region, para3: Region): cint {.cdecl, raises: [].}

type x11_XWMGeometry* = proc(
  para1: PDisplay,
  para2: cint,
  para3: cstring,
  para4: cstring,
  para5: cuint,
  para6: PXSizeHints,
  para7: Pcint,
  para8: Pcint,
  para9: Pcint,
  para10: Pcint,
  para11: Pcint,
): cint {.cdecl, raises: [].}

type x11_XXorRegion* =
  proc(para1: Region, para2: Region, para3: Region): cint {.cdecl, raises: [].}

## Pure Xlib helpers.
#when defined(MACROS):
proc ConnectionNumber*(dpy: PDisplay): cint
proc RootWindow*(dpy: PDisplay, scr: cint): Window
proc DefaultScreen*(dpy: PDisplay): cint
proc DefaultRootWindow*(dpy: PDisplay): Window
proc DefaultVisual*(dpy: PDisplay, scr: cint): PVisual
proc DefaultGC*(dpy: PDisplay, scr: cint): GC
proc BlackPixel*(dpy: PDisplay, scr: cint): culong
proc WhitePixel*(dpy: PDisplay, scr: cint): culong
proc QLength*(dpy: PDisplay): cint
proc DisplayWidth*(dpy: PDisplay, scr: cint): cint
proc DisplayHeight*(dpy: PDisplay, scr: cint): cint
proc DisplayWidthMM*(dpy: PDisplay, scr: cint): cint
proc DisplayHeightMM*(dpy: PDisplay, scr: cint): cint
proc DisplayPlanes*(dpy: PDisplay, scr: cint): cint
proc DisplayCells*(dpy: PDisplay, scr: cint): cint
proc ScreenCount*(dpy: PDisplay): cint
proc ServerVendor*(dpy: PDisplay): cstring
proc ProtocolVersion*(dpy: PDisplay): cint
proc ProtocolRevision*(dpy: PDisplay): cint
proc VendorRelease*(dpy: PDisplay): cint
proc DisplayString*(dpy: PDisplay): cstring
proc DefaultDepth*(dpy: PDisplay, scr: cint): cint
proc DefaultColormap*(dpy: PDisplay, scr: cint): Colormap
proc BitmapUnit*(dpy: PDisplay): cint
proc BitmapBitOrder*(dpy: PDisplay): cint
proc BitmapPad*(dpy: PDisplay): cint
proc ImageByteOrder*(dpy: PDisplay): cint
proc NextRequest*(dpy: PDisplay): culong
proc LastKnownRequestProcessed*(dpy: PDisplay): culong
proc ScreenOfDisplay*(dpy: PDisplay, scr: cint): PScreen
proc DefaultScreenOfDisplay*(dpy: PDisplay): PScreen
proc DisplayOfScreen*(s: PScreen): PDisplay
proc RootWindowOfScreen*(s: PScreen): Window
proc BlackPixelOfScreen*(s: PScreen): culong
proc WhitePixelOfScreen*(s: PScreen): culong
proc DefaultColormapOfScreen*(s: PScreen): Colormap
proc DefaultDepthOfScreen*(s: PScreen): cint
proc DefaultGCOfScreen*(s: PScreen): GC
proc DefaultVisualOfScreen*(s: PScreen): PVisual
proc WidthOfScreen*(s: PScreen): cint
proc HeightOfScreen*(s: PScreen): cint
proc WidthMMOfScreen*(s: PScreen): cint
proc HeightMMOfScreen*(s: PScreen): cint
proc PlanesOfScreen*(s: PScreen): cint
proc CellsOfScreen*(s: PScreen): cint
proc MinCmapsOfScreen*(s: PScreen): cint
proc MaxCmapsOfScreen*(s: PScreen): cint
proc DoesSaveUnders*(s: PScreen): XBool
proc DoesBackingStore*(s: PScreen): cint
proc EventMaskOfScreen*(s: PScreen): clong
proc XAllocID*(dpy: PDisplay): XID
# implementation

#when defined(MACROS):
template privDisp(): untyped =
  cast[PXPrivDisplay](dpy)

proc ConnectionNumber(dpy: PDisplay): cint =
  privDisp.fd

proc RootWindow(dpy: PDisplay, scr: cint): Window =
  ScreenOfDisplay(dpy, scr).root

proc DefaultScreen(dpy: PDisplay): cint =
  privDisp.default_screen

proc DefaultRootWindow(dpy: PDisplay): Window =
  ScreenOfDisplay(dpy, DefaultScreen(dpy)).root

proc DefaultVisual(dpy: PDisplay, scr: cint): PVisual =
  ScreenOfDisplay(dpy, scr).root_visual

proc DefaultGC(dpy: PDisplay, scr: cint): GC =
  ScreenOfDisplay(dpy, scr).default_gc

proc BlackPixel(dpy: PDisplay, scr: cint): culong =
  ScreenOfDisplay(dpy, scr).black_pixel

proc WhitePixel(dpy: PDisplay, scr: cint): culong =
  ScreenOfDisplay(dpy, scr).white_pixel

proc QLength(dpy: PDisplay): cint =
  privDisp.qlen

proc DisplayWidth(dpy: PDisplay, scr: cint): cint =
  ScreenOfDisplay(dpy, scr).width

proc DisplayHeight(dpy: PDisplay, scr: cint): cint =
  ScreenOfDisplay(dpy, scr).height

proc DisplayWidthMM(dpy: PDisplay, scr: cint): cint =
  ScreenOfDisplay(dpy, scr).mwidth

proc DisplayHeightMM(dpy: PDisplay, scr: cint): cint =
  ScreenOfDisplay(dpy, scr).mheight

proc DisplayPlanes(dpy: PDisplay, scr: cint): cint =
  ScreenOfDisplay(dpy, scr).root_depth

proc DisplayCells(dpy: PDisplay, scr: cint): cint =
  DefaultVisual(dpy, scr).map_entries

proc ScreenCount(dpy: PDisplay): cint =
  privDisp.nscreens

proc ServerVendor(dpy: PDisplay): cstring =
  privDisp.vendor

proc ProtocolVersion(dpy: PDisplay): cint =
  privDisp.proto_major_version

proc ProtocolRevision(dpy: PDisplay): cint =
  privDisp.proto_minor_version

proc VendorRelease(dpy: PDisplay): cint =
  privDisp.release

proc DisplayString(dpy: PDisplay): cstring =
  privDisp.display_name

proc DefaultDepth(dpy: PDisplay, scr: cint): cint =
  ScreenOfDisplay(dpy, scr).root_depth

proc DefaultColormap(dpy: PDisplay, scr: cint): Colormap =
  ScreenOfDisplay(dpy, scr).cmap

proc BitmapUnit(dpy: PDisplay): cint =
  privDisp.bitmap_unit

proc BitmapBitOrder(dpy: PDisplay): cint =
  privDisp.bitmap_bit_order

proc BitmapPad(dpy: PDisplay): cint =
  privDisp.bitmap_pad

proc ImageByteOrder(dpy: PDisplay): cint =
  privDisp.byte_order

proc NextRequest(dpy: PDisplay): culong =
  privDisp.request + 1.culong

proc LastKnownRequestProcessed(dpy: PDisplay): culong =
  privDisp.last_request_read

# from fowltek/pointer_arithm, required for ScreenOfDisplay()
proc offset[A](some: ptr A, b: int): ptr A =
  cast[ptr A](cast[int](some) + (b * sizeof(A)))

proc ScreenOfDisplay(dpy: PDisplay, scr: cint): PScreen =
  #addr(((privDisp.screens)[scr]))
  privDisp.screens.offset(scr.int)

proc DefaultScreenOfDisplay(dpy: PDisplay): PScreen =
  ScreenOfDisplay(dpy, DefaultScreen(dpy))

proc DisplayOfScreen(s: PScreen): PDisplay =
  s.display

proc RootWindowOfScreen(s: PScreen): Window =
  s.root

proc BlackPixelOfScreen(s: PScreen): culong =
  s.black_pixel

proc WhitePixelOfScreen(s: PScreen): culong =
  s.white_pixel

proc DefaultColormapOfScreen(s: PScreen): Colormap =
  s.cmap

proc DefaultDepthOfScreen(s: PScreen): cint =
  s.root_depth

proc DefaultGCOfScreen(s: PScreen): GC =
  s.default_gc

proc DefaultVisualOfScreen(s: PScreen): PVisual =
  s.root_visual

proc WidthOfScreen(s: PScreen): cint =
  s.width

proc HeightOfScreen(s: PScreen): cint =
  s.height

proc WidthMMOfScreen(s: PScreen): cint =
  s.mwidth

proc HeightMMOfScreen(s: PScreen): cint =
  s.mheight

proc PlanesOfScreen(s: PScreen): cint =
  s.root_depth

proc CellsOfScreen(s: PScreen): cint =
  DefaultVisualOfScreen(s).map_entries

proc MinCmapsOfScreen(s: PScreen): cint =
  s.min_maps

proc MaxCmapsOfScreen(s: PScreen): cint =
  s.max_maps

proc DoesSaveUnders(s: PScreen): XBool =
  s.save_unders

proc DoesBackingStore(s: PScreen): cint =
  s.backing_store

proc EventMaskOfScreen(s: PScreen): clong =
  s.root_input_mask

proc XAllocID(dpy: PDisplay): XID =
  privDisp.resource_alloc(dpy)
