//
//  Shader.vsh
//  a01template
//
//  Created by Mitja Hmeljak on 2017-02-13.
//

uniform float u_Width;
uniform float u_Height;

attribute vec4 a_Position;

mat4 myOrtho2D(float pLeft, float pRight, float pBottom, float pTop) {
    float lNear = -1.0;
    float lFar = 1.0;
    float rl = pRight-pLeft;
    float tb = pTop-pBottom;
    float fn = lFar-lNear;
    // the returned matrix is defined "transposed", i.e. the last row
    //   is really the last column as used in matrix multiplication:
    return mat4(2.0/rl,             0.0,                0.0,               0.0,
                0.0,                2.0/tb,             0.0,               0.0,
                0.0,                0.0,                -2.0/fn,           0.0,
                -(pRight+pLeft)/rl, -(pTop+pBottom)/tb, -(lFar+lNear)/fn,  1.0 );
}

// define a varying variable:
varying vec2 var_Position;

void main() {

    mat4 projectionMatrix = myOrtho2D(0.0, u_Width, 0.0, u_Height);

    gl_PointSize = 10.0;

    gl_Position = projectionMatrix * a_Position;

    // the value for var_Position is set in this vertex shader,
    // then it goes through the interpolator before being
    // received (interpolated!) by a fragment shader:
    var_Position = gl_Position.xy;
}
