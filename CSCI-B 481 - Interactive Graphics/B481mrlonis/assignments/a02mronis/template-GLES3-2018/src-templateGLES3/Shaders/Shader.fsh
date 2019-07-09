/**
 * Shader.fsh
 *
 * Created By: Mitja Hmeljak
 * Created On: 24 January 2018
 * Last Modified By: Matthew Lonis (mrlonis)
 * Last Modified On: 19 March 2018
 *
 * Part Of: Assignment 2
 */

#version 300 es

precision mediump float;

uniform vec4 u_Color;

// define an outgoing variable:

out vec4 o_FragColor;

void main() {
    o_FragColor = vec4( u_Color.r, u_Color.g, u_Color.b, u_Color.a );
}
