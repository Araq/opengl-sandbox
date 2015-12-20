import opengl, glm, strutils, nre, macros, sdl2, sdl2/image

#### glm additions ####

type Vec4f* = Vec4[float32]
type Vec3f* = Vec3[float32]
type Vec2f* = Vec2[float32]
type Vec4d* = Vec4[float64]
type Vec3d* = Vec3[float64]
type Vec2d* = Vec2[float64]

type Mat4f* = Mat4x4[float32]
type Mat3f* = Mat3x3[float32]
type Mat2f* = Mat2x2[float32]
type Mat4d* = Mat4x4[float64]
type Mat3d* = Mat3x3[float64]
type Mat2d* = Mat2x2[float64]

proc mat4f*(mat: Mat4d): Mat4f =
  for i in 0..<4:
   for j in 0..<4:
     result[i][j] = mat[i][j]

proc I4*() : Mat4d = mat4x4(
  vec4(1.0, 0, 0, 0),
  vec4(0.0, 1, 0, 0),
  vec4(0.0, 0, 1, 0),
  vec4(0.0, 0, 0, 1)
)
#### Sampler Types ####

macro nilName(name:expr) : expr =
  name.expectKind(nnkIdent)
  newIdentNode("nil_" & $name)

template textureTypeTemplate(name, nilName, target:expr, shadername:string): stmt =
  type name* = distinct GLuint
  const nilName* = name(0)
  proc bindIt*(texture: name) =
    glBindTexture(target, GLuint(texture))
  template glslUniformType*(t : type name): string = shadername

template textureTypeTemplate(name: expr, target:expr, shadername:string): stmt =
  textureTypeTemplate(name, nilName(name), target, shadername)


textureTypeTemplate(Texture1D,                 nil_Texture1D,
    GL_TEXTURE_1D, "sampler1D")
textureTypeTemplate(Texture2D,                 nil_Texture2D,
    GL_TEXTURE_2D, "sampler2D")
textureTypeTemplate(Texture3D,                 nil_Texture3D,
    GL_TEXTURE_3D, "sampler3D")
textureTypeTemplate(Texture1DArray,             nil_Texture1DArray,
    GL_Texture_1D_ARRAY, "sampler2D")
textureTypeTemplate(Texture2DArray,            nil_Texture2DArray,
    GL_TEXTURE_2D_ARRAY, "sampler2D")
textureTypeTemplate(TextureRectangle,          nil_TextureRectangle,
    GL_TEXTURE_RECTANGLE, "sampler2D")
textureTypeTemplate(TextureCubeMap,            nil_TextureCubeMap,
    GL_TEXTURE_CUBE_MAP, "sampler2D")
textureTypeTemplate(TextureCubeMapArray,       nil_TextureCubeMapArray,
    GL_TEXTURE_CUBE_MAP_ARRAY , "sampler2D")
textureTypeTemplate(TextureBuffer,             nil_TextureBuffer,
    GL_TEXTURE_BUFFER, "sampler2D")
textureTypeTemplate(Texture2DMultisample,      nil_Texture2DMultisample,
    GL_TEXTURE_2D_MULTISAMPLE, "sampler2D")
textureTypeTemplate(Texture2DMultisampleArray, nil_Texture2DMultisampleArray,
    GL_TEXTURE_2D_MULTISAMPLE_ARRAY, "sampler2D")

proc loadAndBindTextureRectangleFromFile*(filename: string): TextureRectangle =
  let surface = image.load(filename)
  defer: freeSurface(surface)
  let surface2 = sdl2.convertSurfaceFormat(surface, SDL_PIXELFORMAT_RGBA8888, 0)
  defer: freeSurface(surface2)
  glGenTextures(1, cast[ptr GLuint](result.addr))
  result.bindIt()
  glTexImage2D(GL_TEXTURE_RECTANGLE, 0, GL_RGBA, surface2.w, surface2.h, 0, GL_RGBA, GL_UNSIGNED_INT_8_8_8_8, surface2.pixels)
  glTexParameteri(GL_TEXTURE_RECTANGLE, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
  glTexParameteri(GL_TEXTURE_RECTANGLE, GL_TEXTURE_MAG_FILTER, GL_LINEAR)

proc loadAndBindTexture2DFromFile*(filename: string): Texture2D =
  let surface = image.load(filename)
  defer: freeSurface(surface)
  let surface2 = sdl2.convertSurfaceFormat(surface, SDL_PIXELFORMAT_RGBA8888, 0)
  defer: freeSurface(surface2)
  glGenTextures(1, cast[ptr GLuint](result.addr))
  result.bindIt()
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, surface2.w, surface2.h, 0, GL_RGBA, GL_UNSIGNED_INT_8_8_8_8, surface2.pixels)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
  glGenerateMipmap(GL_TEXTURE_2D)

