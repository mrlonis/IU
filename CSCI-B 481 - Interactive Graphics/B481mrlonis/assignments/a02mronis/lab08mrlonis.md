# Lab 08

#### B 481
#### 2 March 2018
#### Name: Matthew Lonis
#### Username: mrlonis

## Notes

In this lab we added three buttons to our OpenGL view in order to select which type of spline we would like to use when drawing our splines. This is a good starting point for Assignment 2.

### Important

In order to draw splines, you will want to pass that dummy array I made at the top of my swift file into the vertex shader, along with the four control points. I'll need to make new variables in the vertex shader and also a new function to draw the splines. Map a mode variable to the vertex shader to know which spline we are drawing.

Make sure in the for loop you make in the vertex shader that you loop from 0 to 1 however many times corresponding to the number of dummy vertices you pass.

This is your problem now! ~ Past Matt
