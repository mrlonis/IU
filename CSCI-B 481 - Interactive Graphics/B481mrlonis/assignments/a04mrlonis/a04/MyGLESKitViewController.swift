/*
 * MyGLESKitViewController.swift
 *
 * Created by: Mitja Hmeljak
 * Created on: 23 February 2018
 * Last Modified by: Matthew Lonis
 * Last Modified on: 2 May 2018
 */

import GLKit
import OpenGLES

// OpenGL ES requires the use of C-like pointers to "CPU memory",
// without the automated memory management provided by Swift:
func obtainUnsafePointer(_ i: Int) -> UnsafeRawPointer? {
    return UnsafeRawPointer(bitPattern: i)
}

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
    [1.0, 1.0, 1.0, 1.0], // White      6
    [0.0, 0.0, 0.0, 1.0]  // Black      7
]

let G_DISTANCE_VV: GLfloat = 20.0
let G_DISTANCE_VL: GLfloat = 10.0

// ------------------------------------------------------------------------
// MARK: - Radius used for rolling ball rotation
// ------------------------------------------------------------------------
let obj1_radius : GLfloat = 5.0;
let obj1_negative_radius : GLfloat = -1 * obj1_radius;
let obj2_radius : GLfloat = -5.0;
let obj2_negative_radius : GLfloat = -1 * obj2_radius;
let obj3_radius : GLfloat = 5.0;
let obj3_negative_radius : GLfloat = -1 * obj1_radius;

// ------------------------------------------------------------------------
// MARK: - Perspective Matrix
// ------------------------------------------------------------------------
var perspective_matrix : [GLfloat] = [GLfloat(0.0)];

// ------------------------------------------------------------------------
// MARK: - Light Modeling Matrix
// ------------------------------------------------------------------------
let light_modeling_matrix : GLKMatrix4 = GLKMatrix4Identity;
var light_modeling_array : [GLfloat] = MyGLESKitViewController.GLKMatrix4ToArray(m: light_modeling_matrix);

// ------------------------------------------------------------------------
// MARK: - Cam Variables
// ------------------------------------------------------------------------
var cam_rotation : GLKMatrix4 = GLKMatrix4Identity;
var cam_translation : GLKMatrix4 = GLKMatrix4MakeTranslation(0.0, 0.0, -30.0);
var viewing_matrix : GLKMatrix4 = GLKMatrix4Multiply(cam_translation, cam_rotation);
var viewing_array : [GLfloat] = MyGLESKitViewController.GLKMatrix4ToArray(m: viewing_matrix);
var cam_modeling_array : [GLfloat] = MyGLESKitViewController.GLKMatrix4ToArray(m: GLKMatrix4Identity);
var cam_translate_x : GLfloat = 0.0;
var cam_translate_y : GLfloat = 0.0;
var cam_translate_z : GLfloat = -30.0;

// ------------------------------------------------------------------------
// MARK: - Obj1 Variables
// ------------------------------------------------------------------------
var obj1_rotation : GLKMatrix4 = GLKMatrix4Identity;
var obj1_translation : GLKMatrix4 = GLKMatrix4Identity;
var obj1_scale_matrix : GLKMatrix4 = GLKMatrix4Identity;
let obj1_radius_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj1_radius, obj1_radius, obj1_radius);
let obj1_negative_radius_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj1_negative_radius, obj1_negative_radius, obj1_negative_radius);

var obj1_modeling_matrix : GLKMatrix4 = GLKMatrix4Multiply(obj1_translation, GLKMatrix4Multiply(obj1_radius_matrix, GLKMatrix4Multiply(obj1_rotation, GLKMatrix4Multiply(obj1_scale_matrix, obj1_negative_radius_matrix))));

var obj1_modeling_array : [GLfloat] = MyGLESKitViewController.GLKMatrix4ToArray(m: obj1_modeling_matrix);

