
class Atom {
  
  private boolean empty = false;
  private Nucleus nucleus;
  private ElectronCloud cloud;
  private AtomicCard card;
  
  Atom(int atomicNumber, float r) {
    TableRow atom = periodic.findRow(""+atomicNumber, "atomic_number");
    if (atom != null) {
      cloud = new ElectronCloud(atomicNumber, r);
      nucleus = new Nucleus(r*0.7, atomicNumber*2);
      card = new AtomicCard(atomicNumber, atom.getString("symbol"), 
            atom.getString("name"), atom.getFloat("atomic_weight"));
    } else {
      empty = true;
      card = new AtomicCard();
    }
  }
  
  
  void display() {
    if (!empty) {
      nucleus.display();
      cloud.display();
    }
    card.display();
  }
  
}
