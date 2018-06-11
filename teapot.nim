
#[ Copyright (c) Mark J. Kilgard, 1994, 2001. ]#

#[
(c) Copyright 1993, Silicon Graphics, Inc.

ALL RIGHTS RESERVED

Permission to use, copy, modify, and distribute this software
for any purpose and without fee is hereby granted, provided
that the above copyright notice appear in all copies and that
both the copyright notice and this permission notice appear in
supporting documentation, and that the name of Silicon
Graphics, Inc. not be used in advertising or publicity
pertaining to distribution of the software without specific,
written prior permission.

THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU
"AS-IS" AND WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR
OTHERWISE, INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF
MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  IN NO
EVENT SHALL SILICON GRAPHICS, INC.  BE LIABLE TO YOU OR ANYONE
ELSE FOR ANY DIRECT, SPECIAL, INCIDENTAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OF ANY KIND, OR ANY DAMAGES WHATSOEVER,
INCLUDING WITHOUT LIMITATION, LOSS OF PROFIT, LOSS OF USE,
SAVINGS OR REVENUE, OR THE CLAIMS OF THIRD PARTIES, WHETHER OR
NOT SILICON GRAPHICS, INC.  HAS BEEN ADVISED OF THE POSSIBILITY
OF SUCH LOSS, HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
ARISING OUT OF OR IN CONNECTION WITH THE POSSESSION, USE OR
PERFORMANCE OF THIS SOFTWARE.

US Government Users Restricted Rights

Use, duplication, or disclosure by the Government is subject to
restrictions set forth in FAR 52.227.19(c)(2) or subparagraph
(c)(1)(ii) of the Rights in Technical Data and Computer
Software clause at DFARS 252.227-7013 and/or in similar or
successor clauses in the FAR or the DOD or NASA FAR
Supplement.  Unpublished-- rights reserved under the copyright
laws of the United States.  Contractor/manufacturer is Silicon
Graphics, Inc., 2011 N.  Shoreline Blvd., Mountain View, CA
94039-7311.
]#


#[ Rim, body, lid, and bottom data must be reflected in x and
   y; handle and spout data across the y axis only.  ]#

let patchdata seq[array[16,int32]] = @[
    #[ rim ]#
  [102'i32, 103, 104, 105, 4, 5, 6, 7, 8, 9, 10, 11,
    12, 13, 14, 15],
    #[ body ]#
  [12'i32, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
    24, 25, 26, 27],
  [24'i32, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36,
    37, 38, 39, 40],
    #[ lid ]#
  [96'i32, 96, 96, 96, 97, 98, 99, 100, 101, 101, 101,
    101, 0, 1, 2, 3,],
  [0'i32, 1, 2, 3, 106, 107, 108, 109, 110, 111, 112,
    113, 114, 115, 116, 117],
    #[ bottom ]#
  [118'i32, 118, 118, 118, 124, 122, 119, 121, 123, 126,
    125, 120, 40, 39, 38, 37],
    #[ handle ]#
  [41'i32, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
    53, 54, 55, 56],
  [53'i32, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
    28, 65, 66, 67],
    #[ spout ]#
  [68'i32, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
    80, 81, 82, 83],
  [80'i32, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
    92, 93, 94, 95]
];
#[ *INDENT-OFF* ]#

