class CentralBody{
    float G, M, R, Xc, Yc, scale;
  
  CentralBody (float M, float R, float scale){
     G = 6.674*pow(10, -11);
     this.M = M;
     this.R = R;
     Xc = 900;
     Yc = 350;
     this.scale = scale;
  }
   
  float getAx (float X, float Y){
     float r = sqrt(sq(X-Xc)+sq(Y-Yc));
     return -G*M*(X-Xc)/pow(r, 3);
  }
  
  float getAy (float X, float Y){
     float r = sqrt(sq(X-Xc)+sq(Y-Yc));
     return -G*M*(Yc-Y)/pow(r, 3);
  }
  
  float getXcenter (){
    return Xc;
  }
  
  float getYcenter (){
    return Yc;
  }
  
  void display (){
    fill (211,144,101);
    ellipse (Xc, Yc, 36.5*R/scale, 38.8*R/scale);
  }
  
}