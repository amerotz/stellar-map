class Star{
  float x, y;
  float lum;
  String name;
  color c;
  
  Star(float cx, float cy, float rad){
    name = randomName();
    x = cx + random(-rad, rad);
    y = cy + random(-rad, rad);
    lum = 1+random(8);
    c = lerpColor(blue, white, lum/8); 
  }
  
  void show() {
    fill(c);
    noStroke();
    circle(x, y, lum*2+1);
  }
  
  void showName(){
    textSize(11);
    stroke(black);
    strokeWeight(2);
    fill(c);
    text(name, x-name.length()*11/4, y-20);
  }
  
  void render() {
    fill(180);
    noStroke();
    circle(x, y, (lum*2+1)/3);
  }
  
}
