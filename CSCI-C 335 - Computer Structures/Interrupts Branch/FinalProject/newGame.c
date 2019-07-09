/**
 * newGame.c
 *
 * Description: Game Logic
 *
 * Created By: Matthew Lonis & Alvaro Michael
 * Created On: December 8th, 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: December 8th, 2017
 */

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers
#include <f3d_delay.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_rtc.h>
#include <f3d_systick.h>
#include <f3d_timer2.h>
#include <f3d_dac.h>
#include <f3d_nunchuk.h>
#include <glcdfont.h>
#include <diskio.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ff.h>

#define TIMER 20000

#define boardSize 8
#define gridCellSize 15
#define maxEnemies 50

#define enemy1Health 250
#define enemy2Health 500
#define enemy3Health 1000
#define enemy4Health 2000

#define tower1Damage 10
#define tower2Damage 25
#define tower3Damage 50
#define tower4Damage 100

#define towerCostScale 50

#define initialLives 10
#define initialMoney 200

void newGame(void);
void moveEnemies();
void attackEnemies();
void setupEnemies();
void changeTowerSelected();
void changeTowerPlacement();
void transitionToTowerSelect();
void transitionToTowerPlacement();

/*
 * Bottom Functions
 */
void drawLifeMoney(uint16_t lives, uint16_t money);
void drawBottomInitial(uint16_t lives, uint16_t money);
void drawBottom(uint8_t initial, uint16_t lives, uint16_t money, uint8_t clearBottomSelection, short bottomSelection, uint8_t previousBottomSelection);

/*
 * Middle Functions
 */
void drawGridCell(uint8_t x1, uint8_t y1, uint16_t color);
void drawTower(uint8_t x1, uint8_t y1, uint8_t type);
void drawEnemy(uint8_t x1, uint16_t y1, uint8_t direction, uint8_t type);
void drawDeadEnemy(uint8_t x1, uint16_t y1, uint8_t direction);
void drawWeaponFire(uint8_t x1, uint8_t y1, uint8_t enemyX, uint16_t enemyY, uint8_t type);
void redrawTowerPlacementPortion(uint8_t redrawTowerPlacementInitial, uint8_t clearTowerPlacement, uint8_t towerPlacementX, uint8_t towerPlacementY, uint8_t previousPlacementX, uint8_t previousPlacementY, uint8_t board[boardSize][boardSize]);
void setupPath(uint8_t board[boardSize][boardSize]);

/*
 * Top Functions
 */
void drawTitle(uint8_t initial);

typedef struct {
    short health;
    uint8_t x;
    uint16_t y;
    uint8_t direction; //0 is up, 1 is right
    uint8_t type;
} enemy;

static nunchuk_t nunData;
static float accel[3];

static uint8_t board[boardSize][boardSize];
static enemy enemies[maxEnemies];
static uint16_t colors[ST7735_width];
static char str[25];

static uint8_t enemyCount;
static uint8_t enemiesAlive;

static enemy defaultEnemy;

static uint8_t roundNum;
static uint8_t newRound;
static uint16_t lives;
static uint16_t money;

static uint8_t end;

static uint8_t towerSelect;
static short bottomSelection;
static uint8_t previousBottomSelection;

static uint8_t towerPlacement;
static short towerPlacementX;
static short previousPlacementX;
static short towerPlacementY;
static short previousPlacementY;

static uint8_t pause;

