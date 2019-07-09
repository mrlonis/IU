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

// ------------------------------------------------------------------------
// MARK: - gXAxisData
// ------------------------------------------------------------------------
var gXAxisData: [GLfloat] = [
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
    10.0, 0.0, 0.5      // 45
];

// ------------------------------------------------------------------------
// MARK: - gYAxisData
// ------------------------------------------------------------------------
var gYAxisData: [GLfloat] = [
    // Y-axis
    0.0, 0.0, 0.0,      // 0
    0.0, 10.0, 0.0,     // 1
    
    // Y-ticks
    0.0, 0.0, 0.0,      // 2
    0.5, 0.0, 0.0,      // 3
    0.0, 0.0, 0.0,      // 4
    0.0, 0.0, 0.5,      // 5
    
    0.0, 1.0, 0.0,      // 6
    0.5, 1.0, 0.0,      // 7
    0.0, 1.0, 0.0,      // 8
    0.0, 1.0, 0.5,      // 9
    
    0.0, 2.0, 0.0,      // 10
    0.5, 2.0, 0.0,      // 11
    0.0, 2.0, 0.0,      // 12
    0.0, 2.0, 0.5,      // 13
    
    0.0, 3.0, 0.0,      // 14
    0.5, 3.0, 0.0,      // 15
    0.0, 3.0, 0.0,      // 16
    0.0, 3.0, 0.5,      // 17
    
    0.0, 4.0, 0.0,      // 18
    0.5, 4.0, 0.0,      // 19
    0.0, 4.0, 0.0,      // 20
    0.0, 4.0, 0.5,      // 21
    
    0.0, 5.0, 0.0,      // 22
    0.5, 5.0, 0.0,      // 23
    0.0, 5.0, 0.0,      // 24
    0.0, 5.0, 0.5,      // 25
    
    0.0, 6.0, 0.0,      // 26
    0.5, 6.0, 0.0,      // 27
    0.0, 6.0, 0.0,      // 28
    0.0, 6.0, 0.5,      // 29
    
    0.0, 7.0, 0.0,      // 30
    0.5, 7.0, 0.0,      // 31
    0.0, 7.0, 0.0,      // 32
    0.0, 7.0, 0.5,      // 33
    
    0.0, 8.0, 0.0,      // 34
    0.5, 8.0, 0.0,      // 35
    0.0, 8.0, 0.0,      // 36
    0.0, 8.0, 0.5,      // 37
    
    0.0, 9.0, 0.0,      // 38
    0.5, 9.0, 0.0,      // 39
    0.0, 9.0, 0.0,      // 40
    0.0, 9.0, 0.5,      // 41
    
    0.0, 10.0, 0.0,     // 42
    0.5, 10.0, 0.0,     // 43
    0.0, 10.0, 0.0,     // 44
    0.0, 10.0, 0.5      // 45
];

// ------------------------------------------------------------------------
// MARK: - gZAxisData
// ------------------------------------------------------------------------
var gZAxisData: [GLfloat] = [
    // Z-Axis
    0.0, 0.0, 0.0,      // 0
    0.0, 0.0, 10.0,     // 1
    
    // Z-Axis Ticks
    0.0, 0.0, 0.0,      // 2
    0.5, 0.0, 0.0,      // 3
    0.0, 0.0, 0.0,      // 4
    0.0, 0.5, 0.0,      // 5
    
    0.0, 0.0, 1.0,      // 6
    0.5, 0.0, 1.0,      // 7
    0.0, 0.0, 1.0,      // 8
    0.0, 0.5, 1.0,      // 9
    
    0.0, 0.0, 2.0,      // 10
    0.5, 0.0, 2.0,      // 11
    0.0, 0.0, 2.0,      // 12
    0.0, 0.5, 2.0,      // 13
    
    0.0, 0.0, 3.0,      // 14
    0.5, 0.0, 3.0,      // 15
    0.0, 0.0, 3.0,      // 16
    0.0, 0.5, 3.0,      // 17
    
    0.0, 0.0, 4.0,      // 18
    0.5, 0.0, 4.0,      // 19
    0.0, 0.0, 4.0,      // 20
    0.0, 0.5, 4.0,      // 21
    
    0.0, 0.0, 5.0,      // 22
    0.5, 0.0, 5.0,      // 23
    0.0, 0.0, 5.0,      // 24
    0.0, 0.5, 5.0,      // 25
    
    0.0, 0.0, 6.0,      // 26
    0.5, 0.0, 6.0,      // 27
    0.0, 0.0, 6.0,      // 28
    0.0, 0.5, 6.0,      // 29
    
    0.0, 0.0, 7.0,      // 30
    0.5, 0.0, 7.0,      // 31
    0.0, 0.0, 7.0,      // 32
    0.0, 0.5, 7.0,      // 33
    
    0.0, 0.0, 8.0,      // 34
    0.5, 0.0, 8.0,      // 35
    0.0, 0.0, 8.0,      // 36
    0.0, 0.5, 8.0,      // 37
    
    0.0, 0.0, 9.0,      // 38
    0.5, 0.0, 9.0,      // 39
    0.0, 0.0, 9.0,      // 40
    0.0, 0.5, 9.0,      // 41
    
    0.0, 0.0, 10.0,     // 42
    0.5, 0.0, 10.0,     // 43
    0.0, 0.0, 10.0,     // 44
    0.0, 0.5, 10.0      // 45
];

