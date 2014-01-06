void setupSound(){
  minim = new Minim(this);
  song = minim.loadFile("track1.mp3", 1024);
  song.loop();
}