var obj1_translate_x : GLfloat = 0.0;
var obj1_translate_y : GLfloat = 0.0;
var obj1_translate_z : GLfloat = 0.0;
var obj1_scale : GLfloat = 1.0;

// ------------------------------------------------------------------------
// MARK: - Obj2 Variables
// ------------------------------------------------------------------------
var obj2_angle : GLfloat = 0;
var obj2_rotation : GLKMatrix4 = GLKMatrix4Identity;
var obj2_translation : GLKMatrix4 = GLKMatrix4Identity;
var obj2_scale_matrix : GLKMatrix4 = GLKMatrix4Identity;
let obj2_radius_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj2_radius, obj2_radius, obj2_radius);
let obj2_negative_radius_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj2_negative_radius, obj2_negative_radius, obj2_negative_radius);

var obj2_modeling_matrix : GLKMatrix4 = GLKMatrix4Multiply(obj2_translation, GLKMatrix4Multiply(obj2_radius_matrix, GLKMatrix4Multiply(obj2_rotation, GLKMatrix4Multiply(obj2_scale_matrix, obj2_negative_radius_matrix))));

var obj2_modeling_array : [GLfloat] = MyGLESKitViewController.GLKMatrix4ToArray(m: obj2_modeling_matrix);

var obj2_translate_x : GLfloat = 0.0;
var obj2_translate_y : GLfloat = 0.0;
var obj2_translate_z : GLfloat = 0.0;
var obj2_scale : GLfloat = 1.0;

// ------------------------------------------------------------------------
// MARK: - Obj3 Variables
// ------------------------------------------------------------------------
var obj3_rotation : GLKMatrix4 = GLKMatrix4Identity;
var obj3_translation : GLKMatrix4 = GLKMatrix4Identity;
var obj3_scale_matrix : GLKMatrix4 = GLKMatrix4Identity;

let obj3_radius_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj3_radius, obj3_radius, obj3_radius);
let obj3_negative_radius_matrix : GLKMatrix4 = GLKMatrix4MakeTranslation(obj3_negative_radius, obj3_negative_radius, obj3_negative_radius);

var obj3_modeling_matrix : GLKMatrix4 = GLKMatrix4Multiply(obj3_translation, GLKMatrix4Multiply(obj3_radius_matrix, GLKMatrix4Multiply(obj3_rotation, GLKMatrix4Multiply(obj3_scale_matrix, obj3_negative_radius_matrix))));