#### nim -> glsl type mapping ####

template glslUniformType*(t : type Vec4): string = "vec4"
template glslUniformType*(t : type Vec3): string = "vec3"
template glslUniformType*(t : type Vec2): string = "vec2"
template glslUniformType*(t : type Mat4x4): string = "mat4"
template glslUniformType*(t : type Mat3x3): string = "mat3"
template glslUniformType*(t : type Mat2x2): string = "mat2"
template glslUniformType*(t : type float): string = "float"
template glslUniformType*(t : type float32): string = "float"
template glslUniformType*(t : type float64): string = "float"

template glslAttribType*(t : type seq[Vec4]): string = "vec4"
template glslAttribType*(t : type seq[Vec3]): string = "vec3"
template glslAttribType*(t : type seq[Vec2]): string = "vec2"
template glslAttribType*(t : type seq[Mat4x4]): string = "mat4"
template glslAttribType*(t : type seq[Mat3x3]): string = "mat3"
template glslAttribType*(t : type seq[Mat2x2]): string = "mat2"

#### Uniform ####

proc uniform*(location: GLint, mat: Mat4x4[float64]) =
  var mat_float32 = mat4f(mat)
  glUniformMatrix4fv(location, 1, false, cast[ptr GLfloat](mat_float32.addr))

proc uniform*(location: GLint, mat: var Mat4x4[float32]) =
  glUniformMatrix4fv(location, 1, false, cast[ptr GLfloat](mat.addr))

proc uniform*(location: GLint, value: float32) =
  glUniform1f(location, value)

proc uniform*(location: GLint, value: float64) =
  glUniform1f(location, value)

proc uniform*(location: GLint, value: Vec2f) =
  glUniform2f(location, value[0], value[1])

proc uniform*(location: GLint, value: Vec3f) =
  glUniform3f(location, value[0], value[1], value[2])

proc uniform*(location: GLint, value: Vec4f) =
  glUniform4f(location, value[0], value[1], value[2], value[3])


#### Vertex Array Object ####


type VertexArrayObject* = distinct GLuint

proc newVertexArrayObject*() : VertexArrayObject =
  glGenVertexArrays(1, cast[ptr GLuint](result.addr))

const nil_vao* = VertexArrayObject(0)

proc bindIt*(vao: VertexArrayObject) =
  glBindVertexArray(GLuint(vao))

proc delete*(vao: VertexArrayObject) =
  var raw_vao = GLuint(vao)
  glDeleteVertexArrays(1, raw_vao.addr)

template blockBind*(vao: VertexArrayObject, blk: stmt) : stmt =
  vao.bindIt
  blk
  nil_vao.bindIt

#### Array Buffers ####

type ArrayBuffer*[T]        = distinct GLuint
type ElementArrayBuffer*[T] = distinct GLuint
type UniformBuffer*[T]      = distinct GLuint


proc newArrayBuffer*[T](): ArrayBuffer[T] =
  glGenBuffers(1, cast[ptr GLuint](result.addr))

proc newElementArrayBuffer*[T](): ElementArrayBuffer[T] =
  glGenBuffers(1, cast[ptr GLuint](result.addr))

proc newUniformBuffer*[T](): UniformBuffer[T] =
  glGenBuffers(1, cast[ptr GLuint](result.addr))


proc currentArrayBuffer*[T](): ArrayBuffer[T] =
  glGetIntegerv(GL_ARRAY_BUFFER_BINDING, cast[ptr GLint](result.addr))

proc currentElementArrayBuffer*[T](): ElementArrayBuffer[T] =
  glGetIntegerv(GL_ELEMENT_ARRAY_BUFFER_BINDING, cast[ptr GLint](result.addr))

proc currentUniformBuffer*[T](): UniformBuffer[T] =
  glGetIntegerv(GL_UNIFORM_BUFFER_BINDING, cast[ptr GLint](result.addr))