// ------------------------------------------------------------------------
// MARK: - gCubeData
// ------------------------------------------------------------------------
var gCubeData: [GLfloat] = [
    // Cube Faces
    // Face 1 Front
    0.0, 0.0, 0.0,      // 0
    0.0, 10.0, 0.0,     // 1
    10.0, 10.0, 0.0,    // 2
    0.0, 0.0, 0.0,      // 3
    10.0, 0.0, 0.0,     // 4
    10.0, 10.0, 0.0,    // 5
    
    // Face 2 Back
    0.0, 0.0, 10.0,     // 6
    0.0, 10.0, 10.0,    // 7
    10.0, 10.0, 10.0,   // 8
    0.0, 0.0, 10.0,     // 9
    10.0, 0.0, 10.0,    // 10
    10.0, 10.0, 10.0,   // 11
    
    // Face 3 Left
    0.0, 0.0, 0.0,      // 12
    0.0, 0.0, 10.0,     // 13
    0.0, 10.0, 10.0,    // 14
    0.0, 0.0, 0.0,      // 15
    0.0, 10.0, 0.0,     // 16
    0.0, 10.0, 10.0,    // 17
    
    // Face 4 Right
    10.0, 0.0, 0.0,     // 18
    10.0, 0.0, 10.0,    // 19
    10.0, 10.0, 10.0,   // 20
    10.0, 0.0, 0.0,     // 21
    10.0, 10.0, 0.0,    // 22
    10.0, 10.0, 10.0,   // 23
    
    // Face 5 Up
    0.0, 10.0, 0.0,     // 24
    0.0, 10.0, 10.0,    // 25
    10.0, 10.0, 10.0,   // 26
    0.0, 10.0, 0.0,     // 27
    10.0, 10.0, 0.0,    // 28
    10.0, 10.0, 10.0,   // 29
    
    // Face 6 Down
    0.0, 0.0, 0.0,      // 30
    0.0, 0.0, 10.0,     // 31
    10.0, 0.0, 10.0,    // 32
    0.0, 0.0, 0.0,      // 33
    10.0, 0.0, 0.0,     // 34
    10.0, 0.0, 10.0     // 35
];

// ------------------------------------------------------------------------
// MARK: - gZAxisData
// ------------------------------------------------------------------------
var gLight : [GLfloat] = [
    11.0, 11.0, 11.0
];

// ------------------------------------------------------------------------
// MARK: - gColorData
// ------------------------------------------------------------------------
var gColorData: [[GLfloat]] = [
    // color data in RGBA float format
    [1.0, 0.0, 0.0, 1.0], // Red        0
    [0.0, 1.0, 0.0, 1.0], // Green      1
    [0.0, 0.0, 1.0, 1.0], // Blue       2
    [1.0, 1.0, 0.0, 1.0], // Yellow     3
    [0.0, 1.0, 1.0, 1.0], // Cyan       4
    [1.0, 0.0, 1.0, 1.0], // Purple     5
    [1.0, 1.0, 1.0, 1.0]  // White      6
]

