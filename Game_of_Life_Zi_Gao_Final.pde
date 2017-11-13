Cell[][] oldGrid;
boolean newGrid[][];
Button play = new Button(1080, 800, 100, 100, true, "START");
Button gLife;
Button oD;
Button menu = new Button(1150, 920, 100, 100, true, "MENU");
Button clear = new Button(1220, 800, 100, 100, true, "CLEAR");
Button finish = new Button(1150, 690, 100, 100, true, "SET");

ArrayList<Square> squares = new ArrayList<Square>();

boolean a, b, c, d, e, f, g, h;

int ruleNumber = 0;

Button[] rules = new Button[16];

int currentRow = 0;

int gameState = 0;

int rows = 100;
int columns = 100;

void setup() {
  size(1300, 1000); 
  oldGrid = new Cell[columns][rows];
  newGrid = new boolean[columns][rows];

  rules[0] = new Button(1045, 380, 50, 50, true, "9"); 
  rules[1] = new Button(1115, 380, 50, 50, true, "15");
  rules[2] = new Button(1185, 380, 50, 50, true, "22");
  rules[3] = new Button(1255, 380, 50, 50, true, "26");
  rules[4] = new Button(1045, 450, 50, 50, true, "30");
  rules[5] = new Button(1115, 450, 50, 50, true, "41");
  rules[6] = new Button(1185, 450, 50, 50, true, "45");
  rules[7] = new Button(1255, 450, 50, 50, true, "57");
  rules[8] = new Button(1045, 520, 50, 50, true, "62");
  rules[9] = new Button(1115, 520, 50, 50, true, "73");
  rules[10] = new Button(1185, 520, 50, 50, true, "105");
  rules[11] = new Button(1255, 520, 50, 50, true, "106");
  rules[12] = new Button(1045, 590, 50, 50, true, "110");
  rules[13] = new Button(1115, 590, 50, 50, true, "150");
  rules[14] = new Button(1185, 590, 50, 50, true, "232");
  rules[15] = new Button(1255, 590, 50, 50, true, "90");

  gLife = new Button(850, height/1.5, 300, 100, false, "Game of Life"); 
  oD = new Button(450, height/1.5, 300, 100, false, "1-D CAutomata");

  for (int i = 0; i < columns; i++) {
    for  (int j = 0; j < rows; j++) {
      if (i > 0 && j > 0 && i < columns-1 && j < rows-1) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 +5, i-1, j, i+1, j, i-1, j-1, i+1, j+1, i, j+1, i, j-1, i+1, j-1, i-1, j+1);
        newGrid[i][j] = false;
      } else if (i == 0 && j == 0) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, columns-1, 0, i+1, 0, columns-1, 1, i+1, j+1, columns-1, rows-1, i, j+1, 0, rows-1, 1, rows-1);
        newGrid[i][j] = false;
      } else if (i == 0 && j == rows-1) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, columns-1, j, i+1, j, columns-1, rows-2, 1, 0, 0, 0, i+1, j-1, i, j-1, columns-1, 0);
        newGrid[i][j] = false;
      } else if (i == columns-1 && j == 0) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, i-1, j, 0, j, 0, rows-1, 0, 1, i-1, rows-1, i, j+1, i-1, j+1, i, rows-1);
        newGrid[i][j] = false;
      } else if (i == columns-1 && j == rows-1) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, i-1, j, 0, j, 0, 0, 0, rows-2, i-1, 0, 99, 0, i-1, j-1, i, j-1);
        newGrid[i][j] = false;
      } else if (i > 0 && j == 0) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, i-1, j, i+1, j, i, j+1, i+1, j+1, i-1, j+1, i+1, rows-1, i-1, rows-1, i, rows-1);
        newGrid[i][j] = false;
      } else if (i == 0 && j > 0) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, columns-1, j, i+1, j, i, j-1, i, j+1, i+1, j-1, i+1, j+1, columns-1, j-1, columns-1, j+1);
        newGrid[i][j] = false;
      } else if (i == columns-1 && j > 0) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, i-1, j, 0, j, i, j+1, i, j-1, i-1, j-1, i-1, j+1, 0, j-1, 0, j+1);
        newGrid[i][j] = false;
      } else if (i > 0 && j == rows-1) {
        oldGrid[i][j] = new Cell(i*10 + 5, j*10 + 5, i-1, j, i+1, j, i, j-1, i+1, j-1, i-1, j-1, i-1, 0, i, 0, i+1, 0);
        newGrid[i][j] = false;
      }
    }
  }

  rules[4].clicked = true;
}

