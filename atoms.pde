
PVector x = new PVector(0, 0, 1);
PVector y = new PVector(0, 1, 0);
PVector z = new PVector(1, 0, 0);
PVector camera;

Table periodic;
float atomRadius = 450;
int atomicNumber = 1;
int maxAtomicNumber = 118;

color electronColor = color(12, 191, 29);
color protonColor = color(245, 214, 67);
color neutronColor = color(128, 128, 128);

Atom atom;
Atom[] elements;


void setup() {
  size(1000, 1000, P3D);
  camera = new PVector(500,500, 500);

  periodic = loadTable("periodic_table.csv", "header, csv");
  elements = new Atom[maxAtomicNumber];
  for (int i = 1; i <= maxAtomicNumber; ++i) {
    elements[i-1] = new Atom(i, atomRadius);
  }

  //atom = new Atom(atomicNumber, atomRadius);

  translate(width/2, height/2, -200);
  pushMatrix();
}


void draw() {
  popMatrix();
  background(0);
  lights();
  atom = elements[atomicNumber];

  
  // rotations
  if (mousePressed) {
    PVector axis;
    // about arbitrary axes
    if (mouseButton == LEFT) {
      // "project" mouse point into 3d
      PVector point = new PVector(mouseX-width/2, mouseY-height/2, 0);
      //point.z = sqrt(atomRadius*atomRadius - point.x*point.x - point.y*point.y);
      //float originDist = sqrt(point.x*point.x + point.y*point.y);
      //if (originDist > atomRadius)
        //point.z *= -1;
      // get vector with respect to model
      PVector modelPoint = new PVector(modelX(point.x,point.y,point.z),
                                       modelY(point.x,point.y,point.z),
                                       modelZ(point.x,point.y,point.z));
      PVector dir = new PVector(mouseX-pmouseX, mouseY-pmouseY, 0);
      axis = modelPoint.cross(point);
      //rotateAroundAxis(axis, map(sqrt(dir.x*dir.x+dir.y*dir.y), -width/2,width/2, -PI,PI));
    // roll - rotate about casmera axis
    } else if (mouseButton == RIGHT) {
      pushMatrix();
      //resetMatrix();
      //PVector cam = new PVector(width/2, height/2, height/(2*tan(PI/6)));
      PVector cam = new PVector(0,0,1);
      axis = new PVector(modelX(cam.x,cam.y,cam.z), 
                         modelY(cam.x,cam.y,cam.z),
                         modelZ(cam.x,cam.y,cam.z));
      
      popMatrix();
      //println("rotating around axis: " + axis);
      //rotateAroundAxis(axis, map(mouseX-pmouseX, -width/2, width/2, -PI, PI));
      //popMatrix();
    }
  }

  atom.display();
  
  x = new PVector(modelX(1,0,0),modelY(1,0,0),modelZ(1,0,0));
  y = new PVector(modelX(0,1,0),modelY(0,1,0),modelZ(0,1,0));
  z = new PVector(modelX(0,0,1),modelY(0,0,1),modelZ(0,0,1));

  pushMatrix();
}


//void mouseDragged() {
//  PVector axis;
//  // about arbitrary axes
//  if (mouseButton == LEFT) {
//    //PVector point = new PVector(mouseX-width/2, mouseY-height/2, 0);
//    //point.z = sqrt(atomRadius*atomRadius - point.x*point.x - point.y*point.y);
//    //float originDist = sqrt(point.x*point.x + point.y*point.y);
//    //if (originDist > atomRadius)
//    //  point.z *= -1;
//    //PVector modelPoint = new PVector(modelX(point.x,point.y,point.z),
//    //                                 modelY(point.x,point.y,point.z),
//    //                                 modelZ(point.x,point.y,point.z));
//  } else if (mouseButton == RIGHT) {
//    pushMatrix();
//    resetMatrix();
//    //PVector cam = new PVector(width/2,height/2,height/(2*tan(PI/6)));
//    PVector cam = new PVector(0,0,1);
//    //axis = new PVector(modelX(cam.x,cam.y,cam.z),
//    //                   modelY(cam.x,cam.y,cam.z),
//    //                   modelZ(cam.x,cam.y,cam.z));
//    //println("rotating around axis: " + axis);
//    rotateAroundAxis(cam, map(mouseX-pmouseX, -width/2,width/2, -PI,PI));
//    popMatrix();
//  }
//}


void keyPressed() {
  if ((keyCode == UP || keyCode == RIGHT) && atomicNumber < maxAtomicNumber)
    ++atomicNumber;
    //atom = new Atom(++atomicNumber, atomRadius);
  if ((keyCode == DOWN || keyCode == LEFT) && atomicNumber > 1)
    --atomicNumber;
    //atom = new Atom(--atomicNumber, atomRadius);
}


//PVector 


void rotateAroundAxis(PVector axis, float theta) {
  PVector w = axis.copy();
  w.normalize();
  PVector t = w.copy();
  if (abs(w.x) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.x = 1;
  } else if (abs(w.y) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.y = 1;
  } else if (abs(w.z) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.z = 1;
  }
  PVector u = w.cross(t);
  u.normalize();
  PVector v = w.cross(u);
  applyMatrix(u.x, v.x, w.x, 0, 
    u.y, v.y, w.y, 0, 
    u.z, v.z, w.z, 0, 
    0.0, 0.0, 0.0, 1);
  rotateZ(theta);
  applyMatrix(u.x, u.y, u.z, 0, 
    v.x, v.y, v.z, 0, 
    w.x, w.y, w.z, 0, 
    0.0, 0.0, 0.0, 1);
}
