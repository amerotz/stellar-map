Player p;
int worldSeed = 0;
Sky s;
final color black = color(3, 25, 30);
final color white = color(253, 250, 255);
final color blue = color(79, 252, 255);
final color red = color(251, 54, 64);
final float gridStroke = 0.3;
final float compassStroke = 0.1;

void setup(){
  size(1000, 1000);
  p = new Player();
  randomSeed(worldSeed);
  s = new Sky(worldSeed);
}

float scale = 1;
boolean consts = false;
boolean rect = false;
boolean wasSelecting = false;
boolean names = true;

void keyPressed(){
  if(key == '9'){
    if(scale >= 1) scale += 1;
    else scale = 1;
  }
  else if(key == '7') {
    if(scale > 1) scale--;
    else scale = 0.8;
  }
  if(key == 'c'){
    consts = !consts;
    key = '\\';
  }
  if(key == 'r'){
    wasSelecting = rect;
    rect = !rect;
    key = '\\';
  }
  if(key == 'n'){
    names = !names;
    key = '\\';
  }
}

void draw(){
  scale(scale);
  translate(width/(2*scale)-p.px, height/(2*scale)-p.py);
  background(black);
  p.move();
  s.update();
  s.show(consts, names, rect);
  p.show();
}

String randomName(){
  String s = "";
  s += (char) random(65, 91);
  int len = (int) random(2, 10);
  char vow[] = {'a', 'e', 'i', 'o', 'u', 'y'};
  for(int i = 0; i < len; i++){
    if(i%2 == 0) s+= vow[(int) random(vow.length)];
    else s+= (char) random(97, 123);
  }
  return s;
}

float distSq(float x1, float y1, float x2, float y2){
  return (x1-x2)*(x1-x2)+(y1-y2)+(y1-y2);
}