void newGame() {
    uint8_t i, x, y;
    
    for (x = 0; x < boardSize; x++) {
        for (y = 0; y < boardSize; y++) {
            board[x][y] = 0;
        }
    }
    
    board[5][0] = 5;
    board[5][1] = 5;
    board[5][2] = 5;
    board[5][3] = 5;
    board[5][4] = 5;
    board[5][5] = 5;
    board[4][5] = 5;
    board[3][5] = 5;
    board[2][5] = 5;
    board[1][5] = 5;
    board[1][6] = 5;
    board[1][7] = 5;
    
    defaultEnemy.health = 0;
    defaultEnemy.x = 16;
    defaultEnemy.y = 136; // 137 is where the bottom section starts. So if an enemy is at y value less than or equal to 137, we dont want to draw it or attack it
    defaultEnemy.direction = 0;
    defaultEnemy.type = 0;
    
    for (i = 0; i < maxEnemies; i++) {
        enemies[i] = defaultEnemy;
    }
    
    roundNum = 1;
    newRound = 1;
    lives = initialLives;
    money = initialMoney;
    
    end = 0;
    
    towerSelect = 1;
    bottomSelection = 0;
    previousBottomSelection = 0;
    
    towerPlacement = 0;
    towerPlacementX = 0;
    previousPlacementX = 1;
    towerPlacementY = 0;
    previousPlacementY = 1;
    
    pause = 1;
    
    f3d_lcd_fillScreen(BLACK);
    
    drawTitle(1);
    setupPath(board);
    drawBottomInitial(lives, money);
    
    /*
     * Game loop
     */
    while (end != 1) {
        delay(125);
        f3d_nunchuk_read(&nunData);
        f3d_accel_read(accel);
        
        float pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
        float roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);
        
        if (pause == 0) {
            if (nunData.z == 1) {
                pause = 1;
                drawTitle(0);
            } else {
                if (fabs(pitch) > 0.1 || fabs(roll)> 0.1) {
                    roundNum++;
                    newRound = 1;
                    pause = 1;
                    
                    if (roundNum == 6) {
                        end = 1;
                    } else {
                        drawTitle(1);
                    }
                } else if (newRound == 1) {
                    setupEnemies();
                    newRound = 0;
                } else if (lives > 0 && enemiesAlive > 0) {
                    moveEnemies();
                    attackEnemies();
                } else if (roundNum < 6) {
                    roundNum++;
                    newRound = 1;
                    pause = 1;
                    drawTitle(1);
                } else {
                    end = 1;
                }
            }
        } else if (pause == 1) {
            if (nunData.z == 1) {
                pause = 0;
                
                if (towerSelect == 0 && towerPlacement == 1) {
                    transitionToTowerSelect();
                }
                
                drawTitle(0);
            } else {
                if (towerSelect == 1) {
                    changeTowerSelected();
                } else {
                    changeTowerPlacement();
                }
            }
        }
        
        /*
         * Handles nunchuk events for when the c button is pressed
         */
        if (nunData.c == 1) {
            if (towerSelect == 1) {
                if (money >= (100 + (towerCostScale * bottomSelection))) {
                    transitionToTowerPlacement();
                }
            } else if (towerPlacement == 1) {
                transitionToTowerSelect();
            }
        }
    }
}

/*
 * This will handle moving and actually physically drawing the enemies
 */
void moveEnemies() {
    uint8_t currentEnemy = 0;
    
    for (currentEnemy = 0; currentEnemy < enemyCount; currentEnemy++) {
        if (enemies[currentEnemy].health != 0 && enemies[currentEnemy].y >= 7) {
            if (enemies[currentEnemy].y == 8 && enemies[currentEnemy].health != 0) {
                lives--;
                drawLifeMoney(lives, money);
                
                if (lives == 0) {
                    end = 1;
                }
                
                enemies[currentEnemy].health = 0;
                
                drawDeadEnemy(enemies[currentEnemy].x, enemies[currentEnemy].y, enemies[currentEnemy].direction);
            } else if (enemies[currentEnemy].y == 89 && enemies[currentEnemy].direction == 0) {
                enemies[currentEnemy].direction = 1;
                enemies[currentEnemy].x++;
            } else if (enemies[currentEnemy].x == 80 && enemies[currentEnemy].direction == 1) {
                enemies[currentEnemy].direction = 0;
                enemies[currentEnemy].y--;
            } else if (enemies[currentEnemy].direction == 0) {
                enemies[currentEnemy].y--;
            } else if (enemies[currentEnemy].direction == 1) {
                enemies[currentEnemy].x++;
            }
            
            if (enemies[currentEnemy].y < 137 && enemies[currentEnemy].health > 0 && enemies[currentEnemy].y > 8) {
                drawEnemy(enemies[currentEnemy].x, enemies[currentEnemy].y, enemies[currentEnemy].direction, enemies[currentEnemy].type);
            }
        }
    }
}

