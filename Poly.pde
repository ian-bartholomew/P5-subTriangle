class Poly {
  UVec3 v[];
  int col;  
  float h,s,b;
 
 Poly(UVec3 v1, UVec3 v2, UVec3 v3, int c) {
    v=new UVec3[3];
    v[0]=v1;
    v[1]=v2;
    v[2]=v3;
    
    col = c;
    
  }
  
  Poly(UVec3 v1, UVec3 v2, UVec3 v3) {
    v=new UVec3[3];
    v[0]=v1;
    v[1]=v2;
    v[2]=v3;
    
    h = 0;
    s = 255;
    b = 0;
    
    col = color(h,s,b);
    
//    col=color(random(50, 100)+(random(100)>50?185:0));
//    if(random(100)>80)
//      col=UColorTool.interpolate(random(1),"00FFFF","003366");
//    else if(random(100)>80)
//      col=UColorTool.interpolate(random(1),"FF6600","FFCC00");
  }
  
  public void setColor(int c){
    col = c;    
  } 
  
  public void setBrightness(float _b) {
    b = _b;    
  }
  
  public void setHue(float _h) {
    h = _h;
  }
  
  public void setSaturation(float _s) {
    s = _s;
  }
  
  public float getBrightness(){
    return b;
  }
 
  public void draw() {
    fill(col);
    beginShape(TRIANGLES);
    vertex(v[0].x, v[0].y);
    vertex(v[1].x, v[1].y);
    vertex(v[2].x, v[2].y);
    endShape();

    // lets let the color fade            
    b *= 0.975f;
    
    col = color(h,s,b);
    
  }
 
  // calculate random point in triangle, tending towards the
  // center of the triangle surface
  public UVec3 calcRandomPoint() {
    UVec3 vv=UVec3.interpolate(v[1], v[2], UUtil.rnd.random(0.33f, 0.66f));
    vv=UVec3.interpolate(v[0], vv, UUtil.rnd.random(0.33f, 0.66f));
    return vv;
  }
 
  // subdivide Poly by calculating the midpoint in the triangle
  // face and using it to produce four new Poly instances
  public Poly[] subdivide() {
    
    // midway points
    UVec3 v1 = new UVec3( (v[0].x + v[1].x) * 0.5, (v[0].y + v[1].y) * 0.5, (v[0].z + v[1].z) * 0.5);
    UVec3 v2 = new UVec3( (v[1].x + v[2].x) * 0.5, (v[1].y + v[2].y) * 0.5, (v[1].z + v[2].z) * 0.5);
    UVec3 v3 = new UVec3( (v[2].x + v[0].x) * 0.5, (v[2].y + v[0].y) * 0.5, (v[2].z + v[0].z) * 0.5);
    
    Poly p[]=new Poly[4];

    p[0]=new Poly(v[0], v1, v3);    
    p[1]=new Poly(v[1], v2, v1);        
    p[2]=new Poly(v[2], v3, v2);    
    p[3]=new Poly(v1, v2, v3);
    
    return p;
  }
}