void draw() {
  background(#26547C);
  strokeWeight(1);
  stroke(100);

  if (gameState == 0) {
    mainMenu();
  } else if (gameState == 1) {
    fill(#EF476F);
    rect(width/2, height/2, width, height);
    gameOfLife();
  } else if (gameState == 3) {
    oneD();
  }
}


void mainMenu() {

  for (int j = 0; j < squares.size(); j++) {
    Square mySquare = squares.get(j);
    mySquare.update();
    if (mySquare.x > width || mySquare.x < 0 || mySquare.y < 0 || mySquare.y > height) {
      squares.remove(j);
    }
  }
  textAlign(CENTER);
  textSize(120);
  fill(#FC7521);
  text("A-LYFE", width/2 - 10, 100);
  textSize(30);
  text("An Artificial Life Simulator", width/2 - 10, 150);
  gLife.update();
  oD.update();
  if (gLife.clicked) {
    gLife.clicked = false;
    gameState = 1;
  } else if (oD.clicked) {
    oD.clicked = false;
    gameState = 3;
  }

  if (squares.size() < 20) {
    squares.add(new Square(random(0, width), random(0, height), random(-5, 5), random(-5, 5), random (30, 100)));
  }
}

void mouseReleased() {
  if (dist(mouseX, mouseY, 1200, 500) < 50) { 
    calculate();
  }
  drag1 = false;
  drag2 = false;
  drag3 = false;
}

void calculate() {
  //Game of Life
  if (gameState == 1) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < rows; j++) {
        for (int k = 0; k < 8; k++) {
          if (oldGrid[int(oldGrid[i][j].n[k].x)][int(oldGrid[i][j].n[k].y)].alive == true) {
            oldGrid[i][j].neighborCount++;
          }
        }
        if (oldGrid[i][j].neighborCount > rule1 || oldGrid[i][j].neighborCount < rule1-1) {
          newGrid[i][j] = false;
        } else if (oldGrid[i][j].neighborCount == rule2 && !oldGrid[i][j].alive) {
          newGrid[i][j] = true;
        } else if ((oldGrid[i][j].neighborCount == rule1 || oldGrid[i][j].neighborCount == rule1-1) && oldGrid[i][j].alive) {
          newGrid[i][j] = true;
        }
      }
    }

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < rows; j++) {
        oldGrid[i][j].alive = newGrid[i][j]; 
        oldGrid[i][j].neighborCount = 0;
      }
    }
  } else if (gameState == 3) {
    int j = currentRow;

    switch(ruleNumber) {
    case 0:
      a = true; 
      b = false; 
      c = false; 
      d = true; 
      e = false; 
      f = false; 
      g = false; 
      h = false; 
      break;

    case 1:
      a = true; 
      b = true; 
      c =true; 
      d = true; 
      e = false; 
      f = false; 
      g = false; 
      h = false; 
      break;

    case 2:
      a = false; 
      b = true; 
      c = true; 
      d = false; 
      e = true; 
      f = false; 
      g = false; 
      h = false; 
      break;

    case 3:
      a = false; 
      b = true; 
      c = false; 
      d = true; 
      e = true; 
      f = false; 
      g = false; 
      h = false; 
      break;

    case 4:
      a = false; 
      b = true; 
      c = true; 
      d = true; 
      e = true; 
      f = false; 
      g = false; 
      h = false; 
      break;

    case 5:
      a = true; 
      b = false; 
      c = false; 
      d = true; 
      e = false; 
      f = true; 
      g = false; 
      h = false; 
      break;

    case 6:
      a = true; 
      b = false; 
      c = true; 
      d = true; 
      e = false; 
      f = true; 
      g = false; 
      h = false; 
      break;

    case 7:
      a = true; 
      b = false; 
      c = false; 
      d = true; 
      e = true; 
      f = true; 
      g = false; 
      h = false; 
      break;

    case 8:
      a = false; 
      b = true; 
      c = true; 
      d = true; 
      e = true; 
      f = true; 
      g = false; 
      h = false; 
      break;

    case 9:
      a = true; 
      b = false; 
      c = false; 
      d = true; 
      e = false; 
      f = false; 
      g = true; 
      h = false; 
      break;

    case 10:
      a = true; 
      b = false; 
      c = false; 
      d = true; 
      e = false; 
      f = true; 
      g = true; 
      h = false; 
      break;

    case 11:
      a = false; 
      b = true; 
      c = false; 
      d = true; 
      e = false; 
      f = true; 
      g = true; 
      h = false; 
      break;

    case 12:
      a = false; 
      b = true; 
      c = true; 
      d = true; 
      e = false; 
      f = true; 
      g = true; 
      h = false; 
      break;

    case 13:
      a = false; 
      b = true; 
      c = true; 
      d = false; 
      e = true; 
      f = false; 
      g = false; 
      h = true; 
      break;

    case 14:
      a = false; 
      b = false; 
      c = false; 
      d = true; 
      e = false; 
      f = true; 
      g = true; 
      h = true; 
      break;

    case 15:
      a = false; 
      b = true; 
      c = false; 
      d = true; 
      e = true; 
      f = false; 
      g = true; 
      h = false; 
      break;
    }

    for (int i = 0; i < columns; i++) {
      if (oldGrid[int(oldGrid[i][j].n[0].x)][int(oldGrid[i][j].n[0].y)].alive == true) {
        oldGrid[i][j].l = true;
      }
      if (oldGrid[int(oldGrid[i][j].n[1].x)][int(oldGrid[i][j].n[1].y)].alive == true) {
        oldGrid[i][j].r = true;
      }
      if (oldGrid[i][j].l && oldGrid[i][j].alive && oldGrid[i][j].r) {
        newGrid[i][j+1] = h;
      } else if (oldGrid[i][j].l && oldGrid[i][j].alive && !oldGrid[i][j].r) {
        newGrid[i][j+1] = g;
      } else if (oldGrid[i][j].l && !oldGrid[i][j].alive && oldGrid[i][j].r) {
        newGrid[i][j+1] = f;
      } else if (oldGrid[i][j].l && !oldGrid[i][j].alive && !oldGrid[i][j].r) {
        newGrid[i][j+1] = e;
      } else if (!oldGrid[i][j].l && oldGrid[i][j].alive && oldGrid[i][j].r) {
        newGrid[i][j+1] = d;
      } else if (!oldGrid[i][j].l && oldGrid[i][j].alive && !oldGrid[i][j].r) {
        newGrid[i][j+1] = c;
      } else if (!oldGrid[i][j].l && !oldGrid[i][j].alive && oldGrid[i][j].r) {
        newGrid[i][j+1] = b;
      } else if (!oldGrid[i][j].l && !oldGrid[i][j].alive && !oldGrid[i][j].r) {
        newGrid[i][j+1] = a;
      }
    }

    for (int i = 0; i < columns; i++) {
      oldGrid[i][j+1].alive = newGrid[i][j+1];
    }

    if (currentRow < rows-2) {
      currentRow++;
    }
  }
}


