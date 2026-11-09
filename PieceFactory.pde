interface PieceFactory {
  Piece create();
  Piece getNextPiece();
}

private Piece getPiece(Block block) {
  Piece p;
  if (block == Block.I) { 
    p = new IPiece();
  } else if (block == Block.J) {
    p = new JPiece();
  } else if (block == Block.L) { 
    p = new LPiece();
  } else if (block == Block.O) { 
    p = new OPiece(); 
  } else if (block == Block.S) { 
    p = new SPiece(); 
  } else if (block == Block.T) { 
    p = new TPiece();
  } else if (block == Block.Z) { 
    p = new ZPiece();
  } else {
    p = null;
  }
  
  return p;
}

class RandomPieceFactory
implements PieceFactory {
  Piece create() {
    int i = (int) random(0, Block.values().length);
    return getPiece(Block.values()[i]);
  }
  
  Piece getNextPiece() {
    return null;
  }
}

class BagPieceFactory
implements PieceFactory {
  
  private int bagCount = 1;
  private ArrayList<Block> blocks =
    new ArrayList<Block>();
    
  private Piece nextPiece;
  
  public BagPieceFactory() {
    init();
  }
  
  public BagPieceFactory(int bagCount) {
    if (bagCount < 1)
      throw new RuntimeException(
       "Invalid bag count"
      );
    this.bagCount = bagCount;
    init();
  }
  
  private void init() {
    refill();
    nextPiece = pick();
  }
  
  private void refill() {
    if (blocks.size() != 0) return;
    Block[] bs = Block.values();
    for(int i=0;i<bagCount;i++) {
      for(int j=0;j<bs.length;j++) {
        blocks.add(bs[j]);
      }
    }
  }
  
  Piece create() {
    Piece cur = nextPiece;
    nextPiece = pick();
    return cur;
  }
  
  private Piece pick() {
    if (blocks.size()==0) refill();
    int i = (int) random(0, blocks.size());
    Piece b = getPiece(blocks.get(i));
    blocks.remove(i);
    return b;
  }
  
  Piece getNextPiece() {
    return nextPiece;
  }
}