proc bindIt*[T](buffer: ArrayBuffer[T]) =
  glBindBuffer(GL_ARRAY_BUFFER, GLuint(buffer))

proc bindIt*[T](buffer: ElementArrayBuffer[T]) =
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, GLuint(buffer))

proc bindIt*[T](buffer: UniformBuffer[T]) =
  glBindBuffer(GL_UNIFORM_BUFFER, GLuint(buffer))


proc bufferData*[T](buffer: ArrayBuffer[T], data: var seq[T]) =
  glBufferData(GL_ARRAY_BUFFER, GLsizeiptr(data.len * sizeof(T)), data[0].addr, GL_STATIC_DRAW)

proc bufferData*[T](buffer: ElementArrayBuffer[T], data: seq[T]) =
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, GLsizeiptr(data.len * sizeof(T)), data[0].addr, GL_STATIC_DRAW)

proc bufferData*[T](buffer: UniformBuffer[T], data: T) =
  glBufferData(GL_ARRAY_BUFFER, GLsizeiptr(sizeof(T)), data.addr, GL_STATIC_DRAW)

#### etc ####

type ShaderParam* = tuple[name: string, gl_type: string]

let sourceHeader = """
#version 330
#extension GL_ARB_explicit_uniform_location : enable
#define M_PI 3.1415926535897932384626433832795
"""

proc genShaderSource*(
    uniforms : openArray[ShaderParam], uniformLocations : bool,
    inParams : openArray[ShaderParam], inLocations : bool,
    outParams: openArray[ShaderParam],
    includes: openArray[string], mainSrc: string): string =
  result = sourceHeader
  for i, u in uniforms:
    if uniformLocations:
      result.add format("layout(location = $3) uniform $2 $1;\n", u.name, u.gl_type, i)
    else:
      result.add format("uniform $2 $1;\n", u.name, u.gl_type)
  for i, a in inParams:
    if inLocations:
      result.add format("layout(location = $3) in $2 $1;\n", a.name, a.gl_type, i)
    else:
      result.add format("in $2 $1;\n", a.name, a.gl_type, i)
  for v in outParams:
    result.add format("out $2 $1;\n", v.name, v.gl_type)
  for incl in includes:
    result.add incl
  result.add("void main() {\n")
  result.add(mainSrc)
  result.add("\n}")

proc shaderSource*(shader: GLuint, source: string) =
  var source_array: array[1, string] = [source]
  var c_source_array = allocCStringArray(source_array)
  defer: deallocCStringArray(c_source_array)
  glShaderSource(shader, 1, c_source_array, nil)

proc compileStatus*(shader:GLuint): bool =
  var status: GLint
  glGetShaderiv(shader, GL_COMPILE_STATUS, status.addr)
  status != 0

proc linkStatus*(program:GLuint): bool =
  var status: GLint
  glGetProgramiv(program, GL_LINK_STATUS, status.addr)
  status != 0

proc shaderInfoLog*(shader: GLuint): string =
  var length: GLint = 0
  glGetShaderiv(shader, GL_INFO_LOG_LENGTH, length.addr)
  result = newString(length.int)
  glGetShaderInfoLog(shader, length, nil, result)

proc showError*(log: string, source: string): void =
  let lines = source.splitLines
  for match in log.findIter(re"(\d+)\((\d+)\).*"):
    let line_nr = match.captures[1].parseInt;
    echo lines[line_nr - 1]
    echo match.match

proc programInfoLog*(program: GLuint): string =
  var length: GLint = 0
  glGetProgramiv(program, GL_INFO_LOG_LENGTH, length.addr);
  result = newString(length.int)
  glGetProgramInfoLog(program, length, nil, result);

proc compileShader*(shaderType: GLenum, source: string): GLuint =
  result = glCreateShader(shaderType)
  result.shaderSource(source)
  glCompileShader(result)

  echo "*****"
  echo source
  echo "*****"

  if not result.compileStatus:
    echo "==== start Shader Problems ======================================="
    echo source
    echo "------------------------------------------------------------------"
    showError(result.shaderInfoLog, source)
    echo "==== end Shader Problems ========================================="

proc linkShader*(shaders: varargs[GLuint]): GLuint =
  result = glCreateProgram()

  for shader in shaders:
    glAttachShader(result, shader)
    glDeleteShader(shader)
  glLinkProgram(result)

  if not result.linkStatus:
    echo "Log: ", result.programInfoLog
    glDeleteProgram(result)
    result = 0