class Button {
  float xPos, yPos, w, h;
  boolean clicked = false;
  boolean circle = false;
  String word;

  Button (float _xPos, float _yPos, float _w, float _h, boolean _circle, String _word)
  {
    xPos = _xPos;
    yPos = _yPos;
    w = _w;
    h = _h;
    circle = _circle;
    word = _word;
  }

  void update() {
    strokeWeight(5);
    if (circle) {
      if (dist(mouseX, mouseY, xPos, yPos) < w/2) {

        fill(#26C485);
        ellipse(xPos, yPos, w, h);
        fill(#EF476F);
        textSize(h/3.4);
        text(word, xPos, yPos + 5);
        if (mousePressed && !clicked) {
          clicked = true;
          mousePressed = false;
        } else if (mousePressed && clicked) {
          clicked = false;
          mousePressed = false;
        }
      } else {
        if (clicked) {
          fill(#26C485);
          ellipse(xPos, yPos, w, h);
          fill(#EF476F);
          textSize(h/3.4);
          text(word, xPos, yPos + 5);
        } else {
          fill(255);
          ellipse(xPos, yPos, w, h);
          fill(#7BB4C8);
          textSize(h/3.4);
          text(word, xPos, yPos + 5);
        }
      }
    } else {
      rectMode(CENTER);
      if (mouseX > (xPos - w/2) && mouseX < (xPos + w/2) && mouseY > (yPos - h/2) && mouseY < (yPos + h/2)) {
        fill(#26C485);
        rect(xPos, yPos, w, h);
        if (mousePressed && !clicked) {
          clicked = true;
          mousePressed = false;
        } else if (mousePressed && clicked) {
          clicked = false;
          mousePressed = false;
        }
      } else {
        fill(#6BA292);
        rect(xPos, yPos, w, h);
      }
      fill(#FC7521);
      textSize(h/4);
      text(word, xPos, yPos + 5);
    }
    strokeWeight(1);
  }
}


class Square {
  float x, y, xVel, yVel, d;

  Square(float _x, float _y, float _xVel, float _yVel, float _d) {
    x = _x;
    y = _y;
    xVel = _xVel;
    yVel = _yVel;
    d = _d;
  }

  void update() {
    x = x+xVel;
    y = y+yVel;
    fill(0, 70);
    rect(x, y, d, d);
  }
}


boolean setted = false;

void oneD() {
  stroke(100);
  strokeWeight(1);
  fill(50, 60);
  rect(1150, 850, 290, 250);


  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      oldGrid[i][j].display();
    }
  }

  play.update();
  menu.update();
  clear.update();
  finish.update();


  if (!finish.clicked && !setted) {
    fill(0, 230);
    rect(500, 510, 1000, 1000);
    fill(255);
    textSize(40);
    text("Select Original Configuration in First Row", 500, 300);
    text("then Click Set to Confirm. Click Clear to Reset All", 500, 400);

    for (int i = 0; i < 100; i++) {
      for (int j = 1; j < 100; j++) {
        if (oldGrid[i][j].alive) {
          oldGrid[i][j].alive = false;
        }
      }
    }
  }
  if(finish.clicked){
    if (play.clicked) {
      calculate();
    }
    setted = true;
  }

  if (clear.clicked) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        oldGrid[i][j].alive = false;
      }
    }
    clear.clicked = false;
    currentRow = 0;
    play.clicked = false;
    finish.clicked = false;
    setted = false;
  }

  stroke(#FFB30F, 80);
  fill(#26547C);
  rect(1150, 140, 260, 200);
  rect(1150, 140, 200, 100);
  textAlign(CENTER);
  textSize(120);
  fill(#FFB30F);
  text("1-D", 1150, 100); 
  textSize(60);
  text("Cellular", 1150, 160);
  text("Automata", 1150, 230);

  fill(50, 60);
  rect(1150, 450, 290, 350);
  fill(#B8DBD9);
  textSize(40);
  text("Rule Set #", 1150, 320);

  for (int i = 0; i < 16; i++) {
    rules[i].update();
    if (rules[i].clicked) {
      ruleNumber = i;
      for (int j = 0; j < 16; j++) {
        if (j!=i) {
          rules[j].clicked = false;
        }
      }
    }
  }

  if (menu.clicked) {
    menu.clicked = false;
    gameState=0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        oldGrid[i][j].alive = false;
      }
    }
    currentRow = 0;
  }
}

float sx1 = 1100;
float sx2 = 1100;
float sx3 = 1150;
float sy1 = 400;
float sy2 = 550;
float sy3 = 700;
boolean drag1 = false;
boolean drag2 = false;
boolean drag3 = false;
int rule1 = 3;
int rule2 = 3;
float speed;
int counter;

void gameOfLife() {
  speed = sx3 - 1285;
  stroke(50, 150);
  rectMode(CENTER);
  rect(1150, 160, 260, 200);
  rect(1150, 160, 200, 100);
  fill(50, 60);
  rect(1150, 400, 290, 130);
  rect(1150, 550, 290, 130);
  rect(1150, 815, 290, 350);

  play.update();
  menu.update();
  clear.update();

  if (clear.clicked) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        oldGrid[i][j].alive = false;
      }
    }
    clear.clicked = false;
  }

  if (play.clicked) {
    counter-=5;
    if (counter < speed) {
      calculate();
      counter = 0;
    }
  } else {
    if (drag1 && mouseX < 1280 && mouseX > 1020) {
      sx1 = mouseX;
    } else {
      if (sx1 >= 1025 && sx1 <= 1055) {
        sx1 = 1040;
        rule1 = 1;
      } else if (sx1 > 1055 && sx1 <= 1085) {
        sx1 = 1070;
        rule1 = 2;
      } else if (sx1 > 1085 && sx1 <= 1115) {
        sx1 = 1100;
        rule1 = 3;
      } else if (sx1 > 1115 && sx1 <= 1145) {
        sx1 = 1135;
        rule1 = 4;
      } else if (sx1 > 1145 && sx1 <= 1175) {
        sx1 = 1165;
        rule1 = 5;
      } else if (sx1 > 1175 && sx1 <= 1205) {
        sx1 = 1195;
        rule1 = 6;
      } else if (sx1 > 1205 && sx1 <= 1235) {
        sx1 = 1228;
        rule1 = 7;
      } else if (sx1 > 1235 && sx1 <= 1300) {
        sx1 = 1258;
        rule1 = 8;
      }
    }

    if (drag2 && mouseX < 1280 && mouseX > 1020) {
      sx2 = mouseX;
    } else {
      if (sx2 >= 1025 && sx2 <= 1055) {
        sx2 = 1040;
        rule2 = 1;
      } else if (sx2 > 1055 && sx2 <= 1085) {
        sx2 = 1070;
        rule2 = 2;
      } else if (sx2 > 1085 && sx2 <= 1115) {
        sx2 = 1100;
        rule2 = 3;
      } else if (sx2 > 1115 && sx2 <= 1145) {
        sx2 = 1135;
        rule2 = 4;
      } else if (sx2 > 1145 && sx2 <= 1175) {
        sx2 = 1165;
        rule2 = 5;
      } else if (sx2 > 1175 && sx2 <= 1205) {
        sx2 = 1195;
        rule2 = 6;
      } else if (sx2 > 1205 && sx2 <= 1235) {
        sx2 = 1228;
        rule2 = 7;
      } else if (sx2 > 1235 && sx2 <= 1300) {
        sx2 = 1258;
        rule2 = 8;
      }
    }
  }

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      oldGrid[i][j].display();
    }
  }
  //adjust difficulty
  strokeWeight(5);
  line(1030, 400, 1270, 400);
  line(1030, 550, 1270, 550);
  line(1030, 700, 1270, 700);

