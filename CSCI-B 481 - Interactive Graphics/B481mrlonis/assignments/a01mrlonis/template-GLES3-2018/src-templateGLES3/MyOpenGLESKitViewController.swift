//
//  MyOpenGLESKitViewController.swift
//  templateGLES3
//
//  Created by Mitja Hmeljak on 2018-01-24.
//  Copyright © 2018 B481/B581 Spring 2018. All rights reserved.
//

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
    //
]

var gColorData: [[GLfloat]] = [
    // color data in RGBA float format
    [0.0, 1.0, 0.0, 1.0],   // Green
    [0.0, 0.0, 1.0, 1.0],   // Blue
    [1.0, 0.0, 0.0, 1.0],   // Red
    [1.0, 1.0, 1.0, 1.0]    // White
]

let point_threshold : GLfloat = 10;
let line_threshold : GLfloat = 5;


class MyOpenGLESKitViewController: GLKViewController {
    var myGLESProgram: GLuint = 0
    
    var myPosAttrib: GLuint = 0
    
    var myModelViewProjectionMatrix:GLKMatrix4 = GLKMatrix4Identity
    
    var myViewPortWidth:GLsizei = -1
    var myViewPortHeight:GLsizei = -1
    
    var myWidthUniform: GLint = 0
    var myHeightUniform: GLint = 0
    var myColorUniform: GLint = 0
    
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
    
    // Mode
    var proximity_result: [Int] = [-1, 0, 0, 0, 0];
    
    // polygon build data:
    var myEnteredVertices = 0
    
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
        //   set our (MyOpenGLESKitViewController's) view as a GL view:
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
        
        
        glEnableVertexAttribArray(self.myPosAttrib)
        
        // public func glVertexAttribPointer(
        //        _ indx: GLuint,
        //        _ size: GLint,
        //        _ type: GLenum,
        //        _ normalized: GLboolean,
        //        _ stride: GLsizei,
        //        _ ptr: UnsafeRawPointer!)
        glVertexAttribPointer(self.myPosAttrib, 2, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gVertexData)
        
        glLineWidth(3.0)
        
        
        // only draw if you have at least 2 vertices
        let lNumberOfVertices = gVertexData.count/2
        if (lNumberOfVertices >= 2) {
            // what color to use for the line strip:
            glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
            // draw the line:
            // these are the parameters for glDrawArrays() :
            //   glDrawArrays(_ mode: GLenum,
            //                _ first: GLint,
            //                _ count: GLsizei )
            if (self.proximity_result[0] == 2) {
                if (self.proximity_result[1] == 0) {
                    glDrawArrays( GLenum(GL_LINE_STRIP), 1, GLsizei(lNumberOfVertices - 1) );
                } else if (self.proximity_result[1] == (gVertexData.count - 4)) {
                    glDrawArrays( GLenum(GL_LINE_STRIP), 0, GLsizei(lNumberOfVertices - 1) );
                } else {
                    let first_count = (self.proximity_result[1] / 2) + 1;
                    let end_count = lNumberOfVertices - first_count;
                    let count_message = "first count = \(first_count) | end_count = \(end_count) | lNumberOfVertices = \(lNumberOfVertices)";
                    NSLog(count_message);
                    glDrawArrays( GLenum(GL_LINE_STRIP), 0, GLsizei(first_count) );
                    glDrawArrays( GLenum(GL_LINE_STRIP), GLint((self.proximity_result[1]/2) + 1), GLsizei(end_count) );
                }
            } else {
                glDrawArrays( GLenum(GL_LINE_STRIP), 0, GLsizei(lNumberOfVertices) );
            }
        }
        
