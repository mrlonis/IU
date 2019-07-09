/*
 * from the archives of...
 * CSCI Computer Graphics courses B481/B581
 * lighting template code: one model, one light
 * Mitja Hmeljak
 */

#include <stdio.h>
#include <stdlib.h>
// #include <unistd.h>
#include <math.h>

#ifdef WIN32
#include <windows.h>
#endif

#if defined (__APPLE__) || defined(MACOSX)
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif



/*****************************************************************/
/******************** MY FUNCTION DEFINITIONS ********************/
/*****************************************************************/

static void myInitGL(void);
static void myInitData(int *argc, char **argv);
static void myInitMenus (void);
static void myInitCheckers(void);
static void myDrawTeapot(GLdouble size);

/* my callback functions needed for GLUT event handling */
static void myHandleMenu(int value);
static void myDisplay(void);
static void myReshape(int width, int height);
static void myMotion(int curx, int cury);
static void myButton(int button, int state, int x, int y);
static void myVisibility(int state);
static void myKeyboard(unsigned char key, int x, int y);
static void myMenus (int value);


/***************************************************************/
/******************** MY GLOBAL CONSTANTS **********************/
/***************************************************************/

#define MY_MAX(A,B) ((A) >= (B) ? (A) : (B))

/* my constants for GLUT window defaults */
#define MY_WIND_X_SIZE     600
#define MY_WIND_Y_SIZE     600
#define MY_WIND_X_POS      100
#define MY_WIND_Y_POS      100

/* my menu IDs for GLUT menu-handling functions */
#define MY_MENU_EXIT     -9999
#define MY_MENU_RESET     -200
#define MY_MENU_CAMERA      20
#define MY_MENU_LIGHT       30
#define MY_MENU_OBJECT      40

#define	MY_CHECKERS_WIDTH   64
#define	MY_CHECKERS_HEIGHT  64


/***************************************************************/
/******************** MY GLOBAL VARIABLES **********************/
/***************************************************************/

/* globals for generated texture - modified from Red Book's original checker.c - */
static GLubyte CheckersImg[MY_CHECKERS_HEIGHT][MY_CHECKERS_WIDTH][3];
static GLuint  TextureName;
static GLboolean TextureOn = GL_TRUE;


static GLfloat LightPos[4];

/* user interaction */
static GLint InteractionMode;
static GLint XmouseDown, YmouseDown;
static GLint XmouseCurrent, YmouseCurrent;
static GLint XmousePrev, YmousePrev, MouseDX, MouseDY;
static GLint WindHeight, WindWidth;
static GLint KeybModifiers;

/* transformations */
static GLdouble  CofMX, CofMY, CofMZ;

/* 3D Projection */
static GLdouble CamX, CamY, CamZ;
static GLdouble FOVangle, FOVratio, ClipNear, ClipFar;


/**************************** MAIN *****************************/


int main(int argc, char **argv) {
    glutInit(&argc,argv);

    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);
    glutInitWindowPosition(MY_WIND_X_POS, MY_WIND_Y_POS);
    glutInitWindowSize(MY_WIND_X_SIZE, MY_WIND_Y_SIZE);

    glutCreateWindow("B481/B581 3D illumination/lighting template code: one model, one light");

    glutDisplayFunc       (myDisplay);
    glutReshapeFunc       (myReshape);
    glutMouseFunc         (myButton);
    glutMotionFunc        (myMotion);
    glutPassiveMotionFunc (NULL);
    glutIdleFunc          (NULL);
    glutKeyboardFunc      (myKeyboard);
    glutVisibilityFunc    (myVisibility);

    fprintf(stderr,"Press ESC or 'q' to Exit.\n");

    myInitGL();
    myInitData(&argc,argv);  /* pass command line arguments for texture */

    /* initialize GLUT menu handler as last one, to take over access
     to GLUT_RIGHT_BUTTON, regardles to what other handlers did to it: */
    myInitMenus();
    
    glutMainLoop();
    return(EXIT_SUCCESS);
} /* main() */


/* --------------------------------------- */
/*           initialize my data            */
/* --------------------------------------- */

