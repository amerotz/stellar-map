class Sky{

  final int globalSeed;
  ArrayList<SkyRegion> sky;
  final int regionSize;
  int zCoord;
  float rad = 2;
  
  Sky(int seed){
    regionSize = width/2;
    globalSeed = seed;
    sky = new ArrayList<SkyRegion>();
    sky.ensureCapacity((int)(4*rad*rad));
    zCoord = p.pz;
    int startx = (int)((int) (p.px/regionSize)*regionSize - rad*regionSize);
    int starty = (int)((int) (p.py/regionSize)*regionSize - rad*regionSize);
    for(int i = 0; i < 2*rad; i++){
      for(int j = 0; j < 2*rad; j++){
        int x = startx + i*regionSize;
        int y = starty + j*regionSize;
        int rSeed = x*(x+y)+y+globalSeed;
        sky.add(new SkyRegion(rSeed, x, y, regionSize));
      }
    }
  }
  
  void update(){
    if(zCoord != p.pz){
      for(SkyRegion r : sky) r.changeSky(p.pz);
      zCoord = p.pz;
    }
    float minX = p.px-rad*regionSize;
    float maxX = p.px+rad*regionSize;
    float minY = p.py-rad*regionSize;
    float maxY = p.py+rad*regionSize;
    for(int i = 0; i < sky.size(); i++){
      SkyRegion r = sky.get(i);
      if(r.minx >= maxX || r.maxx <= minX || r.miny >= maxY || r.maxy <= minY)
        sky.remove(i);
    }
    sky.ensureCapacity((int)(4*rad*rad));
    int startx = (int)((int) (p.px/regionSize)*regionSize - rad*regionSize);
    int starty = (int)((int) (p.py/regionSize)*regionSize - rad*regionSize);
    for(int i = 0; i < 2*rad; i++){
      for(int j = 0; j < 2*rad; j++){
        boolean free = true;
        int x = startx + i*regionSize;
        int y = starty + j*regionSize;
        for(SkyRegion r : sky){
          if(r.minx == x && r.miny == y){
            free = false;
            break;
          }
        }
        int rSeed = x*(x+y)+y;
        if(free) sky.add(new SkyRegion(rSeed, x, y, regionSize));
      }
    }
  }
  
  void show(boolean c, boolean n, boolean r){
    for(SkyRegion reg : sky) reg.show(c, n, r);
  }

}
