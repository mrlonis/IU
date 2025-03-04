# Homework 4

**Name:** Matthew Lonis
**Username:** mrlonis
**Date:** May 2nd, 2018

## Table of Contents

- [A Answer](#a-answer)
- [B.1 Answer](#b1-answer)
- [B.2 Answer](#b2-answer)
- [C.1 Answer](#c1-answer)
- [C.2 Answer](#c2-answer)
- [D.a Answer](#da-answer)
- [D.b Answer](#db-answer)
- [D.c Answer](#dc-answer)
- [D.d Answer](#dd-answer)
- [D.e Answer](#de-answer)
- [E.a Answer](#ea-answer)
- [E.b Answer](#eb-answer)
- [E.c Answer](#ec-answer)
- [E.d Answer](#ed-answer)
- [E.e Answer](#ee-answer)

## A. [20 points] 3D transformation and projection pipeline

Write down, as clearly as you can, the sequence of transformations to take a vertex of a 3D object model:
from its position in the defining "ideal" coordinate system (sometimes also called object coordinate system)
to a screen viewport pixel.

Include:

1. [5 points] An arbitrary scale, orientation, and position in the world. (Hint: the transformation that defines modeling)

2. [5 points] An basic camera model, i.e., the position of the camera within the world coordinate system. (Hint: the transformation that defines viewing)

3. [5 points] The "pinhole camera" projection, using the style of projection matrix we derived in class, which transforms to the screen in world coordinates, not pixel coordinates. (Hint: this can be accomplished by a gluPerspective() function call.

4. [5 points] The final conversion to integer screen pixels; assume the viewport, in pixels, is [u0 ... u1] horizontally and [v0 ... v1] vertically. (Hint: This is the standard linear world-to-device-pixel transformation between coordinate systems.)

Your answer should contain sufficiently explicit mathematics at each step, that the reader could write a program. Matrices can be defined directly once, and thereafter represented by symbolic notation.

### A Answer

I'll start by defining some matrices:

**Perspective MAtrix P:**

pFoV: 90.0

pAspect: ViewPortWidth / ViewPortHeight

pNear: 1.0

pFar: 1000.0

lAngle: (pFoV / 180.0) * 3.14159

lFocus: 1.0 / tan(lAngle * 0.5)

[(lFocus / pAspect), 0.0,    0.0,                               0.0,

0.0,                 lFocus, 0.0,                               0.0,

0.0,                 0.0,    ((pFar + pNear) / (pNear - pFar)), ((2.0 * pFar * pNear) / (pNear - pFar)),

0.0,                 0.0,    -1.0,                              0.0]

**Viewing Matrix V:**

[1.0, 0.0, 0.0, 0.0,

0.0, 1.0, 0.0, 0.0,

0.0, 0.0, 1.0, 0.0,

0.0, 0.0, 0.0, 1.0]

**Modeling Matrix M:**

[2.0 * cos(2), -sin(2), 0.0, 1.0,

sin(2), cos(2), 0.0, 1.0,

0.0, 0.0, 1.0, 1.0,

0.0, 0.0, 0.0, 1.0]

**Final Transformation** = P * V * M * A where A is the vec4 position of the coordinate system

**_End of A Answer_** [Back to Table of Contents](#table-of-contents)

## B. [20 points] Computing Normals to Polyhedron Faces (for use in Illumination Equations)

Premise: if you have to evaluate the illumination equation on each polygon face of a polyhedron 3D model object, you need to compute (at least) one normal vector per polygon face. In the simplest case, each polygon face is a triangle. For this homework task, you only need to compute the normal (not the illumination equation).
Let's assume a triangle with the 3D vertices in this order (positive, counterclockwise) :
**x<sub>1</sub>=(x<sub>1</sub>, y<sub>1</sub>, z<sub>1</sub>), x<sub>2</sub>=(x<sub>2</sub>, y<sub>2</sub>, z<sub>2</sub>), and x<sub>3</sub>=(x<sub>3</sub>, y<sub>3</sub>, z<sub>3</sub>)**.

1. [10 points] Write down the vector components of this cross-product (explicitly in terms of **x<sub>1</sub>**, **y<sub>1</sub>**, etc.), i.e. **[(x<sub>2</sub> - x<sub>1</sub>) ⨯ (x<sub>3</sub> - x<sub>2</sub>)] = ?**

### B.1 Answer

((x<sub>2</sub>-x<sub>1</sub>), (y<sub>2</sub>-y<sub>1</sub>), (z<sub>2</sub>-z<sub>1</sub>)) x ((x<sub>3</sub>-x<sub>2</sub>), (y<sub>3</sub>-y<sub>2</sub>), (z<sub>3</sub>-z<sub>2</sub>)) = 

[(((y<sub>2</sub>-y<sub>1</sub>) * (z<sub>3</sub>-z<sub>2</sub>)) - ((z<sub>2</sub>-z<sub>1</sub>) * (y<sub>3</sub>-y<sub>2</sub>))), (((z<sub>2</sub>-z<sub>1</sub>) * (x<sub>3</sub>-x<sub>2</sub>)) - ((x<sub>2</sub>-x<sub>1</sub>) * (z<sub>3</sub>-z<sub>2</sub>))), (((x<sub>2</sub>-x<sub>1</sub>) * (y<sub>3</sub>-y<sub>2</sub>)) - ((y<sub>2</sub>-y<sub>1</sub>) * (x<sub>3</sub>-x<sub>2</sub>)))]

**_End of B.1 Answer_** [Back to Table of Contents](#table-of-contents)

2. [10 points] There are six identical forms of this particular normal direction, written in terms of the cross products of **x<sub>2</sub>**-**x<sub>1</sub>**, **x<sub>3</sub>**-**x<sub>2</sub>**, and **x<sub>1</sub>**-**x<sub>3</sub>**. Three of these six identical forms are basically different in their apparent from, and three other forms are derived from one of the first three, with order and sign changes. Write down these six equivalent forms. (Note: e.g. use **x<sub>2</sub>**-**x<sub>1</sub>** only in that order, and not in the **x<sub>1</sub>**-**x<sub>2</sub>** order: the two orderings are not to be considered as a separate vector for this particular homework task.)

### B.2 Answer

I have no idea what this even means. I couldn't even begin to guess and I don't have time to try to figure it out and get it wrong.

**_End of B.2 Answer_** [Back to Table of Contents](#table-of-contents)

## C. Specular Illumination [20 points]

For all the questions in this task, please refer to Homework 03 Task B for terminology, symbols, and definitions --- use those same quantities and symbols, and define them when necessary, to answer the following questions:

1. [10 points] What is the geometric factor for Phong specular lighting with shininess f?

_Hint_: in the geometric factor for Phong specular lighting, you may use either the vector **R**, or the vector **B**.

Note: you have to derive **C, L, B, R**, etc. if you use them, entirely in terms of the known vectors:

**P<sub>world</sub>==P** = a vertex (as a point≡vector in 3D space) on a surface, with unit normal vector **_N_** at that vertex.

**L<sub>world</sub>==X<sub>L</sub>** = be the light position (as a point≡vector in 3D space),

**C<sub>world</sub>==X<sub>C</sub>**, the camera position (as a point≡vector in 3D space),and **_N_**.

(as a reminder: **C** is the normalized unit vector pointing to the camera (or viewer) from the vertex **P**, **L** is the normalized direction to the light source from the current vertex **P**, **R** is the normalized direction of a specularly reflected light ray, and **B** is the normalized bisector(≡halfway vector) of the light and viewer directions)

### C.1 Answer

pow( Max( 0, ( ( ( **C<sub>world</sub>** + **L<sub>world</sub>** ) / abs( **C<sub>world</sub>** + **L<sub>world</sub>** ) ) .* **_N_** ) ), **f** )

**_End of C.1 Answer_** [Back to Table of Contents](#table-of-contents)

2. [10 points] Under what conditions should the Phong specular lighting component be set to zero? Please list at least two distinct circumstances (two different causes) when that may happen.

### C.2 Answer

If the cosine angle  ( ( ( **C<sub>world</sub>** + **L<sub>world</sub>** ) / abs( **C<sub>world</sub>** + **L<sub>world</sub>** ) ) .* **_N_** ) is less than zero, then the Phonbg specular lighting component should be set to zero.

**_End of C.2 Answer_** [Back to Table of Contents](#table-of-contents)

## D. Texture Mapping [20 points]

Texture Mapping in OpenGL ES:

Explain and write down the texture mapping setup used in OpenGL ES for a single polygon and a single (given) 2D texture map.

**a**. Write down the **graphics primitives** (vertices, coordinates, etc.) that will draw a **hexagonal object** on the 2D screen (i.e., centered at 0,0 with height 2.0 and width 2.0) with vertical left and right edges [4 points].

### D.a Answer

// X then Y coordinates. Each new line is a new coordinate

0.0, 1.0

1.0, 0.5,

1.0, -0.5,

0.0, -1.0,

-1.0, -0.5,

-1.0, 0.5

**_End of D.a Answer_** [Back to Table of Contents](#table-of-contents)

**b**. Write down the pseudocode that will map some predefined texture (do not define it) onto the entire hexagon, with the top line of the texture following the upper two edges of the hexagon, and similarly for the bottom. [4 points].

Note: the standard OpenGL ES texture interpolation does not do a pretty job of this without a lot of trouble - which you are not expected to solve for this specific homework question. It is perfectly acceptable to provide a texture mapping that would look something like this (this is direct output from an OpenGL program running with a 2D orthographic setup, not a 3D projection setup!):

Your answer to the above two questions should contain sufficiently explicit mathematics that the reader could write a program.

### D.b Answer

0.0, 0.0

1.0, 0.0,

1.0, 1.0,

0.0, 1.0,

0.0, 0.0,

1.0, 0.0

I have no idea what this is even asking or if this is right.

**_End of D.b Answer_** [Back to Table of Contents](#table-of-contents)

**Understanding Texture Mapping:**

**c**. What would we have to do to our **polygon models** to achieve the **effect of texture mapping**, if texture mapping were not supported directly in the OpenGL ES API? Assume in this part that you have only flat Gouraud interpolation available, and no access to programming GPU shaders, only pass-through GLSL shaders with the mandated outputs. [4 points]

### D.c Answer

I guess I would pass a color that is based on a texture I want and multiply that to the actual color of the polygon?

**_End of D.c Answer_** [Back to Table of Contents](#table-of-contents)

**d**. First, review how you would implement the **scan conversion process** we called Goraud interpolation if you had to do it in GLSL software, e.g. if you had access to programmable GPU shaders that could control the rasterization/interpolation part of the GPU process (you don't need to write down how the OpenGL ES interpolation process works, just carefully review the Gouraud interpolation process before answering this part).

Now, assume that you have access to such programmable GPU shaders that could control the rasterization/interpolation part of the GPU process; how would you now implement texture mapping?

(for this question, you need to again assume as if texture mapping were not supported directly in OpenGL ES, just as in the previous question) [4 points]

### D.d Answer

I literally have no idea. We didn't cover much of this in class and the lecture notes are inadequet to answer this kind of question. I wouldn't even know how to guess for this problem.

**_End of D.d Answer_** [Back to Table of Contents](#table-of-contents)

**e**. What is MIPmapping, and what problem does it solve? [4 points]

### D.e Answer

MIPmapping is a pre-calculated set of images that get progressively smaller with each image. I guess this allows for a finer tuning or faster texturization on an object that is big or small. For example, Instead of texturizing a small object with a huge texture, the MIPmap would have a smaller image map and make it much quicker to figure out how to texturize the object.

**_End of D.e Answer_** [Back to Table of Contents](#table-of-contents)

## E. Bump Mapping [20 points]

**a**. In a polygon-projection pipeline such as OpenGL ES, does Bump Mapping affect the geometry or topology of a surface? If yes, how? If not, in which way does it enhance the rendering of lit wrinkled surfaces? [4 points]

### E.a Answer

It does not affect the geometry of a surface but it enhances rendering by altering the normals to simulate a bumpy surface.

**_End of E.a Answer_** [Back to Table of Contents](#table-of-contents)

**b**. What is a Height Map? How is it used in Bump Mapping? What data type is used in a Height Map in an OpenGL ES program? [4 points]

### E.b Answer

A height map spoecifies the heighjt of each pixel that is a number specifying how far that pixel will be away from ther flat surface. Floats are used as the data type and it is used in bump mapping to specify the bumps.

**_End of E.b Answer_** [Back to Table of Contents](#table-of-contents)

**c**. What is a Normal Map? How does it relate to a Height Map? What data type is used in a Normal Map in an OpenGL ES program? [4 points]

### E.c Answer

A normal map is map of normal values that specify the normal at each pixel or bump that is used in tandem with the height map. Floats are used as well.

**_End of E.c Answer_** [Back to Table of Contents](#table-of-contents)

**d**. What is the Tangent Space? What are the Tangent, Normal and Binormal vectors? [4 points]

### E.d Answer

The tangent space is a space that includes the tangent to each point on the surface map and is used in the illumination calculation for speed. The tangent is the tangent to a point, the binormal is perpendicular to the tangent, and then the normal is just the normal to the Tangent and binormal vector.

**_End of E.d Answer_** [Back to Table of Contents](#table-of-contents)

**e**. Now, assume that you have a complete OpenGL ES-based Bump Mapping implementation that uses a Normal Map object for rendering. Provide a pseudocode description of the process required to transform the provided Height Map object to the Normal Map object required by the Bump Mapping implementation. [4 points] _Example_: you may assume the two squares in the following image as representing of the Normal and Bump maps: the first one is the input you have available, the second one is what you have to compute, and will be used by the Bump Mapping implementation.

_Hint_: the colors in the figure above represent how the Normal and Bump map would look like if you were to display them as _images_. Recall that a Bump Mapping-based rendering will not use these maps to display them as images or texture maps.

Your answer to the above five questions should contain sufficiently explicit mathematics that the reader could write a program. Any vectors and matrices you need in your explanation, you may define directly by components, or via OpenGL ES calls, and thereafter represent them by symbols.

### E.e Answer

I have no idea what to do for this problem. I REALLY NEED to study for my other finals AND this final as well as finish other final projects so heres a good answer from the lecture notes:

For each point on the surface we want to calculate the perturbed normal, given the height bump map H(u,v):

- P(u,v) = point on the surface
- N = Pu × Pv is the normal at P(u,v), where Pu and Pv = partial derivatives of P(u,v) in u and v directions
- N = normalized unit vector of N

applying the height bump map H(u,v):

- the updated surface position is P(u,v) = P(u,v) + H(u,v) N
- perturbed normal N = N - Hv (N × Pu) + Hu (N × Pv) where Hu and Hv = partial derivatives of H(u,v) in the u and v directions

and then you have your normal map.

**_End of E.e Answer_** [Back to Table of Contents](#table-of-contents)
