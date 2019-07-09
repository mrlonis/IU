/*
 * MyGLESKitViewController.swift
 *
 * Created by: Mitja Hmeljak
 * Created on: 23 February 2018
 * Last Modified by: Matthew Lonis
 * Last Modified on: 30 March 2018
 */

import GLKit
import OpenGLES

// OpenGL ES requires the use of C-like pointers to "CPU memory",
// without the automated memory management provided by Swift:
func obtainUnsafePointer(_ i: Int) -> UnsafeRawPointer? {
    return UnsafeRawPointer(bitPattern: i)
}

var gVertexData: [GLfloat] = [
    // vertex data structured thus:
    //  positionX, positionY, positionZ, etc.
    
    // X-axis
    0.0, 0.0, 0.0,      // 0
    10.0, 0.0, 0.0,     // 1
    
    // X-ticks
    0.0, 0.0, 0.0,      // 2
    0.0, 0.5, 0.0,      // 3
    0.0, 0.0, 0.0,      // 4
    0.0, 0.0, 0.5,      // 5
    
    1.0, 0.0, 0.0,      // 6
    1.0, 0.5, 0.0,      // 7
    1.0, 0.0, 0.0,      // 8
    1.0, 0.0, 0.5,      // 9
    
    2.0, 0.0, 0.0,      // 10
    2.0, 0.5, 0.0,      // 11
    2.0, 0.0, 0.0,      // 12
    2.0, 0.0, 0.5,      // 13
    
    3.0, 0.0, 0.0,      // 14
    3.0, 0.5, 0.0,      // 15
    3.0, 0.0, 0.0,      // 16
    3.0, 0.0, 0.5,      // 17
    
    4.0, 0.0, 0.0,      // 18
    4.0, 0.5, 0.0,      // 19
    4.0, 0.0, 0.0,      // 20
    4.0, 0.0, 0.5,      // 21
    
    5.0, 0.0, 0.0,      // 22
    5.0, 0.5, 0.0,      // 23
    5.0, 0.0, 0.0,      // 24
    5.0, 0.0, 0.5,      // 25

    6.0, 0.0, 0.0,      // 26
    6.0, 0.5, 0.0,      // 27
    6.0, 0.0, 0.0,      // 28
    6.0, 0.0, 0.5,      // 29
    
    7.0, 0.0, 0.0,      // 30
    7.0, 0.5, 0.0,      // 31
    7.0, 0.0, 0.0,      // 32
    7.0, 0.0, 0.5,      // 33
    
    8.0, 0.0, 0.0,      // 34
    8.0, 0.5, 0.0,      // 35
    8.0, 0.0, 0.0,      // 36
    8.0, 0.0, 0.5,      // 37
    
    9.0, 0.0, 0.0,      // 38
    9.0, 0.5, 0.0,      // 39
    9.0, 0.0, 0.0,      // 40
    9.0, 0.0, 0.5,      // 41
    
    10.0, 0.0, 0.0,     // 42
    10.0, 0.5, 0.0,     // 43
    10.0, 0.0, 0.0,     // 44
    10.0, 0.0, 0.5,     // 45
    
    // Y-axis
    0.0, 0.0, 0.0,      // 46
    0.0, 10.0, 0.0,     // 47
    
    // Y-ticks
    0.0, 0.0, 0.0,      // 48
    0.5, 0.0, 0.0,      // 49
    0.0, 0.0, 0.0,      // 50
    0.0, 0.0, 0.5,      // 51
    
    0.0, 1.0, 0.0,      // 52
    0.5, 1.0, 0.0,      // 53
    0.0, 1.0, 0.0,      // 54
    0.0, 1.0, 0.5,      // 55
    
    0.0, 2.0, 0.0,      // 56
    0.5, 2.0, 0.0,      // 57
    0.0, 2.0, 0.0,      // 58
    0.0, 2.0, 0.5,      // 59
    
    0.0, 3.0, 0.0,      // 60
    0.5, 3.0, 0.0,      // 61
    0.0, 3.0, 0.0,      // 62
    0.0, 3.0, 0.5,      // 63
    
    0.0, 4.0, 0.0,      // 64
    0.5, 4.0, 0.0,      // 65
    0.0, 4.0, 0.0,      // 66
    0.0, 4.0, 0.5,      // 67
    
    0.0, 5.0, 0.0,      // 68
    0.5, 5.0, 0.0,      // 69
    0.0, 5.0, 0.0,      // 70
    0.0, 5.0, 0.5,      // 71
    
    0.0, 6.0, 0.0,      // 72
    0.5, 6.0, 0.0,      // 73
    0.0, 6.0, 0.0,      // 74
    0.0, 6.0, 0.5,      // 75
    
    0.0, 7.0, 0.0,      // 76
    0.5, 7.0, 0.0,      // 77
    0.0, 7.0, 0.0,      // 78
    0.0, 7.0, 0.5,      // 79
    
    0.0, 8.0, 0.0,      // 80
    0.5, 8.0, 0.0,      // 81
    0.0, 8.0, 0.0,      // 82
    0.0, 8.0, 0.5,      // 83
    
    0.0, 9.0, 0.0,      // 84
    0.5, 9.0, 0.0,      // 85
    0.0, 9.0, 0.0,      // 86
    0.0, 9.0, 0.5,      // 87
    
    0.0, 10.0, 0.0,     // 88
    0.5, 10.0, 0.0,     // 89
    0.0, 10.0, 0.0,     // 90
    0.0, 10.0, 0.5,     // 91
    
    // Z-axiz
    0.0, 0.0, 0.0,      // 92
    0.0, 0.0, 10.0,     // 93
    
    0.0, 0.0, 0.0,      // 94
    0.5, 0.0, 0.0,      // 95
    0.0, 0.0, 0.0,      // 96
    0.0, 0.5, 0.0,      // 97
    
    0.0, 0.0, 1.0,      // 98
    0.5, 0.0, 1.0,      // 99
    0.0, 0.0, 1.0,      // 100
    0.0, 0.5, 1.0,      // 101
   
    0.0, 0.0, 2.0,      // 102
    0.5, 0.0, 2.0,      // 103
    0.0, 0.0, 2.0,      // 104
    0.0, 0.5, 2.0,      // 105
    
    0.0, 0.0, 3.0,      // 106
    0.5, 0.0, 3.0,      // 107
    0.0, 0.0, 3.0,      // 108
    0.0, 0.5, 3.0,      // 109
    
    0.0, 0.0, 4.0,      // 110
    0.5, 0.0, 4.0,      // 111
    0.0, 0.0, 4.0,      // 112
    0.0, 0.5, 4.0,      // 113
    
    0.0, 0.0, 5.0,      // 114
    0.5, 0.0, 5.0,      // 115
    0.0, 0.0, 5.0,      // 116
    0.0, 0.5, 5.0,      // 117
    
    0.0, 0.0, 6.0,      // 118
    0.5, 0.0, 6.0,      // 119
    0.0, 0.0, 6.0,      // 120
    0.0, 0.5, 6.0,      // 121
    
    0.0, 0.0, 7.0,      // 122
    0.5, 0.0, 7.0,      // 123
    0.0, 0.0, 7.0,      // 124
    0.0, 0.5, 7.0,      // 125

    0.0, 0.0, 8.0,      // 126
    0.5, 0.0, 8.0,      // 127
    0.0, 0.0, 8.0,      // 128
    0.0, 0.5, 8.0,      // 129
    
    0.0, 0.0, 9.0,      // 130
    0.5, 0.0, 9.0,      // 131
    0.0, 0.0, 9.0,      // 132
    0.0, 0.5, 9.0,      // 133
    
    0.0, 0.0, 10.0,     // 134
    0.5, 0.0, 10.0,     // 135
    0.0, 0.0, 10.0,     // 136
    0.0, 0.5, 10.0      // 137
]

