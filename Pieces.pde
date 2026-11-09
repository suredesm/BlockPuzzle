class IPiece extends Piece {
  
  private boolean isHorizontal = false;
  
  public IPiece() {
    blocks[0][2] = Block.I;
    blocks[1][2] = Block.I;
    blocks[2][2] = Block.I;
    blocks[3][2] = Block.I;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    if (isHorizontal) {
      rotateCCW(bs,4);
    } else {
      rotateCW(bs,4);
    }
  }
  
  @Override
  public void rot() {
    super.rot();
    isHorizontal = !isHorizontal;
  }
}

class JPiece extends Piece {
  public JPiece() {
    blocks[0][1] = Block.J;
    blocks[1][1] = Block.J;
    blocks[2][1] = Block.J;
    blocks[2][0] = Block.J;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    rotateCW(bs,3);
  }
}

class LPiece extends Piece {
  
  public LPiece() {
    blocks[0][1] = Block.L;
    blocks[1][1] = Block.L;
    blocks[2][1] = Block.L;
    blocks[2][2] = Block.L;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    rotateCW(bs,3);
  }
}

class OPiece extends Piece {
  
  public OPiece() {
    blocks[0][0] = Block.O;
    blocks[0][1] = Block.O;
    blocks[1][0] = Block.O;
    blocks[1][1] = Block.O;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    //rotateCW(blocks,2);
  }
}

class SPiece extends Piece {
  
  private boolean isHorizontal = true;
  
  public SPiece() {
    blocks[1][0] = Block.S;
    blocks[1][1] = Block.S;
    blocks[0][1] = Block.S;
    blocks[0][2] = Block.S;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    if (isHorizontal) {
      rotateCW(bs,3);
    } else {
      rotateCCW(bs,3);
    }
  }
  
  @Override
  public void rot() {
    super.rot();
    isHorizontal = !isHorizontal;
  }
}

class ZPiece extends Piece {
  
  private boolean isHorizontal = true;
  
  public ZPiece() {
    blocks[0][0] = Block.Z;
    blocks[0][1] = Block.Z;
    blocks[1][1] = Block.Z;
    blocks[1][2] = Block.Z;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    if (isHorizontal) {
      rotateCCW(bs,3);
    } else {
      rotateCW(bs,3);
    }
  }
  
  @Override
  public void rot() {
    super.rot();
    isHorizontal = !isHorizontal;
  }
}

class TPiece extends Piece {
  
  public TPiece() {
    blocks[0][1] = Block.T;
    blocks[1][0] = Block.T;
    blocks[1][1] = Block.T;
    blocks[1][2] = Block.T;
  }
  
  @Override
  public void rotMech(Block[][] bs) {
    rotateCW(bs,3);
  }
}