//
//  Shader.vsh
//  a01solution
//
//  Created by Mitja Hmeljak on 2018-02-23.
//  Copyright  2018 B481 Spring 2018. All rights reserved.
//

#version 300 es

// define "uniform" incoming variables:

uniform float u_Width;
uniform float u_Height;

// define "attribute" incoming variable:

in vec4 a_Position;

// a provided function to compute 2D orthogonal projection:
mat4 myOrtho2D(float pLeft, float pRight, float pBottom, float pTop) {
    float lNear = -1.0;
    float lFar = 1.0;
    float rl = pRight-pLeft;
    float tb = pTop-pBottom;
    float fn = lFar-lNear;
    // the returned matrix is defined "transposed", i.e. the last row
    //   is really the last column as used in matrix multiplication:
    return mat4(  2.0/rl,                0.0,              0.0,  0.0,
                0.0,             2.0/tb,              0.0,  0.0,
                0.0,                0.0,          -2.0/fn,  0.0,
                -(pRight+pLeft)/rl, -(pTop+pBottom)/tb, -(lFar+lNear)/fn,  1.0 );
}

// define a "varying" outgoing variable,
//   in this case it's not really used for anything,
//   just showing how a varying variable can be passed to the fragment shader:
out vec2 var_Position;


// here starts the main program for the Vertex Shader
void main() {

    mat4 projectionMatrix = myOrtho2D(0.0, u_Width, 0.0, u_Height);

    // this could be changed for "highlighting" a specific primitive:
    gl_PointSize = 10.0;

    // the *mandatory* output for every vertex shader
    //   is the gl_Position variable, which musts be set:
    gl_Position = projectionMatrix * a_Position;

    // the value for var_Position is set in this vertex shader,
    // then it goes through the interpolator before being
    // received (interpolated!) by a fragment shader:
    var_Position = gl_Position.xy;
}
