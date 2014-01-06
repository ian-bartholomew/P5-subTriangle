// initializes triangle surface in one of two configurations
public void reinit() {
  doCrack=false;  
  
  UVec3 v[];
  f=new ArrayList<Poly>();
   
  UVertexList vl=new UVertexList();
    vl.add(50, 50);
    vl.add(width - 50, 50);
    vl.add(width/2, height - 50);
    
    v=vl.v;
    
    f.add(new Poly(v[0], v[1], v[2], color(0, 255, 255)));
      
}
 
void crack() {    
    
  ArrayList<Poly> ff=new ArrayList<Poly>();
  for (int i = 0; i<f.size(); i++){
   Poly pp = f.get(i);
   
   // subdivide triangle to produce new triangles
    Poly p[]=pp.subdivide();         
     
    // add the new triangles to arraylist
    for (int j=0; j<p.length; j++) ff.add(p[j]);
   
  }
  
  // remove old triangles from arraylist
  f.clear();
  
  // add new triangles
  for (Poly p : ff){
    f.add(p);
  }  
     
}
