class Button {
  String text;
  int x;
  int y;
  int w;
  int h;
  boolean isPressed = false;
  
  public Button(
    String text,
    int x,
    int y,
    int w,
    int h
  ) {
    this.text = text;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  private OnClickListener listener = null;
  
  void render() {
    push();
    fill(98, 0, 238);
    rect(x,y,w,h,20);
    textAlign(CENTER, CENTER);
    textSize(128);
    fill(255);
    text(text,x+w/2,y+h/2);
    pop();
  }
  
  boolean intercepts(int x,int y) {
    return x >= this.x && x < this.x + w &&
      y >= this.y && y < this.y + h;
  }
  
  void setOnClickListener(OnClickListener l) {
    listener = l;
  }
  
  void triggerOnClick() {
    if (listener != null) listener.onClick();
  }
}

interface OnClickListener {
  void onClick();
}