let cpdata seq[array[3,float32]] = @[
    [ 0.2000f,  0.0000f,  2.70000f],
    [ 0.2000f, -0.1120f,  2.70000f],
    [ 0.1120f, -0.2000f,  2.70000f],
    [ 0.0000f, -0.2000f,  2.70000f],
    [ 1.3375f,  0.0000f,  2.53125f],
    [ 1.3375f, -0.7490f,  2.53125f],
    [ 0.7490f, -1.3375f,  2.53125f],
    [ 0.0000f, -1.3375f,  2.53125f],
    [ 1.4375f,  0.0000f,  2.53125f],
    [ 1.4375f, -0.8050f,  2.53125f],
    [ 0.8050f, -1.4375f,  2.53125f],
    [ 0.0000f, -1.4375f,  2.53125f],
    [ 1.5000f,  0.0000f,  2.40000f],
    [ 1.5000f, -0.8400f,  2.40000f],
    [ 0.8400f, -1.5000f,  2.40000f],
    [ 0.0000f, -1.5000f,  2.40000f],
    [ 1.7500f,  0.0000f,  1.87500f],
    [ 1.7500f, -0.9800f,  1.87500f],
    [ 0.9800f, -1.7500f,  1.87500f],
    [ 0.0000f, -1.7500f,  1.87500f],
    [ 2.0000f,  0.0000f,  1.35000f],
    [ 2.0000f, -1.1200f,  1.35000f],
    [ 1.1200f, -2.0000f,  1.35000f],
    [ 0.0000f, -2.0000f,  1.35000f],
    [ 2.0000f,  0.0000f,  0.90000f],
    [ 2.0000f, -1.1200f,  0.90000f],
    [ 1.1200f, -2.0000f,  0.90000f],
    [ 0.0000f, -2.0000f,  0.90000f],
    [-2.0000f,  0.0000f,  0.90000f],
    [ 2.0000f,  0.0000f,  0.45000f],
    [ 2.0000f, -1.1200f,  0.45000f],
    [ 1.1200f, -2.0000f,  0.45000f],
    [ 0.0000f, -2.0000f,  0.45000f],
    [ 1.5000f,  0.0000f,  0.22500f],
    [ 1.5000f, -0.8400f,  0.22500f],
    [ 0.8400f, -1.5000f,  0.22500f],
    [ 0.0000f, -1.5000f,  0.22500f],
    [ 1.5000f,  0.0000f,  0.15000f],
    [ 1.5000f, -0.8400f,  0.15000f],
    [ 0.8400f, -1.5000f,  0.15000f],
    [ 0.0000f, -1.5000f,  0.15000f],
    [-1.6000f,  0.0000f,  2.02500f],
    [-1.6000f, -0.3000f,  2.02500f],
    [-1.5000f, -0.3000f,  2.25000f],
    [-1.5000f,  0.0000f,  2.25000f],
    [-2.3000f,  0.0000f,  2.02500f],
    [-2.3000f, -0.3000f,  2.02500f],
    [-2.5000f, -0.3000f,  2.25000f],
    [-2.5000f,  0.0000f,  2.25000f],
    [-2.7000f,  0.0000f,  2.02500f],
    [-2.7000f, -0.3000f,  2.02500f],
    [-3.0000f, -0.3000f,  2.25000f],
    [-3.0000f,  0.0000f,  2.25000f],
    [-2.7000f,  0.0000f,  1.80000f],
    [-2.7000f, -0.3000f,  1.80000f],
    [-3.0000f, -0.3000f,  1.80000f],
    [-3.0000f,  0.0000f,  1.80000f],
    [-2.7000f,  0.0000f,  1.57500f],
    [-2.7000f, -0.3000f,  1.57500f],
    [-3.0000f, -0.3000f,  1.35000f],
    [-3.0000f,  0.0000f,  1.35000f],
    [-2.5000f,  0.0000f,  1.12500f],
    [-2.5000f, -0.3000f,  1.12500f],
    [-2.6500f, -0.3000f,  0.93750f],
    [-2.6500f,  0.0000f,  0.93750f],
    [-2.0000f, -0.3000f,  0.90000f],
    [-1.9000f, -0.3000f,  0.60000f],
    [-1.9000f,  0.0000f,  0.60000f],
    [ 1.7000f,  0.0000f,  1.42500f],
    [ 1.7000f, -0.6600f,  1.42500f],
    [ 1.7000f, -0.6600f,  0.60000f],
    [ 1.7000f,  0.0000f,  0.60000f],
    [ 2.6000f,  0.0000f,  1.42500f],
    [ 2.6000f, -0.6600f,  1.42500f],
    [ 3.1000f, -0.6600f,  0.82500f],
    [ 3.1000f,  0.0000f,  0.82500f],
    [ 2.3000f,  0.0000f,  2.10000f],
    [ 2.3000f, -0.2500f,  2.10000f],
    [ 2.4000f, -0.2500f,  2.02500f],
    [ 2.4000f,  0.0000f,  2.02500f],
    [ 2.7000f,  0.0000f,  2.40000f],
    [ 2.7000f, -0.2500f,  2.40000f],
    [ 3.3000f, -0.2500f,  2.40000f],
    [ 3.3000f,  0.0000f,  2.40000f],
    [ 2.8000f,  0.0000f,  2.47500f],
    [ 2.8000f, -0.2500f,  2.47500f],
    [ 3.5250f, -0.2500f,  2.49375f],
    [ 3.5250f,  0.0000f,  2.49375f],
    [ 2.9000f,  0.0000f,  2.47500f],
    [ 2.9000f, -0.1500f,  2.47500f],
    [ 3.4500f, -0.1500f,  2.51250f],
    [ 3.4500f,  0.0000f,  2.51250f],
    [ 2.8000f,  0.0000f,  2.40000f],
    [ 2.8000f, -0.1500f,  2.40000f],
    [ 3.2000f, -0.1500f,  2.40000f],
    [ 3.2000f,  0.0000f,  2.40000f],
    [ 0.0000f,  0.0000f,  3.15000f],
    [ 0.8000f,  0.0000f,  3.15000f],
    [ 0.8000f, -0.4500f,  3.15000f],
    [ 0.4500f, -0.8000f,  3.15000f],
    [ 0.0000f, -0.8000f,  3.15000f],
    [ 0.0000f,  0.0000f,  2.85000f],
    [ 1.4000f,  0.0000f,  2.40000f],
    [ 1.4000f, -0.7840f,  2.40000f],
    [ 0.7840f, -1.4000f,  2.40000f],
    [ 0.0000f, -1.4000f,  2.40000f],
    [ 0.4000f,  0.0000f,  2.55000f],
    [ 0.4000f, -0.2240f,  2.55000f],
    [ 0.2240f, -0.4000f,  2.55000f],
    [ 0.0000f, -0.4000f,  2.55000f],
    [ 1.3000f,  0.0000f,  2.55000f],
    [ 1.3000f, -0.7280f,  2.55000f],
    [ 0.7280f, -1.3000f,  2.55000f],
    [ 0.0000f, -1.3000f,  2.55000f],
    [ 1.3000f,  0.0000f,  2.40000f],
    [ 1.3000f, -0.7280f,  2.40000f],
    [ 0.7280f, -1.3000f,  2.40000f],
    [ 0.0000f, -1.3000f,  2.40000f],
    [ 0.0000f,  0.0000f,  0.00000f],
    [ 1.4250f, -0.7980f,  0.00000f],
    [ 1.5000f,  0.0000f,  0.07500f],
    [ 1.4250f,  0.0000f,  0.00000f],
    [ 0.7980f, -1.4250f,  0.00000f],
    [ 0.0000f, -1.5000f,  0.07500f],
    [ 0.0000f, -1.4250f,  0.00000f],
    [ 1.5000f, -0.8400f,  0.07500f],
    [ 0.8400f, -1.5000f,  0.07500f],
]