        /*
         * Draw points
         */
        if (lNumberOfVertices >= 1) {
            // what color to use for the line strip:
            glUniform4f(self.myColorUniform, gColorData[2][0], gColorData[2][1], gColorData[2][2], gColorData[2][3]);
            // draw the line:
            // these are the parameters for glDrawArrays() :
            //   glDrawArrays(_ mode: GLenum,
            //                _ first: GLint,
            //                _ count: GLsizei )
            if (self.proximity_result[0] == 1) {
                /*
                 * Need to check if the vertex for editing is the first or last vertex
                 */
                if (self.proximity_result[1] == 0) {
                    glDrawArrays( GLenum(GL_POINTS), 1, GLsizei(lNumberOfVertices - 1) );
                } else if (self.proximity_result[1] == (gVertexData.count - 2)) {
                    glDrawArrays( GLenum(GL_POINTS), 0, GLsizei(lNumberOfVertices - 1) );
                } else {
                    let first_count = self.proximity_result[1] / 2;
                    let end_count = lNumberOfVertices - 1 - first_count;
                    let count_message = "first count = \(first_count) | end_count = \(end_count) | lNumberOfVertices = \(lNumberOfVertices)";
                    NSLog(count_message);
                    glDrawArrays( GLenum(GL_POINTS), 0, GLsizei(first_count) );
                    glDrawArrays( GLenum(GL_POINTS), GLint((self.proximity_result[1]/2) + 1), GLsizei(end_count) );
                }
            } else {
                glDrawArrays( GLenum(GL_POINTS), 0, GLsizei(lNumberOfVertices) );
            }
        }
        
        /*
         * Draw highlighted Point if it needs to be highlighted
         */
        if (self.proximity_result[0] == 1) {
            glUniform4f(self.myColorUniform, gColorData[3][0], gColorData[3][1], gColorData[3][2], gColorData[3][3]);
            glDrawArrays( GLenum(GL_POINTS), GLint(self.proximity_result[1] / 2), GLsizei(1) );
        }
        
        /*
         * Draw highlighted Line if it needs to be highlighted
         */
        if (self.proximity_result[0] == 2) {
            glUniform4f(self.myColorUniform, gColorData[3][0], gColorData[3][1], gColorData[3][2], gColorData[3][3]);
            glDrawArrays( GLenum(GL_LINE_STRIP), GLint(self.proximity_result[1] / 2), GLsizei(2) );
        }
        
