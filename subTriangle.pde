import unlekker.modelbuilder.UVec3;
import unlekker.modelbuilder.UVec3;
/**
 * UCracking01.pde - Marius Watz, 2012
 * http://workshop.evolutionzone.com
 *
 * Cracking (aka subdivision) of triangular geometry.
 *
 */
  
 
import controlP5.*;
 
import java.util.ArrayList;
 
import unlekker.modelbuilder.*;
import unlekker.util.*;
import unlekker.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
 
public ArrayList<Poly> f;
public boolean doCrack,doSave;
public USimpleGUI gui;
public Minim minim;  
public AudioPlayer song;
public FFT fftLin;

int startCrack = 2;
 
public void setup() {
  size(1280, 1080);
   
  gui=new USimpleGUI(this);
  gui.addButton("reinit");
  gui.addToggle("doCrack",doCrack);  
  
  setupSound();
  
  reinit();
  smooth();
  
  colorMode(HSB);
  
  for (int i = 0; i<startCrack; i++) crack();
  
  
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fftLin = new FFT( song.bufferSize(), song.sampleRate() );
  fftLin.linAverages( 3 );
  noStroke();
}
 
public void draw() {
  background(0);  
   
  fftLin.forward( song.mix );
 
  int r = (int) random(0,f.size());  
  Poly p = f.get(r);
  
  p.setBrightness( fftLin.getAvg(0) * 100 );
  p.setHue( fftLin.getAvg(1) * 100 );
  p.setSaturation( fftLin.getAvg(2) * 100);
  
  for (Poly pp:f) pp.draw();
 
  if (doCrack) crack();
   
  gui.draw();    
    
}
 
public void keyPressed() {
//  if(!online && key=='s') doSave=true;
}
 
public void mousePressed() {
  if(!gui.isMouseOver()) crack();
}
