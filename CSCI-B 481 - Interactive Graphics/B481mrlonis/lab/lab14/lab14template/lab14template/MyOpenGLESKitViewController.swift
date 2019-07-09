//
//  MyOpenGLESKitViewController.swift
//  lab14solution
//
//  Created by Mitja Hmeljak on 2018-04-07.
//  Copyright © 2018 IU CSCI B481/B581 Spring 2018. All rights reserved.
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
    100.0, 100.0,
    300.0, 100.0,
    300.0, 300.0
]


var gTextureData: [GLfloat] = [

    // vertex data structured thus:
    //  positionX, positionY, etc.
    //
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0
]
var gColorData: [[GLfloat]] = [
    // color data in RGBA float format
    [1.0, 0.0, 0.0, 1.0],
    [0.0, 1.0, 0.0, 1.0],
    [0.0, 0.0, 1.0, 1.0]
]



class MyOpenGLESKitViewController: GLKViewController {

    var myGLESProgram: GLuint = 0

    var myVertexPositionAttribute: GLuint = 0

    var myVertexTextureAttribute: GLuint = 0

    var myModelViewProjectionMatrix:GLKMatrix4 = GLKMatrix4Identity

    var myViewPortWidth:GLsizei = -1
    var myViewPortHeight:GLsizei = -1

    var myWidthUniform: GLint = 0
    var myHeightUniform: GLint = 0
    var myColorUniform: GLint = 0

    var myGLESContext: EAGLContext? = nil
    var myGLKView: GLKView? = nil

    // touch event data:
    var myTouchXbegin: GLfloat = -1.0
    var myTouchYbegin: GLfloat = -1.0
    var myTouchXcurrent: GLfloat = -1.0
    var myTouchYcurrent: GLfloat = -1.0
    var myTouchXold: GLfloat = -1.0
    var myTouchYold: GLfloat = -1.0
    var myTx: GLfloat = 0.0
    var myTy: GLfloat = 0.0
    var myTouchPhase: UITouchPhase? = nil

    // polygon build data:
    var myEnteredVertices = 0

    // texture data:
    var myTexUniform: GLint = 0
    var myTexture: GLuint = 0


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


        // Get location of attribute variable in the shader:
        self.myVertexPositionAttribute = GLuint(glGetAttribLocation(self.myGLESProgram, "a_Position"))

        // Get location of attribute variable in the shader:
        self.myVertexTextureAttribute = GLuint(glGetAttribLocation(self.myGLESProgram, "a_TextureCoordinates"))

        // in 3D, we need depth/Z-buffer:
        glEnable(GLenum(GL_DEPTH_TEST))

        // glViewport(x: GLint, _ y: GLint, _ width: GLsizei, _ height: GLsizei)
        self.myViewPortWidth = GLsizei(self.view.bounds.size.width)
        self.myViewPortHeight = GLsizei(self.view.bounds.size.height)

        glViewport ( 0, 0, self.myViewPortWidth, self.myViewPortHeight )

        // Set the background color
        glClearColor ( 0.94, 0.94, 0.94, 1.0 )