void myInitData(int *argc, char **argv) {
    int  i;
    char s[1024];
    InteractionMode = MY_MENU_CAMERA;

    CofMX = 1.1; CofMY = 0.8; CofMZ = -2.0;

    XmouseDown = -1;
    YmouseDown = -1;
    XmouseCurrent = XmousePrev = -1;
    YmouseCurrent = YmousePrev = -1;
    MouseDX = MouseDY = 0;
    KeybModifiers = 0;

    /* initialize texturing */
    TextureOn = GL_TRUE;

    /* read texture from PPM file - printout command line arguments for debugging */
    fprintf(stderr,"argc = %d: ",*argc);
    for (i = 0; i< *argc; i++)
        fprintf(stderr, " arg[%d] = %s, ",i, argv[i]);
    fprintf(stderr,"\n");

    i = -1;
    printf("Using checkers texture.\n"); 
    myInitCheckers();
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    glGenTextures(1, &TextureName);
    glBindTexture(GL_TEXTURE_2D, TextureName);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, MY_CHECKERS_WIDTH, MY_CHECKERS_HEIGHT, 
                 0, GL_RGB, GL_UNSIGNED_BYTE, CheckersImg);        
} /* myInitData() */


/* --------------------------------------- */

void myInitCheckers(void) {
    int i, j, c;
    
    for (i = 0; i < MY_CHECKERS_HEIGHT; i++) {
        for (j = 0; j < MY_CHECKERS_WIDTH; j++) {
            c = ((((i&0x8)==0)^((j&0x8))==0))*255;
            CheckersImg[i][j][0] = (GLubyte) c;
            CheckersImg[i][j][1] = (GLubyte) c;
            CheckersImg[i][j][2] = (GLubyte) c;
        }
    }
} /* myInitCheckers() */




/***************************************************************/
/*********************** MOUSE CALLBACKS ***********************/
/***************************************************************/

/* ------------------------------------------------------------------------ */
/* Mouse Button  UP/DOWN  or DOWN/UP transition only */
/* ------------------------------------------------------------------------ */
void myButton(int button, int state, int x, int y) {    
    if (button == GLUT_LEFT_BUTTON) {
        if (state == GLUT_DOWN) {
            XmouseDown = x;
            YmouseDown = WindHeight - y - 1;	/* Invert to right-handed system */
            XmouseCurrent = XmousePrev = XmouseDown;
            YmouseCurrent = YmousePrev = YmouseDown;
            KeybModifiers = glutGetModifiers();
        } else {
            /* at button up, invalidate: */
            XmouseCurrent = XmousePrev = XmouseDown = -1;
            YmouseCurrent = YmousePrev = YmouseDown = -1;
            KeybModifiers = 0;
        }
        MouseDX = MouseDY = 0;
    }
    glutPostRedisplay();
} /* myButton() */


/* ------------------------------------------------------------------------ */
/* Mouse motion WHILE BUTTON DOWN  */
/*  COMPLAINS  if you call glutGetModifiers()  here!! */
/* ------------------------------------------------------------------------ */
void myMotion(int x, int y) {    
    XmouseCurrent = x;
    YmouseCurrent = WindHeight - y - 1;	/* Invert to right-handed system */
    
    MouseDX = XmouseCurrent - XmousePrev;
    MouseDY = YmouseCurrent - YmousePrev;
    // printf("%d %d \n", MouseDX, MouseDY);

    XmousePrev = XmouseCurrent;
    YmousePrev = YmouseCurrent;

    glutPostRedisplay();
} /* myMotion(int x, int y) */


/* ------------------------------------------------------------------------ */
/* Handle Keyboard */
/* ------------------------------------------------------------------------ */
void myKeyboard(unsigned char key, int x, int y) {
    /*  Option: To force all lower case */
    if (key >= 'A' && key <= 'Z') key = (key-'A') + 'a';

    switch (key) {
            
        case 't':
            if (TextureOn==GL_TRUE) TextureOn=GL_FALSE;
            else TextureOn=GL_TRUE;
            break;
        case 'q' :
        case  27 :  /* 27 -> ESC */
            fprintf(stderr,"Normal Exit.\n");
            exit(EXIT_SUCCESS);
            break;

        default: fprintf(stderr,"Unhandled key: %c [%d] \n",key,key);
    }

    glutPostRedisplay();
} /* myKeyboard() */




