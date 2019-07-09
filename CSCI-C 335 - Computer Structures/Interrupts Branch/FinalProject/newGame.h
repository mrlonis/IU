/**
 *
 */

void newGame(void);

void drawBottomInitial(uint16_t lives, uint16_t money);
void drawBottom(uint8_t initial, uint16_t lives, uint16_t money, uint8_t clearBottomSelection, short bottomSelection, uint8_t previousBottomSelection);

void drawGridCell(uint8_t x1, uint8_t y1, uint16_t color, uint8_t size);
void drawTower(uint8_t x1, uint8_t y1, /* uint16_t color */ uint8_t type, uint16_t size);
void drawEnemy(uint8_t x1, uint16_t y1, /* uint8_t direction, */ /* uint16_t color*/ uint8_t type, uint8_t size);
void drawDeadEnemy(uint8_t x, uint16_t y, uint8_t size);
void drawWeaponFire(uint8_t x, uint8_t y, uint8_t enemyX, uint16_t enemyY, uint8_t type);
void redrawTowerPlacementPortion(uint8_t redrawTowerPlacementInitial, uint8_t clearTowerPlacement, uint8_t towerPlacementX, uint8_t towerPlacementY, uint8_t previousPlacementX, uint8_t previousPlacementY, uint8_t board[8][8]);
void setupPath(uint8_t board[8][8]);

void drawTitle(uint8_t initial, uint8_t pause, uint8_t round);

void sd_die();
void sd_openFile(char string[]);
void sd_typeFileContents();
void sd_closeFile();
void sd_openRootDir();
void sd_directoryListing();
void sd_drawBMP(char * string, uint8_t towerOrEnemy, uint8_t xCoord, uint16_t yCoord, uint8_t size);

void playAudio();

