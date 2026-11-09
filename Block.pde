enum Block {
  I,J,L,O,S,T,Z
}

class Color {
  public int r;
  public int g;
  public int b;
  
  public Color(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
}

public Color getColor(Block block) {
  Color c;
  if (block == Block.I) { 
    c = new Color(0, 216, 232); 
  } else if (block == Block.J) { 
    c = new Color(40, 100, 232); 
  } else if (block == Block.L) { 
    c = new Color(245, 158, 11); 
  } else if (block == Block.O) { 
    c = new Color(244, 213, 46); 
  } else if (block == Block.S) { 
    c = new Color(50, 198, 107); 
  } else if (block == Block.T) { 
    c = new Color(168, 85, 232); 
  } else if (block == Block.Z) { 
    c = new Color(239, 68, 68);
  } else {
    c = null;
  }
  
  return c;
}