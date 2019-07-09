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
    //  positionX, positionY, etc.
    
    // A01 SOLUTION: start from NO vertices:
]

var gColorData: [[GLfloat]] = [
    // color data in RGBA float format
    [0.0, 1.0, 0.0, 1.0],
    [0.0, 1.0, 1.0, 1.0],
    [1.0, 0.0, 0.0, 1.0]
]

let G_DISTANCE_VV: GLfloat = 20.0
let G_DISTANCE_VL: GLfloat = 10.0

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
        self.myGLKView!.drawableDepthFormat = GLKViewDrawableDepthFormat.formatNone
        // in 3D we'll often need the depth buffer, e.g.:
        // lView.drawableDepthFormat = GLKViewDrawableDepthFormat.Format24
        
        self.setupGL()
        
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
        glDisable(GLenum(GL_DEPTH_TEST))
        
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
    
    // ------------------------------------------------------------------------
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glUseProgram(myGLESProgram)
        
        glClear( GLbitfield(GL_COLOR_BUFFER_BIT)  )
        
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
        
        // A01 SOLUTION: don't change the gVertexData array in the drawing function!
        
        glEnableVertexAttribArray(self.myPosAttrib)
        
        // public func glVertexAttribPointer(
        //        _ indx: GLuint,
        //        _ size: GLint,
        //        _ type: GLenum,
        //        _ normalized: GLboolean,
        //        _ stride: GLsizei,
        //        _ ptr: UnsafeRawPointer!)
        glVertexAttribPointer(self.myPosAttrib, 2, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gVertexData)
        
        glLineWidth(1.0)
        
        // A01 SOLUTION: only draw if you have at least 2 vertices
        let lNumberOfVertices = gVertexData.count/2
        if (lNumberOfVertices >= 2) {
            // what color to use for the line strip:
            glUniform4f(self.myColorUniform,
                        gColorData[0][0],
                        gColorData[0][1],
                        gColorData[0][2],
                        gColorData[0][3])
            // draw the line strip:
            // these are the parameters for glDrawArrays() :
            //   glDrawArrays(_ mode: GLenum,
            //                _ first: GLint,
            //                _ count: GLsizei )
            glDrawArrays( GLenum(GL_LINE_STRIP), 0, GLsizei(lNumberOfVertices) )
        }
        
        // NOTE: don't change contents of the gVertexData array in the drawing function!
        
        // A01 SOLUTION: hightlight line detected as "close" in proximity:
        if (self.myLitType == G_LIT.LITLINE) {
            
            glLineWidth(3.0)
            
            // what color to use for the highlighted points:
            glUniform4f(self.myColorUniform,
                        gColorData[1][0],
                        gColorData[1][1],
                        gColorData[1][2],
                        gColorData[1][3])
            // draw the highlighted point in the array:
            glDrawArrays( GLenum(GL_LINES), GLint(myLitID), 2 )
            
        }
        
        glEnable(GLenum(GL_POINT_SMOOTH))
        
        // this wont work since it's part of OpenGL ES 1.0 !!! :
        glPointSize(20.0)
        // (it passes compilation but does nothing... must instead
        //  use the Vertex Shader to change point size in ES 3.0
        
        
        // A01 SOLUTION: only draw if there is at least 1 vertex
        if (lNumberOfVertices >= 1) {
            // what color to use for the points:
            glUniform4f(self.myColorUniform,
                        gColorData[2][0],
                        gColorData[2][1],
                        gColorData[2][2],
                        gColorData[2][3])
            // draw the second point in the array:
            glDrawArrays( GLenum(GL_POINTS), 0, GLsizei(lNumberOfVertices) )
        }
        
        // A01 SOLUTION: hightlight vertex detected as "close" in proximity:
        if (self.myLitType == G_LIT.LITVERTEX) {
            // what color to use for the highlighted points:
            glUniform4f(self.myColorUniform,
                        gColorData[1][0],
                        gColorData[1][1],
                        gColorData[1][2],
                        gColorData[1][3])
            // draw the highlighted point in the array:
            glDrawArrays( GLenum(GL_POINTS), GLint(myLitID), 1 )
            
        }
        
    } // end of glkView( ... drawInRect: )
    
    // ------------------------------------------------------------------------
    // MARK: - Assignment 02 Task B SOLUTION: distance functions
    // ------------------------------------------------------------------------
    
    /* Proximity functions:
     *  vvDist =  vert vert distance
     *  vlinedist = "h" = vert-to-line distance
     *  vlineproj = "l" = projection-on-line distance
     *  vertonseg =  "l-test" = 1 if on seg, 0 if not */
    
    // ------------------------------------------------------------------------
    func vvDist(_ lX1: GLfloat, _ lY1: GLfloat,
                _ lX2: GLfloat, _ lY2: GLfloat) -> GLfloat {
        return (
            sqrt(
                pow((lX2 - lX1), 2) +
                    pow((lY2 - lY1), 2)
            )
        )
    }
    
    // ------------------------------------------------------------------------
    /* the line segment is from (x1,y1) to (x2, y2) */
    /* the point is (x0,y0)*/
    func vlinedist(_ x0: GLfloat, _ y0: GLfloat, _ x1: GLfloat, _ y1: GLfloat, _ x2: GLfloat, _ y2: GLfloat) -> GLfloat {
        
        var vldis, length: GLfloat
        var normX, normY: GLfloat
        
        length = vvDist(x1,y1,x2,y2)
        
        // test for degenerate edges:
        if (length == 0.0) { return -999.0 }
        
        /* find norm direction perpendicular to the line X2-X1 */
        normX = -(y2-y1) / length
        normY = (x2-x1) / length
        
        /* the projection of X0-X1 on the perpendicular norm */
        vldis = normX * (x0-x1) + normY * (y0-y1)
        
        return vldis
    } // end of vlinedist()
    
    // ------------------------------------------------------------------------
    func vlineproj(_ x0: GLfloat, _ y0: GLfloat, _ x1: GLfloat, _ y1: GLfloat, _ x2: GLfloat, _ y2: GLfloat) -> GLfloat {
        var vlpro, length: GLfloat
        var horX, horY: GLfloat
        
        /* normalized vector from vertex (x1,y1) to vertex (x2,y2) */
        length = vvDist(x1,y1,x2,y2)
        
        // test for degenerate edges:
        if (length==0.0) { return -999.0 }
        
        horX = (x2-x1)/length
        horY = (y2-y1)/length
        vlpro = horX * (x0-x1) + horY * (y0-y1)
        
        return vlpro
    }
    
    // ------------------------------------------------------------------------
    /* Returns true if projected point is on line segment, false otherwise  */
    func vertonseg(_ x0: GLfloat, _ y0: GLfloat, _ x1: GLfloat, _ y1: GLfloat, _ x2: GLfloat, _ y2: GLfloat) -> Bool {
        var l, length: GLfloat
        
        length = vvDist(x1,y1,x2,y2)
        
        // test for degenerate edges:
        if (length == 0.0) { return false }
        
        l = vlineproj(x0,y0,x1,y1,x2,y2)
        
        if (l>=0 && l<=length) {
            return true
        } else {
            return false
        }
    } // end of vertonseg
    
    // ------------------------------------------------------------------------
    func proximityTest() -> Bool {
        var onseg: Bool
        var dist: GLfloat
        
        self.myLitType = G_LIT.NONLIT
        self.myLitID = -1
        
        /* Test vertex first */
        // only test closeness to vertex if there is a vertex already!
        if (self.myEnteredVertices >= 1) {
            for i in 0 ..< self.myEnteredVertices {
                
                let lViX = gVertexData[i*2]
                let lViY = gVertexData[i*2 + 1]
                dist = vvDist(self.myTouchXbegin, self.myTouchYbegin, lViX, lViY)
                
                if (dist <= G_DISTANCE_VV) {
                    self.myLitType = G_LIT.LITVERTEX
                    self.myLitID = i
                    return true
                }
                
            }
        }
        /* Test edges next */
        if (self.myEnteredVertices >= 2) {
            
            for i in 0 ..< (self.myEnteredVertices - 1) {
                onseg =  vertonseg(self.myTouchXbegin, self.myTouchYbegin,
                                   gVertexData[i*2], gVertexData[i*2 + 1],
                                   gVertexData[i*2 + 2], gVertexData[i*2 + 3])
                dist =  fabs(vlinedist(
                    self.myTouchXbegin, self.myTouchYbegin,
                    gVertexData[i*2], gVertexData[i*2 + 1],
                    gVertexData[i*2 + 2], gVertexData[i*2 + 3] ))
                if (onseg && (dist <= G_DISTANCE_VL)) {
                    self.myLitType = G_LIT.LITLINE
                    self.myLitID = i
                    return true
                }
            }
            
        }
        return false
    } // end of proximityTest
    
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
            
            // A01 SOLUTION task B:
            // if not close to a vertex, nor close to a line, add a vertex:
            if (!proximityTest()) {
                // SOLUTION task A: add one vertex to the gVertexData Swift array of floats:
                gVertexData.append(self.myTouchXbegin)
                gVertexData.append(self.myTouchYbegin)
                self.myEnteredVertices += 1
            }
            
            
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
            
            // A01 SOLUTION task C : move vertex or line segment:
            if (self.myLitType == G_LIT.NONLIT) {
                // A01 SOLUTION task A: modify the current vertex, if entering a new
                //   vertex to the gVertexData Swift array of floats:
                gVertexData[2 * (self.myEnteredVertices-1)] = self.myTouchXcurrent
                gVertexData[(2 * (self.myEnteredVertices-1)) + 1] = self.myTouchYcurrent
            } else if (self.myLitType == G_LIT.LITVERTEX) {
                // A01 SOLUTION task B: if close to a vertex, or close to a line, move highlighted element:
                gVertexData[2 * self.myLitID] += (self.myTouchXcurrent - self.myTouchXold)
                gVertexData[2 * self.myLitID + 1] += (self.myTouchYcurrent - self.myTouchYold)
            } else if (self.myLitType == G_LIT.LITLINE){
                gVertexData[2 * self.myLitID] += (self.myTouchXcurrent - self.myTouchXold)
                gVertexData[2 * self.myLitID + 1] += (self.myTouchYcurrent - self.myTouchYold)
                gVertexData[2 * self.myLitID + 2] += (self.myTouchXcurrent - self.myTouchXold)
                gVertexData[2 * self.myLitID + 3] += (self.myTouchYcurrent - self.myTouchYold)
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
            
            // A01 SOLUTION: stop highlighting when touch event is off:
            self.myLitType = G_LIT.NONLIT
            self.myLitID = -1
            
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