let G_DISTANCE_VV: GLfloat = 20.0
let G_DISTANCE_VL: GLfloat = 10.0

// ------------------------------------------------------------------------
// MARK: - Cam Variables
// ------------------------------------------------------------------------
var cam_rotation : GLKMatrix4 = GLKMatrix4Identity;
var cam_translate_x : GLfloat = 0.0;
var cam_translate_y : GLfloat = 0.0;
var cam_translate_z : GLfloat = -30.0;

// ------------------------------------------------------------------------
// MARK: - Obj1 Variables
// ------------------------------------------------------------------------
var obj1_rotation : GLKMatrix4 = GLKMatrix4Identity;
var obj1_translate_x : GLfloat = 0.0;
var obj1_translate_y : GLfloat = 0.0;
var obj1_translate_z : GLfloat = 0.0;
var obj1_scale : GLfloat = 1.0;

// ------------------------------------------------------------------------
// MARK: - Obj2 Variables
// ------------------------------------------------------------------------
var obj2_rotation : GLKMatrix4 = GLKMatrix4Identity;
var obj2_translate_x : GLfloat = 0.0;
var obj2_translate_y : GLfloat = 0.0;
var obj2_translate_z : GLfloat = 0.0;
var obj2_scale : GLfloat = 1.0;

// ------------------------------------------------------------------------
// MARK: - Obj3 Variables
// ------------------------------------------------------------------------
var obj3_rotation : GLKMatrix4 = GLKMatrix4Identity;
var obj3_translate_x : GLfloat = 0.0;
var obj3_translate_y : GLfloat = 0.0;
var obj3_translate_z : GLfloat = 0.0;
var obj3_scale : GLfloat = 1.0;

// ------------------------------------------------------------------------
// MARK: - Button Variables
// ------------------------------------------------------------------------
var rot : Int = 0;
var txy : Int = 0;
var txz : Int = 0;
var scale : Int = 0;
var obj1 : Int = 0;
var obj2 : Int = 0;
var obj3 : Int = 0;
var cam : Int = 0;

// ------------------------------------------------------------------------
// MARK: - Radius used for rolling ball rotation
// ------------------------------------------------------------------------
let obj1_radius : GLfloat = 5.0;
let obj1_negative_radius : GLfloat = -1 * obj1_radius;

enum G_LIT {
    case NONLIT
    case LITVERTEX
    case LITLINE
}

// ------------------------------------------------------------------------
// MARK: - MyGLESKitViewController
// ------------------------------------------------------------------------
class MyGLESKitViewController: GLKViewController {
    /*
     * Assignment 3 Buttons
     */
    @IBOutlet var rot_button: UIButton!
    @IBOutlet var txy_button: UIButton!
    @IBOutlet var txz_button: UIButton!
    @IBOutlet var scale_button: UIButton!
    @IBOutlet var obj1_button: UIButton!
    @IBOutlet var obj2_button: UIButton!
    @IBOutlet var obj3_button: UIButton!
    @IBOutlet var cam_button: UIButton!
    
    var myGLESProgram: GLuint = 0
    
    var myPosAttrib: GLuint = 0
    
    var myModelViewProjectionMatrix:GLKMatrix4 = GLKMatrix4Identity
    
    var myViewPortWidth:GLsizei = -1
    var myViewPortHeight:GLsizei = -1
    
    var myWidthUniform: GLint = 0
    var myHeightUniform: GLint = 0
    var myColorUniform: GLint = 0
    
    /*
     * Assignment 3
     */
    var myPerspectiveMatrix : GLint = 0;
    var myViewingTransformation : GLint = 0;
    var myModelingTransformation : GLint = 0;
    
    var myVertexArray: GLuint = 0
    var myVertexBuffer: GLuint = 0
    
    var myLightPosition : GLint = 0;
    
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
        
        self.txy_button_action(self.txy_button);
        self.cam_button_action(self.cam_button);
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
        glClearColor ( 0.0, 0.0, 0.0, 1.0 )
        
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
    
