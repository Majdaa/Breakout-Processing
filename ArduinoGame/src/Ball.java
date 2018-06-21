
public class Ball {

	private int posx;
	private int posy;
	private int breite;
	private int hoehe;
	
	private int mittex;
	private int mittey;
	
	public Ball(int posx, int posy, int breite, int hoehe) {
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
	
	public void setPosx(int posx) {
		this.posx = posx;
	}	
	public void setPosy(int posy) {
		this.posy = posy;
	}
	
	public int getMittex() {
		return this.mittex;
	}
	public int getMittey() {
		return this.mittey;
	}
	
	public int getRadius() {
		return this.breite/2;
	}
}
