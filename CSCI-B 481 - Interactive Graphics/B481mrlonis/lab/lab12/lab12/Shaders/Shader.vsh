/*
 * Shader.vsh
 *
 * Created by: Mitja Hmeljak
 * Created on: 23 February 2018
 * Last Modified by: Matthew Lonis
 * Last Modified on: 30 March 2018
 */

#version 300 es

/*
 * define "uniform" incoming variables:
 */
uniform float u_Width;
uniform float u_Height;

/*
 * define "attribute" incoming variable:
 */
in vec4 a_Position;

/*
 * Lab 11 added variables
 */
uniform float u_FoV;
uniform float u_Aspect;
uniform float u_Near;
uniform float u_Far;

/*
 * Lab 12 added variables
 */
uniform float u_Tx;
uniform float u_Ty;
uniform float u_Tz;

/*
 * Lab 11 Added Function
 *
 * function that computes a 3D translation matrix:
 */
mat4 myTranslate(float pTX, float pTY, float pTZ) {
    // the returned matrix is defined "transposed", i.e. the last row
    //   is really the last column as used in matrix multiplication:
    return mat4(1.0,         0.0,         0.0,      0.0,
                0.0,         1.0,         0.0,      0.0,
                0.0,         0.0,         1.0,      0.0,
                pTX,         pTY,         pTZ,      1.0);
}

/*
 * Lab 11 Added Function
 *
 * function that computes a 3D perspective transformation matrix:
 */
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

/*
 * a provided function to compute 2D orthogonal projection:
 */
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

mat4 translation_matrix(float tx, float ty, float tz) {
    return mat4(1.0, 0.0, 0.0, 0.0,
               0.0, 1.0, 0.0, 0.0,
               0.0, 0.0, 1.0, 0.0,
               tx, ty, tz, 1.0);
}

mat4 scaling_matrix(float sx, float sy, float sz) {
    return mat4(sx, 0.0, 0.0, 0.0,
               0.0, sy, 0.0, 0.0,
               0.0, 0.0, sz, 0.0,
               0.0, 0.0, 0.0, 1.0);
}


/**
 * if xyz == 0 - x-axis rotation
 * if xyz == 1 - y-axis rotation
 * if xyz == 2 - z-axis rotation
 */
mat4 rotation_matrix(float degrees, int xyz) {
    if (xyz == 0) {
        return mat4(1.0, 0.0, 0.0, 0.0,
                    0.0, cos(degrees * (3.141592/180.0)), sin(degrees * (3.141592/180.0)), 0.0,
                    0.0, (-1.0 * sin(degrees * (3.141592/180.0))), cos(degrees * (3.141592/180.0)), 0.0,
                    0.0, 0.0, 0.0, 1.0);
    } else if (xyz == 1) {
        return mat4(cos(degrees * (3.141592/180.0)), 0.0, (-1.0 * sin(degrees * (3.141592/180.0))), 0.0,
                    0.0, 1.0, 0.0, 0.0,
                    sin(degrees * (3.141592/180.0)), 0.0, cos(degrees * (3.141592/180.0)), 0.0,
                    0.0, 0.0, 0.0, 1.0);
    } else if (xyz == 2) {
        return mat4(cos(degrees * (3.141592/180.0)), sin(degrees * (3.141592/180.0)), 0.0, 0.0,
                    (-1.0 * sin(degrees * (3.141592/180.0))), cos(degrees * (3.141592/180.0)), 0.0, 0.0,
                    0.0, 0.0, 1.0, 0.0,
                    0.0, 0.0, 0.0, 1.0);
    }
}

/*
 * define a "varying" outgoing variable,
 * in this case it's not really used for anything,
 * just showing how a varying variable can be passed to the fragment shader:
 */
out vec2 var_Position;

/*
 * here starts the main program for the Vertex Shader
 */
void main() {
    /*
     * TODO for Lab 11: define a projectionMatrix using myGLUPerspective()
     * with perspective parameters as from provided new uniform variables
     *
     * Old projectionMatrix code:
     *
     * mat4 projectionMatrix = myOrtho2D(0.0, u_Width, 0.0, u_Height);
     */
    mat4 projectionMatrix = myGLUPerspective(u_FoV, u_Aspect, u_Near, u_Far);
    
    /*
     * TODO for Lab 11: define a modelViewMatrix using myTranslate()
     * with translation parameters Tx = 0, Ty = 0, Tz = -500
     */
    mat4 modelViewMatrix = myTranslate(0.0, 0.0, -20.0);
    
    /*
     * this could be changed for "highlighting" a specific primitive:
     */
    gl_PointSize = 10.0;
    
    /*
     * the *mandatory* output for every vertex shader
     * is the gl_Position variable, which musts be set:
     */
    gl_Position = projectionMatrix * modelViewMatrix * (translation_matrix(u_Tx, u_Ty, u_Tz) * a_Position);
    /*
     * the value for var_Position is set in this vertex shader,
     * then it goes through the interpolator before being
     * received (interpolated!) by a fragment shader:
     */
    var_Position = gl_Position.xy;
}
