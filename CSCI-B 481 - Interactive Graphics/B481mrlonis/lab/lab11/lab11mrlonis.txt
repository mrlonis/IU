# Lab 11 - B481/Spring 2018

**Name:** Matthew Lonis
**Username:** mrlonis
**Date:** 30 March 2018 12:30 PM

## Part F

When the above changes are complete, try running your Lab 11 code: you will notice that vertex input from the touch interface will create and draw new vertices and line segments, but these are ***not*** going to be aligned to the touch positions. In your ***written answers*** submission for Lab 11, please write down your own explanation as to why that may be.

### Explaination

The touch interface will create and draw new vertices and line segments, but these are ***not***  aligned to the touch positions because of our translation matrix drawing the view -500 points away from the screen and because of our myGLUPerspective() function. This results in touch events that are not located at the exact touch location.