    /*
     * Lab 11 Added Function
     *
     * function that computes a 3D perspective transformation matrix:
     */
    func myGLUPerspective(pFoV: GLfloat, pAspect: GLfloat, pNear: GLfloat, pFar: GLfloat) -> [GLfloat]  {
    
        var lPerspectiveMatrix : [GLfloat] = [0.0, 0.0, 0.0, 0.0,
                                              0.0, 0.0, 0.0, 0.0,
                                              0.0, 0.0, 0.0, 0.0,
                                              0.0, 0.0, 0.0, 0.0];
        
        let lAngle : GLfloat = (pFoV / 180.0) * 3.14159;
        let lFocus : GLfloat = 1.0 / tan(lAngle * 0.5);
        
        lPerspectiveMatrix[0] = lFocus / pAspect;
        lPerspectiveMatrix[5] = lFocus;
        lPerspectiveMatrix[10] = (pFar + pNear) / (pNear - pFar);
        lPerspectiveMatrix[11] = -1.0;
        lPerspectiveMatrix[14] = (2.0 * pFar * pNear) / (pNear - pFar);
        
        return lPerspectiveMatrix;
    }
    
    func GLKMatrix4Print(m : GLKMatrix4, name : String) {
        NSLog(name);
        NSLog("m00 \(m.m00), m01 \(m.m01), m02 \(m.m02), m03 \(m.m03),");
        NSLog("m10 \(m.m10), m11 \(m.m11), m12 \(m.m12), m13 \(m.m13),");
        NSLog("m20 \(m.m20), m21 \(m.m21), m22 \(m.m22), m23 \(m.m23),");
        NSLog("m30 \(m.m30), m31 \(m.m31), m32 \(m.m32), m33 \(m.m33)");
        NSLog("End of " + name);
    }
    
    func GLKMatrix4ToArray(m : GLKMatrix4) -> [GLfloat] {
        return [m.m00, m.m01, m.m02, m.m03,
                m.m10, m.m11, m.m12, m.m13,
                m.m20, m.m21, m.m22, m.m23,
                m.m30, m.m31, m.m32, m.m33];
    }
    
    // ------------------------------------------------------------------------
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glUseProgram(myGLESProgram)
        
        glClear( GLbitfield(GL_COLOR_BUFFER_BIT) | GLbitfield(GL_DEPTH_BUFFER_BIT) );
        
        // get viewport dimensions:
        self.myViewPortWidth = GLsizei(self.view.bounds.size.width)
        self.myViewPortHeight = GLsizei(self.view.bounds.size.height)
        
        // pass viewport dimensions to the vertex shader:
        glUniform1f(self.myWidthUniform, GLfloat(self.myViewPortWidth));
        glUniform1f(self.myHeightUniform, GLfloat(self.myViewPortHeight));
        glUniform3f(self.myLightPosition, gLight[0], gLight[1], gLight[2]);
        
        // NOTE: don't change contents of the gVertexData array in the drawing function!
        glEnable(GLenum(GL_POINT_SMOOTH))
        
        // this wont work since it's part of OpenGL ES 1.0 !!! :
        glPointSize(20.0)
        // (it passes compilation but does nothing... must instead
        //  use the Vertex Shader to change point size in ES 3.0
        
        // Setup perspective matrix
        var perspective_matrix : [GLfloat] = myGLUPerspective(pFoV: 90.0, pAspect: GLfloat(self.myViewPortWidth)/GLfloat(self.myViewPortHeight), pNear: 1.0, pFar: 1000.0);
        glUniformMatrix4fv(self.myPerspectiveMatrix, 1, GLboolean(GL_FALSE), &perspective_matrix);
        
        // Setup viewing transformation matrix
        let viewing_translation_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation((-1 * cam_translate_x), (-1 * cam_translate_y), cam_translate_z);
        let viewing_rotation_matrix : GLKMatrix4 = cam_rotation;
        let viewing_scaling_matrix : GLKMatrix4 = GLKMatrix4Identity;
        
        let viewing_transformation_matrix : GLKMatrix4 = GLKMatrix4Multiply(viewing_translation_matrix, GLKMatrix4Multiply(viewing_rotation_matrix, viewing_scaling_matrix));
        var viewing_transformation_array : [GLfloat] = GLKMatrix4ToArray(m: viewing_transformation_matrix);
        glUniformMatrix4fv(self.myViewingTransformation, 1, GLboolean(GL_FALSE), &viewing_transformation_array);
        
