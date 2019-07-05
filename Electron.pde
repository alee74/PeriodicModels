
class Electron extends Particle {
  
  
  private int last = 0;
  private int level;
  private float orbitalRadius;
  private PVector orbitalAxis;
  private float orbitalVelocity = PI/150;
  
 
  Electron(PVector pos, float or, int lvl) {
    super(pos, 20, electronColor);
    orbitalRadius = or;
    level = lvl;
    orbitalVelocity = PI/175 * level;
    orbitalAxis = center.cross(new PVector(0,(center.x < 0 ? 1 : -1),0));
      //.cross(new PVector(random(15),0,0));
  }
  
  
  void display() {
    super.display();
    update();
  }
  
  // simulate orbit by rotating about an axis
  // through the origin and updating position :)
  void update() {
    pushMatrix();
    resetMatrix();
    rotateAroundAxis(orbitalAxis, orbitalVelocity);
    center = new PVector(modelX(center.x,center.y,center.z), 
                         modelY(center.x,center.y,center.z),
                         modelZ(center.x,center.y,center.z));
    popMatrix();
  }
  
  
}
