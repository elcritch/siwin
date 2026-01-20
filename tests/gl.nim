import macros, tables, strutils
import vmath, opengl, pixie, shady
import siwin/siwindefs

when (compiles do: import imageman):
  import imageman
  const hasImageman* = true
else:
  const hasImageman* = false

export vmath, opengl


type
  Buffers* = ref BuffersObj
  BuffersObj = object
    n: int32
    obj: UncheckedArray[GlUint]

  VertexArrays* = ref VertexArraysObj
  VertexArraysObj = object
    n: int32
    obj: UncheckedArray[GlUint]
  
  Textures* = ref TexturesObj
    ## note: texures can't be actualy deleted for now. glDeleteTextures is not enough. If you want to resize texture, use loadTexture multiple times instead.
  TexturesObj = object
    n: int32
    obj: UncheckedArray[GlUint]
  
  Shader* = ref ShaderObj
  ShaderObj = object
    obj: GlUint

  FrameBuffers* = ref FrameBuffersObj
  FrameBuffersObj = object
    n: int32
    obj: UncheckedArray[GlUint]
  
  ShaderCompileDefect* = object of Defect

  Shape* = ref object
    kind: GlEnum
    len: int
    vao: VertexArrays
    bo: Buffers

  OpenglUniform*[T] = distinct GlInt
  Uniform*[T] = T


  DrawContext* = ref object
    rect*: Shape
    shaders*: Table[int, RootRef]

    px, wh: Vec2
    frameBufferHierarchy: seq[tuple[fbo: GlUint, size: IVec2]]
    offset*: Vec2


# -------- Buffers, VertexArrays, Textures --------
template makeOpenglObjectSeq(t, tobj, T, gen, del, newp, delextra) =
  proc `=destroy`(xobj {.inject.}: tobj) {.siwin_destructor.} =
    delextra
    del(xobj.n, cast[ptr T](xobj.obj.addr))

  proc newp*(n: int): t =
    if n == 0: return
    assert n in 1..int32.high
    unsafeNew result, int32.sizeof + n * T.sizeof
    result.n = n.int32
    gen(n.int32, cast[ptr T](result.obj.addr))

  proc len*(x: t): int =
    if x == nil: 0
    else: x.n

  proc `[]`*(x: t, i: int): T =
    if i notin 0..<x.len:
      raise IndexDefect.newException("index " & $i & " out of range 0..<" & $x.len)
    x.obj[i]


proc unloadTextures(x: TexturesObj) =
  for i in 0..<x.n:
    ## sems like it don't work
    # glBindTexture(GlTexture2d, x.obj[i])
    # glTexImage2D(GlTexture2d, 0, GlRgba.Glint, 0, 0, 0, GlRgba, GlUnsignedByte, nil)


{.push, warning[Effect]: off.}
makeOpenglObjectSeq Buffers, BuffersObj, GlUint, glGenBuffers, glDeleteBuffers, newBuffers: discard
makeOpenglObjectSeq VertexArrays, VertexArraysObj, GlUint, glGenVertexArrays, glDeleteVertexArrays, newVertexArrays: discard
makeOpenglObjectSeq Textures, TexturesObj, GlUint, glGenTextures, glDeleteTextures, newTextures:
  unloadTextures(xobj)
makeOpenglObjectSeq FrameBuffers, FrameBuffersObj, GlUint, glGenFrameBuffers, glDeleteFrameBuffers, newFrameBuffers: discard
{.pop.}

proc `[]`*(x: Textures, i: enum): GlUint =
  if i.int notin 0..<x.len:
    raise IndexDefect.newException("index " & $i & " out of range 0..<" & $x.len)
  x.obj[i.int]

when defined(gcc):
  {.passc: "-fcompare-debug-second".}  # seems like it hides warning about "passing flexieble array ABI changed in GCC 4.4"
  # i don't care, gcc


# -------- helpers --------
proc arrayBufferData*[T](data: openarray[T], usage: GlEnum = GlStaticDraw) =
  glBufferData(GlArrayBuffer, data.len * T.sizeof, data.unsafeaddr, usage)

proc elementArrayBufferData*[T](data: openarray[T], usage: GlEnum = GlStaticDraw) =
  glBufferData(GlElementArrayBuffer, data.len * T.sizeof, data.unsafeaddr, usage)

template withVertexArray*(vao: GlUint, body) =
  glBindVertexArray(vao)
  block: body
  glBindVertexArray(0)

when hasImageman:
  proc loadTexture*(obj: GlUint, img: imageman.Image[ColorRGBAU]) =
    glBindTexture(GlTexture2d, obj)
    glTexImage2D(GlTexture2d, 0, GlRgba.GLint, img.width.GLsizei, img.height.GLsizei, 0, GlRgba, GlUnsignedByte, img.data[0].unsafeaddr)
    glGenerateMipmap(GlTexture2d)
    glBindTexture(GlTexture2d, 0)