  textSize(25);
  text("1  2  3  4  5  6  7  8", 1150, 450);
  text("1  2  3  4  5  6  7  8", 1150, 600);

  textSize(20);
  text("Speed of Animation", 1150, 670);
  text("# of Neighbors to Stay Alive", 1150, 370); 
  text("# of Neighbors to Come Alive", 1150, 520);

  ellipse(sx1, sy1, 30, 30);
  ellipse(sx2, sy2, 30, 30);
  ellipse(sx3, sy3, 30, 30);

  if (play.clicked) {
    fill(50, 150);
    rect(1150, 400, 290, 130);
    rect(1150, 550, 290, 130);
  }

  if (drag3 && mouseX < 1280 && mouseX > 1020) {
    sx3 = mouseX;
  }

  fill(#93B7BE);
  textSize(100);
  textAlign(CENTER);
  text("GAME", 1150, 100); 
  text("OF", 1150, 200);
  text("LIFE", 1150, 300);
  textSize(20);

  if (menu.clicked) {
    menu.clicked = false;
    gameState = 0;
    play.clicked = false;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        oldGrid[i][j].alive = false;
      }
    }
  }
}


void lSystem() {
}

class Cell {
  int xPos = 0;
  int yPos = 0;
  int w = 10;
  int h = 10;
  int neighborCount = 0;
  boolean alive = false;
  PVector n[] = new PVector[8];
  boolean r = false;
  boolean l = false;

