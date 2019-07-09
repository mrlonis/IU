# Assignment 2 README

### Name: Matthew Lonis
### Username: mrlonis
### Date Due: March 19th, 2018

## The parts of the assignment you have completed
- I have completed everything but the parts pertaining to derivatives. I have buttons in place to implement the user functionality to disable or enable derivatives but I didn't actually get the shader to raw the derivatives.

## The sequence of commands you used to compile and execute your program(s)
- I compiled my code by clicking the run button... I simulated an iPhone 8 Plus

## Any particularly clever code you added
- I made a dummy array where each vertex corresponded to a value of 0 - 50. I did this because I could make the vertex shader compute the value of t by passing in a uniform t_inc value of 0.02 and then multiplying that value with either the x or the y data of the vertex. This made it easy to draw splines. All i had to do was set some uniform variables and glDrawArrays and my vertex shader handled the rest.

## Include your name and IU username.
- See the top of my file
