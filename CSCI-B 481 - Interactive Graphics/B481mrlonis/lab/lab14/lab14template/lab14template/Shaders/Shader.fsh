//
//  Shader.fsh
//  lab04
//
//  Created by Mitja Hmeljak on 2018-01-24.
//  Copyright © 2018 B481/B581 Spring 2018. All rights reserved.
//

#version 300 es


precision mediump float;

// define incoming variables:

in vec2 var_Position;

in vec2 var_TextureCoordinates;

uniform vec4 u_Color;

uniform sampler2D u_TextureSampler;


// define an outgoing variable:

out vec4 o_FragColor;

void main() {

    //    o_FragColor = vec4( u_Color.r, u_Color.g, u_Color.b, u_Color.a );

    vec4 colorVec = vec4( abs(var_Position.y), abs(var_Position.x), abs(var_Position.y), 1 );

    o_FragColor = colorVec * texture(u_TextureSampler, var_TextureCoordinates);

}