proc loadTexture*(obj: GlUint, img: pixie.Image) =
  glBindTexture(GlTexture2d, obj)
  glTexImage2D(GlTexture2d, 0, GlRgba.GLint, img.width.GLsizei, img.height.GLsizei, 0, GlRgba, GlUnsignedByte, img.data[0].unsafeaddr)
  glGenerateMipmap(GlTexture2d)
  glBindTexture(GlTexture2d, 0)



# -------- Shader --------
{.push, warning[Effect]: off.}
proc `=destroy`(x: ShaderObj) {.siwin_destructor.} =
  if x.obj != 0:
    glDeleteProgram(x.obj)
{.pop.}

proc newShader*(shaders: openarray[(GlEnum, string)]): Shader =
  new result

  var shad = newSeq[GlUint](shaders.len)

  proc free =
    for x in shad:
      if x != 0: glDeleteShader(x)

  for i, (k, s) in shaders:
    var cs = s.cstring
    shad[i] = glCreateShader(k)
    glShaderSource(shad[i], 1, cast[cstringArray](cs.addr), nil)
    glCompileShader(shad[i])
    if (var success: GlInt; glGetShaderiv(shad[i], GlCompileStatus, success.addr); success != GlTrue.GlInt):
      var buffer: array[512, char]
      glGetShaderInfoLog(shad[i], 512, nil, cast[cstring](buffer.addr))
      free()
      raise ShaderCompileDefect.newException("failed to compile shader " & $(i+1) & ": " & $cast[cstring](buffer.addr))
  
  defer: free()

  result.obj = glCreateProgram()
  for i, x in shad:
    glAttachShader(result.obj, x)
  glLinkProgram(result.obj)
  if (var success: GlInt; glGetProgramiv(result.obj, GlLinkStatus, success.addr); success != GlTrue.GlInt):
    var buffer: array[512, char]
    glGetProgramInfoLog(result.obj, 512, nil, cast[cstring](buffer.addr))
    # todo: delete gl shader programm?
    raise ShaderCompileDefect.newException("failed to link shader program: " & $cast[cstring](buffer.addr))

proc use*(x: Shader) =
  glUseProgram(x.obj)

proc `[]`*(x: Shader, name: string): GlInt =
  result = glGetUniformLocation(x.obj, name)
  if result == -1:
    raise KeyError.newException("shader has no uniform " & name & " (is it unused?)")

proc `uniform=`*(i: GlInt, value: GlFloat) =
  glUniform1f(i, value)

proc `uniform=`*(i: GlInt, value: Vec2) =
  glUniform2f(i, value.x, value.y)

proc `uniform=`*(i: GlInt, value: Vec3) =
  glUniform3f(i, value.x, value.y, value.z)

proc `uniform=`*(i: GlInt, value: Vec4) =
  glUniform4f(i, value.x, value.y, value.z, value.w)

proc `uniform=`*(i: GlInt, value: Mat4) =
  glUniformMatrix4fv(i, 1, GlFalse, cast[ptr GlFloat](value.unsafeaddr))


proc `uniform=`*[T](x: OpenglUniform[T], value: T) = x.GlInt.uniform = value


# -------- Shape --------
proc makeAttributes(t: type) =
  when t is tuple:
    var i = 0
    var offset = 0
    var x: t
    for x in x.fields:
      type t2 = x.typeof
      glVertexAttribPointer i.uint32, t2.sizeof div GlFloat.sizeof, cGlFloat, GlFalse, t.sizeof.GlSizei, cast[pointer](offset)
      glEnableVertexAttribArray i.uint32
      inc i
      inc offset, t2.sizeof
  else:
    glVertexAttribPointer 0, t.sizeof div GlFloat.sizeof, cGlFloat, GlFalse, t.sizeof.GlSizei, nil
    glEnableVertexAttribArray 0


proc newShape*[T](vert: openarray[T], idx: openarray[GlUint], kind = GlTriangles): Shape =
  new result
  result.vao = newVertexArrays(1)
  result.bo = newBuffers(2)
  result.len = idx.len
  result.kind = kind

  withVertexArray result.vao[0]:
    glBindBuffer GlArrayBuffer, result.bo[0]
    arrayBufferData vert
    glBindBuffer GlElementArrayBuffer, result.bo[1]
    elementArrayBufferData idx
    makeAttributes T

proc draw*(x: Shape) =
  withVertexArray x.vao[0]:
    glDrawElements(x.kind, x.len.GlSizei, GlUnsignedInt, nil)


