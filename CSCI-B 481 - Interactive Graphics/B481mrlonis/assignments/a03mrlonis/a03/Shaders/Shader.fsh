/*
 * Shader.fsh
 *
 * Created by: Mitja Hmeljak
 * Created on: 23 February 2018
 * Last Modified by: Matthew Lonis
 * Last Modified on: 30 March 2018
 */

#version 300 es

precision mediump float;

uniform vec3 u_LightPos;

// define incoming "varying" variable:
// in vec2 var_Position;
in vec3 v_Position;
in vec4 v_Color;
in vec3 v_Normal;

// define an outgoing variable:

out vec4 o_FragColor;

void main() {
    // Will be used for attenuation.
    float distance = length(u_LightPos - v_Position);
    
    // Get a lighting direction vector from the light to the vertex.
    vec3 lightVector = normalize(u_LightPos - v_Position);
    
    // Calculate the dot product of the light vector and vertex normal. If the normal and light vector are
    // pointing in the same direction then it will get max illumination.
    float diffuse = max(dot(v_Normal, lightVector), 0.1);
    
    // Add attenuation.
    diffuse = diffuse * (1.0 / (1.0 + (0.25 * distance * distance)));
    
    // Multiply the color by the diffuse illumination level to get final output color.
    // gl_FragColor = v_Color * diffuse;
    
    o_FragColor = vec4( v_Color.r, v_Color.g, v_Color.b, v_Color.a );
    // o_FragColor = v_Color * diffuse;
}
