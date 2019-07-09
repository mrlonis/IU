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

// define incoming "varying" variable:

in vec2 var_Position;

// define incoming "uniform" variable:

uniform vec4 u_Color;


// define an outgoing variable:

out vec4 o_FragColor;

void main() {
    // EXTRA TODO: try using the varying var_Position variable from the vertex shader
    // to set color values smoothly varying within a line segment:
    // e.g. from full color on one vertex,
    //   to another color in the middle of the line segment,
    //   and back to full color on the other vertex
    // Hint: you may use abs(...)
    o_FragColor = vec4( u_Color.r, u_Color.g, u_Color.b, u_Color.a );
}