template attribSize(t: type Vec3[float64]) : GLint = 3
template attribType(t: type Vec3[float64]) : GLenum = cGL_DOUBLE
template attribNormalized(t: type Vec3[float64]) : bool = false

proc makeAndBindBuffer*[T](buffer: var ArrayBuffer[T], index: GLuint, value: var seq[T], usage: GLenum) =
  buffer = newArrayBuffer[T]()
  buffer.bindIt
  glBufferData(GL_ARRAY_BUFFER, GLsizeiptr(value.len * sizeof(T)), value[0].addr, usage)
  glVertexAttribPointer(index, attribSize(T), attribType(T), attribNormalized(T), 0, nil)

template renderBlockTemplate(globalsBlock, sequenceInitBlock,
               bufferCreationBlock, setUniformsBlock: expr): stmt {. dirty .} =
  block:
    var vao {.global.}: VertexArrayObject
    var glProgram {.global.}: GLuint  = 0

    globalsBlock

    if glProgram == 0:

      sequenceInitBlock

      gl_program = linkShader(
        compileShader(GL_VERTEX_SHADER,   genShaderSource(uniforms, true, attributes, true, varyings, includes, vertexSrc)),
        compileShader(GL_FRAGMENT_SHADER, genShaderSource(uniforms, true, varyings, false, fragOut, includes, fragmentSrc)),
      )

      glUseProgram(gl_program)
      vao = newVertexArrayObject()
      bindIt(vao)

      bufferCreationBlock

      glBindBuffer(GL_ARRAY_BUFFER, 0)
      bindIt(nil_vao)
      glUseProgram(0)

    glUseProgram(gl_program)

    bindIt(vao)

    setUniformsBlock

    glDrawArrays(GL_TRIANGLES, 0, GLsizei(len(vertex)))

    bindIt(nil_vao)
    glUseProgram(0);