void attackEnemies() {
    uint8_t x, y;
    uint8_t currentEnemy = 0;
    
    while (currentEnemy < enemyCount && (enemies[currentEnemy].health <= 0 || enemies[currentEnemy].y >= (137 - gridCellSize))) {
        currentEnemy++;
    }
    
    if (currentEnemy == enemyCount) {
        return;
    }
    
    for (x = 0; x < 8; x++) {
        for (y = 0; y < 8; y++) {
            if (board[x][y] != 0 && board[x][y] != 5) {
                uint8_t boardVal = board[x][y];
                
                drawWeaponFire(x, y, enemies[currentEnemy].x, enemies[currentEnemy].y, boardVal);
                
                if (boardVal == 1) {
                    enemies[currentEnemy].health -= tower1Damage;
                } else if (boardVal == 2) {
                    enemies[currentEnemy].health -= tower2Damage;
                } else if (boardVal == 3) {
                    enemies[currentEnemy].health -= tower3Damage;
                } else {
                    enemies[currentEnemy].health -= tower4Damage;
                }
                
                money++;
                drawLifeMoney(lives, money);
                
                if (enemies[currentEnemy].health <= 0) {  
                    drawDeadEnemy(enemies[currentEnemy].x, enemies[currentEnemy].y, enemies[currentEnemy].direction);
                    
                    currentEnemy++;
                    enemiesAlive--;
                    
                    if (currentEnemy == enemyCount || enemiesAlive == 0) {
                        drawTower(x, y, board[x][y]);
                        return;
                    }
                }
                
                drawTower(x, y, board[x][y]);
            }
        }
    }
}

void setupEnemies() {
    uint8_t x, y;
    
    if (roundNum == 1) {
        enemyCount = 10;
        enemiesAlive = enemyCount;
        
        defaultEnemy.health = enemy1Health;
        defaultEnemy.type = 0;
        
        for (x = 0, y = 0; x < enemyCount; x++, y++) {
            enemies[x] = defaultEnemy;
            enemies[x].y += (y*20);
        }
    } else if (roundNum == 2) {
        enemyCount = 20;
        enemiesAlive = enemyCount;
        
        defaultEnemy.health = enemy2Health;
        defaultEnemy.type = 1;
        
        for (x = 0, y = 0; x < enemyCount; x++, y++) {
            enemies[x] = defaultEnemy;
            enemies[x].y += (y*20);
        }
    } else if (roundNum == 3) {
        enemyCount = 30;
        enemiesAlive = enemyCount;
        
        defaultEnemy.health = enemy3Health;
        defaultEnemy.type = 2;
        
        for (x = 0, y = 0; x < enemyCount; x++, y++) {
            enemies[x] = defaultEnemy;
            enemies[x].y += (y*20);
        }
    } else if (roundNum == 4) {
        enemyCount = 40;
        enemiesAlive = enemyCount;
        
        defaultEnemy.health = enemy4Health;
        defaultEnemy.type = 3;
        
        for (x = 0, y = 0; x < enemyCount; x++, y++) {
            enemies[x] = defaultEnemy;
            enemies[x].y += (y*20);
        }
    } else if (roundNum == 5) {
        enemyCount = maxEnemies;
        enemiesAlive = maxEnemies;
        
        defaultEnemy.health = enemy4Health;
        
        for (x = 0, y = 0; x < maxEnemies; x++, y++) {
            enemies[x] = defaultEnemy;
            enemies[x].y += (y*20);
        }
    }
}

/*
 * This function handles changing all the necessary variables and drawing whatever
 * is needed to change the tower selection when the user is selecting a tower to place
 * down.
 */
