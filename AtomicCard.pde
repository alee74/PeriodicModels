
class AtomicCard {
  
  private float x, y;
  private int atomicNumber;
  private float atomicMass;
  private String symbol;
  private String element;
  
  private PFont numberFont;
  private PFont symbolFont;
  private PFont elementFont;
  
  //private float xoff = 43;
  //private float yoff = 105;
  
  AtomicCard() {
    x = 50;
    y = 100;
    atomicNumber = -1;
    atomicMass = 0.000;
    symbol = "NULL";
    element = "no data";
    numberFont = createFont("Arial", 35);
    symbolFont = createFont("Arial Bold", 50);
    elementFont = createFont("Arial", 25);
  }
  
  AtomicCard(int an, String sym, String elem, float am) {
    this();
    //x = 50;
    //y = 100;
    atomicNumber = an;
    atomicMass = am;
    symbol = sym;
    element = elem;
    //numberFont = createFont("Arial", 35);
    //symbolFont = createFont("Arial Bold", 50);
    //elementFont = createFont("Arial", 25);
  }
  
  
  void display() {
    float widest = 0;
    fill(255);
    textAlign(CENTER);
    textFont(elementFont);
    widest = textWidth(""+atomicMass) > textWidth(element) ? 
             textWidth(""+atomicMass) : textWidth(element);
    text(atomicMass, -width/2-x, height/2+y);
    text(element, -width/2-x, height/2+y-35);
    textFont(symbolFont);
    widest = textWidth(symbol) > widest ? textWidth(symbol) : widest;
    text(symbol, -width/2-x, height/2+y-70);
    textFont(numberFont);
    widest = textWidth(""+atomicNumber) > widest ? textWidth(""+atomicNumber) : widest;
    println("widest = " + widest);
    text(atomicNumber, -width/2-x, height/2+y-120);
    stroke(255);
    strokeWeight(2.5);
    noFill();
    rect(-width/2-x-widest/2-7.5,height/2+y-155, widest+20,165);
  }
  
}
