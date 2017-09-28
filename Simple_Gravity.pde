Background myBackground;
CentralBody myBody;
Object myObject;
Object Europa;
Object Callisto;
Object Ganymede;
float t, dt, scale, rBody, rObject, rEuropa, rCallisto, rGanymede;
float[] rx, ry;
int stars = 150;
float orbits, eorbits, corbits, gorbits = 0;
float lastY, elastY, clastY, glastY = 0;
boolean active = false;
PImage img;
PImage io;
float imgscale = 0.0347;
float ioscale = 1;
boolean showOrbits = true;
boolean showText = true;

void setup (){
   frameRate(60);
   size(1280, 685);  
   myBackground = new Background (800, 800);  
   scale = 6266666.66666667;    // ratio of m to px
   
   // This is the big object (planet or moon) assumed to be stationary
   float massBody = 1.898*pow(10,27);
   rBody = 6991100;
   myBody = new CentralBody (massBody, rBody, scale);  
 
  // This is the small object, often what is orbiting
  rObject = 1821300;   // in m 
  rEuropa = 3057753.6;
  rCallisto = 2410797.31;
  rGanymede = 2631277.44;
  float Vi = 17331.63;      // in m/s
  
  float degrees = 90;  // this is the initial angle that the object is moving; if it is moving UP, the angle = 90
  float Xi = 1200;      // in px, use scale to calculate!!
  float Yi = 350;
  
  myObject = new Object (rObject, myBody, scale);          // radius, myBody, initialScale 
  myObject.setInitialConditions (Vi, degrees, Xi-232.7074468085, Yi);       // Vi, degrees
  Europa = new Object (rObject, myBody, scale);          // radius, myBody, initialScale 
  Europa.setInitialConditions (13743.361, degrees, Xi-192.9414893617, Yi);
  Callisto = new Object (rObject, myBody, scale);          // radius, myBody, initialScale 
  Callisto.setInitialConditions (8202.78, degrees, Xi, Yi);
  Ganymede = new Object (rObject, myBody, scale);          // radius, myBody, initialScale 
  Ganymede.setInitialConditions (10879.167, degrees, Xi-129.2553191489, Yi);
     
  //initializes t, sets dt, and starts the object in motion 
  dt = 50;   // in s
  t = 0;        // in s

  rx = new float[stars];
  ry = new float[stars];
  
  for (int i = 0; i < stars; i++) {
    rx[i] = random(0, width);
    ry[i] = random(0, height);
  }
  img = loadImage("downloads/Jupiter.png");
  io = loadImage("downloads/Io.png");
}


void mouseClicked() {
  active = !active;
}

void keyPressed() {
  if (keyCode == SHIFT) {
    showOrbits = !showOrbits;
  }
  if (keyCode == ENTER) {
    showText = !showText;
  }
}