var newShaderId {.compileTime.}: int = 1

macro makeShader*(ctx: DrawContext, body: untyped): auto =
  ## 
  ## .. code-block:: nim
  ##   let solid = ctx.makeShader:
  ##     {.version: "330 core".}
  ##     proc vert(
  ##       gl_Position: var Vec4,
  ##       pos: var Vec2,
  ##       ipos: Vec2,
  ##       transform: Uniform[Mat4],
  ##       size: Uniform[Vec2],
  ##       px: Uniform[Vec2],
  ##     ) =
  ##       transformation(gl_Position, pos, size, px, ipos, transform)
  ##    
  ##     proc frag(
  ##       glCol: var Vec4,
  ##       pos: Vec2,
  ##       radius: Uniform[float],
  ##       size: Uniform[Vec2],
  ##       color: Uniform[Vec4],
  ##     ) =
  ##       glCol = vec4(color.rgb * color.a, color.a) * roundRect(pos, size, radius)
  ##
  ## convers to (roughly):
  ## 
  ## .. code-block:: nim
  ##   proc vert(
  ##     gl_Position: var Vec4,
  ##     pos: var Vec2,
  ##     ipos: Vec2,
  ##     transform: Uniform[Mat4],
  ##     size: Uniform[Vec2],
  ##     px: Uniform[Vec2],
  ##   ) =
  ##     transformation(gl_Position, pos, size, px, ipos, transform)
  ##  
  ##   proc frag(
  ##     glCol: var Vec4,
  ##     pos: Vec2,
  ##     radius: Uniform[float],
  ##     size: Uniform[Vec2],
  ##     color: Uniform[Vec4],
  ##   ) =
  ##     glCol = vec4(color.rgb * color.a, color.a) * roundRect(pos, size, radius)
  ##   
  ##   type MyShader = ref object of RootObj
  ##     shader: Shader
  ##     transform: OpenglUniform[Mat4]
  ##     size: OpenglUniform[Vec2]
  ##     px: OpenglUniform[Vec2]
  ##     radius: OpenglUniform[float]
  ##     color: OpenglUniform[Vec4]
  ##   
  ##   if not ctx.shaders.hasKey(1):
  ##     let x = MyShader()
  ##     x.shader = newShader {GlVertexShader: vert.toGLSL("330 core"), GlFragmentShader: frag.toGLSL("330 core")}
  ##     x.transform =  OpenglUniform[Mat4](result.solid.shader["transform"])
  ##     x.size = OpenglUniform[Vec2](result.solid.shader["size"])
  ##     x.px = OpenglUniform[Vec2](result.solid.shader["px"])
  ##     x.radius = OpenglUniform[float](result.solid.shader["radius"])
  ##     x.color = OpenglUniform[Vec4](result.solid.shader["color"])
  ##     ctx.shaders[1] = RootRef(x)
  ##   
  ##   MyShader(ctx.shaders[1])
  let id = newShaderId
  inc newShaderId
  var
    vert: NimNode
    frag: NimNode
    uniforms = initTable[string, NimNode]()
  
  var version: NimNode = newLit "330 core"
  var origBody = body
  var body = body
  if body.kind != nnkStmtList:
    body = newStmtList(body)

  proc isUniformType(n: NimNode, uniformType: var NimNode): bool =
    if n.kind == nnkBracketExpr and n.len == 2 and n[0].eqIdent("Uniform"):
      uniformType = n[1]
      return true
    false

  proc getProcNameIdent(n: NimNode): NimNode =
    var nameNode = n[0]
    if nameNode.kind == nnkPostfix and nameNode.len == 2 and nameNode[0].eqIdent("*"):
      nameNode = nameNode[1]
    if nameNode.kind == nnkAccQuoted and nameNode.len > 0:
      nameNode = nameNode[0]
    nameNode

  proc findFormalParams(n: NimNode): NimNode =
    for child in n:
      if child.kind == nnkFormalParams:
        return child
    newEmptyNode()

  proc collectUniforms(uniforms: var Table[string, NimNode], params: NimNode) =
    for param in params:
      if param.kind != nnkIdentDefs:
        continue
      var uniformType: NimNode
      if isUniformType(param[^2], uniformType):
        for i in 0 ..< param.len - 2:
          if param[i].kind in {nnkIdent, nnkSym}:
            uniforms[param[i].strVal] = uniformType

  proc handleVersionPragma(n: NimNode, versionNode: var NimNode): bool =
    if n.kind != nnkPragma or n.len != 1:
      return false
    let item = n[0]
    if item.kind == nnkExprColonExpr and item[0].eqIdent("version"):
      versionNode = item[1]
      return true
    false

  var outStmts = newStmtList()
  for stmt in body:
    if handleVersionPragma(stmt, version):
      if defined(windows):
        let versionStr = if version.kind in {nnkStrLit, nnkTripleStrLit, nnkRStrLit}:
          version.strVal
        else:
          ""
        if "es" in versionStr:
          warning("ignoring OpenGL ES shader version on windows, since OpenGL ES is not supported there")
    elif stmt.kind == nnkProcDef:
      let params = findFormalParams(stmt)
      let nameIdent = getProcNameIdent(stmt)
      if nameIdent.kind in {nnkIdent, nnkSym} and nameIdent.strVal == "vert":
        outStmts.add(stmt)
        vert = nameIdent
        collectUniforms(uniforms, params)
      elif nameIdent.kind in {nnkIdent, nnkSym} and nameIdent.strVal == "frag":
        outStmts.add(stmt)
        frag = nameIdent
        collectUniforms(uniforms, params)
      else:
        outStmts.add(stmt)
    else:
      outStmts.add(stmt)

  if vert == nil:
    error("vert shader proc not defined", origBody)
  if frag == nil:
    error("frag shader proc not defined", origBody)

  let shaderT = genSym(nskType)
  let shaderX = genSym(nskLet)

  var recList = nnkRecList.newTree(
    nnkIdentDefs.newTree(
      ident("shader"),
      bindSym("Shader"),
      newEmptyNode()
    )
  )
  for n, t in uniforms:
    recList.add(
      nnkIdentDefs.newTree(
        ident(n),
        nnkBracketExpr.newTree(bindSym("OpenglUniform"), t),
        newEmptyNode()
      )
    )

  let typeSection = nnkTypeSection.newTree(
    nnkTypeDef.newTree(
      shaderT,
      newEmptyNode(),
      nnkRefTy.newTree(
        nnkObjectTy.newTree(
          newEmptyNode(),
          nnkOfInherit.newTree(bindSym("RootObj")),
          recList
        )
      )
    )
  )

  let shaderTable = nnkTableConstr.newTree(
    nnkExprColonExpr.newTree(
      ident("GlVertexShader"),
      nnkCall.newTree(bindSym("toGLSL"), vert, version)
    ),
    nnkExprColonExpr.newTree(
      ident("GlFragmentShader"),
      nnkCall.newTree(bindSym("toGLSL"), frag, version)
    )
  )

  var shaderInit = newStmtList(
    nnkLetSection.newTree(
      nnkIdentDefs.newTree(
        shaderX,
        newEmptyNode(),
        nnkCall.newTree(bindSym("new"), shaderT)
      )
    ),
    nnkAsgn.newTree(
      nnkDotExpr.newTree(shaderX, ident("shader")),
      nnkCall.newTree(bindSym("newShader"), shaderTable)
    )
  )

  for n, t in uniforms:
    shaderInit.add(
      nnkAsgn.newTree(
        nnkDotExpr.newTree(shaderX, ident(n)),
        nnkCall.newTree(
          nnkBracketExpr.newTree(bindSym("OpenglUniform"), t),
          nnkBracketExpr.newTree(
            nnkDotExpr.newTree(shaderX, ident("shader")),
            newLit(n)
          )
        )
      )
    )

  shaderInit.add(
    nnkCall.newTree(
      bindSym("[]="),
      nnkDotExpr.newTree(ctx, ident("shaders")),
      newLit(id),
      nnkCall.newTree(bindSym("RootRef"), shaderX)
    )
  )

  let ifStmt = nnkIfStmt.newTree(
    nnkElifBranch.newTree(
      nnkCall.newTree(
        bindSym("not"),
        nnkCall.newTree(
          bindSym("hasKey"),
          nnkDotExpr.newTree(ctx, ident("shaders")),
          newLit(id)
        )
      ),
      shaderInit
    )
  )

  let resultExpr = nnkCall.newTree(
    shaderT,
    nnkCall.newTree(
      bindSym("[]"),
      nnkDotExpr.newTree(ctx, ident("shaders")),
      newLit(id)
    )
  )

  var blockStmts = newStmtList()
  for stmt in outStmts:
    blockStmts.add(stmt)
  blockStmts.add(typeSection)
  blockStmts.add(ifStmt)
  blockStmts.add(resultExpr)

  result = nnkBlockStmt.newTree(newEmptyNode(), blockStmts)


proc newDrawContext*: DrawContext =
  new result

  result.rect = newShape(
    [
      vec2(0, 1),   # top left
      vec2(0, 0),   # bottom left
      vec2(1, 0),   # bottom right
      vec2(1, 1),   # top right
    ], [
      0'u32, 1, 2,
      2, 3, 0,
    ]
  )
