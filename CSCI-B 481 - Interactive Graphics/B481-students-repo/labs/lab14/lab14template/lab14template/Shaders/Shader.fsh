//
//  Shader.fsh
//  lab14
//
//  Created by Mitja Hmeljak on 2018-04-20.
//  Copyright © 2018 B481/B581 Spring 2018. All rights reserved.
//

#version 300 es


precision mediump float;

// define incoming variables:

// varying variables from the vertex shader:
in vec2 var_Position;
in vec2 var_TextureCoordinates;

// uniform variables from the CPU:
uniform vec4 u_Color;
uniform sampler2D u_TextureSampler;


// define an outgoing variable:

out vec4 o_FragColor;


void main() {

    // a fixed-color fragment shader would be:
    //    o_FragColor = vec4( u_Color.r, u_Color.g, u_Color.b, u_Color.a );

    // here we compute a color to be used for the current fragment,
    //    from the var_Position variable received (interpolated) from the vertex shader:
    //    (this may be replaced with illumination equation results)
    vec4 colorVec = vec4( abs(var_Position.y), abs(var_Position.x), abs(var_Position.y), 1 );
    //  to add illumination, this needs to be assigned the output of the illumination equation:
    //  vec4 colorVec = vec4( abs(var_Position.y), abs(var_Position.x), abs(var_Position.y), 1 );

    // here we combine the computed color for the fragment
    //    with the color value obtained from the texture map:
    //    (equivalent to GL_MODULATE in fixed pipeline)
    o_FragColor = colorVec * texture(u_TextureSampler, var_TextureCoordinates);

}