var gColorData: [[GLfloat]] = [
    // color data in RGBA float format
    [1.0, 0.0, 0.0, 1.0], // Red
    [0.0, 1.0, 0.0, 1.0], // Green
    [0.0, 0.0, 1.0, 1.0]  // Blue
]

let G_DISTANCE_VV: GLfloat = 20.0
let G_DISTANCE_VL: GLfloat = 10.0

var translate   : Int = 0;
var translate_x : GLfloat = 0.0;
var translate_y : GLfloat = 0.0;
var translate_z : GLfloat = 0.0;

enum G_LIT {
    case NONLIT
    case LITVERTEX
    case LITLINE
}

class MyGLESKitViewController: GLKViewController {
    
    var myGLESProgram: GLuint = 0
    
    var myPosAttrib: GLuint = 0
    
    var myModelViewProjectionMatrix:GLKMatrix4 = GLKMatrix4Identity
    
    var myViewPortWidth:GLsizei = -1
    var myViewPortHeight:GLsizei = -1
    
    var myWidthUniform: GLint = 0
    var myHeightUniform: GLint = 0
    var myColorUniform: GLint = 0
    
    /*
     * Lab 11 Uniform variables for Vertex shader
     */
    var myFoVUniform: GLint = 0
    var myAspectUniform: GLint = 0
    var myNearUniform: GLint = 0
    var myFarUniform: GLint = 0
    
