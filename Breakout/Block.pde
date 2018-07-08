class Block {

  private int posx;
  private int posy;
  private int breite;
  private int hoehe;
  
  private int mittex;
  private int mittey;
  
  private boolean active = true;
  
  //Um nicht zwei mal den Block in der Variable zu zÃ¤hlen, falls er deaktiviert ist
  private boolean schonGezeahlt = false;
  public Block(int posx, int posy, int breite, int hoehe) {
    this.posx = posx;
    this.posy = posy;
    
    this.breite = breite;
    this.hoehe = hoehe;
    this.mittex = this.posx + (breite/2);
    this.mittey = this.posy + (hoehe/2);
  }
  
  public int getPosx() {
    return this.posx;
  }  
  public int getPosy() {
    return this.posy;
  }
  
  public int getMittex() {
    return this.mittex;
  }
  public int getMittey() {
    return this.mittey;
  }
  
  public void setActive(boolean active) {
    this.active = active;
  }  
  public boolean getActive() {
    return this.active;
  }
  
  public void setSchonGezaehlt(boolean schonGezeahlt) {
    this.schonGezeahlt = schonGezeahlt;
  }  
  public boolean getSchonGezaehlt() {
    return this.schonGezeahlt;
  }
}
