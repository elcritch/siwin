import unittest, strutils
import opengl, vmath
import siwin

let globals = newSiwinGlobals(
  preferedPlatform = defaultPreferedPlatform()
)

test "OpenGL":
  var g = 1.0
  
  let window = globals.newOpenglWindow(title="OpenGL test", transparent=true)
  loadExtensions()
  let versionPtr = glGetString(GlVersion)
  let versionStr = if versionPtr != nil: $cast[cstring](versionPtr) else: ""
  let isGles = versionStr.find("OpenGL ES") >= 0

  type EsRenderer = object
    program: GlUint
    vbo: GlUint
    attrPos: GlInt
    attrColor: GlInt

  proc compileShader(kind: GlEnum, source: string): GlUint =
    result = glCreateShader(kind)
    var src = source.cstring
    glShaderSource(result, 1, cast[cstringArray](src.addr), nil)
    glCompileShader(result)
    if (var success: GlInt; glGetShaderiv(result, GlCompileStatus, success.addr); success != GlTrue.GlInt):
      var buffer: array[512, char]
      glGetShaderInfoLog(result, 512, nil, cast[cstring](buffer.addr))
      raise ValueError.newException("failed to compile shader: " & $cast[cstring](buffer.addr))

  proc linkProgram(vert, frag: GlUint): GlUint =
    result = glCreateProgram()
    glAttachShader(result, vert)
    glAttachShader(result, frag)
    glLinkProgram(result)
    if (var success: GlInt; glGetProgramiv(result, GlLinkStatus, success.addr); success != GlTrue.GlInt):
      var buffer: array[512, char]
      glGetProgramInfoLog(result, 512, nil, cast[cstring](buffer.addr))
      raise ValueError.newException("failed to link shader program: " & $cast[cstring](buffer.addr))

  proc initEsRenderer(): EsRenderer =
    const
      vertSrc = """
attribute vec2 a_pos;
attribute vec3 a_color;
varying vec3 v_color;
void main() {
  gl_Position = vec4(a_pos, 0.0, 1.0);
  v_color = a_color;
}
"""
      fragSrc = """
precision mediump float;
varying vec3 v_color;
void main() {
  gl_FragColor = vec4(v_color, 1.0);
}
"""
    let vert = compileShader(GlVertexShader, vertSrc)
    let frag = compileShader(GlFragmentShader, fragSrc)
    result.program = linkProgram(vert, frag)
    if vert != 0: glDeleteShader(vert)
    if frag != 0: glDeleteShader(frag)

    result.attrPos = glGetAttribLocation(result.program, "a_pos")
    result.attrColor = glGetAttribLocation(result.program, "a_color")
    if result.attrPos < 0 or result.attrColor < 0:
      raise ValueError.newException("missing attribute in GLES shader")

    glGenBuffers(1, result.vbo.addr)

  var esRenderer: EsRenderer
  var esReady = false
  var esDirty = true
  
  run window, WindowEventsHandler(
    onResize: proc(e: ResizeEvent) =
      glViewport 0, 0, e.size.x.GLsizei, e.size.y.GLsizei
      if not isGles:
        glMatrixMode GlProjection
        glLoadIdentity()
        glOrtho -30, 30, -30, 30, -30, 30
        glMatrixMode GlModelView
    ,
    onRender: proc(e: RenderEvent) =
      glClearColor 0.1, 0.1, 0.1, 0.3
      glClear GlColorBufferBit or GlDepthBufferBit
    
      if isGles:
        if not esReady:
          esRenderer = initEsRenderer()
          esReady = true

        if esDirty:
          var verts: array[15, GlFloat] = [
            -0.5, -0.5, 1 * g, g - 1, g - 1,
             0.5, -0.5, g - 1, 1 * g, g - 1,
            -0.5,  0.5, g - 1, g - 1, 1 * g
          ]
          glBindBuffer GlArrayBuffer, esRenderer.vbo
          glBufferData(GlArrayBuffer, verts.sizeof, verts.addr, GlDynamicDraw)
          esDirty = false

        glUseProgram esRenderer.program
        glBindBuffer GlArrayBuffer, esRenderer.vbo
        glEnableVertexAttribArray esRenderer.attrPos.GlUint
        glEnableVertexAttribArray esRenderer.attrColor.GlUint
        glVertexAttribPointer esRenderer.attrPos.GlUint, 2, cGlFloat, GlFalse, 5 * GlFloat.sizeof, cast[pointer](0)
        glVertexAttribPointer esRenderer.attrColor.GlUint, 3, cGlFloat, GlFalse, 5 * GlFloat.sizeof, cast[pointer](2 * GlFloat.sizeof)
        glDrawArrays GlTriangles, 0, 3
      else:
        glShadeModel GlSmooth
      
        glLoadIdentity()
        glTranslatef -15, -15, 0
      
        glBegin GlTriangles
        glColor3f 1 * g, g - 1, g - 1
        glVertex2f 0, 0
        glColor3f g - 1, 1 * g, g - 1
        glVertex2f 30, 0
        glColor3f g - 1, g - 1, 1 * g
        glVertex2f 0, 30
        glEnd()
    ,
    onKey: proc(e: KeyEvent) =
      if e.pressed:
        case e.key
        of Key.escape:
          close e.window
        of Key.f1:
          e.window.fullscreen = not window.fullscreen
        of Key.f2:
          e.window.maximized = not window.maximized
        of Key.f3:
          e.window.minimized = not window.minimized
        of Key.f4:
          e.window.size = ivec2(300, 300)
        else: discard
    ,
    onClick: proc(e: ClickEvent) =
      if e.double:
        close e.window
      else:
        case e.button
        of MouseButton.left, MouseButton.right:
          g = (e.pos.x / e.window.size.x.float32 * 2).min(2).max(0)
          esDirty = true
          redraw e.window
        of MouseButton.middle:
          e.window.maxSize = ivec2(600, 600)
          e.window.minSize = ivec2(300, 300)
        else: discard
    ,
    onMouseMove: proc(e: MouseMoveEvent) =
      if e.kind == leave: echo "leave: ", e.pos
      if e.kind == MouseMoveKind.enter: echo "enter: ", e.pos
      if MouseButton.left in e.window.mouse.pressed:
        g = (e.pos.x / e.window.size.x.float32 * 2).min(2).max(0)
        esDirty = true
        redraw e.window
    ,
    onStateBoolChanged: proc(e: StateBoolChangedEvent) =
      echo e.kind, ": ", e.value
  )
