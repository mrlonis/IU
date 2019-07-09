/*
 * Shader.fsh
 *
 * Created by: Mitja Hmeljak
 * Created on: 23 February 2018
 * Last Modified by: Matthew Lonis
 * Last Modified on: 2 May 2018
 */

#version 300 es

precision mediump float;

// Light model
uniform vec3 u_Light_position;
uniform vec3 u_Light_color;
uniform float u_Shininess;
uniform vec3 u_Ambient_color;
uniform sampler2D u_TextureSampler;
uniform float u_Draw_Light;

// define incoming "varying" variable:
in vec4 v_Color;
in vec3 v_Vertex;
in vec3 v_Normal;
in vec3 v_Light_position;
in vec2 var_TextureCoordinates;

// define an outgoing variable:

out vec4 o_FragColor;

void main() {
    if (u_Draw_Light == 0.0) {
        vec3 to_light;
        vec3 vertex_normal;
        vec3 reflection;
        vec3 to_camera;
        float cos_angle;
        vec3 diffuse_color;
        vec3 specular_color;
        vec3 ambient_color;
        vec3 color;
        
        ambient_color = u_Ambient_color * vec3(v_Color);
        
        // Calculate a vector from the fragment location to the light source
        to_light = v_Light_position - v_Vertex;
        to_light = normalize( to_light );
        
        vertex_normal = normalize( v_Normal );
        
        cos_angle = dot(vertex_normal, to_light);
        cos_angle = clamp(cos_angle, 0.0, 1.0);
        
        diffuse_color = vec3(v_Color) * cos_angle;
        
        // Calculate the reflection vector
        reflection = 2.0 * dot(vertex_normal,to_light) * vertex_normal - to_light;
        
        to_camera = -1.0 * v_Vertex;
        
        // Calculate the cosine of the angle between the reflection vector and the vector going to the camera.
        reflection = normalize( reflection );
        to_camera = normalize( to_camera );
        cos_angle = dot(reflection, to_camera);
        cos_angle = clamp(cos_angle, 0.0, 1.0);
        cos_angle = pow(cos_angle, u_Shininess);
        
        if (cos_angle > 0.0) {
            specular_color = u_Light_color * cos_angle;
            diffuse_color = diffuse_color * (1.0 - cos_angle);
        } else {
            specular_color = vec3(0.0, 0.0, 0.0);
        }
        
        color = ambient_color + diffuse_color + specular_color;
        o_FragColor = vec4(color, v_Color.a) * texture(u_TextureSampler, var_TextureCoordinates);
    } else if (u_Draw_Light == 1.0) {
        o_FragColor = v_Color;
    }
}
