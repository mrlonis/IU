# Assignment 3 - B481/Spring 2018

**Name:** Matthew Lonis
**Username:** mrlonis
**Date:** 11 April 2018 12:30 PM

## Parts of Assignment Completed

- **All** of Part A _(Including the optional rotation of the camera)_
- **All** of Part B _(Including the optional scaling of the object about it's center of mass)_
- None of Part C _(As of writting this)_
- I tried to get this working and have code in place in my fragment and vertex shader to sort of do the work necessary but I couldn't get it to work.
- **All** of Part D

## Clever code added

I made the buttons turn gray if the function was not implemented. For example if you click on scalig while the cam button is active, the button will be gray instead of green signaling that it doesn't work on the cam.

## Assignment 04 Proposal

**Choose a topic which is related either to a 3D game or game-like virtual environment, or a small prototype 3D scientific visualization application, or a 3D interactive demonstration.**

**Topic:**

For my Final Project I am simply going to use my Assignment 3 code and add more objects. I will retain the cube as my obj1 but will add a diamond for my obj2 and a sphere (if possible and time allows. If I can't get a sphere to work I will simply draw polygons with many faces like a hexagon) for my obj3. All objects will be interactive however, the diamond will be animated to spin on it's y-axis. I hope to still allow the diamond to be interactive despite its spinning animation.

I am choosing to go with this Topic since I don't think I have the skills necessary to make a "game" or "scientific visualization". It is also best to base this off of assignment 3 code because this is the ONLY assignment where we've gotten experience with 3D graphics, and since I'm still new at it and lacking in skills, I will stick to the format of assignment 3.

Below talks about the required features for our project and we need to have more fluid controls for the camera instead of just translating the camera in the x/y/z axis. I don't know what this means since I don't know how else a camera would move so I imagine it means we need to give the camera more fluid controls than how we control the camera in assignment 3. So to combat this, if time allows, I will try to add "gamepad like" control buttons on the screen, similar to old GameBoy controls in order to move or "walk" in the scene.

**Required features:**

- Lighting and material. Non-trivial lighting models and materials are expected: per-vertex lighting is required, per-fragment lighting is optional but highly recommended.
- Per-vertex lighting would resemble Gouraud shading which I plan to implement on the objects. I also plan to implement ambient (or flat shading) for per-fragment shading.
- Camera motion. The user should have a feeling of good control while moving through the scene: camera controls need to provide more than just translation along x/y/z axes.
- How would I do more than move along the x/y/z axis?
- Interaction. Several 3D objects in your scene should respond to user interaction, similarly to Assignment 03 task A.
- Read topic above. I plan to have all of my objects be interactive with translate, rotate, and scaling operations.
- Animation. At least one 3D object in your scene should be spontaneously moving using a timer callback or equivalent function.
- Will animate the diamond to spin on it's y-axis. I wanted to do an animation where the object moves but I am instead going to simply stick with a spin on an object.
- Mapping. Either texture mapping or bump mapping, used in a non-trivial way.
- Plan to apply textures on the sphere in order to highlight how its made up of many triangles. If I can't get a sphere to work and instead have to go with a different polygon, I will still apply a texture on it.