    /*
     * Lab 12 Uniform variables for Vertex shader
     */
    var myTx: GLint = 0;
    var myTy: GLint = 0;
    var myTz: GLint = 0;
    
    var myVertexArray: GLuint = 0
    var myVertexBuffer: GLuint = 0
    
    var myGLESContext: EAGLContext? = nil
    var myGLKView: GLKView? = nil
    
    // touch event data:
    var myTouchXbegin: GLfloat = -1.0
    var myTouchYbegin: GLfloat = -1.0
    var myTouchXcurrent: GLfloat = -1.0
    var myTouchYcurrent: GLfloat = -1.0
    var myTouchXold: GLfloat = -1.0
    var myTouchYold: GLfloat = -1.0
    var myTouchPhase: UITouchPhase? = nil
    
    // polygon build data:
    var myEnteredVertices = 0
    var myLitType = G_LIT.NONLIT
    var myLitID = -1
    
    // ------------------------------------------------------------------------
    deinit {
        self.tearDownGL()
        
        if EAGLContext.current() === self.myGLESContext {
            EAGLContext.setCurrent(nil)
        }
    }
    
    // ------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller's view has loaded.
        //   It's time to initialize OpenGL ES!
        
        // Initialize a newly allocated OpenGL ES *rendering context*
        //   with the specified version of the OpenGL ES rendering API:
        self.myGLESContext = EAGLContext(api: EAGLRenderingAPI.openGLES3)
        
        if !(self.myGLESContext != nil) {
            NSLog("EAGLContext failed to initialize OpenGL ES 3 context :-( ")
            return
        }
        
        // now that the OpenGL ES rendering context is available,
        //   set our (MyGLESKitViewController's) view as a GL view:
        self.myGLKView = self.view as? GLKView
        // The GLKView directly manages a framebuffer object
        //   on our application’s behalf.
        // Our code just needs to draw into the framebuffer
        //   when the contents need to be updated.
        self.myGLKView!.context = self.myGLESContext!
        // set the *depth* (z-buffer)'s size:
        self.myGLKView!.drawableDepthFormat = GLKViewDrawableDepthFormat.format24
        // in 3D we'll often need the depth buffer, e.g.:
        // lView.drawableDepthFormat = GLKViewDrawableDepthFormat.Format24
        
