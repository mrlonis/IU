//
//  Shader.fsh
//  templateGLES3
//
//  Created by Mitja Hmeljak on 2018-01-24.
//  Copyright © 2018 B481/B581 Spring 2018. All rights reserved.
//

#version 300 es


precision mediump float;

// define incoming variables:

in vec2 var_Position;

uniform vec4 u_Color;


// define an outgoing variable:

out vec4 o_FragColor;

void main() {
    // TODO: you may try using the incoming var_Position variable
    //   from the vertex shader to set color values
    //   smoothly varying within a line segment.
    // e.g. from full color on one vertex,
    //   to another color in the middle of the line segment,
    //   and back to full color on the other vertex
    // Hint: you may use abs(...)
    o_FragColor = vec4( u_Color.r, u_Color.g, u_Color.b, u_Color.a );
}

