class Player{
  
  float facing;
  float px, py;
  int pz;
  final int cRad = 50;
  boolean selecting;
  boolean compass;
  
  Player(){
    px = 0;
    py = 0;
    pz = 0;
    facing = -PI/2;
    selecting = false;
    compass = false;
  }
  
  void move(){
    int rad = 0;
    if(!keyPressed) return;
    if(key == '5') rad += 10/scale;
    if(key == '4') facing -= PI/30;
    else if(key == '6') facing += PI/30;
    if(key == '1'){
      pz--;
      key = '\\';
    }
    else if(key == '2'){
      pz = 0;
      key = '\\';
    }
    else if(key == '3'){
      pz++;
      key = '\\';
    }
    if(key == '8'){
      selecting = !selecting;
      if(selecting){
        wasSelecting = rect;
        rect = true;
      }
      else rect = wasSelecting;
      key = '\\';
    }
    if(key == 'e'){
      compass = !compass;
      key = '\\';
    }
    float xmov = cos(facing)*rad;
    float ymov = sin(facing)*rad;
    px += xmov;
    py += ymov;
  }
  
  void selectStar(){
    SkyRegion r = findCurrentRegion();
    if(r == null) return;
    noFill();
    rectMode(CORNERS);
    stroke(255, 0, 0);
    strokeWeight(2);
    rect(r.minx, r.miny, r.maxx, r.maxy);
    Star s = findNearestStar(r);
    if(s == null) return;
    fill(red);
    noStroke();
    circle(s.x, s.y, s.lum*2+5);
    stroke(255);
    strokeWeight(gridStroke);
    line(px, py, s.x, s.y);
  }
  
  SkyRegion findCurrentRegion(){
    if(s == null) return null;
    for(SkyRegion r : s.sky){
      if(r.minx <= px && px <= r.maxx && r.miny <= py && py <= r.maxy) return r;
    }
    return null;
  }
  
  Star findNearestStar(SkyRegion r){
    if(r.curr.stars == null) return null;
    float minDist = 10000;
    Star nearest = null;
    for(Star s : r.curr.stars){
      float dist = dist(s.x, s.y, px, py);
      if(dist < minDist){
        minDist = dist;
        nearest = s;
      }
    }
    return nearest;
  }
  
  void show(){
    if(compass) showCompass();
    if(selecting) selectStar();
    stroke(white);
    strokeWeight(2/scale);
    noFill();
    circle(px, py, cRad*2/scale);
    fill(white);
    circle(px, py, cRad/(5*scale));  
    line(px, py, px+cRad*cos(facing)/scale, py+cRad*sin(facing)/scale);
  }
  
  void showCompass(){
    stroke(white);
    strokeWeight(compassStroke);
    noFill();
    circle(px, py, width/3);
    circle(px, py, 2*width/3);
    circle(px, py, width);
    for(float a = 0; a < 2*PI; a += PI/6){
      line(px, py, px+width*cos(a), py+width*sin(a));
    }
  }
}
