//  a01 sample solution
//
//  Mitja Hmeljak - CSCI B481 Spring 2018
//


//    https://www.cs.indiana.edu/classes/b481/

var gl;
var canvas;
var a_Position;
var u_Width;
var u_Height;
var u_Color;
var bufferId;

var MODES = { E_MODE_INSERT:0, E_MODE_PROXIMITY:1, E_MODE_EDIT:2 };
var mode = MODES.E_MODE_INSERT;

var vertices;
// SOLUTION BEGIN
var num_verts = 0;
var high_vert; // vertex to highlight
var num_high_verts; // =1 if vertex highlighting, =2 if edge highlighting
// SOLUTION END
var colors;
var COLORS = { RED:0, GREEN:1, BLUE:2, WHITE:3 };

var mouseXbegin;
var mouseYbegin;
var mouseXcurrent;
var mouseYcurrent;
var mouseXold;
var mouseYold;

var mouseDownFlag = false;

window.onload = function init()
{
    canvas = document.getElementById( "gl-canvas" );
    
    gl = WebGLUtils.setupWebGL( canvas );
    if ( !gl ) { alert( "WebGL isn't available" ); }

    // Set up our event handlers for mouse events
    canvas.onmousedown = handleMouseDown;
    canvas.onmousemove = handleMouseMove;
    canvas.onmouseup = handleMouseUp;
    
    // Vertex data structured:
    // positionX, positionY
    vertices = new Float32Array([0, 0,
                                 1, 1,
                                -1, -1,
                                 0, 0,
                                 0, 0,
                                 1, 1,
                                -1, -1,
                                 0, 0,
                                 0, 0,
                                 1, 1,
                                -1, -1,
                                 0, 0]);

    // Colors in RGBA fomat
    colors = [new Float32Array([1,0,0,1]), // red
              new Float32Array([0,1,0,1]), // green
              new Float32Array([0,0,1,1]), // blue
              new Float32Array([1,1,1,1])] // white
    
    //  Configure WebGL

    gl.viewport( 0, 0, canvas.width, canvas.height );
    gl.clearColor( 0.0, 0.0, 0.0, 1.0 );
    
    //  Load shaders and initialize attribute buffers
    
    var program = initShaders( gl, "vertex-shader", "fragment-shader" );
    gl.useProgram( program );
    
    // Load the data into the GPU
    
    bufferId = gl.createBuffer();
    gl.bindBuffer( gl.ARRAY_BUFFER, bufferId );
    gl.bufferData( gl.ARRAY_BUFFER,vertices, gl.STATIC_DRAW ); // write our vertices array to the buffer
    
    // Associate out shader variables with our data buffer
    // Each vertex will have a value for each attribute
    // In this case, each vertex will have its own position
    
    a_Position = gl.getAttribLocation( program, "a_Position" );
    gl.vertexAttribPointer( a_Position, 2, gl.FLOAT, false, 0, 0 );
    gl.enableVertexAttribArray( a_Position );

    // Get a pointer to our uniforms in the shader and initialize
    
    u_Width = gl.getUniformLocation( program, "u_Width"); // get pointer
    gl.uniform1f( u_Width, canvas.width); // send value to shader
    u_Height = gl.getUniformLocation( program, "u_Height"); // get pointer
    gl.uniform1f( u_Height, canvas.height	); // send value to shader
    u_Color = gl.getUniformLocation( program, "u_Color"); // get pointer
    gl.uniform4fv( u_Color, colors[0]); // send value to shader

    render();
    
};

function render() {
    gl.clear( gl.COLOR_BUFFER_BIT );
    
    // Load vertices to GPU
    gl.bindBuffer( gl.ARRAY_BUFFER, bufferId );
    gl.bufferData( gl.ARRAY_BUFFER,vertices, gl.STATIC_DRAW );
    
    // Enable which attributes the buffer data will use
    gl.enableVertexAttribArray( a_Position );

    // SOLUTION BEGIN    
    // Set the color for drawing the vertices
    gl.uniform4fv( u_Color, colors[COLORS.RED]);
    // Draw the lines
    gl.drawArrays( gl.LINE_STRIP, 0, num_verts)
    // Draw the points
    gl.drawArrays( gl.POINTS, 0, num_verts);

    if (mode == MODES.E_MODE_PROXIMITY || mode == MODES.E_MODE_EDIT) {
        // Set the color for drawing the highlighted point
        gl.uniform4fv( u_Color, colors[COLORS.WHITE]);
        gl.drawArrays( gl.LINE_STRIP, high_vert, num_high_verts)
        gl.drawArrays( gl.POINTS, high_vert, num_high_verts);
    }
    // SOLUTION END
}