  Cell(int _xPos, int _yPos, int n1x, int n1y, int n2x, int n2y, int n3x, int n3y, 
    int n4x, int n4y, int n5x, int n5y, int n6x, int n6y, int n7x, int n7y, int n8x, int n8y) {
    xPos = _xPos;
    yPos = _yPos;
    n[0] = new PVector(n1x, n1y);
    n[1] = new PVector(n2x, n2y);
    n[2] = new PVector(n3x, n3y);
    n[3] = new PVector(n4x, n4y);
    n[4] = new PVector(n5x, n5y);
    n[5] = new PVector(n6x, n6y);
    n[6] = new PVector(n7x, n7y);
    n[7] = new PVector(n8x, n8y);
  }

  void display() {
    if (alive && gameState == 1) {
      fill(#EF476F);
    } else if (alive && gameState ==3) {
      fill(#26547C);
    } else {
      fill(255);
    }
    rectMode(CENTER);
    rect(xPos, yPos, w, h);

    if (mousePressed && mouseX >= xPos - w/2 && mouseX <= xPos + w/2 && mouseY <= yPos + h/2 && mouseY >= yPos - h/2 && !alive) {
      alive = true;
      mousePressed = false;
    } else if (mousePressed && mouseX >= xPos - w/2 && mouseX <= xPos + w/2 && mouseY <= yPos + h/2 && mouseY >= yPos - h/2 && alive) {
      alive = false;
      mousePressed = false;
    }
  }
}

void mousePressed() {
  if (dist(mouseX, mouseY, sx1, sy1) < 15) {
    drag1 = true;
  }
  if (dist(mouseX, mouseY, sx2, sy2) < 15) {
    drag2 = true;
  }
  if (dist(mouseX, mouseY, sx3, sy3) < 15) {
    drag3 = true;
  }
}