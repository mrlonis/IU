# Assignment 6 Report

**Name:** Matthew Lonis
**Username:** mrlonis
**Date:** April 27th, 2018

## Description of my implementation of the functions required for Assignment 6

- fs_open: The fs_open fnction searches the main directory to see if the file exists. If it does it opens it up into the memory.
-fs_close: Checks to see if the file is valid and if so it closes it on the main directory.
-fs_create: Creates a new file and sets the read and write pointer to a default value for its offset, and then finally stores the entry in the main directory.
-fs_seek: Adjusts a file's read and write pointers to the specified offset given as a parameter to the function.
-fs_read: Reads the data stored in a specified file.
-fs_write: Writes given data to a specified offset on the specified file.

## Lessons Learned

I learned how to implement a basic file system on the Xinu OS. Furthermore I learned what kind of functions are needed in order to make this work and how to design the functions to produce the desired results.
