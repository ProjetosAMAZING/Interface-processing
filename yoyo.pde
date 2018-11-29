import vsync.*;
import controlP5.*;
    import processing.serial.*;
ControlP5 cp5;

Slider velSlider;
Toggle sentToog;
Button sub,stp;
Label b;
    PFont f;                           // STEP 1 Declare PFont variable
  int i = 0;
  float theta = 0;
  float arcx;
  float arcy;
  float ax;
  float ay;
  int strk = 50;
  int strk2 = 10;
  float text ;
  

  float late;
  float lge;
  
//  Create a sender and a receiver for incoming and outgoing synchronization.
ValueReceiver receiver;
ValueSender sender;
public int velArd = 0;


public int sent =1;
public int vel=0;

public int lg;
public int lat;
 public int gpss;
void setup() {
  
  
    Serial serial = new Serial(this, "COM6", 115200);
  
  sender = new ValueSender(this, serial);
  receiver = new ValueReceiver(this,serial);
  //  Tell the ValueSender what variables to synchronize from the arduino to the Processing sketch.
  //  Be careful to always use the same order as on the other side!
  
   receiver.observe("velArd");
  sender.observe("vel");
  sender.observe("sent");
  receiver.observe("lat");
  receiver.observe("lg");   
   receiver.observe("gpss");
 
  
  
 size(1024,860);
 smooth();
   cp5 = new ControlP5(this);
   cp5.enableShortcuts();
   
   
    arcx = width*3/8 + width/4;
 arcy = height/2.5;
  ax = width*3/8;
 ay = ax;
  f = createFont("Arial",25,true); 
  fill(255);// STEP 2 Create Font
  
  
  
  

 velSlider=cp5.addSlider("Velocidade")
     .setPosition(25,150)
     .setSize(200,20)
     .setRange(0,200)
     .setValue(128)
     .setHeight(100)
     .setHandleSize(300)
     .setRange(0, 100) 
     .setSize(width/5,100)
     .setValue(0);
     ;
 cp5.getController("Velocidade").getCaptionLabel().hide();
     
    sub =cp5.addButton("Submit")
     .setValue(0)
     .setPosition(25,350)
     .setSize(200,50)
      .setFont(f)
      .activateBy(ControlP5.PRESSED)
     ;
     
   
     
   
  

     
   stp = cp5.addButton("STOP")
     .setValue(0)
     .setPosition(25,600)
     .setSize(200,50)
     .setColorValue(0)
      .setFont(f)
       .activateBy(ControlP5.PRESSED)
     ;
     
     
     
     
  sentToog=cp5.addToggle("SentidoToogle")
     .setPosition(150,302)
     .setSize(50,20)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     ;
     
      cp5.getController("SentidoToogle").getCaptionLabel().hide();
}

void draw() {
    
  noStroke();
  fill(8,11,23);
  rect(0,0,width/4,height);
  fill(14,29,42);
  rect(width/4,0,width,height);
 
strokeCap(SQUARE);

   stroke(26,128,224,20);
   strokeWeight(50); 
   arc(arcx, arcy, ax, ay, PI, PI +PI);
    stroke(26,128,224);
   arc(arcx, arcy, ax, ay, PI, PI +PI*velArd/100);

   
   textSize(100);
   textAlign(CENTER);
   fill(26,128,224);
   text(velArd,arcx,height/3);
   textSize(25);
   text("km/h",arcx,height/3+ 50);
  
    textSize(20);
    text("50",width*3/8 + width/4,height/2.5 - 30 -(width*3/8)/2);

   text(25,arcx+cos(3*PI/4)*(ax/2)-25,arcy- sin(3*PI/4)*ax/2 -20);
   text(75,arcx-cos(3*PI/4)*(ax/2)+20,arcy- sin(3*PI/4)*ax/2 -25);
   text("0",arcx-ax/2-35,arcy);
   text("100",arcx+ax/2+45,arcy);

 text("User configuration",100,60);
 text("SPEED",width/8,height/6.5);
 text("Sentido",80,320);
 
  noFill();
  strokeWeight(1);
  stroke(200);
  rect(475, 450, 350, 350, 5);

 float temp = lat;
 float temp2 = lg;
 late = (temp/255)*350;
 lge = (temp2/255)*350;
 
 
 println(late);
println(gpss);
 
 fill(150);
   strokeWeight(20);
 rect((475+int(late)),(450+int(lge)),1,1,10);
 
 
  
  
 
}
public void controlEvent(ControlEvent theEvent) {
  
  println(theEvent.getController().getName());

   if(theEvent.isFrom(sub))
    {
      vel = (int)velSlider.getValue();
      sent = (int) sentToog.getValue();

    }
     if(theEvent.isFrom(stp))
    {
       velSlider.setValue(0);
       sentToog.setState(true);
    }
}

void SentidoToogle(boolean theFlag) {
  
  println("a toggle event.");
}