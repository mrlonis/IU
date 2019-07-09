//
//  Shader.vsh
//  templateGLES3
//
//  Created by Mitja Hmeljak on 2018-01-24.
//  Copyright © 2018 B481/B581 Spring 2018. All rights reserved.
//

#version 300 es

// define incoming variables:

uniform float u_FoV;
uniform float u_Aspect;
uniform float u_Near;
uniform float u_Far;

uniform float u_Tx;
uniform float u_Ty;

in vec4 a_Position;



// define outgoing (varying) variables:

out vec2 var_Position;



// function that computes a 3D translation matrix:
mat4 myTranslate(float pTX, float pTY, float pTZ) {
    // the returned matrix is defined "transposed", i.e. the last row
    //   is really the last column as used in matrix multiplication:
    return mat4(  1.0,         0.0,         0.0,      0.0,
                  0.0,         1.0,         0.0,      0.0,
                  0.0,         0.0,         1.0,      0.0,
                  pTX,         pTY,         pTZ,      1.0   );
}

// function that computes a 3D perspective transformation matrix:
mat4 myGLUPerspective(in float pFoV, in float pAspect, in float pNear, in float pFar)  {

    mat4 lPerspectiveMatrix = mat4(0.0);

    float lAngle = (pFoV / 180.0) * 3.14159;
    float lFocus = 1.0 / tan ( lAngle * 0.5 );


    lPerspectiveMatrix[0][0] = lFocus / pAspect;
    lPerspectiveMatrix[1][1] = lFocus;
    lPerspectiveMatrix[2][2] = (pFar + pNear) / (pNear - pFar);
    lPerspectiveMatrix[2][3] = -1.0;
    lPerspectiveMatrix[3][2] = (2.0 * pFar * pNear) / (pNear - pFar);

    return lPerspectiveMatrix;
}

void main() {

    //  define a projectionMatrix using myGLUPerspective()
    //  with perspective parameters as from uniform variables:
    mat4 projectionMatrix = myGLUPerspective(u_FoV, u_Aspect, u_Near, u_Far);


    //  define a viewMatrix using myTranslate()
    //  with translation parameters as from Tx, Ty camera position uniform variables:
    mat4 viewMatrix = myTranslate(-u_Tx, -u_Ty, -30.0);

    // the predefined (and compulsory!) gl_Position variable is assigned a value:
    gl_Position = projectionMatrix * viewMatrix * a_Position;

    // the value for var_Position is set in this vertex shader,
    // then it goes through the interpolator before being
    // received (interpolated!) by a fragment shader:
    var_Position = gl_Position.xy;
}