var obj3_modeling_array : [GLfloat] = MyGLESKitViewController.GLKMatrix4ToArray(m: obj3_modeling_matrix);

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
// MARK: - Angle Variables
// ------------------------------------------------------------------------
var MAX_ANGLE : GLfloat = 2 * GLfloat.pi;
var ANGLE_INC : GLfloat = 1 * (GLfloat.pi / 180);

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
    var myNormalAttrib : GLuint = 0;
    
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
    var myLightColor : GLint = 0;
    var myShininess : GLint = 0;
    var myAmbientColor : GLint = 0;
    
    var myDrawLight : GLint = 0;
    
    var myGLESContext: EAGLContext? = nil;
    var myGLKView: GLKView? = nil;
    
    // touch event data:
    var myTouchXbegin: GLfloat = -1.0;
    var myTouchYbegin: GLfloat = -1.0;
    var myTouchXcurrent: GLfloat = -1.0;
    var myTouchYcurrent: GLfloat = -1.0;
    var myTouchXold: GLfloat = -1.0;
    var myTouchYold: GLfloat = -1.0;
    var myTouchPhase: UITouchPhase? = nil;
    
    // texture data:
    var myTexUniform: GLint = 0;
    var myTexture: GLuint = 0;
    var myVertexTextureAttribute: GLuint = 0;
    
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
        
        self.myGLKView = self.view as? GLKView
        
        self.myGLKView!.context = self.myGLESContext!
        
        self.myGLKView!.drawableDepthFormat = GLKViewDrawableDepthFormat.format24
        
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
        let lGL_VERSION = String(cString: lGL_VERSION_ptr!)
        print("glGetString(GLenum(GL_VERSION_ptr)) = \(String(describing: lGL_VERSION_ptr))")
        print("   returned: '\(lGL_VERSION)'")
        let lGL_SHADING_LANGUAGE_VERSION_ptr = glGetString(GLenum(GL_SHADING_LANGUAGE_VERSION))
        let lGL_SHADING_LANGUAGE_VERSION = String(cString: lGL_SHADING_LANGUAGE_VERSION_ptr!)
        print("glGetString(GLenum(GL_SHADING_LANGUAGE_VERSION_ptr)) = \(String(describing: lGL_SHADING_LANGUAGE_VERSION_ptr))")
        print("   returns '\(lGL_SHADING_LANGUAGE_VERSION)' ")
        
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
        
        // BEGIN TEXTURE
        loadTexture(filename: "checkerboard.jpg")
        // END TEXTURE
        
        perspective_matrix = MyGLESKitViewController.myGLUPerspective(pFoV: 90.0, pAspect: GLfloat(self.myViewPortWidth)/GLfloat(self.myViewPortHeight), pNear: 1.0, pFar: 1000.0);
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
    // MARK: - Utility Functions added by Matthew Lonis
    // ------------------------------------------------------------------------
    
    /*
     * Lab 11 Added Function
     *
     * function that computes a 3D perspective transformation matrix:
     */
    static func myGLUPerspective(pFoV: GLfloat, pAspect: GLfloat, pNear: GLfloat, pFar: GLfloat) -> [GLfloat]  {
        
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
    
    static func GLKMatrix4Print(m : GLKMatrix4, name : String) {
        var printer : String = name + "\n";
        printer += "m00 \(m.m00), m01 \(m.m01), m02 \(m.m02), m03 \(m.m03), \n";
        printer += "m10 \(m.m10), m11 \(m.m11), m12 \(m.m12), m13 \(m.m13), \n";
        printer += "m20 \(m.m20), m21 \(m.m21), m22 \(m.m22), m23 \(m.m23), \n";
        printer += "m30 \(m.m30), m31 \(m.m31), m32 \(m.m32), m33 \(m.m33) \n";
        printer += "End of " + name;
        NSLog(printer);
    }
    
    static func GLKMatrix4ToArray(m : GLKMatrix4) -> [GLfloat] {
        return [m.m00, m.m01, m.m02, m.m03,
                m.m10, m.m11, m.m12, m.m13,
                m.m20, m.m21, m.m22, m.m23,
                m.m30, m.m31, m.m32, m.m33];
    }
    
    // ------------------------------------------------------------------------
    // MARK: - GLKView and GLKViewController delegate methods
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    func update() {
        obj2_angle += ANGLE_INC;
        
        if (obj2_angle >= MAX_ANGLE) {
            obj2_angle = 0.0;
        }
        
        obj2_rotation = GLKMatrix4MakeYRotation(obj2_angle);
        
        obj2_modeling_matrix = GLKMatrix4Multiply(obj2_translation, GLKMatrix4Multiply(obj2_radius_matrix, GLKMatrix4Multiply(obj2_rotation, GLKMatrix4Multiply(obj2_scale_matrix, obj2_negative_radius_matrix))));
        
        obj2_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj2_modeling_matrix);
    } // end of update()
    
    // ------------------------------------------------------------------------
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        update();
        
        glUseProgram(myGLESProgram)
        
        glClear( GLbitfield(GL_COLOR_BUFFER_BIT) | GLbitfield(GL_DEPTH_BUFFER_BIT) );
        
        // get viewport dimensions:
        self.myViewPortWidth = GLsizei(self.view.bounds.size.width);
        self.myViewPortHeight = GLsizei(self.view.bounds.size.height);
        
        // Enable vertex array
        glEnableVertexAttribArray(self.myPosAttrib);
        
        // Set line width
        glLineWidth(4.0);
        
        // pass viewport dimensions to the vertex shader:
        glUniform1f(self.myWidthUniform, GLfloat(self.myViewPortWidth));
        glUniform1f(self.myHeightUniform, GLfloat(self.myViewPortHeight));
        glUniform3f(self.myLightPosition, Vertices.gLight[0], Vertices.gLight[1], Vertices.gLight[2]);
        glUniform3f(self.myLightColor, GLfloat(1.0), GLfloat(1.0), GLfloat(1.0));
        glUniform1f(self.myShininess, 30.0);
        glUniform3f(self.myAmbientColor, 0.2, 0.2, 0.2);
        glUniform1f(self.myDrawLight, 1.0);
        
        glEnable(GLenum(GL_POINT_SMOOTH))
        
        // Setup perspective matrix
        glUniformMatrix4fv(self.myPerspectiveMatrix, 1, GLboolean(GL_FALSE), &perspective_matrix);
        
        // Setup viewing transformation matrix
        glUniformMatrix4fv(self.myViewingTransformation, 1, GLboolean(GL_FALSE), &viewing_array);
        
        /*
         * Coordinate Axis
         */
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &cam_modeling_array);
        
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gXAxisData);
        glUniform4f(self.myColorUniform, gColorData[0][0], gColorData[0][1], gColorData[0][2], gColorData[0][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(90) );
        
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gYAxisData);
        glUniform4f(self.myColorUniform, gColorData[1][0], gColorData[1][1], gColorData[1][2], gColorData[1][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(90) );
        
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gZAxisData);
        glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(90) );
        
        /*
         * Light Source
         */
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &light_modeling_array);
        
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gLight);
        
        glUniform4f(self.myColorUniform, gColorData[6][0], gColorData[6][1], gColorData[6][2], gColorData[6][3]);
        
        glDrawArrays( GLenum(GL_POINTS), 0, GLsizei(1) );
        
        /*
         * Obj1 (Cube) Drawings
         */
        glUniform1f(self.myDrawLight, 0.0);
        
        glEnableVertexAttribArray(self.myNormalAttrib);
        glEnableVertexAttribArray(self.myVertexTextureAttribute)
        
        glActiveTexture(GLenum(GL_TEXTURE0));
        glBindTexture(GLenum(GL_TEXTURE_2D), self.myTexture);
        glUniform1i(self.myTexUniform, 0);
        glVertexAttribPointer(self.myVertexTextureAttribute, 2, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gTextureData)
        
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &obj1_modeling_array);
        
        glVertexAttribPointer(self.myNormalAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gCubeNormalData);
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gCubeData);
        
        glUniform4f(self.myColorUniform, gColorData[0][0], gColorData[0][1], gColorData[0][2], gColorData[0][3]);
        glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 0, GLsizei(4) );
        
        glUniform4f(self.myColorUniform, gColorData[1][0], gColorData[1][1], gColorData[1][2], gColorData[1][3]);
        glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 4, GLsizei(4) );
        
        glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
        glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 8, GLsizei(4) );
        
        glUniform4f(self.myColorUniform, gColorData[3][0], gColorData[3][1], gColorData[3][2], gColorData[3][3]);
        glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 12, GLsizei(4) );
        
        glUniform4f(self.myColorUniform, gColorData[4][0], gColorData[4][1], gColorData[4][2], gColorData[4][3]);
        glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 16, GLsizei(4) );
        
        glUniform4f(self.myColorUniform, gColorData[5][0], gColorData[5][1], gColorData[5][2], gColorData[5][3]);
        glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 20, GLsizei(4) );
        
        glDisableVertexAttribArray(myVertexTextureAttribute);
        
        /*
         * Diamond (obj2)
         */
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &obj2_modeling_array);
        
        glVertexAttribPointer(self.myNormalAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gDiamondNormalData);
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gDiamondData);
        
        glUniform4f(self.myColorUniform, gColorData[4][0], gColorData[4][1], gColorData[4][2], gColorData[4][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 0, GLsizei(24) );
        
        glUniform1f(self.myDrawLight, 1.0);
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gDiamondLineData);
        
        glUniform4f(self.myColorUniform, gColorData[7][0], gColorData[7][1], gColorData[7][2], gColorData[7][3]);
        glDrawArrays( GLenum(GL_LINES), 0, GLsizei(24) );
        glUniform1f(self.myDrawLight, 0.0);
        
        /*
         * Tetrahedron (obj3)
         */
        glUniformMatrix4fv(self.myModelingTransformation, 1, GLboolean(GL_FALSE), &obj3_modeling_array);
        
        glVertexAttribPointer(self.myNormalAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gTetrahedronNormalData);
        glVertexAttribPointer(self.myPosAttrib, 3, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &Vertices.gTetrahedronData);
        
        glUniform4f(self.myColorUniform, gColorData[5][0], gColorData[5][1], gColorData[5][2], gColorData[5][3]);
        glDrawArrays( GLenum(GL_TRIANGLES), 0, GLsizei(12) );
    } // end of glkView( ... drawInRect: )
    
    // BEGIN TEXTURE
    func loadTexture(filename: String) {
        let image: CGImage? = UIImage(named: filename)?.cgImage
        
        let width: Int = image!.width
        let height: Int = image!.height
        let imageData = calloc(Int(CGFloat(width) * CGFloat(height) * 4), Int(MemoryLayout<GLubyte>.size))
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let imageContext: CGContext = CGContext(data: imageData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width*4, space: image!.colorSpace!, bitmapInfo: bitmapInfo.rawValue)!
        
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width) , height: CGFloat(height))
        
        imageContext.draw(image!, in: rect, byTiling:false)
        
        // Generate textures
        glGenTextures(1, &myTexture)
        // Bind it
        glBindTexture(GLenum(GL_TEXTURE_2D), myTexture)
        
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_NEAREST)
        glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GL_RGBA, GLsizei(width), GLsizei(height), 0, GLenum(GL_RGBA), UInt32(GL_UNSIGNED_BYTE), imageData)
        
        free(imageData)
    }
    // END TEXTURE
    
    // ------------------------------------------------------------------------
    // MARK: - UIResponder delegate methods for touch events
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            // let lMessage = "Touch Began at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
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
            
            // NSLog(lMessage)
        }
    } // end of touchesBegan()
    
    // ------------------------------------------------------------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            // let lMessage = "Touch Moved to \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
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
                    var dx : GLfloat = (self.myTouchXcurrent - self.myTouchXbegin);
                    var dy : GLfloat = (self.myTouchYcurrent - self.myTouchYbegin);
                    
                    if (dx == 0.0) {
                        dx = 1.0;
                    }
                    
                    if (dy == 0.0) {
                        dy = 1.0;
                    }

                    let dr : GLfloat = sqrtf(powf(dx, 2) + powf(dy, 2));
                    let nx : GLfloat = -1.0 * (dy/dr);
                    let ny : GLfloat = dx/dr;
                    let nz : GLfloat = 0.0;
                    
                    var n : GLKVector3 = GLKVector3Make(nx, ny, nz);
                    n = GLKVector3Normalize(n);
                    
                    let angle = dr/(GLfloat(self.view.bounds.size.width) / 2.0);
                    
                    let rot_matrix : GLKMatrix4 = GLKMatrix4MakeRotation(angle, n.x, n.y, n.z);
                    cam_rotation = GLKMatrix4Multiply(rot_matrix, cam_rotation);
                    
                    viewing_matrix = GLKMatrix4Multiply(cam_translation, cam_rotation);
                    viewing_array = MyGLESKitViewController.GLKMatrix4ToArray(m: viewing_matrix);
                } else if (txy == 1) {
                    cam_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    cam_translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    cam_translation = GLKMatrix4MakeTranslation((-1 * cam_translate_x), (-1 * cam_translate_y), cam_translate_z);
                    
                    viewing_matrix = GLKMatrix4Multiply(cam_translation, cam_rotation);
                    viewing_array = MyGLESKitViewController.GLKMatrix4ToArray(m: viewing_matrix);
                } else if (txz == 1) {
                    cam_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    cam_translate_z += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    cam_translation = GLKMatrix4MakeTranslation((-1 * cam_translate_x), (-1 * cam_translate_y), cam_translate_z);
                    
                    viewing_matrix = GLKMatrix4Multiply(cam_translation, cam_rotation);
                    viewing_array = MyGLESKitViewController.GLKMatrix4ToArray(m: viewing_matrix);
                }
            } else if (obj1 == 1) {
                if (rot == 1) {
                    var dx : GLfloat = (self.myTouchXcurrent - self.myTouchXold);
                    var dy : GLfloat = (self.myTouchYcurrent - self.myTouchYold);
                    
                    if (dx == 0.0) {
                        dx = 1.0;
                    }
                    
                    if (dy == 0.0) {
                        dy = 1.0;
                    }
                    
                    let dr : GLfloat = sqrtf(powf(dx, 2) + powf(dy, 2))
                    let nx : GLfloat = -1.0 * (dy/dr);
                    let ny : GLfloat = dx/dr;
                    let nz : GLfloat = 0.0;
                    
                    var n : GLKVector3 = GLKVector3Make(nx, ny, nz);
                    n = GLKVector3Normalize(n);
                    
                    let angle = dr/obj1_radius;
                    
                    let rot_matrix : GLKMatrix4 = GLKMatrix4MakeRotation(angle, n.x, n.y, n.z);
                    obj1_rotation = GLKMatrix4Multiply(rot_matrix, obj1_rotation);
                    
                    obj1_modeling_matrix = GLKMatrix4Multiply(obj1_translation, GLKMatrix4Multiply(obj1_radius_matrix, GLKMatrix4Multiply(obj1_rotation, GLKMatrix4Multiply(obj1_scale_matrix, obj1_negative_radius_matrix))));
                    
                    obj1_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj1_modeling_matrix);
                } else if (txy == 1) {
                    obj1_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj1_translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    obj1_translation = GLKMatrix4MakeTranslation(obj1_translate_x, obj1_translate_y, obj1_translate_z);
                    
                    obj1_modeling_matrix = GLKMatrix4Multiply(obj1_translation, GLKMatrix4Multiply(obj1_radius_matrix, GLKMatrix4Multiply(obj1_rotation, GLKMatrix4Multiply(obj1_scale_matrix, obj1_negative_radius_matrix))));
                    
                    obj1_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj1_modeling_matrix);
                } else if (txz == 1) {
                    obj1_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj1_translate_z += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    obj1_translation = GLKMatrix4MakeTranslation(obj1_translate_x, obj1_translate_y, obj1_translate_z);
                    
                    obj1_modeling_matrix = GLKMatrix4Multiply(obj1_translation, GLKMatrix4Multiply(obj1_radius_matrix, GLKMatrix4Multiply(obj1_rotation, GLKMatrix4Multiply(obj1_scale_matrix, obj1_negative_radius_matrix))));
                    
                    obj1_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj1_modeling_matrix);
                } else if (scale == 1) {
                    let dy : GLfloat = self.myTouchYcurrent - self.myTouchYold;
                    
                    if (dy >= 0) {
                        obj1_scale += 0.01;
                    } else if (obj1_scale > 0.06) {
                        obj1_scale -= 0.01;
                    }
                    
                    obj1_scale_matrix = GLKMatrix4MakeScale(obj1_scale, obj1_scale, obj1_scale);
                    
                    obj1_modeling_matrix = GLKMatrix4Multiply(obj1_translation, GLKMatrix4Multiply(obj1_radius_matrix, GLKMatrix4Multiply(obj1_rotation, GLKMatrix4Multiply(obj1_scale_matrix, obj1_negative_radius_matrix))));
                    
                    obj1_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj1_modeling_matrix);
                }
            } else if (obj2 == 1) {
                if (rot == 1) {
                    update();
                } else if (txy == 1) {
                    obj2_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj2_translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    obj2_translation = GLKMatrix4MakeTranslation(obj2_translate_x, obj2_translate_y, obj2_translate_z);
                    
                    obj2_modeling_matrix = GLKMatrix4Multiply(obj2_translation, GLKMatrix4Multiply(obj2_radius_matrix, GLKMatrix4Multiply(obj2_rotation, GLKMatrix4Multiply(obj2_scale_matrix, obj2_negative_radius_matrix))));
                    
                    obj2_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj2_modeling_matrix);
                } else if (txz == 1) {
                    obj2_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj2_translate_z += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    obj2_translation = GLKMatrix4MakeTranslation(obj2_translate_x, obj2_translate_y, obj2_translate_z);
                    
                    obj2_modeling_matrix = GLKMatrix4Multiply(obj2_translation, GLKMatrix4Multiply(obj2_radius_matrix, GLKMatrix4Multiply(obj2_rotation, GLKMatrix4Multiply(obj2_scale_matrix, obj2_negative_radius_matrix))));
                    
                    obj2_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj2_modeling_matrix);
                } else if (scale == 1) {
                    let dy : GLfloat = self.myTouchYcurrent - self.myTouchYold;
                    
                    if (dy >= 0) {
                        obj2_scale += 0.01;
                    } else if (obj2_scale >= 0.06) {
                        obj2_scale -= 0.01;
                    }
                    
                    obj2_scale_matrix = GLKMatrix4MakeScale(obj2_scale, obj2_scale, obj2_scale);
                    
                    obj2_modeling_matrix = GLKMatrix4Multiply(obj2_translation, GLKMatrix4Multiply(obj2_radius_matrix, GLKMatrix4Multiply(obj2_rotation, GLKMatrix4Multiply(obj2_scale_matrix, obj2_negative_radius_matrix))));
                    
                    obj2_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj2_modeling_matrix);
                }
            } else if (obj3 == 1) {
                if (rot == 1) {
                    var dx : GLfloat = (self.myTouchXcurrent - self.myTouchXold);
                    var dy : GLfloat = (self.myTouchYcurrent - self.myTouchYold);
                    
                    if (dx == 0.0) {
                        dx = 1.0;
                    }
                    
                    if (dy == 0.0) {
                        dy = 1.0;
                    }
                    
                    let dr : GLfloat = sqrtf(powf(dx, 2) + powf(dy, 2))
                    let nx : GLfloat = -1.0 * (dy/dr);
                    let ny : GLfloat = dx/dr;
                    let nz : GLfloat = 0.0;
                    
                    var n : GLKVector3 = GLKVector3Make(nx, ny, nz);
                    n = GLKVector3Normalize(n);
                    
                    let angle = dr/obj3_radius;
                    
                    let rot_matrix : GLKMatrix4 = GLKMatrix4MakeRotation(angle, n.x, n.y, n.z);
                    obj3_rotation = GLKMatrix4Multiply(rot_matrix, obj3_rotation);
                    
                    obj3_modeling_matrix = GLKMatrix4Multiply(obj3_translation, GLKMatrix4Multiply(obj3_radius_matrix, GLKMatrix4Multiply(obj3_rotation, GLKMatrix4Multiply(obj3_scale_matrix, obj3_negative_radius_matrix))));
                    
                    obj3_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj3_modeling_matrix);
                } else if (txy == 1) {
                    obj3_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj3_translate_y += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    obj3_translation = GLKMatrix4MakeTranslation(obj3_translate_x, obj3_translate_y, obj3_translate_z);
                    
                    obj3_modeling_matrix = GLKMatrix4Multiply(obj3_translation, GLKMatrix4Multiply(obj3_radius_matrix, GLKMatrix4Multiply(obj3_rotation, GLKMatrix4Multiply(obj3_scale_matrix, obj3_negative_radius_matrix))));
                    
                    obj3_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj3_modeling_matrix);
                } else if (txz == 1) {
                    obj3_translate_x += (0.05 * (self.myTouchXcurrent - self.myTouchXold));
                    obj3_translate_z += (0.05 * (self.myTouchYcurrent - self.myTouchYold));
                    
                    obj3_translation = GLKMatrix4MakeTranslation(obj3_translate_x, obj3_translate_y, obj3_translate_z);
                    
                    obj3_modeling_matrix = GLKMatrix4Multiply(obj3_translation, GLKMatrix4Multiply(obj3_radius_matrix, GLKMatrix4Multiply(obj3_rotation, GLKMatrix4Multiply(obj3_scale_matrix, obj3_negative_radius_matrix))));
                    
                    obj3_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj3_modeling_matrix);
                } else if (scale == 1) {
                    let dy : GLfloat = self.myTouchYcurrent - self.myTouchYold;
                    
                    if (dy >= 0) {
                        obj3_scale += 0.01;
                    } else if (obj2_scale >= 0.06) {
                        obj3_scale -= 0.01;
                    }
                    
                    obj3_scale_matrix = GLKMatrix4MakeScale(obj3_scale, obj3_scale, obj3_scale);
                    
                    obj3_modeling_matrix = GLKMatrix4Multiply(obj3_translation, GLKMatrix4Multiply(obj3_radius_matrix, GLKMatrix4Multiply(obj3_rotation, GLKMatrix4Multiply(obj3_scale_matrix, obj3_negative_radius_matrix))));
                    
                    obj3_modeling_array = MyGLESKitViewController.GLKMatrix4ToArray(m: obj3_modeling_matrix);
                }
            }
            
            // NSLog(lMessage)
        }
    } // end of touchesMoved()
    
    // ------------------------------------------------------------------------
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            // let lMessage = "Touches Ended at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            // A01 SOLUTION:
            // detected end of touch event sequence (finger lifted from surface)
            // NOTE: here you may need to instead set both current and old points to the last detected coordinates:
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent
            
            self.myTouchXcurrent = GLfloat(firstTouchPoint.x)
            self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)
            
            // we are in the "completed" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.ended
            
            // NSLog(lMessage)
        }
    } // end of touchesEnded()
    
    // ------------------------------------------------------------------------
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        // let lMessage = "Touches Cancelled"
        
        self.myTouchXbegin = -1.0
        self.myTouchYbegin = -1.0
        self.myTouchXcurrent = -1.0
        self.myTouchYcurrent = -1.0
        self.myTouchXold = -1.0
        self.myTouchYold = -1.0
        
        // we are in the "something just interrupted us, e.g. a phone call" phase
        //     of the touch event sequence:
        self.myTouchPhase = UITouchPhase.cancelled
        
        // NSLog(lMessage)
        
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
        self.myPosAttrib = GLuint(glGetAttribLocation(myGLESProgram, "a_Position"));
        self.myNormalAttrib = GLuint(glGetAttribLocation(myGLESProgram, "a_Normal"));
        
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
        self.myLightPosition = glGetUniformLocation(myGLESProgram, "u_Light_position");
        self.myLightColor = glGetUniformLocation(myGLESProgram, "u_Light_color");
        self.myShininess = glGetUniformLocation(myGLESProgram, "u_Shininess");
        self.myAmbientColor = glGetUniformLocation(myGLESProgram, "u_Ambient_color");
        self.myDrawLight = glGetUniformLocation(myGLESProgram, "u_Draw_Light");
        
        // Get location of attribute variable in the shader:
        self.myVertexTextureAttribute = GLuint(glGetAttribLocation(self.myGLESProgram, "a_TextureCoordinates"));
        
        // BEGIN TEXTURE
        self.myTexUniform = glGetUniformLocation(myGLESProgram, "u_TextureSampler")
        // END TEXTURE
        
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

