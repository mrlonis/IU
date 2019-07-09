/*
 * Shader.vsh
 *
 * Created by: Mitja Hmeljak
 * Created on: 23 February 2018
 * Last Modified by: Matthew Lonis
 * Last Modified on: 2 May 2018
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
in vec3 a_Normal;
in vec2 a_TextureCoordinates;

/*
 * Assignment 3 Added Variables
 */
uniform mat4 u_projectionMatrix;
uniform mat4 u_viewingTransformation;
uniform mat4 u_modelingTransformation;

uniform vec3 u_Light_position;
uniform vec3 u_Light_color;
uniform float u_Shininess;
uniform vec3 u_Ambient_color;

/*
 * define a "varying" outgoing variable,
 */
out vec4 v_Color;
out vec3 v_Vertex;
out vec3 v_Normal;
out vec3 v_Light_position;
out vec2 var_TextureCoordinates;

/*
 * here starts the main program for the Vertex Shader
 */
void main() {
    gl_PointSize = 10.0;
    
    gl_Position = (u_projectionMatrix * (u_viewingTransformation * (u_modelingTransformation * a_Position)));
    
    v_Vertex = vec3((u_viewingTransformation * (u_modelingTransformation * a_Position)));
    v_Normal = vec3((u_viewingTransformation * (u_modelingTransformation * vec4(a_Normal, 0.0))));
    v_Color = u_Color;
    v_Light_position = vec3(u_viewingTransformation * vec4(u_Light_position, 0.0));
    
    var_TextureCoordinates = a_TextureCoordinates;
}
