public static void rotateCW(
    Block[][] bs,
    int squareLength
) {
  Block[][] dup = copy2D(bs);
  int cellCount = min(squareLength, bs.length);
  
  for(int i=0;i<cellCount;i++) {
    for(int j=0;j<cellCount;j++) {
      int invI = j;
      int invJ = cellCount - i - 1;
      bs[invI][invJ] = dup[i][j];
    }
  }
}

public static void rotateCCW(
    Block[][] bs,
    int squareLength
) {
  Block[][] dup = copy2D(bs);
  int cellCount = min(squareLength, bs.length);
  
  for(int i=0;i<cellCount;i++) {
    for(int j=0;j<cellCount;j++) {
      int invI = cellCount - j - 1;
      int invJ = i;
      bs[invI][invJ] = dup[i][j];
    }
  }
}

private static Block[][] copy2D(Block[][] og) {
  Block[][] b = new Block[og.length][og[0].length];
  for(int i=0;i<og.length;i++){
    for(int j=0;j<og[i].length;j++){
      b[i][j] = og[i][j];
    }
  }
  return b;
}