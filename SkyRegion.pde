class SkyRegion{
  
  int minx, maxx;
  int miny, maxy;
  int w;
  StarField curr;
  StarField background;
  int seed;
  int currentZ;
  
  SkyRegion(int Seed, int x, int y, int w_){
    currentZ = p.pz;
    seed = Seed;
    minx = x;
    miny = y;
    w = w_;
    maxx = x+w;
    maxy = y+w;
    curr = new StarField(seed, x, y, w, currentZ);
    background = new StarField(seed-1, x, y, w, currentZ);
  }
  
  void show(boolean c, boolean n, boolean r){
    background.render();
    curr.show(c, n);
    if(r) showRect();
  }
  
  void showRect(){
    rectMode(CORNERS);
    stroke(white);
    strokeWeight(gridStroke);
    noFill();
    rect(minx, miny, maxx, maxy);
    textSize(11);
    fill(white);
    text(minx/w+", "+miny/w+", "+currentZ, minx+6, miny-6);
  }
  
  void changeSky(int z){
    if(z > currentZ){
      background = curr;
      curr = new StarField(seed, minx, miny, w, z);
    } else if(z < currentZ){
      curr = background;
      background = new StarField(seed-1, minx, miny, w, z);
    }
    currentZ = z;
  }
  
}
