/**
 * Shader.vsh
 *
 * Created By: Mitja Hmeljak
 * Created On: 24 January 2018
 * Last Modified By: Matthew Lonis (mrlonis)
 * Last Modified On: 19 March 2018
 *
 * Part Of: Assignment 2
 */

#version 300 es

// define incoming variables:

uniform float u_Width;
uniform float u_Height;

in vec4 a_Position;

uniform int u_spline_type;
uniform int u_draw_spline;

/**
 * Control Points
 */
uniform vec4 u_p0;
uniform vec4 u_p1;
uniform vec4 u_p2;
uniform vec4 u_p3;

uniform float u_t_inc;

// a function to compute 2D orthogonal projection:
mat4 myOrtho2D(float pLeft, float pRight, float pBottom, float pTop) {
    float lNear = -1.0;
    float lFar = 1.0;
    float rl = pRight-pLeft;
    float tb = pTop-pBottom;
    float fn = lFar-lNear;
    // the returned matrix is defined "transposed", i.e. the last row
    //   is really the last column as used in matrix multiplication:
    return mat4(2.0/rl,             0.0,                0.0,              0.0,
                0.0,                2.0/tb,             0.0,              0.0,
                0.0,                0.0,                -2.0/fn,          0.0,
                -(pRight+pLeft)/rl, -(pTop+pBottom)/tb, -(lFar+lNear)/fn, 1.0);
}

float f10(float t) {
    /**
     * 0 = bezier
     * 1 = Catmull-Rom
     * 2 = B-Spline
     */
    if (u_spline_type == 0) {
        return t;
    } else if (u_spline_type == 1) {
        return t + 1.0;
    } else if (u_spline_type == 2) {
        return (t + 2.0) / 3.0;
    } else {
        return t;
    }
}

float f11(float t) {
    /**
     * 0 = bezier
     * 1 = Catmull-Rom
     * 2 = B-Spline
     */
    if (u_spline_type == 0 || u_spline_type == 1) {
        return t;
    } else if (u_spline_type == 2) {
        return (t + 1.0) / 3.0;
    } else {
        return t;
    }
}

float f12(float t) {
    /**
     * 0 = bezier
     * 1 = Catmull-Rom
     * 2 = B-Spline
     */
    if (u_spline_type == 0) {
        return t;
    } else if (u_spline_type == 1) {
        return t - 1.0;
    } else if (u_spline_type == 2) {
        return t / 3.0;
    } else {
        return t;
    }
}

float f20(float t) {
    /**
     * 0 = bezier
     * 1 = Catmull-Rom
     * 2 = B-Spline
     */
    if (u_spline_type == 0) {
        return t;
    } else if (u_spline_type == 1 || u_spline_type == 2) {
        return (t + 1.0) / 2.0;
    } else {
        return t;
    }
}

float f21(float t) {
    /**
     * 0 = bezier
     * 1 = Catmull-Rom
     * 2 = B-Spline
     */
    if (u_spline_type == 0) {
        return t;
    } else if (u_spline_type == 1 || u_spline_type == 2) {
        return t / 2.0;
    } else {
        return t;
    }
}

float f3(float t) {
    return t;
}

vec4 linear(vec4 p0, vec4 p1, float t) {
    return ((1.0 - t) * p0) + (t * p1);
}

vec4 spline_position(float t) {
    // Comment: 1st level of interpolation reduces 4 controls to 3 outputs
    vec4 p10 = linear(u_p0, u_p1, f10(t));
    vec4 p11 = linear(u_p1, u_p2, f11(t));
    vec4 p12 = linear(u_p2, u_p3, f12(t));
    
    // Comment: 2nd level of interpolation reduces 3 outputs to 2 outputs
    vec4 p20 = linear(p10, p11, f20(t));
    vec4 p21 = linear(p11, p12, f21(t));
    
    // Comment: last level returns interpolation of last two outputs
    return linear(p20, p21, f3(t));
}

// the main program for the Vertex Shader
void main() {
    mat4 projectionMatrix = myOrtho2D(0.0, u_Width, 0.0, u_Height);
    
    gl_PointSize = 20.0;
    
    if (u_draw_spline == 0) {
        gl_Position = projectionMatrix * a_Position;
    } else if (u_draw_spline == 1) {
        float t = a_Position.x * u_t_inc;
        
        vec4 new_position = spline_position(t);
        
        gl_Position = projectionMatrix * new_position;
    }
}