int s, m, h, d, mo, y, os, om, oh, od, omo, oy, monthfix, omonthfix, 
es, em, eh, ed, emo, ey, cs, cm, ch, cd, cmo, cy, gs, gm, gh, gd, gmo, gy;
int ot, ottotal, et, ettotal, ct, cttotal, gt, gttotal = 0;
void draw() {
  myBackground.display();
  for (int i = 0; i < stars; i++) {
    fill(random(240, 255), 240, random(240, 255));
    ellipse(rx[i], ry[i], 2, 2);
  }
  
  if (showOrbits) {
    stroke(255);
    noFill();
    ellipse(900, 350, 2*67.2925531915, 2*67.2925531915);
    ellipse(900, 350, 2*107.0585106383, 2*107.0585106383);
    ellipse(900, 350, 2*170.7446808511, 2*170.7446808511);
    ellipse(900, 350, 2*300, 2*300);
    noStroke();
  }
  
  myBody.display();
  fill(212,196,75);
  myObject.display();
  fill(212,102,28);
  Europa.display();
  fill(145,118,91);
  Callisto.display();
  fill(80,70,58);
  Ganymede.display();
  lastY = myObject.getY();
  elastY = Europa.getY();
  clastY = Callisto.getY();
  glastY = Ganymede.getY();
  
  if (active) { 
    myObject.moveObject(dt);
    Europa.moveObject(dt);
    Callisto.moveObject(dt);
    Ganymede.moveObject(dt);
    if ((sq(myObject.getXdisplay()-350)+sq(myObject.getYdisplay()-350))<sq((rBody+rObject)/scale)){
      dt = 0;
    }
    t = t + dt;
  }
  s = int(t%60);
  m = int(t/60)%60;
  h = int(t/3600)%24;
  d = int(t/86400)%30;
  mo = int((t-monthfix)/2592000)%12;
  y = int(t/31536000);
  if(t%31536000 == 0) {
    monthfix += 5;
  }
  
  fill(229);
  textSize(12);
  textAlign(LEFT);
  
  if (showText) {
    text("Time (y/mo/d/h/m/s): " + y + " Earth years, " + mo + " months, " + d + " Earth days, " + h + " hours, " + m + " minutes, " + s + " seconds", 8, 20); 
    text("Time (s): " + int(t) + " seconds", 8, 40);
    text("Io, Number of Orbits: " + int(orbits), 8, 60);
    text("Io, Last Orbital Period: " + oy + " Earth years, " + omo + " months, " + od + " Earth days, " + oh + " hours, " + om + " minutes, " + os + " seconds", 8, 80); 
    text("Europa, Number of Orbits: " + int(eorbits), 8, 100);
    text("Europa, Last Orbital Period: " + ey + " Earth years, " + emo + " months, " + ed + " Earth days, " + eh + " hours, " + em + " minutes, " + es + " seconds", 8, 120);
    text("Callisto, Number of Orbits: " + int(corbits), 8, 140);
    text("Callisto, Last Orbital Period: " + cy + " Earth years, " + cmo + " months, " + cd + " Earth days, " + ch + " hours, " + cm + " minutes, " + cs + " seconds", 8, 160);
    text("Ganymede, Number of Orbits: " + int(gorbits), 8, 180);
    text("Ganymede, Last Orbital Period: " + gy + " Earth years, " + gmo + " months, " + gd + " Earth days, " + gh + " hours, " + gm + " minutes, " + gs + " seconds", 8, 200);
    text("Scale: 1 Pixel = " + String.format("%6.3e", scale) + " m", 8, 675);
  }
 
  textAlign(CENTER);
  text("Jupiter", myBody.getXcenter(), myBody.getYcenter() - 40);
  text("Io", myObject.getXdisplay(), myObject.getYdisplay() - 20);
  text("Europa", Europa.getXdisplay(), Europa.getYdisplay() - 20);
  text("Callisto", Callisto.getXdisplay(), Callisto.getYdisplay() - 20);
  text("Ganymede", Ganymede.getXdisplay(), Ganymede.getYdisplay() - 20);
  
  if (myObject.getY() <= 350 && lastY >= 350) { // will refine later but for now this is fine
    orbits += 1;
    ot = int(t) - ottotal;
    ottotal = int(t);
  }
  if(ot%31536000 == 0) {
    omonthfix += 5;
  }
  os = int(ot%60);
  om = int(ot/60)%60;
  oh = int(ot/3600)%24;
  od = int(ot/86400)%30;
  omo = int((ot-omonthfix)/2592000)%12;
  oy = int(ot/31536000);
  
  if (Europa.getY() <= 350 && elastY >= 350) { 
    eorbits += 1;
    et = int(t) - ettotal;
    ettotal = int(t);
  }
  if(et%31536000 == 0) {
    omonthfix += 5;
  }
  es = int(et%60);
  em = int(et/60)%60;
  eh = int(et/3600)%24;
  ed = int(et/86400)%30;
  emo = int((et-omonthfix)/2592000)%12;
  ey = int(et/31536000);
  
  if (Callisto.getY() <= 350 && clastY >= 350) { 
    corbits += 1;
    ct = int(t) - cttotal;
    cttotal = int(t);
  }
  if(et%31536000 == 0) {
    omonthfix += 5;
  }
  cs = int(ct%60);
  cm = int(ct/60)%60;
  ch = int(ct/3600)%24;
  cd = int(ct/86400)%30;
  cmo = int((ct-omonthfix)/2592000)%12;
  cy = int(ct/31536000);
  
  if (Ganymede.getY() <= 350 && glastY >= 350) { 
    gorbits += 1;
    gt = int(t) - gttotal;
    gttotal = int(t);
  }
  if(et%31536000 == 0) {
    omonthfix += 5;
  }
  gs = int(gt%60);
  gm = int(gt/60)%60;
  gh = int(gt/3600)%24;
  gd = int(gt/86400)%30;
  gmo = int((gt-omonthfix)/2592000)%12;
  gy = int(gt/31536000);
  
  image(img, 878, 328.5, img.width*imgscale, img.height*imgscale);
}