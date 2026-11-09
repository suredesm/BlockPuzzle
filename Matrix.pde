class Matrix {
  int w = 10;
  int h = 20;
  Block[][] blocks = new Block[h][w];
  
  PieceFactory fact = new BagPieceFactory(3);
  Piece piece;
  int score = 0;
  boolean gameOver = false;
  
  public Matrix() {
    createPiece();
  }
  
  private void createPiece() {
    if (gameOver) return;
    piece = fact.create();
    int d = (int) random(0, 4);
    
    for(int i=0;i<d;i++) {
      piece.rot();
    }
    
    int p = -1;
    for(int i=4-1;i>=0;i--) {
      for(int j=0;j<4;j++) {
        Block b = piece.blocks[i][j];
        if (b!=null) {
          p = i;
          break;
        }
      }
      if(p!=-1) break;
    }
    if (p!=-1)
     piece.offset.y = - p -1;
  }
  
  public void swipeRight() {
    boolean intersects = false;
    
    for(int i=0;i<4;i++) {
      for(int j=0;j<4;j++) {
        Block p = piece.blocks[i][j];
        int ni = piece.offset.y + i;
        int nj = piece.offset.x + j + 1;
        Block m;
        try {
          if (ni < 0) {
            m = null;
          } else {
           m = blocks[ni][nj];
          }
        } catch(ArrayIndexOutOfBoundsException e) {
          m = Block.T; //Fake pretends a block
        }
        
        if (p != null && m != null) {
          intersects = true;
          break;
        }
      }
      if (intersects) break;
    }
    
    if(!intersects) {
      piece.offset.x++;
    }
  }
  
  void swipeLeft() {
    boolean intersects = false;
    
    for(int i=0;i<4;i++) {
      for(int j=0;j<4;j++) {
        Block p = piece.blocks[i][j];
        int ni = piece.offset.y + i;
        int nj = piece.offset.x + j - 1;
        Block m;
        try {
          if (ni < 0) {
            m = null;
          } else {
           m = blocks[ni][nj];
          }
        } catch(ArrayIndexOutOfBoundsException e) {
          m = Block.T; //Fake pretends a block
        }
        
        if (p != null && m != null) {
          intersects = true;
          break;
        }
      }
      if (intersects) break;
    }
    
    if(!intersects) {
      piece.offset.x--;
    }
  }
  
  void goDown() {
    boolean intersects = false;
    if (gameOver) return;
        
    for(int i=0;i<4;i++) {
      for(int j=0;j<4;j++) {
        Block p = piece.blocks[i][j];
        int ni = piece.offset.y + i + 1;
        int nj = piece.offset.x + j;
        Block m;
        try {
          if (ni < 0) {
            m = null;
          } else {
           m = blocks[ni][nj];
          }
        } catch(ArrayIndexOutOfBoundsException e) {
          m = Block.T; //Fake pretends a block
        }
        
        if (p != null && m != null) {
          intersects = true;
          break;
        }
      }
      if (intersects) break;
    }
    
    if(!intersects) {
      piece.offset.y++;
    } else {
      for(int i=0;i<4;i++) {
        for(int j=0;j<4;j++) {
          int ni = piece.offset.y + i;
          int nj = piece.offset.x + j;
          Block b = piece.blocks[i][j];
          try {
            if (b != null)
              blocks[ni][nj] = b;
          } catch (Exception e) {
            gameOver = true;
          }
        }
      }
      
      checkLine();
      createPiece();
    }
  }
  
  private void checkLine() {
    for(int i=h-1;i>=0;i--) {
      boolean lined = true;
      for(int j=0;j<w;j++) {
        Block b = blocks[i][j];
        if (b==null) {
          lined = false;
          break;
        }
      }
      
      if (lined) {
        clearLine(i);
        score++;
        i++;
      }
    }
  }
  
  private void clearLine(int at) {
    for(int i=0;i<w;i++) {
      blocks[at][i] = null;
    }
    
    for(int i=at-1;i>=0;i--) {
      for(int j=0;j<w;j++) {
        blocks[i+1][j] = blocks[i][j];
      }
    }
  }
  
  void rotatePiece() {
    if (gameOver) return;
    boolean intersects = false;
    Block[][] snap = piece.rotSnap();
    
    for(int i=0;i<4;i++) {
      for(int j=0;j<4;j++) {
        Block p = snap[i][j];
        int ni = piece.offset.y + i;
        int nj = piece.offset.x + j;
        Block m;
        try {
          if (ni < 0) {
            m = null;
          } else {
           m = blocks[ni][nj];
          }
        } catch(ArrayIndexOutOfBoundsException e) {
          m = Block.T; //Fake pretends a block
        }
        
        if (p != null && m != null) {
          intersects = true;
          break;
        }
      }
      if (intersects) break;
    }
    
    if(!intersects) {
      piece.rot();
    }
  }
}