        // NOTE: don't change contents of the gVertexData array in the drawing function!
        
        
    } // end of glkView( ... drawInRect: )
    
    
    
    
    
    
    // ------------------------------------------------------------------------
    // MARK: - UIResponder delegate methods for touch events
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view);
            let lMessage = "Touch Began at \(firstTouchPoint.x), \(firstTouchPoint.y)";
            
            /*
             * If myTouchX/Ycurrent are not less than zero, set them equal to self.myTouchX/Ycurrent
             * Else update self.myTouchX/Ycurrent and set pastTouchX/Y accordingly
             */
            if (!(self.myTouchXbegin < 0 || self.myTouchYbegin < 0)) {
                self.myTouchXold = self.myTouchXbegin;
                self.myTouchYold = self.myTouchYbegin;
                self.myTouchXbegin = GLfloat(firstTouchPoint.x);
                self.myTouchYbegin = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1);
            } else {
                self.myTouchXbegin = GLfloat(firstTouchPoint.x);
                self.myTouchYbegin = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1);
                self.myTouchXold = self.myTouchXbegin;
                self.myTouchYold = self.myTouchYbegin;
            }
            
            // we are in the "we've just began" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.began;
            
            // print out debugging info:
            NSLog(lMessage);
            
            // Mode Detection
            self.proximity_result = E_MODE_PROXIMITY(xCoord: self.myTouchXbegin, yCoord: self.myTouchYbegin);
            
            if (self.proximity_result[0] == 0) {
                E_MODE_INSERT(xCoord: self.myTouchXbegin, yCoord: self.myTouchYbegin);
            } else if (self.proximity_result[0] == 1 || self.proximity_result[0] == 2) {
                E_MODE_EDIT(xCoord: self.myTouchXbegin, yCoord: self.myTouchYbegin, data: self.proximity_result, xPast: self.myTouchXold, yPast: self.myTouchYold);
            }
            
            let proximity_message = "Proximity Data: [\(self.proximity_result[0]), \(self.proximity_result[1]), \(self.proximity_result[2]), \(self.proximity_result[3]), \(self.proximity_result[4])";
            NSLog(proximity_message);
            
        }
    } // end of touchesBegan()
    
    
    // ------------------------------------------------------------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touch Moved to \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            /*
             * If myTouchX/Ycurrent are not less than zero, set them equal to self.myTouchX/Ycurrent
             * Else update self.myTouchX/Ycurrent and set pastTouchX/Y accordingly
             */
            if (!(self.myTouchXcurrent < 0 || self.myTouchYcurrent < 0)) {
                self.myTouchXold = self.myTouchXcurrent;
                self.myTouchYold = self.myTouchYcurrent;
                self.myTouchXcurrent = GLfloat(firstTouchPoint.x);
                self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1);
            } else {
                self.myTouchXcurrent = GLfloat(firstTouchPoint.x);
                self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1);
                self.myTouchXold = self.myTouchXcurrent;
                self.myTouchYold = self.myTouchYcurrent;
            }
            
            // we are in the "something has moved" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.moved
            
            // print out debugging info:
            // NSLog(lMessage)
            
            /*
             * Call EDIT regardless if editing since if proximity_result[0] == 0, nothing will happen
             */
            E_MODE_EDIT(xCoord: self.myTouchXcurrent, yCoord: self.myTouchYcurrent, data: self.proximity_result, xPast: self.myTouchXold, yPast: self.myTouchYold);
        }
    } // end of touchesMoved()
    
    
    
    // ------------------------------------------------------------------------
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touches Ended at \(firstTouchPoint.x), \(firstTouchPoint.y)"
            
            /*
             * If myTouchX/Ycurrent are not less than zero, set them equal to self.myTouchX/Ycurrent
             * Else update self.myTouchX/Ycurrent and set pastTouchX/Y accordingly
             */
            if (!(self.myTouchXcurrent < 0 || self.myTouchYcurrent < 0)) {
                self.myTouchXold = self.myTouchXcurrent;
                self.myTouchYold = self.myTouchYcurrent;
                self.myTouchXcurrent = GLfloat(firstTouchPoint.x);
                self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1);
            } else {
                self.myTouchXcurrent = GLfloat(firstTouchPoint.x);
                self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1);
                self.myTouchXold = self.myTouchXcurrent;
                self.myTouchYold = self.myTouchYcurrent;
            }
            
            // we are in the "completed" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.ended
            
            // NSLog(lMessage)
            
            /*
             * Call EDIT regardless if editing since if proximity_result[0] == 0, nothing will happen
             */
            E_MODE_EDIT(xCoord: self.myTouchXcurrent, yCoord: self.myTouchYcurrent, data: self.proximity_result, xPast: self.myTouchXold, yPast: self.myTouchYold);
            
            self.myTouchXbegin = -1.0
            self.myTouchYbegin = -1.0
            self.myTouchXcurrent = -1.0
            self.myTouchYcurrent = -1.0
            self.myTouchXold = -1.0
            self.myTouchYold = -1.0
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
    // MARK: - Interaction Modes
    // ------------------------------------------------------------------------
    
    /*
     *
     */
    func E_MODE_INSERT(xCoord: GLfloat, yCoord: GLfloat) {
        gVertexData.append(xCoord);
        gVertexData.append(yCoord);
    }
    
    /*
     * Returns an array of information to be used. If index 0 in the array is 0, then we
     * are in insert mode. gVertexData[1] & [2] are indexes into gVertexData if
     * proximity_result[0] == 1. gVertexData[3] & [4] are indexes into gVertexData if
     * proximity_result[0] == 2, along with gVertexData[1] & [2] being filled out. If
     * proximity_result[0] == 2 then we are in line edit mode and hence why we need
     * indexes to two points in order to compute the line. 
     */
    func E_MODE_PROXIMITY(xCoord: GLfloat, yCoord: GLfloat) -> [Int] {
        var ans = [0, 0, 0, 0, 0];
        
        var i : Int = 0;
        while (i < gVertexData.count) {
            let x1 = gVertexData[i];
            let y1 = gVertexData[i + 1];
            
            if (abs(xCoord - x1) <= point_threshold && abs(yCoord - y1) <= point_threshold) {
                ans = [1, i, i+1, 0, 0];
                return ans;
            }/* else if (i % 2 == 0 && i <= gVertexData.count - 4) {
                let x2 = gVertexData[i + 2];
                let y2 = gVertexData[i + 3];
                let d : GLfloat = minimum_distance(x: xCoord, y: yCoord, x1: x1, y1: y1, x2: x2, y2: y2);
                
                if (d <= line_threshold) {
                    ans = [2, i, i+1, i+2, i+3];
                    return ans;
                }
            } */
            
            i = i + 2;
        }
        
        i = 0;
        while (i <= gVertexData.count - 4) {
            let x1 = gVertexData[i];
            let y1 = gVertexData[i + 1];
            let x2 = gVertexData[i + 2];
            let y2 = gVertexData[i + 3];
            let d : GLfloat = minimum_distance(x: xCoord, y: yCoord, x1: x1, y1: y1, x2: x2, y2: y2);
            
            if (d <= line_threshold) {
                ans = [2, i, i+1, i+2, i+3];
                return ans;
            }
            
            i = i + 2;
        }
        
        return ans;
    }
    
    func minimum_distance(x: GLfloat, y: GLfloat, x1: GLfloat, y1: GLfloat, x2: GLfloat, y2: GLfloat) -> GLfloat {
        let A : GLfloat = x - x1;
        let B : GLfloat = y - y1;
        let C : GLfloat = x2 - x1;
        let D : GLfloat = y2 - y1;
        
        let dot : GLfloat = A * C + B * D;
        let len_sq : GLfloat = C * C + D * D;
        var param : GLfloat = -1;
        
        //in case of 0 length line
        if (len_sq != 0) {
            param = dot / len_sq;
        }
        
        var xx : GLfloat;
        var yy : GLfloat;
        
        if (param < 0) {
            xx = x1;
            yy = y1;
        }
        else if (param > 1) {
            xx = x2;
            yy = y2;
        }
        else {
            xx = x1 + param * C;
            yy = y1 + param * D;
        }
        
        let dx : GLfloat  = x - xx;
        let dy : GLfloat = y - yy;
        return (dx * dx + dy * dy).squareRoot();
    }
    
    func E_MODE_EDIT(xCoord: GLfloat, yCoord: GLfloat, data: [Int], xPast: GLfloat, yPast: GLfloat) {
        /*
         * If data[0] == 1, we are editing a vertex point.
         * If data[0] == 2, We are editing a line (two vertex points)
         */
        if (data[0] == 1) {
            gVertexData[data[1]] = xCoord;
            gVertexData[data[2]] = yCoord;
        } else if (data[0] == 2) {
            let xChange : GLfloat = xCoord - xPast;
            let yChange : GLfloat = yCoord - yPast;
            
            let message = "xChange = \(xChange) & yChange = \(yChange)";
            
            // NSLog(message);
            
            gVertexData[data[1]] = gVertexData[data[1]] + xChange;
            gVertexData[data[2]] = gVertexData[data[2]] + yChange;
            gVertexData[data[3]] = gVertexData[data[3]] + xChange;
            gVertexData[data[4]] = gVertexData[data[4]] + yChange;
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
    
    
    
    
    
    
} // end of class MyOpenGLESKitViewController