/* -------------------------------------------------------------- */
/* myMenus() - callback for GLUT menus */
/* -------------------------------------------------------------- */
void myMenus (int value) {
    switch(value) {
        case MY_MENU_RESET:
            /* reset things here */
            break;
        case MY_MENU_CAMERA:
            InteractionMode = MY_MENU_CAMERA;
            break;
        case MY_MENU_LIGHT:
            InteractionMode = MY_MENU_LIGHT;
            break;
        case MY_MENU_OBJECT:
            InteractionMode = MY_MENU_OBJECT;
            break;            
        case MY_MENU_EXIT:
            exit(0);
            break;
        default:
            //            fprintf(stderr,"unknown menu entry");
            ;
    } /* switch () */
    glutPostRedisplay(); /* make sure we Display according to changes */
} /* myMenus() */


/* -------------------------------------------------------------- */
/* initialize GLUT menus */
/* -------------------------------------------------------------- */
void myInitMenus (void) {    
    glutCreateMenu(myMenus);
    
    glutAddMenuEntry("Reset Everything",   MY_MENU_RESET);
    glutAddMenuEntry(" ", -1);    
    glutAddMenuEntry("Move Camera",        MY_MENU_CAMERA);
    glutAddMenuEntry("Move Light",         MY_MENU_LIGHT);
    glutAddMenuEntry("Move Object",        MY_MENU_OBJECT);
    glutAddMenuEntry(" ", -2);
    glutAddMenuEntry("Exit",               MY_MENU_EXIT);

    glutAttachMenu(GLUT_RIGHT_BUTTON);
} /* myInitMenus() */



/***************************************************************/
/************************** INIT GL ****************************/
/***************************************************************/

void myInitGL (void) {
    GLfloat light_ambient[] = {0.1,0.1,0.1, 1.0};
    GLfloat light_diffuse[] = {1.0,1.0,1.0, 1.0};
    GLfloat light_specular[] = {1.0,1.0,1.0, 1.0};
    
    /* projection pipeline initialization */
    FOVangle = 60.0;
    FOVratio = 1.0;
    ClipNear = 0.1;
    ClipFar = 1000.0;
    CamX = CamY = 0.7;
    CamZ = 5.0;

    WindWidth = glutGet(GLUT_WINDOW_WIDTH);
    WindHeight  = glutGet(GLUT_WINDOW_HEIGHT);
    glViewport(0, 0, WindWidth, WindHeight);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    FOVratio  = (float)WindWidth / (float)WindHeight; /* keep viewed x/y ratio == 1 */
    /* instead of glFrustum(-1.0*ratio, 1.0*ratio, -1.0,1.0, FLength, 25.0);  */
    gluPerspective(FOVangle, FOVratio, ClipNear, ClipFar);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    /* Colors, Lighting, Material  initialization */
    glClearColor( 0.4f, 0.6f, 0.5f, 1.0f);
    glPointSize(1);     glEnable(GL_POINT_SMOOTH);
    glLineWidth(1);     glEnable(GL_LINE_SMOOTH);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);    
    /* we do **not** want model materials to follow the current GL color: */
    glDisable(GL_COLOR_MATERIAL);
    
    glShadeModel(GL_SMOOTH);        /* or GL_FLAT */
    glEnable(GL_NORMALIZE);
    glDepthFunc(GL_LESS);
    glEnable(GL_DEPTH_TEST);
    glLightfv(GL_LIGHT0, GL_AMBIENT, light_ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light_diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
    LightPos[0] = -1.0;    LightPos[1] = 2.0;
    LightPos[2] =  0.5;    LightPos[3] = 1.0;
    glLightfv(GL_LIGHT0, GL_POSITION, LightPos);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
} /* myInitGL() */



/***************************************************************/
/********************** DRAW FUNCTIONS *************************/
/***************************************************************/


void myDrawTeapot(GLdouble size) {
    GLfloat materialDiffuse[] = {0.7, 0.4, 0.2, 1.0};

    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, materialDiffuse);

    if (TextureOn==GL_TRUE) {
        glEnable(GL_TEXTURE_2D);
        glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
        glBindTexture(GL_TEXTURE_2D, TextureName);
//        glFrontFace(GL_CW);
        glutSolidTeapot(size);
//        glFrontFace(GL_CCW);        
        glDisable(GL_TEXTURE_2D);
    } else {
//        glFrontFace(GL_CW);
        glutSolidTeapot(size);
//        glFrontFace(GL_CCW);        
    }
} /* myDrawTeapot() */


