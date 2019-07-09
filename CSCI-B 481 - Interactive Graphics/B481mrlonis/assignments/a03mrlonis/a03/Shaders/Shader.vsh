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
 * Define "uniform" incoming color variable
 */
uniform vec4 u_Color;

/*
 * define "attribute" incoming variable:
 */
in vec4 a_Position;

/*
 * Assignment 3 Added Variables
 */
uniform mat4 u_projectionMatrix;
uniform mat4 u_viewingTransformation;
uniform mat4 u_modelingTransformation;

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
// out vec2 var_Position;
out vec3 v_Position;    // This will be passed into the fragment shader.
out vec4 v_Color;       // This will be passed into the fragment shader.
out vec3 v_Normal;      // This will be passed into the fragment shader.

/*
 * here starts the main program for the Vertex Shader
 */
void main() {
    gl_PointSize = 10.0;
    
    gl_Position = (u_projectionMatrix * (u_viewingTransformation * (u_modelingTransformation * a_Position)));
    
    vec3 x_line = vec3(a_Position.x + 5.0, a_Position.y, a_Position.z);
    vec3 y_line = vec3(a_Position.x, a_Position.y + 5.0, a_Position.z);
    vec3 z_line = vec3(a_Position.x, a_Position.y, a_Position.z + 5.0);
    
    vec3 direction = (y_line - x_line) * (z_line - x_line);
    vec3 a_Normal = direction / length(direction);
    
    v_Position = vec3(u_viewingTransformation * (u_modelingTransformation * a_Position));
    v_Color = u_Color;
    v_Normal = vec3((u_viewingTransformation * (u_modelingTransformation * a_Position)) * vec4(a_Normal, 0.0));
}
