
// Particle super class for Electrons and Composite (Proton/Neutron) particles

class Particle {
  
  protected PVector center;
  protected float radius = 10;
  protected color particleColor;
  
  private PShader shade;
  
  
  Particle(PVector pos, float r, color c) {
    center = pos;
    radius = r;
    particleColor = c;
    shade = loadShader("particlefrag.glsl","particlevert.glsl");
    shade.set("weight", radius*2);
    
    //if (c == protonColor || c == neutronColor) {
    //  println("nucleus particle at: " + center);
    //  println("   radius: " + r);
    //}
  }
    
  
  void display() {
    shader(shade,POINTS);
    strokeWeight(radius*2);
    stroke(particleColor);
    point(center.x, center.y, center.z);
  }
  
  
  // getters
  PVector center() { return center; }
  float radius() { return radius; }
  color particleColor() { return particleColor; }
  
  // setters
  void setCenter(PVector c) { center = c; }
  void setRadius(float r) { radius = r; }
  void setColor(color pc) { particleColor = pc; }
  
  
}
