IntSize gridSize;
int squareLength;
int squareOffsetLength = 5;
int time = 0;
Matrix mat = new Matrix();
int blockSpeed = 30;
int holdStartMillis = Integer.MAX_VALUE;
boolean pressed = false;
boolean isHold = false;
int pressedCount = 1;
Button[] btns = new Button[4];
int fs = 0;

void setup() {
  fullScreen();
  gridSize = new IntSize(10, 20);
  squareLength = height/gridSize.h*8/10;
  
  int w = 200;
  int h = 200;
  int gap = (width - btns.length * w)/(btns.length+1);
  int vm = 20;
  IntOffset off = new IntOffset(gap,height-vm-h);
  String[] icon = {"\u25C0","\u25BC","\u21BB","\u25B6"};
  for(int i=0;i<btns.length;i++) {
    
    btns[i] = new Button(
       icon[i],
       off.x + (gap+w)*i,
       off.y,
       w,
       h
    );
  }
}

void draw() {
  if (
    pressed &&
    !isHold &&
    millis() - holdStartMillis > 500 &&
    pow((mouseX - startOffset.x),2) +
    pow((mouseY - startOffset.y),2) < 100
  ) {
    blockSpeed = 5;
    isHold = true;
  }
  Piece piece = mat.piece;
  fill(0);
  rect(0, 0, width, height);
  for(int i=0;i<gridSize.w;i++) {
    for(int j=0;j<gridSize.h;j++) {
      Block b = mat.blocks[j][i];
      Color c = getColor(b);
      
      if (c != null) {
        fill(c.r,c.g,c.b);
      } else {
        fill(55,55,67);
      }
      
      rect(
        i * squareLength + squareOffsetLength,
        j * squareLength + squareOffsetLength,
        squareLength - squareOffsetLength,
        squareLength- squareOffsetLength
      );
    }
  }
  
  IntOffset off = new IntOffset(
    piece.offset.x * squareLength,
    piece.offset.y * squareLength
  );
  
  for(int i=0;i<4;i++) {
    for(int j=0;j<4;j++) {
      Color c = getColor(piece.blocks[i][j]);
      if (c==null) continue;
      fill(c.r, c.g, c.b);
      rect(
        off.x + j * squareLength + squareOffsetLength,
        off.y + i * squareLength + squareOffsetLength,
        squareLength - squareOffsetLength,
        squareLength - squareOffsetLength
      );
    }
  }
  
  Piece next = mat.fact.getNextPiece();
  IntOffset offset;
  
  if (next instanceof OPiece)
    offset = new IntOffset(2, 2);
  else if (next instanceof IPiece)
    offset = new IntOffset(0,0);
  else
    offset = new IntOffset(1,1);
    
  int sl = 40;
    
  IntOffset org = new IntOffset(
    width - 5*sl - 40,
    0
  );
  
  for(int i=0;i<5;i++) {
    for(int j=0;j<5;j++) {
      int ni = i - offset.y;
      int nj = j - offset.x;
      
      int x = org.x + j * sl;
      int y = org.y + i * sl;
      
      try {
        Block b = next.blocks[ni][nj];
        Color c = getColor(b);
      
        if (c != null) {
          fill(c.r,c.g,c.b);
        } else {
          fill(55,55,67);
        }
      } catch(Exception e) {
        fill(55,55,67);
      }
      
      rect(
        x, y,
        sl, sl
      );
    }
  }
  
  push();
  textSize(128);
  textAlign(CENTER, CENTER);
  fill(255);
  text(
    mat.score,
    width - (width - 10*squareLength)/2,
    height/4
  );
  pop();
  
  for(int i=0;i<btns.length;i++) {
    btns[i].render();
    if (btns[i].isPressed) {
      if ((time-fs+1)%20==0) {
        buttonAction(i);
      }
    }
  }
  
  if (mat.gameOver) {
    fill(0,0,0,200);
    rect(0,0,width,height);
    textSize(128);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Game Over", width/2, height/2);
  }
  
  time++;
  if(time%blockSpeed==0) {
    //if (mat.piece.offset.y<4)
    mat.goDown();
  }
}

IntOffset startOffset = new IntOffset(0,0);

void buttonAction(int i) {
  if(i==0) {
    mat.swipeLeft();
  } else if(i==2) {
    mat.rotatePiece();
  } else if(i==3) {
    mat.swipeRight();
  }
}

void mousePressed() {
  if (mat.gameOver) {
    mat = new Matrix();
    return;
  }
  
  boolean propagate = true;
  for(int i=0;i<btns.length;i++) {
    if (btns[i].intercepts(mouseX, mouseY)) {
      btns[i].isPressed = true;
      fs = time % 20;
      buttonAction(i);
      if(i==1) blockSpeed = 5;
      propagate = false;
      break;
    }
  }
  if (!propagate) return;
  
  pressed = true;
  holdStartMillis = millis();
  startOffset.x = mouseX;
  startOffset.y = mouseY;
  isHold = false;
}

void mouseReleased(){
  pressed = false;
  boolean propagate = true;
  for(int i=0;i<btns.length;i++) {
    if (btns[i].isPressed) {
      propagate = false;
      blockSpeed = 30;
    }
    btns[i].isPressed = false;
  }
  
  if(!propagate) return;
  
  if (isHold) {
    blockSpeed = 30;
    isHold = false;
    holdStartMillis = Integer.MAX_VALUE;
  } else if (mouseX - startOffset.x > 50) {
    // Right swipe
    mat.swipeRight();
  } else if (mouseX - startOffset.x < -50) {
    // Left swipe
    mat.swipeLeft();
  } else {
    mat.rotatePiece();
  }
}