        // BEGIN TEXTURE
        loadTexture(filename: "checkerboard.jpg")
        // END TEXTURE


    } // end of setupGL()

    // ------------------------------------------------------------------------
    func tearDownGL() {
        EAGLContext.setCurrent(self.myGLESContext)

        if self.myGLESProgram != 0 {
            glDeleteProgram(self.myGLESProgram)
            self.myGLESProgram = 0
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

    var lIncrementX: GLfloat = 2
    var lIncrementY: GLfloat = 2

    // ------------------------------------------------------------------------
    func update() {

        // here we could cause a periodic change in the data model
        //  e.g. 3D models to be animated, etc.

        print (" \(gVertexData) " )
        gVertexData[0] = gVertexData[0] + lIncrementX
        gVertexData[1] = gVertexData[1] + lIncrementY
        if  (gVertexData[0] > GLfloat(self.myViewPortWidth))   {
            lIncrementX = -2
        }
        if  (gVertexData[1] > GLfloat(self.myViewPortHeight))   {
            lIncrementY = -2
        }
        if  (gVertexData[0] < GLfloat(0))  {
            lIncrementX = 2
        }
        if  (gVertexData[1] < GLfloat(0))  {
            lIncrementY = 2
        }


    }

    // ------------------------------------------------------------------------
    // main drawing function
    // ------------------------------------------------------------------------
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glUseProgram(self.myGLESProgram)

        glClear( GLbitfield(GL_COLOR_BUFFER_BIT) | GLbitfield(GL_DEPTH_BUFFER_BIT) )

        // get viewport dimensions:
        self.myViewPortWidth = GLsizei(self.view.bounds.size.width)
        self.myViewPortHeight = GLsizei(self.view.bounds.size.height)

        // pass viewport dimensions to the vertex shader:
        glUniform1f(self.myWidthUniform, GLfloat(self.myViewPortWidth))
        glUniform1f(self.myHeightUniform, GLfloat(self.myViewPortHeight))

        // pass values to uniform variables in the vertex shader:
        glEnableVertexAttribArray(self.myVertexPositionAttribute)

        // pass values to uniform variables in the vertex shader:
        glEnableVertexAttribArray(self.myVertexTextureAttribute)

        // BEGIN TEXTURE
        glActiveTexture(GLenum(GL_TEXTURE0));
        glBindTexture(GLenum(GL_TEXTURE_2D), self.myTexture);
        glUniform1i(self.myTexUniform, 0);
        // END TEXTURE


        // public func glVertexAttribPointer(
        //        _ indx: GLuint,
        //        _ size: GLint,
        //        _ type: GLenum,
        //        _ normalized: GLboolean,
        //        _ stride: GLsizei,
        //        _ ptr: UnsafeRawPointer!)
        glVertexAttribPointer(self.myVertexPositionAttribute, 2, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gVertexData)

        glVertexAttribPointer(self.myVertexTextureAttribute, 2, GLenum(GL_FLOAT), GLboolean(GLenum(GL_FALSE)), 0, &gTextureData)
        
        glLineWidth(1.0)

        // lab14 SAMPLE SOLUTION:


        // only draw if you have at least 2 vertices
        let lNumberOfVertices = gVertexData.count/2
        if (lNumberOfVertices >= 2) {
            // what color to use for the line strip:
            glUniform4f(self.myColorUniform,
                        gColorData[0][0],
                        gColorData[0][1],
                        gColorData[0][2],
                        gColorData[0][3])
            // draw the line:
            // these are the parameters for glDrawArrays() :
            //   glDrawArrays(_ mode: GLenum,
            //                _ first: GLint,
            //                _ count: GLsizei )
            glDrawArrays( GLenum(GL_TRIANGLE_STRIP), 0, GLsizei(lNumberOfVertices) )
        }

        // NOTE: don't change contents of the gVertexData array in the drawing function!


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
            let lMessage = "Touch Began at \(firstTouchPoint.x), \(firstTouchPoint.y)"

            // the position where the finger begins touching the screen:
            self.myTouchXbegin = GLfloat(firstTouchPoint.x)
            self.myTouchYbegin = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)

            // the position where the finger currently touches the screen:
            self.myTouchXcurrent = self.myTouchXbegin
            self.myTouchYcurrent = self.myTouchYbegin

            // the last known position of the finger touching the screen,
            //   at redraw, or at new (first) touch event,
            //   it's the same as the current position:
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent

            // we are in the "we've just began" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.began

            // print out debugging info:
            NSLog(lMessage)
        }
    } // end of touchesBegan()


    // ------------------------------------------------------------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touch Moved to \(firstTouchPoint.x), \(firstTouchPoint.y)"

            // store "current" to "old" touch coordinates
            self.myTouchXold = self.myTouchXcurrent
            self.myTouchYold = self.myTouchYcurrent

            // get new "current" touch coordinates
            self.myTouchXcurrent = GLfloat(firstTouchPoint.x)
            self.myTouchYcurrent = GLfloat(self.myViewPortHeight) - GLfloat(firstTouchPoint.y - 1)

            // we are in the "something has moved" phase of the touch event sequence:
            self.myTouchPhase = UITouchPhase.moved

            // lab14 SAMPLE SOLUTION - compute new position for camera:
            self.myTx += (self.myTouchXcurrent - self.myTouchXold) * 0.05
            self.myTy += (self.myTouchYcurrent - self.myTouchYold) * 0.05

            NSLog(lMessage)
        }
    } // end of touchesMoved()



    // ------------------------------------------------------------------------
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first  {
            let firstTouchPoint = firstTouch.location(in: self.view)
            let lMessage = "Touches Ended at \(firstTouchPoint.x), \(firstTouchPoint.y)"

            // detected end of touch event sequence (finger lifted from surface)
            // NOTE: depending on the desired behavior for user interaction,
            //    here you may need to instead set both current and old points
            //    to the last detected coordinates:
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
        self.myGLESProgram = glCreateProgram()

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
        glAttachShader(self.myGLESProgram, vertShader)

        // Attach fragment shader object code to GPU program:
        glAttachShader(self.myGLESProgram, fragShader)

        // Link GPU program:
        if !self.linkProgram(self.myGLESProgram) {
            NSLog("Failed to link program: \(self.myGLESProgram)")
            // if linking fails, dispose of anything we got so far:
            if vertShader != 0 {
                glDeleteShader(vertShader)
                vertShader = 0
            }
            if fragShader != 0 {
                glDeleteShader(fragShader)
                fragShader = 0
            }
            if self.myGLESProgram != 0 {
                glDeleteProgram(self.myGLESProgram)
                self.myGLESProgram = 0
            }
            return false
        }

        // Get location of attribute variable in the shader:
        self.myVertexPositionAttribute = GLuint(glGetAttribLocation(myGLESProgram, "a_Position"))

        // Get location of attribute variable in the shader:
        self.myVertexTextureAttribute = GLuint(glGetAttribLocation(myGLESProgram, "a_TextureCoordinates"))

        // Get location of uniform variables in the shaders:
        self.myWidthUniform = glGetUniformLocation(myGLESProgram, "u_Width")
        self.myHeightUniform = glGetUniformLocation(myGLESProgram, "u_Height")
        self.myColorUniform = glGetUniformLocation(myGLESProgram, "u_Color")

        // BEGIN TEXTURE
        self.myTexUniform = glGetUniformLocation(myGLESProgram, "u_TextureSampler")
        // END TEXTURE

        // Release vertex and fragment shaders.
        if vertShader != 0 {
            glDetachShader(self.myGLESProgram, vertShader)
            glDeleteShader(vertShader)
        }
        if fragShader != 0 {
            glDetachShader(self.myGLESProgram, fragShader)
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