void changeTowerSelected() {
    if (nunData.jx > 180) {
        bottomSelection++;
        
        if (bottomSelection > 3) {
            bottomSelection = 3;
            previousBottomSelection = 2;
        }
        
        drawBottom(0, lives, money, 0, bottomSelection, previousBottomSelection);
        
        previousBottomSelection = bottomSelection;
    } else if (nunData.jx < 100) {
        bottomSelection--;
        
        if (bottomSelection < 0) {
            bottomSelection = 0;
            previousBottomSelection = 1;
        }
        
        drawBottom(0, lives, money, 0, bottomSelection, previousBottomSelection);
        
        previousBottomSelection = bottomSelection;
    }
}

/*
 * This function handles changing and drawing all necessary components related
 * to changing the tower placement position.
 */
void changeTowerPlacement() {
    if (nunData.jx > 180) {
        towerPlacementX++;
        
        if (towerPlacementX > 7) {
            towerPlacementX = 7;
            previousPlacementX = 6;
        }
        
        redrawTowerPlacementPortion(0, 0, towerPlacementX, towerPlacementY, previousPlacementX, previousPlacementY, board);
        
        previousPlacementY = towerPlacementY;
        previousPlacementX = towerPlacementX;
    } else if (nunData.jx < 100) {
        towerPlacementX--;
        
        if (towerPlacementX < 0) {
            towerPlacementX = 0;
            previousPlacementX = 1;
        }
        
        redrawTowerPlacementPortion(0, 0, towerPlacementX, towerPlacementY, previousPlacementX, previousPlacementY, board);
        
        previousPlacementY = towerPlacementY;
        previousPlacementX = towerPlacementX;
    } else if (nunData.jy > 180) {
        towerPlacementY--;
        
        if (towerPlacementY < 0) {
            towerPlacementY = 0;
            previousPlacementY = 1;
        }
        
        redrawTowerPlacementPortion(0, 0, towerPlacementX, towerPlacementY, previousPlacementX, previousPlacementY, board);
        
        previousPlacementY = towerPlacementY;
        previousPlacementX = towerPlacementX;
    } else if (nunData.jy < 100) {
        towerPlacementY++;
        
        if (towerPlacementY > 7) {
            towerPlacementY = 7;
            previousPlacementY = 6;
        }
        
        redrawTowerPlacementPortion(0, 0, towerPlacementX, towerPlacementY, previousPlacementX, previousPlacementY, board);
        
        previousPlacementY = towerPlacementY;
        previousPlacementX = towerPlacementX;
    }
}

/*
 * Handles al necessary variables as well as drawing in order to transition from tower
 * placement mode into tower select mode.
 */
void transitionToTowerSelect() {
    towerSelect = 1;
    towerPlacement = 0;
    
    drawBottom(1, lives, money, 0, bottomSelection, previousBottomSelection);
    
    redrawTowerPlacementPortion(0, 1, towerPlacementX, towerPlacementY, previousPlacementX, previousPlacementY, board);
    
    previousPlacementY = towerPlacementY;
    previousPlacementX = towerPlacementX;
    
    if ((towerPlacementX == 1 && towerPlacementY > 4) || (towerPlacementX > 0 && towerPlacementX < 6 && towerPlacementY == 5) || (towerPlacementX == 5 && towerPlacementY < 6)) {
        money += 100 + (towerCostScale * bottomSelection);
        
        drawBottom(1, lives, money, 0, bottomSelection, previousBottomSelection);
    } else {
        board[towerPlacementX][towerPlacementY] = bottomSelection + 1;
        drawTower(towerPlacementX, towerPlacementY, bottomSelection + 1);
    }
}

/*
 * Handles all necessary variable changes and drawings in order to transition into tower select mode from tower placement mode
 */
void transitionToTowerPlacement() {
    towerSelect = 0;
    towerPlacement = 1;
    
    money -= 100 + (towerCostScale * bottomSelection);
    
    drawBottom(0, lives, money, 1, bottomSelection, previousBottomSelection);
    
    towerPlacementX = 0;
    towerPlacementY = 0;
    
    redrawTowerPlacementPortion(1, 0, towerPlacementX, towerPlacementY, previousPlacementX, previousPlacementY, board);
    
    previousPlacementY = towerPlacementY;
    previousPlacementX = towerPlacementX;
}