macro shadingDsl*(statement: expr) : stmt =

  let attributesSection = newNimNode(nnkBracket)
  let uniformsSection = newNimNode(nnkBracket)
  let varyingsSection = newNimNode(nnkBracket)
  let fragOutSection = newNimNode(nnkBracket)
  let includesSection = newNimNode(nnkBracket)

  let globalsBlock = newStmtList()
  let bufferCreationBlock = newStmtList()
  let setUniformsBlock = newStmtList()

  var attribCount = 0;
  proc addAttrib(lhsIdent, rhsIdent: NimNode): void =
    let lhsStrLit = newLit($lhsIdent)
    let bufferIdentNode = newIdentNode($lhsIdent & "Buffer")

    let shaderParam = quote do:
      (`lhsStrLit`, glslAttribType(type(`rhsIdent`)))

    attributesSection.add(shaderParam)

    template foobarTemplate( lhs, rhs : expr ) : stmt{.dirty.} =
      var lhs {.global.}: ArrayBuffer[rhs[0].type]


    let line = getAst(foobarTemplate( bufferIdentNode, rhsIdent ))

    globalsBlock.add line
    bufferCreationBlock.add(newCall("glEnableVertexAttribArray", newLit(attribCount)))
    bufferCreationBlock.add(newCall("makeAndBindBuffer",
        bufferIdentNode,
        newLit(attribCount),
        rhsIdent,
        newIdentNode(!"GL_STATIC_DRAW")
    ))

    attribCount += 1

  var uniformslist : seq[ tuple[lhsName:string, value: NimNode] ] = @[]
  #var uniformCount = 0
  #proc addUniform(lhsName, rhsName: string): void =
  #  let shaderParam = "(\"" & lhsName & "\", glslUniformType(type(" & rhsName & ")))"
  #  uniformsSection.add(parseExpr(shaderParam))
  #  setUniformsBlock.add newCall("uniform", newLit(uniformCount), newIdentNode(rhsName))
  #  uniformCount += 1

  var varyingCount = 0
  proc addVarying(name, typ: string): void =
    let shaderParam = newPar( newLit(name), newLit(typ) )
    varyingsSection.add shaderParam

    varyingCount += 1

  var fragOutCount = 0
  proc addFragOut(name, typ: string): void =
    let  shaderParam = newPar( newLit(name), newLit(typ) )
    fragOutSection.add shaderParam

    fragOutCount += 1

  var vertexSourceNode = newLit("")
  var fragmentSourceNode = newLit("")

  #### BEGIN PARSE TREE ####

  for section in statement.items:
    section.expectKind nnkCall
    let ident = section[0]
    ident.expectKind nnkIdent
    let stmtList = section[1]
    stmtList.expectKind nnkStmtList

    case $ident
    of "samplers":
      discard
    of "uniforms":
      for capture in stmtList.items:
        capture.expectKind({nnkAsgn, nnkIdent})
        if capture.kind == nnkAsgn:
          capture.expectLen 2
          capture[0].expectKind nnkIdent
          capture[1].expectKind nnkIdent
          uniformslist.add( ($capture[0], capture[1] ) )
        elif capture.kind == nnkIdent:
          uniformslist.add( ($capture, capture) )


    of "attributes":
      for capture in stmtList.items:
        capture.expectKind({nnkAsgn, nnkIdent})

        if capture.kind == nnkAsgn:
          capture.expectLen 2
          capture[0].expectKind nnkIdent
          capture[1].expectKind nnkIdent
          echo "addAttrib(", capture[0],",", capture[1], ")"
          addAttrib(capture[0], capture[1])
        elif capture.kind == nnkIdent:
          addAttrib(capture, capture)


    of "varyings":
      warning("yay got varyings with StmtList")
      for varSec in stmtList.items:
        varSec.expectKind nnkVarSection
        for def in varSec:
          def.expectKind nnkIdentDefs
          echo " varying "
          def[0].expectKind nnkIdent
          def[1].expectKind nnkIdent
          addVarying( $def[0] , $def[1] )


    of "frag_out":
      warning("yay got frag_out with StmtList")
      for varSec in stmtList.items:
        varSec.expectKind nnkVarSection
        for def in varSec:
          def.expectKind nnkIdentDefs
          def.expectKind nnkIdentDefs
          echo " varying "
          def[0].expectKind nnkIdent
          def[1].expectKind nnkIdent
          addFragOut( $def[0] , $def[1] )


    of "vertex_prg":
      stmtList.expectLen(1)
      stmtList[0].expectKind({nnkTripleStrLit, nnkStrLit})
      vertexSourceNode = stmtList[0]

    of  "fragment_prg":
      stmtList.expectLen(1)
      stmtList[0].expectKind({ nnkTripleStrLit, nnkStrLit })
      fragmentSourceNode = stmtList[0]

    of "includes":
      for statement in stmtList:
        statement.expectKind( nnkIdent )
        includesSection.add statement

    else:
      error("unknown section " & $ident.ident)

  #### END PARSE TREE ####

  let sequenceInitBlock = newStmtList()

  var statement:NimNode

  statement = parseStmt(" let attributes: seq[ShaderParam] = @[] ")
  statement[0][0][2][1] = attributesSection
  sequenceInitBlock.add statement

  statement = quote do:
    let uniforms: seq[ShaderParam] = @[]

  for tt in uniformslist:
    let lhsName = tt.lhsName
    let value = tt.value
    statement.add quote do:
      system.add(uniforms, (name : `lhsName`, gl_type: glslUniformType(type(`value`))) )

  for tt in uniformslist:
    let lhsName = tt.lhsName
    let value = tt.value
    echo lhsName, " <---> ", value

  echo repr(statement)
  statement[0][0][2][1] = uniformsSection
  sequenceInitBlock.add statement

  statement = parseStmt(" let varyings: seq[ShaderParam] = @[] ")
  statement[0][0][2][1] = varyingsSection
  sequenceInitBlock.add statement

  statement = parseStmt(" let fragOut: seq[ShaderParam] = @[] ")
  statement[0][0][2][1] = fragOutSection
  sequenceInitBlock.add statement

  statement = parseStmt(" let includes: seq[string] = @[] ")
  statement[0][0][2][1] = includesSection
  sequenceInitBlock.add statement

  sequenceInitBlock.add newLetStmt(newIdentNode("vertexSrc"), vertexSourceNode)
  sequenceInitBlock.add newLetStmt(newIdentNode("fragmentSrc"), fragmentSourceNode)

  result = getAst( renderBlockTemplate(globalsBlock, sequenceInitBlock,
                                       bufferCreationBlock, setUniformsBlock))