let tex: array[2, array[2, array[2, float32]]] = [
  [ [0.0f, 0.0f],
    [1.0f, 0.0f]],
  [ [0.0f, 1.0f],
    [1.0f, 1.0f]]
]

#[ *INDENT-ON* ]#


proc teapot(grid: GLint; scale: float32; typ: GLenum): void =

  var
    p: array[4, array[4, array[3, float32]]],
    q: array[4, array[4, array[3, float32]]],
    r: array[4, array[4, array[3, float32]]],
    s: array[4, array[4, array[3, float32]]]


  glPushAttrib(GL_ENABLE_BIT or GL_EVAL_BIT)
  glEnable(GL_AUTO_NORMAL)
  glEnable(GL_NORMALIZE)

  glEnable(GL_MAP2_VERTEX_3)
  glEnable(GL_MAP2_TEXTURE_COORD_2)

  glPushMatrix()
  glRotatef(270.0, 1.0, 0.0, 0.0)
  glScalef(0.5 * scale, 0.5 * scale, 0.5 * scale)
  glTranslatef(0.0, 0.0, -1.5)

  for i in 0 ..< 10:
    for j in 0 ..< 4:
      for k in 0 ..< 4:
        for l in 0 ..< 3:
          p[j][k][l] = cpdata[patchdata[i][j * 4 + k]][l]
          q[j][k][l] = cpdata[patchdata[i][j * 4 + (3 - k)]][l]
          if l == 1:
            q[j][k][l] *= -1.0
          if i < 6:
            r[j][k][l] =
              cpdata[patchdata[i][j * 4 + (3 - k)]][l]
            if l == 0:
              r[j][k][l] *= -1.0
            s[j][k][l] = cpdata[patchdata[i][j * 4 + k]][l]
            if l == 0:
              s[j][k][l] *= -1.0
            if l == 1:
              s[j][k][l] *= -1.0

    glMap2f(GL_MAP2_TEXTURE_COORD_2, 0, 1, 2, 2, 0, 1, 2*2, 2, &tex[0][0][0])
    glMap2f(GL_MAP2_VERTEX_3,        0, 1, 3, 4, 0, 1, 3*4, 4, &p[0][0][0])

    # glMapGrid2f(grid, 0.0, 1.0, grid, 0.0, 1.0)
    let
      un = grid
      vn = grid
      u1 = 0
      u2 = 1
      v1 = 0
      v2 = 1

      du = (u2 - u1) / un
      dv = (v2 - v1) / vn

    glEvalMesh2(type, 0, grid, 0, grid)

    for i in 0 ..< grid:
      glBegin( GL_QUAD_STRIP )
      for j in 0 ..< grid:
        let u = u1 + i * du
        for v in [v1 + j * dv, v1 + j * dv + dv]:
          # eval tex coord
          let texCoord = vec2f(u,v)

          var position: Vec3f

          glEvalCoord2( u, v )
      glEnd()

    glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, &q[0][0][0])
    glEvalMesh2(type, 0, grid, 0, grid)




    if (i < 6) {
      glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4,
        &r[0][0][0])
      glEvalMesh2(type, 0, grid, 0, grid)
      glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4,
        &s[0][0][0])
      glEvalMesh2(type, 0, grid, 0, grid)
    }
  }
  glPopMatrix()
  glPopAttrib()
}

#[ CENTRY ]#
void GLUTAPIENTRY
glutSolidTeapot(GLdouble scale)
{
  teapot(7, scale, GL_FILL)
}

void GLUTAPIENTRY
glutWireTeapot(GLdouble scale)
{
  teapot(10, scale, GL_LINE)
}

#[ ENDCENTRY ]#
