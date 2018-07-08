import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.serial.*;


    ArrayList<Block> liste = new ArrayList<Block>();
    Ball ball;
    Spieler spieler; 
    
    private double forcex = 3;
    private double forcey = 3;
    
    private int sensitivity = 15;
    
    //Hilfsvariable: Wenn sie gleich der Anzahl der Liste ist, dann gewonnen
    private int anzahlFalse = 0;
    
    private boolean gewonnen = false;
    private boolean verloren = false;
    private int leben = 3;
    
    PImage heart;
    
    //Ball Hit Sound
    Minim spielerSound;
    AudioPlayer player;
    
    //Lose Sound
    Minim loseSound;
    AudioPlayer loseSoundPlayer;
    
    //Win Sound
    Minim winSound;
    AudioPlayer winSoundPlayer;
    
    //Block Hit Sound
    Minim blockHitSound;
    AudioPlayer blockHitSoundPlayer;
    
    //Serial
    Serial myPort;
    PFont myFont;
    float val;
    int[] pin_val;
    int lf = 10;
    boolean received;
    float inByte = 0;
    
      
    public void settings(){
        size(700,700);
    }

    public void setup(){
      background(100, 100, 100);
        ball = new Ball(350, 590, 20, 20);
        spieler = new Spieler(300, 610, 100, 20);
            
        //Liste mit Bloecken fuellen
        for(int i = 0; i <= 4; i++) {
          for(int j = 0; j <= 9; j++) {
            liste.add(new Block((j * 70), (i * 24) , 70, 25));       
          }
        }  
        
        heart = loadImage("heart.png");
        
        //Ball Hit Sound
        spielerSound = new Minim (this);
        player = spielerSound.loadFile("hitWall.wav");
        
        //Lose Sound
        loseSound = new Minim (this);
        loseSoundPlayer = loseSound.loadFile("loseSound.wav");
        
        //Win Sound
        winSound = new Minim (this);
        winSoundPlayer = winSound.loadFile("winSound.wav");
        
        //Block Hit Sound
        blockHitSound = new Minim (this);
        blockHitSoundPlayer = blockHitSound.loadFile("blockHit.wav");
        
        //Serial
        myPort = new Serial (this, Serial.list()[2], 9600);
        pin_val = new int[0];
        val = 0;
        received = false;
        
    }

    public void keyPressed() {
      //Input AD
          if (key == 'a' || key == 'A') {
              spieler.setPosx(spieler.getPosx() - sensitivity);
            } else if (key == 'd' || key == 'D') {
              spieler.setPosx(spieler.getPosx() + sensitivity);
            }
        
      }
    
    public void draw(){         
      if (!gewonnen) {
        for(int i = 0; i <= liste.size() - 1; i++) {
          if((liste.get(i).getActive() == false) &&  (!liste.get(i).getSchonGezaehlt()) ){
            anzahlFalse++;
            liste.get(i).setSchonGezaehlt(true);
          }
        }
      }
      
      if(anzahlFalse == liste.size()) {
        gewonnen = true;
      }
      
      if(ball.getPosy() >= 610) {
        leben--;
        
        if(leben == 0) {
          verloren = true;  
        } else {
          //Zurücksetzen
            forcex = 3;
              forcey = 3;
              
              ball.setPosx((int) (350 - (1*forcex)));
                ball.setPosy((int) (590 - (1*forcey)));
                ellipse(ball.getPosx(), ball.getPosy(), ball.getRadius()*2, ball.getRadius()*2);
        }
      } else if(!gewonnen && !verloren) {       
        background(100, 100, 100);
        noStroke();
        
        //Spieler mit Poti bewegen
        spieler.setPosx((int) (inByte * 0.87));
        System.out.println(spieler.getPosx());
              
        //Score
        fill(255, 255, 255);
        textSize(24);
        text("Score: " + (anzahlFalse * 10), 20, 680); 
        
        //Wenn der Ball einen Block beruehrt active auf false setzen
          for(int i = 0; i <= liste.size() - 1; i++) {
            //Nur wenn Block active ist soll er damit colliden können
            if(liste.get(i).getActive()) {
              if(((ball.getPosx() - 10) >= (liste.get(i).getMittex() - 35)) 
                    && ((ball.getPosx() + 10) <= (liste.get(i).getMittex() + 35))
                    
                    && ((ball.getPosy() - 10) <= (liste.get(i).getMittey() + 13))) {
                  liste.get(i).setActive(false);
                  forcey = forcey * -1;
                  blockHitSoundPlayer.play(0);
                }
            }
            
          }
          
          //Wenn der Ball den Spieler berührt
          if( (ball.getPosy() >= 600)
              && (ball.getPosx() - 10) >= (spieler.getPosx())
              && (ball.getPosx() + 10) <= (spieler.getPosx() + 100) ) {
            forcey = forcey * -1;
            player.play(0);
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
            
            
            
            //Wenn der Ball die Raender beruehrt
            if(ball.getPosx() <= 10 || ball.getPosx() >= 690) {
              forcex = forcex * -1;
              player.play(0);
            }            
            if(ball.getPosy() <= 10 || ball.getPosy() >= 690) {
              forcey = forcey * -1;
               player.play(0);
            }
            
        //Leben
            switch (leben) {
              case 3:
                image(heart, 570, 650);
                image(heart, 610, 650);
                image(heart, 650, 650);
                break;
              case 2:
                image(heart, 610, 650);
                image(heart, 650, 650);
                break;
              case 1:
                image(heart, 650, 650);
                break;
              default:
                break;
      }       
        //Setzen des Balls
        ball.setPosx((int) (ball.getPosx() - (1*forcex)));
        ball.setPosy((int) (ball.getPosy() - (1*forcey)));
        
        fill(255, 0, 255);
        rect(spieler.getPosx(), spieler.getPosy(), spieler.getBreite(), spieler.getHoehe());
        fill(255, 255, 255);
        ellipse(ball.getPosx(), ball.getPosy(), ball.getRadius()*2, ball.getRadius()*2);
            
      } else if (gewonnen) {
        textSize(32);
        fill(0, 200, 100);
        text("Du hast gewonnen!", 210, 350); 
        winSoundPlayer.play();
      } else if (verloren) {
        //Das Leben löschen
        fill(100, 100, 100);
        rect(640, 640, 50, 50);
        
        textSize(32);
        fill(255, 0, 0);
        text("Du hast leider verloren!", 170, 350);
        loseSoundPlayer.play();
      }      
    }
    
  void serialEvent (Serial myPort) {
    String inString = myPort.readStringUntil('\n');
    
    if (inString!= null) {  
    // trim off any whitespace; 
    inString = trim(inString);
    //convert to an int and map to the screen height: 
    inByte = float(inString);
    //println(inByte);
    inByte = map(inByte, 0, 1023, 0, height);   
    }
  }    