        // Enable vertex array
        glEnableVertexAttribArray(self.myPosAttrib);
        
        // Set line width
        glLineWidth(4.0);
        
        // Set Modeling Matrix to the Identity Matrix for Coordinate Axis
        var viewing_modeling_matrix : [GLfloat] = GLKMatrix4ToArray(m: GLKMatrix4Identity);
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &viewing_modeling_matrix);
        
        // Set verticies to X-Axis vertices
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gXAxisData);
        
        // X - axis
        glUniform4f(self.myColorUniform, gColorData[0][0], gColorData[0][1], gColorData[0][2], gColorData[0][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(46) );
        
        // Set verticies to Y-Axis vertices
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gYAxisData);
        
        // Y - axis
        glUniform4f(self.myColorUniform, gColorData[1][0], gColorData[1][1], gColorData[1][2], gColorData[1][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(46) );
        
        // Set verticies to Z-Axis vertices
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gZAxisData);
        
        // Z - axis
        glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(46) );
        
        /*
         * Light Source
         */
        let light_transformation_matrix : GLKMatrix4 = GLKMatrix4Identity;
        
        var light_transformation_array : [GLfloat] = GLKMatrix4ToArray(m: light_transformation_matrix);
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &light_transformation_array);
        
        // Set verticies to Cube vertices
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gLight);
        
        glUniform4f(self.myColorUniform, gColorData[6][0], gColorData[6][1], gColorData[6][2], gColorData[6][3]);
        
        glDrawArrays( GLenum(GL_POINTS), 0, GLsizei(1) );
        
        /*
         * Obj1 (Cube) Drawings
         */
        
        // Set Modeling Matrix for Obj1 (Cube)
        let obj1_translation_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj1_translate_x, obj1_translate_y, obj1_translate_z);
        let obj1_scaling_matrix : GLKMatrix4 = GLKMatrix4MakeScale(obj1_scale, obj1_scale, obj1_scale);
        let obj1_rotation_matrix : GLKMatrix4 = obj1_rotation;
        
        let obj1_transformation_matrix : GLKMatrix4 = GLKMatrix4Multiply(
            obj1_translation_matrix,
            GLKMatrix4Multiply(
                GLKMatrix4MakeTranslation(obj1_radius, obj1_radius, obj1_radius),
                GLKMatrix4Multiply(
                    obj1_rotation_matrix,
                    GLKMatrix4Multiply(
                        obj1_scaling_matrix,
                        GLKMatrix4MakeTranslation(obj1_negative_radius, obj1_negative_radius, obj1_negative_radius)))));
        
        var obj1_transformation_array : [GLfloat] = GLKMatrix4ToArray(m: obj1_transformation_matrix);
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &obj1_transformation_array);
        
        // Set verticies to Cube vertices
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gCubeData);
        
        // Face 1
        glUniform4f(self.myColorUniform, gColorData[0][0], gColorData[0][1], gColorData[0][2], gColorData[0][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 0, GLsizei(6) );
        
        // Face 2
        glUniform4f(self.myColorUniform, gColorData[1][0], gColorData[1][1], gColorData[1][2], gColorData[1][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 6, GLsizei(6) );
        
        // Face 3
        glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 12, GLsizei(6) );
        
        // Face 4
        glUniform4f(self.myColorUniform, gColorData[3][0], gColorData[3][1], gColorData[3][2], gColorData[3][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 18, GLsizei(6) );
        
        // Face 5
        glUniform4f(self.myColorUniform, gColorData[4][0], gColorData[4][1], gColorData[4][2], gColorData[4][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 24, GLsizei(6) );
        
        // Face 6
        glUniform4f(self.myColorUniform, gColorData[5][0], gColorData[5][1], gColorData[5][2], gColorData[5][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 30, GLsizei(6) );
    } // end of glkView( ... drawInRect: )
    
    // ------------------------------------------------------------------------
    // MARK: - UIResponder delegate methods for touch events
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touch Began at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
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
            
            NSLog(lMessage)
        }
    } // end of touchesBegan()
    
    // ------------------------------------------------------------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touch Moved to \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            // A01 SOLUTION: 
            // store "current" to "old" touch coordinates
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent
            
            // get new "current" touch coordinates
            self.myTouchXcurrent = GLfloat(firstTouchPoint.x)
            self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)
            
            // we are in the "something has moved" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.moved
            
            if (cam == 1) {
                if (rot == 1) {
                    let dx : GLfloat = (self.myTouchXcurrent - self.myTouchXold);
                    let dy : GLfloat = (self.myTouchYcurrent - self.myTouchYold);
                    
                    let dr : GLfloat = sqrtf(powf(dx, 2) + powf(dy, 2));
                    var nx : GLfloat = -1.0 * (dy/dr);
                    var ny : GLfloat = dx/dr;
                    let nz : GLfloat = 0.0;
                    
                    let sum : GLfloat = nx + ny;
                    
                    if (sum != 0.0) {
                        nx = nx / sum;
                        ny = ny / sum;
                    }
                    
                    let angle = atanf(dr/obj1_radius);
                    
                    let rot_matrix : GLKMatrix4 = GLKMatrix4MakeRotation(angle, nx, ny, nz);
                    cam_rotation = GLKMatrix4Multiply(rot_matrix, cam_rotation);
                } else if (txy == 1) {
                    cam_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    cam_translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                } else if (txz == 1) {
                    cam_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    cam_translate_z += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                }
            } else if (obj1 == 1) {
                if (rot == 1) {
                    let dx : GLfloat = (self.myTouchXcurrent - self.myTouchXold);
                    let dy : GLfloat = (self.myTouchYcurrent - self.myTouchYold);
                    
                    let dr : GLfloat = sqrtf(powf(dx, 2) + powf(dy, 2))
                    var nx : GLfloat = -1.0 * (dy/dr);
                    var ny : GLfloat = dx/dr;
                    let nz : GLfloat = 0.0;
                    let sum : GLfloat = nx + ny;
                    
                    if (sum != 0.0) {
                        nx = nx / sum;
                        ny = ny / sum;
                    }
                    
                    let angle = atanf(dr/obj1_radius);
                    
                    let rot_matrix : GLKMatrix4 = GLKMatrix4MakeRotation(angle, nx, ny, nz);
                    obj1_rotation = GLKMatrix4Multiply(rot_matrix, obj1_rotation);
                } else if (txy == 1) {
                    obj1_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj1_translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                } else if (txz == 1) {
                    obj1_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj1_translate_z += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                } else if (scale == 1) {
                    let dy : GLfloat = self.myTouchYcurrent - self.myTouchYold;
                    
                    if (dy >= 0) {
                        obj1_scale += 0.01;
                    } else if (obj1_scale > 0.06) {
                        obj1_scale -= 0.01;
                    }
                }
            }
            
            NSLog(lMessage)
        }
    } // end of touchesMoved()
    
    // ------------------------------------------------------------------------
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touches Ended at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            // A01 SOLUTION: 
            // detected end of touch event sequence (finger lifted from surface)
            // NOTE: here you may need to instead set both current and old points to the last detected coordinates:            
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent
            
            self.myTouchXcurrent = GLfloat(firstTouchPoint.x)
            self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)
            
            // we are in the "completed" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.ended
            
            NSLog(lMessage)
        }
    } // end of touchesEnded()
    
    // ------------------------------------------------------------------------
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        let lMessage = "Touches Cancelled"
        
        self.myTouchXbegin = -1.0
        self.myTouchYbegin = -1.0
        self.myTouchXcurrent = -1.0
        self.myTouchYcurrent = -1.0
        self.myTouchXold = -1.0
        self.myTouchYold = -1.0
        
        // we are in the "something just interrupted us, e.g. a phone call" phase
        //     of the touch event sequence:
        self.myTouchPhase = UITouchPhase.cancelled
        
        NSLog(lMessage)
        
    } // end of touchesMoved()
    
    // ------------------------------------------------------------------------
    // MARK: - UIResponder delegate methods for button events
    // ------------------------------------------------------------------------
    @IBAction func rot_button_action(_ sender: UIButton) {
        rot = 1;
        txy = 0;
        txz = 0;
        scale = 0;
        
        rot_button.backgroundColor = UIColor.green;
        txy_button.backgroundColor = UIColor.darkGray;
        txz_button.backgroundColor = UIColor.darkGray;
        scale_button.backgroundColor = UIColor.darkGray;
    }
    
    @IBAction func txy_button_action(_ sender: UIButton) {
        rot = 0;
        txy = 1;
        txz = 0;
        scale = 0;
        
        rot_button.backgroundColor = UIColor.darkGray;
        txy_button.backgroundColor = UIColor.green;
        txz_button.backgroundColor = UIColor.darkGray;
        scale_button.backgroundColor = UIColor.darkGray;
    }
    
    @IBAction func txz_button_action(_ sender: UIButton) {
        rot = 0;
        txy = 0;
        txz = 1;
        scale = 0;
        
        rot_button.backgroundColor = UIColor.darkGray;
        txy_button.backgroundColor = UIColor.darkGray;
        txz_button.backgroundColor = UIColor.green;
        scale_button.backgroundColor = UIColor.darkGray;
    }
    
    @IBAction func scale_button_action(_ sender: UIButton) {
        rot = 0;
        txy = 0;
        txz = 0;
        scale = 1;
        
        rot_button.backgroundColor = UIColor.darkGray;
        txy_button.backgroundColor = UIColor.darkGray;
        txz_button.backgroundColor = UIColor.darkGray;
        
        if (cam == 0) {
            scale_button.backgroundColor = UIColor.green;
        } else {
            scale_button.backgroundColor = UIColor.gray;
        }
    }
    
    @IBAction func obj1_button_action(_ sender: UIButton) {
        obj1 = 1;
        obj2 = 0;
        obj3 = 0;
        cam = 0;
        
        obj1_button.backgroundColor = UIColor.red;
        obj2_button.backgroundColor = UIColor.darkGray;
        obj3_button.backgroundColor = UIColor.darkGray;
        cam_button.backgroundColor = UIColor.darkGray;
        
        if (scale == 1) {
            scale_button_action(scale_button);
        }
    }
    
    @IBAction func obj2_button_action(_ sender: UIButton) {
        obj1 = 0;
        obj2 = 1;
        obj3 = 0;
        cam = 0;
        
        obj1_button.backgroundColor = UIColor.darkGray;
        obj2_button.backgroundColor = UIColor.red;
        obj3_button.backgroundColor = UIColor.darkGray;
        cam_button.backgroundColor = UIColor.darkGray;
        
        if (scale == 1) {
            scale_button_action(scale_button);
        }
    }
    
    @IBAction func obj3_button_action(_ sender: UIButton) {
        obj1 = 0;
        obj2 = 0;
        obj3 = 1;
        cam = 0;
        
        obj1_button.backgroundColor = UIColor.darkGray;
        obj2_button.backgroundColor = UIColor.darkGray;
        obj3_button.backgroundColor = UIColor.red;
        cam_button.backgroundColor = UIColor.darkGray;
        
        if (scale == 1) {
            scale_button_action(scale_button);
        }
    }
    
    @IBAction func cam_button_action(_ sender: UIButton) {
        obj1 = 0;
        obj2 = 0;
        obj3 = 0;
        cam = 1;
        
        obj1_button.backgroundColor = UIColor.darkGray;
        obj2_button.backgroundColor = UIColor.darkGray;
        obj3_button.backgroundColor = UIColor.darkGray;
        cam_button.backgroundColor = UIColor.red;
        
        if (scale == 1) {
            scale_button_action(scale_button);
        }
    }
    
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
         * Assignment 3
         */
        self.myPerspectiveMatrix = glGetUniformLocation(myGLESProgram, "u_projectionMatrix");
        self.myViewingTransformation = glGetUniformLocation(myGLESProgram, "u_viewingTransformation");
        self.myModelingTransformation = glGetUniformLocation(myGLESProgram, "u_modelingTransformation");
        self.myLightPosition = glGetUniformLocation(myGLESProgram, "u_LightPos");
        
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

