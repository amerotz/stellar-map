class StarField{
  
  int z;
  ArrayList<Star> stars;
  int starNum;
  int[][] pv;
  
  StarField(int seed, int x, int y, int w, int z_){
    z = z_;
    randomSeed(seed+z);
    stars = new ArrayList<Star>();
    starNum = (int) random(30)+1;
    stars.ensureCapacity(starNum);
    for(int i = 0; i < starNum; i++){
      float cx = x+w/2;
      float cy = y+w/2;
      float rad = w/2;
      stars.add(new Star(cx,cy,rad));
    }
    pv = new int[starNum][starNum];
    for(int i = 0; i < starNum; i++){
      for(int j = 0; j < starNum; j++) pv[i][j] = -1;
    }
    buildConsts();
  }
  
  void buildConsts(){
   int[] links = new int[pv.length];
   for(int i = 0; i < pv.length; i++) links[i] = 0;
   for(int i = 0; i < pv.length; i++){
     Star s1 = stars.get(i);
     for(int j = i; j < pv.length; j++){        
       Star s2 = stars.get(j);
       if(pv[i][j] == -1 && 
       dist(s1.x,s1.y,s2.x,s2.y) < 100 &&
       links[i] < 4 && links[j] < 4){
         int prob = (int)random(2);
         if(prob == 0) {
           pv[i][j] = 1;
           links[i]++;
           links[j]++;
         }
       }
     }
   }
 }
  
  void showConsts(){
    for(int i = 0; i < pv.length; i++){        
    Star s1 = stars.get(i);
      for(int j = i; j < pv.length; j++){
        if(pv[i][j] == 1){
        Star s2 = stars.get(j);
        stroke(white);
        strokeWeight(gridStroke);
        line(s1.x,s1.y,s2.x,s2.y);
        }
      }
    }
  }
  
  void show(boolean c, boolean n){
    if(c) showConsts();
    for(Star s : stars) s.show();
    if(n) for(Star s : stars) s.showName();
  }
  
  void render(){
    for(Star s : stars) s.render();
  }
}
