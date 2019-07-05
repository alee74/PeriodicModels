
class ElectronCloud {
  
  private float orbitScalar = 0.85;
  private ArrayList<Electron> electrons;
  private int[] perLevel = { 2, 8, 18, 32, 50, 200 };
  
  ElectronCloud(int n, float r) {
    println("ElectronCloud(" + n + ", " + r + ");");
    int i = 0;
    int temp = 0;
    while (n > temp)
      temp += perLevel[i++];
    electrons = new ArrayList<Electron>();
    pushMatrix();
    for (int l = 1; l <= i; ++l) {
      float orbit = r * pow(orbitScalar, i-l);
      float theta = TWO_PI / (n < perLevel[l-1] ? n : perLevel[l-1]);
      for (int k = 0; k < perLevel[l-1]; ++k) {
        pushMatrix();
        rotateX(PI/k+1);
        PVector p = new PVector(modelX(orbit,0,0),modelY(orbit,0,0),modelZ(orbit,0,0));
        electrons.add(new Electron(p,orbit,l));
        popMatrix();
        rotateY(theta);
        --n;
      }
      //rotateX(PI/i);
    }
    popMatrix();
  }
  
  void display() {
    for (Electron e : electrons)
      e.display();
  }
  
}