/// SOLUTION BEGIN
// ------------------------------------------------------------------------
// Utility Functions
// ------------------------------------------------------------------------
function testForProx(x0, y0) {
    // test for point proximimity 
    for (var i=0; i<num_verts; i++) {
        var x1 = vertices[i*2];
        var y1 = vertices[i*2 + 1];
        var dist = Math.sqrt( (x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1) );
        // if closer than 20 pixels, mark the vertex for highlighting
        if (dist < 20) {
            high_vert = i;
            num_high_verts = 1;
            mode = MODES.E_MODE_PROXIMITY;
            return;
        }
    }

    // test for line proximity
    for (var i=0; i<(num_verts-1); i++) {
        x1 = vertices[i*2];
        y1 = vertices[i*2 + 1];
        var x2 = vertices[i*2 + 2];
        var y2 = vertices[i*2 + 3];
        // calculate orthogonal unit vector n
        var nx = -(y2-y1);
        var ny = (x2-x1);
        console.log("n:", nx, ny)
        var n_mag = Math.sqrt(nx*nx + ny*ny); 
        nx /= n_mag;
        ny /= n_mag;
        console.log("|n|", nx, ny)
        // calculate h
        var h = Math.abs( nx * (x0-x1) + ny * (y0-y1) );
        console.log("h:", h)
        // if (x0,y0) is within 15 pixels of the edge
        if (h < 15) {
            // calculate unit vector v
            var vx = (x2-x1);
            var vy = (y2-y1);
            var v_mag = Math.sqrt(vx*vx + vy*vy);
            vx /= v_mag;
            vy /= v_mag;
            // calculate l
            var l = ( vx * (x0-x1) + vy * (y0-y1) );
            console.log("l:",l);
            // if (x0,y0) is on the line segment, mark the edge for highlighting
            if ( (l>=0) && (l<v_mag) ) {
                high_vert = i;
                num_high_verts = 2;
                mode = MODES.E_MODE_PROXIMITY;
                return;
            }
        }
    }
}
// SOLUTION END

// ------------------------------------------------------------------------
// Handlers for mouse events
// ------------------------------------------------------------------------
// Note: Canvas coordinates have (0,0) at top left
//       y coordinates of mouse are transformed to have (0,0) at bottom left

function handleMouseDown(event) {
    mouseDownFlag = true;
    
    mouseXbegin = event.clientX - canvas.getBoundingClientRect().left;
    mouseYbegin = canvas.height - (event.clientY - canvas.getBoundingClientRect().top);
    
    console.log("Mouse Down at (" + mouseXbegin + ", " + mouseYbegin + ")");
    
    mouseXcurrent = mouseXbegin;
    mouseYcurrent = mouseYbegin;
    
    mouseXold = mouseXcurrent;
    mouseYold = mouseYcurrent;

    // SOLUTION BEGIN
    testForProx(mouseXcurrent, mouseYcurrent);
    
    if (mode==MODES.E_MODE_INSERT && num_verts<10) {
        vertices[num_verts*2] = mouseXcurrent;
        vertices[num_verts*2 + 1] = mouseYcurrent;
        num_verts++;
    }   
    // SOLUTION END

    render();
}

function handleMouseMove(event) {
    // Cancel execution if mouse is not down
    if (! mouseDownFlag) return;
    
    mouseXold = mouseXcurrent;
    mouseYold = mouseYcurrent;
    
    mouseXcurrent = event.clientX - canvas.getBoundingClientRect().left;
    mouseYcurrent = canvas.height - (event.clientY - canvas.getBoundingClientRect().top);
    
    console.log("Mouse Moved to (" + mouseXcurrent + ", " + mouseYcurrent + ")");
    
    // SOLUTION BEGIN
    // if vertices are highlighted, edit these vertices
    if (mode==MODES.E_MODE_INSERT) {
    	vertices[(num_verts-1)*2] += mouseXcurrent - mouseXold;
        vertices[(num_verts-1)*2 + 1] += mouseYcurrent - mouseYold;
    }
    else if (mode == MODES.E_MODE_PROXIMITY)
        mode = MODES.E_MODE_EDIT;
    else if (mode == MODES.E_MODE_EDIT) {
        for (var i=0; i<num_high_verts; i++) {
            vertices[high_vert*2 + i*2] += mouseXcurrent - mouseXold;
            vertices[high_vert*2 + i*2 + 1] += mouseYcurrent - mouseYold;
        }
    }
    // SOLUTION END

    render();
}

function handleMouseUp(event) {
    mouseDownFlag = false;
    
    mouseXold = mouseXcurrent;
    mouseYold = mouseYcurrent;
    
    mouseXcurrent = event.clientX - canvas.getBoundingClientRect().left;
    mouseYcurrent = canvas.height - (event.clientY - canvas.getBoundingClientRect().top);
    
    console.log("Mouse Up at (" + mouseXcurrent + ", " + mouseYcurrent + ")");
    
    // SOLUTION BEGIN
    mode = MODES.E_MODE_INSERT;
    // SOLUTION END

    render();
}
