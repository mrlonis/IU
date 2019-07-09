/*
 * initial code Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.example.android.opengl;

import android.content.Context;
import android.content.res.AssetManager;
import android.opengl.GLSurfaceView;
import android.view.MotionEvent;

import java.io.IOException;
import java.io.InputStream;
import java.util.Random;
import java.util.Scanner;

/**
 * A view container where OpenGL ES graphics can be drawn on screen.
 * This view can also be used to capture touch events, such as a user
 * interacting with drawn objects.
 */
public class MyGLSurfaceView extends GLSurfaceView {

    private final MyGLRenderer myGLRenderer;

    // -----------------------------------
    public MyGLSurfaceView(Context pContext, int pScreenHeight, int pScreenWidth) {

        super(pContext);

        // Create an OpenGL ES 2.0 context:
        setEGLContextClientVersion(2);

        // void setEGLConfigChooser (int redSize, int greenSize, int blueSize, int alphaSize, int depthSize, int stencilSize)
        // Install a config chooser which will choose a config with at least the specified depthSize and stencilSize,
        // and exactly the specified redSize, greenSize, blueSize and alphaSize.
        super.setEGLConfigChooser(8, 8, 8, 8, 16, 0);

        // Set the Renderer for drawing on the GLSurfaceView
        myGLRenderer = new MyGLRenderer();

        // read the GLSL fragment shader and vertex shader source code,
        //    and save their source code text into our renderer:
        myGLRenderer.vertexShaderCode = readFile("Shader.vert");
        myGLRenderer.fragmentShaderCode = readFile("Shader.frag");

        // set the surface's renderer to be our OpenGL ES renderer:
        setRenderer(myGLRenderer);

        // Render the view only when there is a change in the drawing data:
        setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);
    }

    // -----------------------------------
    @Override
    public boolean onTouchEvent(MotionEvent pEvent) {

        System.out.println("onTouchEvent() has event X, Y = " + pEvent.getX() + " , " + pEvent.getY());

        if(pEvent.getAction() == MotionEvent.ACTION_DOWN) {
            myGLRenderer.touchesBegan(pEvent.getX(), pEvent.getY());
            // requestRender();
        }
        else if(pEvent.getAction() == MotionEvent.ACTION_MOVE) {
            myGLRenderer.touchesMoved(pEvent.getX(), pEvent.getY());
            // requestRender();
        }
        else if(pEvent.getAction() == MotionEvent.ACTION_UP) {
            myGLRenderer.touchesEnded(pEvent.getX(), pEvent.getY());
            // requestRender();
        }
        return true;

    }


    // -----------------------------------
    private String readFile(String name) {
        AssetManager am = this.getContext().getAssets();
        try
        {
            InputStream is = am.open(name);
            String value = new Scanner(is, "UTF-8").useDelimiter("\\A").next();
            return value;
        }
        catch (IOException e) {return "Failed";}
    }

}
