void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec3 black = vec3(0, 0, 0); // Black
    vec3 white = vec3(1, 1, 1); // White
    vec3 blue = vec3(0, 0, 1); // Blue
    vec3 green = vec3(0, 1, 0); // Green
    vec3 red = vec3(1, 0, 0); // Red
    
    vec3 pixel;
    
    // if the x coordinate is greater than 100 then plot color1
    // else plot color2
    float widthOfStrip = 100.0;
    if( fragCoord.x > 100.0 && fragCoord.x < 200.0) {
        pixel = blue;
    } else if (fragCoord.x > 200.0 && fragCoord.x < 300.0) {
        pixel = green;
    } else {
        pixel = red;
    }
    
    fragColor = vec4(pixel, 1.0);
}
