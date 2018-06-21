import java.util.ArrayList;

import processing.core.PApplet;

public class UsingProcessing extends PApplet{

    public static void main(String[] args) {
        PApplet.main("UsingProcessing");
    }

    ArrayList<Block> liste = new ArrayList<Block>();
    Ball ball;
    Spieler spieler; 
    
    private double forcex = 3;
    private double forcey = 3;
    
    //private int
    public void settings(){
        size(700,700);
    }

    public void setup(){
    	background(100, 100, 100);
        ball = new Ball(350, 590, 20, 20);
        spieler = new Spieler(300, 610, 100, 20);
        		
        for(int i = 0; i <= 4; i++) {
        	for(int j = 0; j <= 9; j++) {
        		liste.add(new Block((j * 70), (i * 24) , 70, 25));
        		
        	}
        }	

    }

    
    public void draw(){		 	
    	background(100, 100, 100);
    	
    	//Wenn der Ball einen Block beruehrt active auf false setzen
    	for(int i = 0; i <= liste.size() - 1; i++) {
    		//Nur wenn Block active ist soll er damit colliden können
    		if(liste.get(i).getActive()) {
    			if(((ball.getPosx() - 10) >= (liste.get(i).getMittex() - 35)) 
        				&& ((ball.getPosx() + 10) <= (liste.get(i).getMittex() + 35))
        				
        				&& ((ball.getPosy() - 10) <= (liste.get(i).getMittey() + 13))) {
        			liste.get(i).setActive(false);
        			forcey = forcey * -1;
        		}
    		}
    		
    	}
    	
    	//Wenn der Ball den Spieler berührt
    	if( (ball.getPosy() >= 600)
    			&& (ball.getMittex() - 10) <= (spieler.getPosx())
    			&& (ball.getMittex() + 10) >= (spieler.getPosx() + 100) ) {
    		forcey = forcey * -1;
    	}
    	
    	//Zeichnen der Bloecke
        for(int i = 0; i <= liste.size() - 1; i++) {
        	if(i < 10) {
        		fill(100, 255, 100);
        	} else if (i < 20) {
        		fill(0, 255, 255);
        	} else if (i < 30) {
        		fill(255, 100, 255);
        	} else if (i < 40) {
        		fill(255, 255, 100);
        	} else if (i < 50) {
        		fill(255, 0, 0);
        	}
        	if(liste.get(i).getActive()) {
        		stroke(100,100,100);
        		rect(liste.get(i).getPosx(), liste.get(i).getPosy(), 70, 25);
        	} else {
        		fill(100, 100, 100);
        		noStroke();
        		rect(liste.get(i).getPosx(), liste.get(i).getPosy(), 70, 25);
        	}	
        }
        
        fill(255, 255, 255);
        noStroke();
        
        ball.setPosx((int) (ball.getPosx() - (1*forcex)));
        ball.setPosy((int) (ball.getPosy() - (1*forcey)));
        
        if(ball.getPosx() <= 10 || ball.getPosx() >= 690) {
        	forcex = forcex * -1;
        }
        
        if(ball.getPosy() <= 10 || ball.getPosy() >= 690) {
        	forcey = forcey * -1;
        }
        
        rect(spieler.getPosx(), spieler.getPosy(), spieler.getBreite(), spieler.getHoehe());
        
        ellipse(ball.getPosx(), ball.getPosy(), ball.getRadius()*2, ball.getRadius()*2);
        
        
    }
}