abstract class Piece {
  public Block[][] blocks = new Block[4][4];
  public IntOffset offset = new IntOffset(3,-4);
  
  abstract void rotMech(Block[][] bs);
  
  void rot() {
    rotMech(blocks);
  }
  
  Block[][] rotSnap() {
    Block[][] bs = copy2D(blocks);
    rotMech(bs);
    return bs;
  }
}