void drawLifeMoney(uint16_t lives, uint16_t money) {
    snprintf(str, sizeof(uint16_t) * 22, "Life: %3d", lives);
    f3d_lcd_drawString(2, 140, str, BLACK, YELLOW);
    
    snprintf(str, sizeof(uint16_t) * 22, "$$$$: %3d", money);
    f3d_lcd_drawString(2, 150, str, BLACK, YELLOW);
}

void drawBottomInitial(uint16_t lives, uint16_t money) {
    uint8_t i;
    for (i = 0; i < 128; i++) {
        colors[i] = YELLOW;
    }
    
    f3d_lcd_setAddrWindow(0, 137, ST7735_width - 1, ST7735_height - 1, MADCTLGRAPHICS);
    
    for (i = 0; i < ((ST7735_height - 1) - 136); i++) {
        f3d_lcd_pushColor(colors, 128);
    }
    
    drawLifeMoney(lives, money);
    
    for (i = 0; i < 23; i++) {
        colors[i] = BLACK;
    }
    
    f3d_lcd_setAddrWindow(63, 137, 63, ST7735_height - 1, MADCTLGRAPHICS);
    f3d_lcd_pushColor(colors, 23);
    
    f3d_lcd_setAddrWindow(79, 137, 79, ST7735_height - 1, MADCTLGRAPHICS);
    f3d_lcd_pushColor(colors, 23);
    
    f3d_lcd_setAddrWindow(95, 137, 95, ST7735_height - 1, MADCTLGRAPHICS);
    f3d_lcd_pushColor(colors, 23);
    
    f3d_lcd_setAddrWindow(111, 137, 111, ST7735_height - 1, MADCTLGRAPHICS);
    f3d_lcd_pushColor(colors, 23);
    
    f3d_lcd_setAddrWindow(127, 137, 127, ST7735_height - 1, MADCTLGRAPHICS);
    f3d_lcd_pushColor(colors, 23);
    
    /*
     * Tower 1
     */
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = CYAN;
    }
    
    f3d_lcd_setAddrWindow(64, 141, 78, ST7735_height - 1, MADCTLGRAPHICS);
    
    for (i = 0; i < gridCellSize; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    /*
     * Draw white around tower 1
     */
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = WHITE;
    }
    
    f3d_lcd_setAddrWindow(64, 137, 78, 140, MADCTLGRAPHICS);
    for (i = 0; i < 4; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    f3d_lcd_setAddrWindow(64, 156, 78, ST7735_height - 1, MADCTLGRAPHICS);
    for (i = 0; i < 4; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    /*
     * Tower 2
     */
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = BLUE;
    }
    
    f3d_lcd_setAddrWindow(80, 141, 94, ST7735_height - 1, MADCTLGRAPHICS);
    for (i = 0; i < gridCellSize; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    /*
     * Tower 3
     */
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = MAGENTA;
    }
    
    f3d_lcd_setAddrWindow(96, 141, 110, ST7735_height - 1, MADCTLGRAPHICS);
    for (i = 0; i < gridCellSize; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    /*
     * Tower 4
     */
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = INDIGO;
    }
    
    f3d_lcd_setAddrWindow(112, 141, 126, ST7735_height - 1, MADCTLGRAPHICS);
    
    for (i = 0; i < gridCellSize; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
}

void drawBottom(uint8_t initial, uint16_t lives, uint16_t money, uint8_t clearBottomSelection, short bottomSelection, uint8_t previousBottomSelection) {
    uint8_t i;
    
    drawLifeMoney(lives, money);
    
    if (clearBottomSelection == 0) {
        for (i = 0; i < gridCellSize; i++) {
            colors[i] = WHITE;
        }
        
        f3d_lcd_setAddrWindow(64 + (bottomSelection * 16), 137, 78 + (bottomSelection * 16), 140, MADCTLGRAPHICS);
        for (i = 0; i < 4; i++) {
            f3d_lcd_pushColor(colors, gridCellSize);
        }
        
        f3d_lcd_setAddrWindow(64 + (bottomSelection * 16), 156, 78 + (bottomSelection * 16), 159, MADCTLGRAPHICS);
        for (i = 0; i < 4; i++) {
            f3d_lcd_pushColor(colors, gridCellSize);
        }
        
        if (initial == 0) {
            for (i = 0; i < gridCellSize; i++) {
                colors[i] = YELLOW;
            }
            
            f3d_lcd_setAddrWindow(64 + (previousBottomSelection * 16), 137, 78 + (previousBottomSelection * 16), 140, MADCTLGRAPHICS);
            for (i = 0; i < 4; i++) {
                f3d_lcd_pushColor(colors, gridCellSize);
            }
            
            f3d_lcd_setAddrWindow(64 + (previousBottomSelection * 16), 156, 78 + (previousBottomSelection * 16), 159, MADCTLGRAPHICS);
            for (i = 0; i < 4; i++) {
                f3d_lcd_pushColor(colors, gridCellSize);
            }
        }
    } else if (clearBottomSelection == 1) {
        for (i = 0; i < gridCellSize; i++) {
            colors[i] = YELLOW;
        }
        
        f3d_lcd_setAddrWindow(64 + (bottomSelection * 16), 137, 78 + (bottomSelection * 16), 140, MADCTLGRAPHICS);
        
        for (i = 0; i < 4; i++) {
            f3d_lcd_pushColor(colors, gridCellSize);
        }
        
        f3d_lcd_setAddrWindow(64 + (bottomSelection * 16), 156, 78 + (bottomSelection * 16), 159, MADCTLGRAPHICS);
        for (i = 0; i < 4; i++) {
            f3d_lcd_pushColor(colors, gridCellSize);
        }
    }
}

void drawGridCell(uint8_t x1, uint8_t y1, uint16_t color) {
    uint8_t i;
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = color;
    }
    
    f3d_lcd_setAddrWindow((x1 * 16), (y1 * 16) + 9, (gridCellSize - 1) + (x1 * 16), (gridCellSize - 1) + 9 + (y1 * 16), MADCTLGRAPHICS);
    
    for (i = 0; i < gridCellSize; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
}

void drawTower(uint8_t x1, uint8_t y1, uint8_t type) {
    uint8_t i;
    uint16_t color;
    
    if (type == 1) {
        color = CYAN;
    } else if (type == 2) {
        color = BLUE;
    } else if (type == 3) {
        color = MAGENTA;
    } else if (type == 4) {
        color = INDIGO;
    } else {
        printf("drawTower(): Else Reached. This is an error!\n");
        color = GREEN;
    }
    
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = color;
    }
    
    f3d_lcd_setAddrWindow((x1 * 16), (y1 * 16) + 9, (gridCellSize - 1) + (x1 * 16), (gridCellSize - 1) + 9 + (y1 * 16), MADCTLGRAPHICS);
    
    for (i = 0; i < gridCellSize; i++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
}

void drawEnemy(uint8_t x1, uint16_t y1, uint8_t direction, uint8_t type) {
    uint8_t i;
    uint16_t color;
    
    if (type == 0) {
        color = YELLOW;
    } else if (type == 1) {
        color = ORANGE;
    } else if (type == 2) {
        color = GREEN;
    } else if (type == 3) {
        color = BLACK;
    } else {
        color = RED;
    }
    
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = color;
    }
    
    f3d_lcd_setAddrWindow(x1, y1, (gridCellSize - 1) + x1, (gridCellSize - 1) + y1, MADCTLGRAPHICS);
    
    uint8_t count;
    for (i = y1, count = 0; i < 137 && count < gridCellSize; i++, count++) {
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    /*
     * Redraws path RED. We ensure every enemy is at least 1 pixel apart so we are never drawing over another enemy
     */
    if (count == 15 && (y1 + gridCellSize) < 137) {
        for (i = 0; i < gridCellSize; i++) {
            colors[i] = RED;
        }
        
        if (direction == 0) {
            f3d_lcd_setAddrWindow(x1, y1 + gridCellSize, x1 + (gridCellSize - 1), y1 + gridCellSize, MADCTLGRAPHICS);
            
            f3d_lcd_pushColor(colors, gridCellSize);
        } else if (direction == 1 && x1 > 16) {
            f3d_lcd_setAddrWindow(x1 - 1, y1, x1 - 1, y1 + (gridCellSize - 1), MADCTLGRAPHICS);
            
            f3d_lcd_pushColor(colors, gridCellSize);
        }
    }
}

void drawDeadEnemy(uint8_t x1, uint16_t y1, uint8_t direction) {
    drawEnemy(x1, y1, direction, 4);
}

void drawWeaponFire(uint8_t x1, uint8_t y1, uint8_t enemyX, uint16_t enemyY, uint8_t type) {
    uint8_t i;
    
    for (i = 0; i < gridCellSize; i++) {
        colors[i] = RED;
    }
    
    if ((x1 * 16) < enemyX) {
        f3d_lcd_setAddrWindow((x1 * 16) + 14, (y1 * 16) + 9, (x1 * 16) + 14, (y1 * 16) + 14 + 9, MADCTLGRAPHICS);
    } else {
        f3d_lcd_setAddrWindow((x1 * 16), (y1 * 16) + 9, (x1 * 16), 14 + 9 + (y1 * 16), MADCTLGRAPHICS);
    }
    
    f3d_lcd_pushColor(colors, gridCellSize);
}

void redrawTowerPlacementPortion(uint8_t redrawTowerPlacementInitial, uint8_t clearTowerPlacement, uint8_t towerPlacementX, uint8_t towerPlacementY, uint8_t previousPlacementX, uint8_t previousPlacementY, uint8_t board[boardSize][boardSize]) {
    
    uint8_t gridCellValue = board[previousPlacementX][previousPlacementY];
    
    if (clearTowerPlacement == 1 || redrawTowerPlacementInitial == 0) {
        if (gridCellValue == 5) {
            drawGridCell(previousPlacementX, previousPlacementY, RED);
        } else if (gridCellValue == 0) {
            drawGridCell(previousPlacementX, previousPlacementY, GREEN);
        } else {
            drawTower(previousPlacementX, previousPlacementY, gridCellValue);
        }
    }
    
    if (clearTowerPlacement == 0) {
        drawGridCell(towerPlacementX, towerPlacementY, WHITE);
    }
}

void setupPath(uint8_t board[boardSize][boardSize]) {
    uint8_t x, y;
    
    for (x = 0; x < boardSize; x++) {
        for (y = 0; y < boardSize; y++) {
            uint8_t boardVal = board[x][y];
            
            if (boardVal == 5) {
                drawGridCell(x, y, RED);
            } else if (boardVal == 0) {
                drawGridCell(x, y, GREEN);
            } else {
                drawTower(x, y, boardVal);
            }
        }
    }
}

void drawTitle(uint8_t initial) {
    uint8_t i;
    
    for (i = 0; i < 128; i++) {
        colors[i] = YELLOW;
    }
    
    f3d_lcd_setAddrWindow(0, 0, ST7735_width - 1, 7, MADCTLGRAPHICS);
    
    for (i = 0; i < boardSize; i++) {
        f3d_lcd_pushColor(colors, 128);
    }
    
    if (initial == 1) {
        snprintf(str, sizeof(uint16_t) * 22, "Round %d - Not Started", roundNum);
        f3d_lcd_drawString(0, 0, str, BLACK, YELLOW);
    } else {
        if (pause == 1) {
            snprintf(str, sizeof(uint16_t) * 22, "Round %d - Paused", roundNum);
            f3d_lcd_drawString(12, 0, str, BLACK, YELLOW);
        } else {
            snprintf(str, sizeof(uint16_t) * 22, "Round %d", roundNum);
            f3d_lcd_drawString(40, 0, str, BLACK, YELLOW);
        }
    }
}