/* ------------------------------------------------------------------------ */
void myDisplay(void) {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    /* by default, we're using the MODELVIEW matrix */
    
    /* set the default matrix to identity */
    glLoadIdentity();    
    
    /* viewing transformation */
    if (InteractionMode == MY_MENU_CAMERA) {
        /* move camera */
        if ((KeybModifiers & GLUT_ACTIVE_SHIFT) == 0) {
            CamX = CamX + 0.01*(GLdouble)MouseDX;
            CamY = CamY + 0.01*(GLdouble)MouseDY;
        } else {
            CamX = CamX + 0.01*(GLdouble)MouseDX;
            CamZ = CamZ + 0.01*(GLdouble)MouseDY;
        }
    }
    // one could also try different camera positioning techinques with:
    // gluLookAt(CamX, CamY, CamZ, 0,0,0, 0,1,0);
    glTranslatef(-CamX,-CamY,-CamZ);

    /* coordinate system origin - unit vectors */
    glDisable(GL_LIGHTING);
    glLineWidth(2.0);
    glBegin(GL_LINES); glColor3f(1.0,0.0,0.0); glVertex3f(0.0,0.0,0.0); glVertex3f(1.0,0.0,0.0); glEnd();
    glBegin(GL_LINES); glColor3f(0.0,1.0,0.0); glVertex3f(0.0,0.0,0.0); glVertex3f(0.0,1.0,0.0); glEnd();
    glBegin(GL_LINES); glColor3f(0.0,0.0,1.0); glVertex3f(0.0,0.0,0.0); glVertex3f(0.0,0.0,1.0); glEnd();
    glEnable(GL_LIGHTING);
    
    
    /* lights positioning */
    if (InteractionMode == MY_MENU_LIGHT) {
        /* move camera */
        if ((KeybModifiers & GLUT_ACTIVE_SHIFT) == 0) {
            LightPos[0] = LightPos[0] + 0.01*(GLdouble)MouseDX;
            LightPos[1] = LightPos[1] + 0.01*(GLdouble)MouseDY;
        } else {
            LightPos[0] = LightPos[0] + 0.01*(GLdouble)MouseDX;
            LightPos[2] = LightPos[2] + 0.01*(GLdouble)MouseDY;
        }
    }
    glLightfv(GL_LIGHT0, GL_POSITION, LightPos);
    /* draw a little cube to mark the light's position: */
    glDisable(GL_LIGHTING); glPushMatrix();
    glTranslatef(LightPos[0],LightPos[1],LightPos[2]);glColor3f(1.0,1.0,1.0);glutSolidCube(0.1);
    glPopMatrix();glEnable(GL_LIGHTING);
    
    /* modeling transformations follow, placing 3D models in the scene */
    if (InteractionMode == MY_MENU_OBJECT) {
        /* move camera */
        if ((KeybModifiers & GLUT_ACTIVE_SHIFT) == 0) {
            CofMX = CofMX + 0.01*(GLdouble)MouseDX;
            CofMY = CofMY + 0.01*(GLdouble)MouseDY;
        } else {
            CofMX = CofMX + 0.01*(GLdouble)MouseDX;
            CofMZ = CofMZ + 0.01*(GLdouble)MouseDY;
        }
    }
    glTranslatef(CofMX, CofMY, CofMZ);
    myDrawTeapot(0.8);
    
    glutSwapBuffers();
} /* myDisplay() */


/***************************************************************/
/*********************** GLUT FUNCTIONS ************************/
/***************************************************************/


/* ------------------------------------------------------------------------ */
void myReshape(int w, int h) {
    w = MY_MAX(w,128);
    h = MY_MAX(h,128);
    WindHeight = h;
    WindWidth = w;
    glutReshapeWindow(w,h);
    glViewport(0,0,w,h);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    FOVratio  = (float)w / (float)h; /* keep world coord x/y ratio == 1 */
    gluPerspective(FOVangle, FOVratio, ClipNear, ClipFar);
    glMatrixMode(GL_MODELVIEW);
} /* myReshape() */

/* ------------------------------------------------------------------------ */
void myVisibility(int state) {
/* ------------------------------------------------------------------------ */
    if (state == GLUT_VISIBLE){
        glutPostRedisplay();
    }
} /* myVisibility() */

/* ------------------------------------------------------------------------ */