        self.setupGL();
    } // end of viewDidLoad()
    
    // ------------------------------------------------------------------------
    // the system is running out of memory: clean up an abandon GLES
    // ------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if self.isViewLoaded && (self.view.window != nil) {
            self.view = nil
            
            self.tearDownGL()
            
            if EAGLContext.current() === self.myGLESContext {
                EAGLContext.setCurrent(nil)
            }
            self.myGLESContext = nil
        }
    } // end of didReceiveMemoryWarning()
    
    // ------------------------------------------------------------------------
    // initialize OpenGL ES:
    // ------------------------------------------------------------------------
    func setupGL() {
        EAGLContext.setCurrent(self.myGLESContext)
        
        
        let lGL_VERSION_ptr = glGetString(GLenum(GL_VERSION))
        //        let lGL_VERSION = String.fromCString(lGL_VERSION_ptr as! UnsafePointer<CChar>)
        let lGL_VERSION = String(cString: lGL_VERSION_ptr!)
        print("glGetString(GLenum(GL_VERSION_ptr)) = \(String(describing: lGL_VERSION_ptr))")
        print("   returned: '\(lGL_VERSION)'")
        //        print("   returns 'OpenGL ES 2.0 APPLE-12.0.40' ")
        //        print("   or 'OpenGL ES 3.0 APPLE-12.0.40' ")
        let lGL_SHADING_LANGUAGE_VERSION_ptr = glGetString(GLenum(GL_SHADING_LANGUAGE_VERSION))
        let lGL_SHADING_LANGUAGE_VERSION = String(cString: lGL_SHADING_LANGUAGE_VERSION_ptr!)
        print("glGetString(GLenum(GL_SHADING_LANGUAGE_VERSION_ptr)) = \(String(describing: lGL_SHADING_LANGUAGE_VERSION_ptr))")
        print("   returns '\(lGL_SHADING_LANGUAGE_VERSION)' ")
        //        print("   returns 'OpenGL ES GLSL ES 1.00' ")
        //        print("   or 'OpenGL ES GLSL ES 3.00' ")
        
        
        // get shaders ready -- load, compile, link GLSL code into GPU program:
        if (!self.loadShaders()) {
            self.alertUserNoShaders()
        }
        
        // in 2D, we don't need depth/Z-buffer:
        glEnable(GLenum(GL_DEPTH_TEST))
        
        // glViewport(x: GLint, _ y: GLint, _ width: GLsizei, _ height: GLsizei)
        self.myViewPortWidth = GLsizei(self.view.bounds.size.width)
        self.myViewPortHeight = GLsizei(self.view.bounds.size.height)
        
        glViewport ( 0, 0, self.myViewPortWidth, self.myViewPortHeight )
        
        // Set the background color
        glClearColor ( 0.94901960784, 0.94901960784, 0.94901960784, 1.0 )
        
    } // end of setupGL()
    
    // ------------------------------------------------------------------------
    func tearDownGL() {
        EAGLContext.setCurrent(self.myGLESContext)
        
        glDeleteBuffers(1, &myVertexBuffer)
        glDeleteVertexArrays(1, &myVertexArray)
        
        if myGLESProgram != 0 {
            glDeleteProgram(myGLESProgram)
            myGLESProgram = 0
        }
    }
    
    // ------------------------------------------------------------------------
    // user interface to alert our user about an inescapable shader problem:
    func alertUserNoShaders() {
        
        // provide an UIAlertController:
        // http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIAlertController_class/
        
        let lAlert = UIAlertController(
            title: "Alert",
            message: "I haven't been successful in creating OpenGL shaders",
            preferredStyle: UIAlertControllerStyle.alert)
        
        // the alert controller only has a "Cancel" button:
        
        let lCancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.default,
            handler: {
                (action: UIAlertAction) -> Void in
                // do nothing if "Cancel" is pressed
        }
        )
        
        // add the two actions as buttons to the alert controller:
        lAlert.addAction(lCancelAction)
        // present the alert to the user:
        present(lAlert, animated: true, completion: nil)
    }  // end of func addUser()
    
    // ------------------------------------------------------------------------
    // MARK: - GLKView and GLKViewController delegate methods
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    func update() {
        // here we could cause a periodic change in the data model
        //  e.g. 3D models to be animated, etc.
        
    } // end of update()
    
    // ------------------------------------------------------------------------
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glUseProgram(myGLESProgram)
        
        glClear( GLbitfield(GL_COLOR_BUFFER_BIT) | GLbitfield(GL_DEPTH_BUFFER_BIT) );
        
        // get viewport dimensions:
        self.myViewPortWidth = GLsizei(self.view.bounds.size.width)
        self.myViewPortHeight = GLsizei(self.view.bounds.size.height)
        
        // pass viewport dimensions to the vertex shader:
        glUniform1f(self.myWidthUniform, GLfloat(self.myViewPortWidth))
        glUniform1f(self.myHeightUniform, GLfloat(self.myViewPortHeight))
        
        /*
         * Lab 11 - set Uniform values
         */
        glUniform1f(self.myFoVUniform, GLfloat(90.0));
        glUniform1f(self.myAspectUniform, GLfloat(1.0));
        glUniform1f(self.myNearUniform, GLfloat(10.0));
        glUniform1f(self.myFarUniform, GLfloat(1000.0));
        
        if (translate == 0) {
            glUniform1f(self.myTx, GLfloat(0.0));
            glUniform1f(self.myTy, GLfloat(0.0));
            glUniform1f(self.myTz, GLfloat(0.0));
        } else if (translate == 1) {
            glUniform1f(self.myTx, GLfloat(translate_x));
            glUniform1f(self.myTy, GLfloat(translate_y));
            glUniform1f(self.myTz, GLfloat(translate_z));
        }
        
        glEnableVertexAttribArray(self.myPosAttrib)
        
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gVertexData)
        
        glLineWidth(4.0)
        
        // X - axis
        glUniform4f(self.myColorUniform, gColorData[0][0], gColorData[0][1], gColorData[0][2], gColorData[0][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(46) );
        
        // Y - axis
        glUniform4f(self.myColorUniform, gColorData[1][0], gColorData[1][1], gColorData[1][2], gColorData[1][3]);
        glDrawArrays( GLenum(GL_LINES), 46, GLsizei(46) );
        
        // Z - axis
        glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
        glDrawArrays( GLenum(GL_LINES), 92, GLsizei(46) );
        
        // NOTE: don't change contents of the gVertexData array in the drawing function!
        
        glEnable(GLenum(GL_POINT_SMOOTH))
        
        // this wont work since it's part of OpenGL ES 1.0 !!! :
        glPointSize(20.0)
        // (it passes compilation but does nothing... must instead
        //  use the Vertex Shader to change point size in ES 3.0
    } // end of glkView( ... drawInRect: )
    
    // ------------------------------------------------------------------------
    // MARK: - UIResponder delegate methods for touch events
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            var lMessage = "Touch Began at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            // the position where the finger begins touching the screen:
            self.myTouchXbegin = GLfloat(firstTouchPoint.x)
            self.myTouchYbegin = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)
            
            // A01 SOLUTION: 
            //  the position where the finger currently touches the screen:
            self.myTouchXcurrent = self.myTouchXbegin
            self.myTouchYcurrent = self.myTouchYbegin
            
            // A01 SOLUTION: 
            // the last known position of the finger touching the screen:
            //   at redraw or at new (first) touch event:
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent
            
            // we are in the "we've just began" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.began
            
            if (translate == 0) {
                translate = 1;
            }
            
            lMessage = lMessage + " - translate = \(translate) \(translate_x) \(translate_y) \(translate_z)";
            
            NSLog(lMessage)
        }
    } // end of touchesBegan()
    
    // ------------------------------------------------------------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            var lMessage = "Touch Moved to \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            // A01 SOLUTION: 
            // store "current" to "old" touch coordinates
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent
            
            // get new "current" touch coordinates
            self.myTouchXcurrent = GLfloat(firstTouchPoint.x)
            self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)
            
            // we are in the "something has moved" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.moved
            
            translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
            translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
            
            lMessage = lMessage + " - translate = \(translate) \(translate_x) \(translate_y) \(translate_z)";
            
            NSLog(lMessage)
        }
    } // end of touchesMoved()
    
    // ------------------------------------------------------------------------
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            var lMessage = "Touches Ended at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            // A01 SOLUTION: 
            // detected end of touch event sequence (finger lifted from surface)
            // NOTE: here you may need to instead set both current and old points to the last detected coordinates:            
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent
            
            self.myTouchXcurrent = GLfloat(firstTouchPoint.x)
            self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)
            
            // we are in the "completed" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.ended
            
            lMessage = lMessage + " - translate = \(translate) \(translate_x) \(translate_y) \(translate_z)";
            
            NSLog(lMessage)
        }
    } // end of touchesEnded()
    
    // ------------------------------------------------------------------------
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        var lMessage = "Touches Cancelled"
        
        self.myTouchXbegin = -1.0
        self.myTouchYbegin = -1.0
        self.myTouchXcurrent = -1.0
        self.myTouchYcurrent = -1.0
        self.myTouchXold = -1.0
        self.myTouchYold = -1.0
        
        // we are in the "something just interrupted us, e.g. a phone call" phase
        //     of the touch event sequence:
        self.myTouchPhase = UITouchPhase.cancelled
        
        lMessage = lMessage + " - translate = \(translate) \(translate_x) \(translate_y) \(translate_z)";
        
        NSLog(lMessage)
        
    } // end of touchesMoved()
    
    // ------------------------------------------------------------------------
    // MARK: -  OpenGL ES 2 shader compilation, linking, binding
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    // load GLSL shaders from separate source code files, then compile and link
    // ------------------------------------------------------------------------
    func loadShaders() -> Bool {
        var vertShader: GLuint = 0
        var fragShader: GLuint = 0
        var vertShaderPathname: String
        var fragShaderPathname: String
        
        // Create shader program.
        myGLESProgram = glCreateProgram()
        
        // Create and compile vertex shader:
        vertShaderPathname = Bundle.main.path(forResource: "Shader", ofType: "vsh")!
        
        if self.compileShader(&vertShader,
                              type: GLenum(GL_VERTEX_SHADER),
                              file: vertShaderPathname) == false {
            
            NSLog("Failed to compile vertex shader")
            return false
        }
        
        // Create and compile fragment shader.
        fragShaderPathname = Bundle.main.path(forResource: "Shader", ofType: "fsh")!
        
        if self.compileShader(&fragShader,
                              type: GLenum(GL_FRAGMENT_SHADER),
                              file: fragShaderPathname) == false {
            NSLog("Failed to compile fragment shader")
            return false
        }
        
        // Attach vertex shader object code to GPU program:
        glAttachShader(myGLESProgram, vertShader)
        
        // Attach fragment shader object code to GPU program:
        glAttachShader(myGLESProgram, fragShader)
        
        // Link GPU program:
        if !self.linkProgram(myGLESProgram) {
            NSLog("Failed to link program: \(myGLESProgram)")
            // if linking fails, dispose of anything we got so far:
            if vertShader != 0 {
                glDeleteShader(vertShader)
                vertShader = 0
            }
            if fragShader != 0 {
                glDeleteShader(fragShader)
                fragShader = 0
            }
            if myGLESProgram != 0 {
                glDeleteProgram(myGLESProgram)
                myGLESProgram = 0
            }
            return false
        }
        
        // Get location of attribute variable in the shader:
        self.myPosAttrib = GLuint(glGetAttribLocation(myGLESProgram, "a_Position"))
        
        // Get location of uniform variables in the shaders:
        self.myWidthUniform = glGetUniformLocation(myGLESProgram, "u_Width")
        self.myHeightUniform = glGetUniformLocation(myGLESProgram, "u_Height")
        self.myColorUniform = glGetUniformLocation(myGLESProgram, "u_Color")
        
        /*
         * Lab 11 Uniform variable locations
         */
        self.myFoVUniform = glGetUniformLocation(myGLESProgram, "u_FoV");
        self.myAspectUniform = glGetUniformLocation(myGLESProgram, "u_Aspect");
        self.myNearUniform = glGetUniformLocation(myGLESProgram, "u_Near");
        self.myFarUniform = glGetUniformLocation(myGLESProgram, "u_Far");
        
        /*
         * Lab 12 Uniform variable locations
         */
        self.myTx = glGetUniformLocation(myGLESProgram, "u_Tx");
        self.myTy = glGetUniformLocation(myGLESProgram, "u_Ty");
        self.myTz = glGetUniformLocation(myGLESProgram, "u_Tz");
        
        // Release vertex and fragment shaders.
        if vertShader != 0 {
            glDetachShader(myGLESProgram, vertShader)
            glDeleteShader(vertShader)
        }
        if fragShader != 0 {
            glDetachShader(myGLESProgram, fragShader)
            glDeleteShader(fragShader)
        }
        
        return true
    } // end of loadShaders()
    
    // ------------------------------------------------------------------------
    // compile GLSL source code into linkable shader object code:
    // ------------------------------------------------------------------------
    func compileShader(_ shader: inout GLuint, type: GLenum, file: String) -> Bool {
        var status: GLint = 0
        var source: UnsafePointer<Int8>
        do {
            source = try NSString(contentsOfFile: file, encoding: String.Encoding.utf8.rawValue).utf8String!
        } catch {
            NSLog("Failed to load vertex shader \(file)")
            return false
        }
        var castSource: UnsafePointer<GLchar>? = UnsafePointer<GLchar>(source)
        
        // create a shader object to hold GLSL source code,
        //   and obtain a non-zero value by which it can be referenced
        shader = glCreateShader(type)
        glShaderSource(shader, 1, &castSource, nil)
        glCompileShader(shader)
        
        var logLength: GLint = 0
        glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
        if logLength > 0 {
            if let logRawPointer = malloc(Int(logLength)) {
                let logOpaquePointer = OpaquePointer(logRawPointer)
                let logContextPointer = UnsafeMutablePointer<GLchar>(logOpaquePointer)
                glGetShaderInfoLog(shader, logLength, &logLength, logContextPointer)
                NSLog("Shader compile log: \n%s", logContextPointer)
                free(logRawPointer)
            }
        }
        
        glGetShaderiv(shader, GLenum(GL_COMPILE_STATUS), &status)
        if status == GL_FALSE {
            glDeleteShader(shader)
            return false
        }
        return true
    } // end of compileShader()
    
    // ------------------------------------------------------------------------
    // link compiled GLSL shaders into a GLSL program for use by CPU GLES code
    // ------------------------------------------------------------------------
    func linkProgram(_ prog: GLuint) -> Bool {
        var status: GLint = 0
        
        glLinkProgram(prog)
        
        var logLength: GLint = 0
        glGetProgramiv(prog, GLenum(GL_INFO_LOG_LENGTH), &logLength)
        if logLength > 0 {
            if let logRawPointer = malloc(Int(logLength)) {
                let logOpaquePointer = OpaquePointer(logRawPointer)
                let logContextPointer = UnsafeMutablePointer<GLchar>(logOpaquePointer)
                glGetProgramInfoLog(prog, logLength, &logLength, logContextPointer)
                NSLog("Shader link log: \n%s", logContextPointer)
                free(logRawPointer)
            }
        }
        
        glGetProgramiv(prog, GLenum(GL_LINK_STATUS), &status)
        if status == GL_FALSE {
            return false
        }
        
        return true
    }
    
    // ------------------------------------------------------------------------
    // you may call validateProgram()
    // ------------------------------------------------------------------------
    func validateProgram(_ prog: GLuint) -> Bool {
        var logLength: GLsizei = 0
        var status: GLint = 0
        
        glValidateProgram(prog)
        glGetProgramiv(prog, GLenum(GL_INFO_LOG_LENGTH), &logLength)
        if logLength > 0 {
            var log: [GLchar] = [GLchar](repeating: 0, count: Int(logLength))
            glGetProgramInfoLog(prog, logLength, &logLength, &log)
            NSLog("Program validate log: %@", String(validatingUTF8: log)!)
        }
        
        glGetProgramiv(prog, GLenum(GL_VALIDATE_STATUS), &status)
        var returnVal = true
        if status == 0 {
            returnVal = false
        }
        return returnVal
    } // end of validateProgram()
} // end of class MyGLESKitViewController

