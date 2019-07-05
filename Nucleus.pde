
class Nucleus {

  private ArrayList<Particle> particles;

  Nucleus(float r, int n) {
    particles = new ArrayList<Particle>();
    ArrayList<PVector> points = new ArrayList<PVector>();

    pushMatrix();
    resetMatrix();
    float y = -1;
    //PVector current = new PVector(0, -1, 0);
    for (int i = 0; i < n; ++i) {
      if (i != 0 && i % 2 == 0)
        rotateX(PI/i);
        //rotateX(PI/(3*i/2));
      if (i != 0 && i % 3 == 0)
        rotateZ(PI/i);

      points.add(new PVector(modelX(0, y, 0), 
                             modelY(0, y, 0), 
                             modelZ(0, y, 0)));
      y += 2;

      //points.add(new PVector(modelX(current.x, current.y, current.z), 
      //                       modelY(current.x, current.y, current.z), 
      //                       modelZ(current.x, current.y, current.z)));
      //current.y += 2;
    }
    popMatrix();



    // create particles
    int i = 0;
    float particleRadius = r / (greatestDistance(points) + 1);
    //println("greatestDistance = " + particleRadius);
    for (PVector p : points) {
      particles.add(new Particle(p.mult(particleRadius), 
        particleRadius, i % 2 == 0 ? protonColor : neutronColor));
      ++i;
    }
  }


  void display() {
    for (Particle p : particles)
      p.display();
  }


  // find and return greatest distance between points,
  // serves as scaling factor for radius of packed spheres
  private float greatestDistance(ArrayList<PVector> points) {
    float greatest = 0;
    for (PVector p1 : points) {
      for (PVector p2 : points) {
        if (p1 != p2) {
          float dist = (p1.x-p2.x)*(p1.x-p2.x) +
            (p1.y-p2.y)*(p1.y-p2.y) +
            (p1.z-p2.z)*(p1.z-p2.z);
          greatest = dist > greatest ? dist : greatest;
        }
      }
    }
    return sqrt(greatest);
  }
}


/* The beginning of pseudo code of A1*/
n ← the number of equal spheres;
r0 ← an empirically estimated value of container radius for n sphere;
r ← 0.5+10-8; /* The fake sphere trick. */
Generates one random initial configuration Xrandom of n spheres;
/* From a randomly generated configuration Xrandom, we get the first Xlocal. */ Xlocal ← A0(r,r0,Xrandom);
if (U(Xlocal,r,r0)<10-16) {
Xfound←Xlocal;
Goto Binary_Search; } /* A1 finds a packing.*/
l←0; /* Scan counter. */
while (l< 6) /* 6 is a manually predetermined upper limit of scan number. */ {
for i=1 to n {
for j=1 to i-1 {
Xnewlocal(ij) ← A0(r,r0, invert(maxU(j,minU(i,Xlocal)),Xlocal)) ; if (U(Xnewlocal(ij),r,r0)<10-16) {
Xfound←Xnewlocal(ij);
Goto Binary_Search; } /* A1 finds a packing. */ }
}
Xlocal←the one with the lowest potential energy among all Xnewlocal(ij); l←l+1;
} /* End of while*/
/* If A1 doesn’t directly find any packing, pick the best configuration ever found.*/ Xfound ← the local optimal configuration with the lowest potential energy ever found during all scans;
Binary_Search:
/* Use a binary search to find the smallest container in which Xfound can just be developed by A0 into a packing. */

r0low←1/2×r0;
r0up←2×r0;
ε←10-12; /* ε is a precision. */ X←Xfound;
while (r0up-r0low>ε)
{
r0←(r0up+r0low)/2; X ←A0(r, r0, X);
if (U(X,r,r0)<10-16)
r0up ←r0;
if (U(X,r,r0)≥10-16)
r0low ←r0; }
r0min←r0up;
/* r0min is the smallest container radius for Xfound to become a packing through A0.*/
Xdense ←A0(r, r0min, X);
/* Xdense is the corresponding dense packing of Xfound in the container of r0min.*/ /* The end of pseudo code of A1*/
