class KuplaSysteemi {
  
  ArrayList<Kupla> kuplat;
  float cutoff;
  float lifespan = 50;
  float lifespanDec = 1;
  PVector location;
  
  KuplaSysteemi (float x_, float y_) {
    cutoff = Kupla.lifespanUB / Kupla.lifespanDec;
    location = new PVector (x_, y_);
    kuplat = new ArrayList<Kupla> ();
  }
  
  void addKupla () {
    kuplat.add (new Kupla (location));
  }
  
  boolean isDead () {
    if (lifespan < 0 && kuplat.size() == 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void update () {
    if (lifespan > 0) {
      addKupla ();
    }
    lifespan -= lifespanDec;
    Iterator<Kupla> kuplaIter = kuplat.iterator ();
    while (kuplaIter.hasNext ()) {
      Kupla kupla = kuplaIter.next ();
      kupla.update ();
      kupla.draw ();
      if (kupla.isDead ()) {
        kuplaIter.remove ();
      }
    }
  }
  
}
