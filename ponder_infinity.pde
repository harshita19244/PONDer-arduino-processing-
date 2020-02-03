//Code References
//http://www.science.smith.edu/dftwiki/index.php/Processing_Tutorial_--_Showing_Animated_Gifs
//https://www.toptal.com/game/ultimate-guide-to-processing-simple-game
//https://www.instructables.com/id/Beginning-Processing-the-Temperature-Visualizer/
import processing.serial.*;
int page = 0;
int k;
Serial myPort;
PFont font;
Dial tempDial;
Dial phDial;
Dial xDial;
Molecules m;
String data;

//generating an array of molecules
int numMolecules = 300;
Molecules [] molecules = new Molecules[numMolecules];

//sensor values
int temp = 0;
int ph = 0;
int x = 0;

void setup()
{
  size(1900,980);
  String portname = Serial.list()[0];
   myPort = new Serial(this, portname, 9600);
   myPort.bufferUntil('\n');
  font = loadFont("HPSimplified-Bold-55.vlw");
  textFont(font);
  tempDial = new Dial(700,350,300,50,"              Temperature");
  phDial = new Dial(850,650,300,14,"             PH");
  xDial = new Dial(1050, 350, 300, 1023,"             Turbidity");
  
  for(int i=0;i<numMolecules;i++){
    molecules[i] = new Molecules(30);
  }
}

void draw()
{
  if (page == 0)
  {
    homePage(); }
  else if (page == 1)
  {
    dataPage(); }
  else if (page == 2)
  {
    pHremedyPage(); }
  else if (page == 3)
  {
    tempremedyPage(); }
  else if (page == 4)
  {
    turbidityremedyPage(); }
  else if (page == 5)
  {
    goPage(); }
 
}
  
void homePage()
{
  background(#2DABED);
  textAlign(CENTER);
  textSize(95);
  PFont mono;
  mono = loadFont("Constantia-Bold-100.vlw");
  textFont(mono);
  text("PONDer",950,250);
  text("-------------",950,290);
  textSize(45);
  text("Status",950,700);
  PImage img;
  img = loadImage("star.png");
  image(img,1650,50);
  PImage img1;
  img1 = loadImage("fish_cut.png");
  image(img1,0,600);
  PImage img2;
  img2 = loadImage("whale2.png");
  image(img2,1000,700);
  PImage img3;
  img3 = loadImage("bubble.png");
  image(img3,1450,650);
  image(img3,100,500);
  image(img3,950,300);
  image(img3,500,150);
  image(img3,1200,0);
  PImage img4;
  img4 = loadImage("jellyf.png");
  image(img4,500,200);
  PImage img5;
  img5 = loadImage("seahor.png");
  image(img5,1000,300);
  PImage img6;
  img6 = loadImage("whale3.png");
  image(img6,0,0);
  PImage img7;
  img7 = loadImage("plant1.png");
  image(img7,1650,650);
  image(img7,550,650);
  PImage img8;
  img8 = loadImage("cluster.png");
  image(img8,1300,300);
}

public void mousePressedForPage1()
{if (dist(mouseX, mouseY, 950, 700) < 100 )
{
 page = 1;
}
}

public void mousePressedForPage()
{
if (dist(mouseX, mouseY, 1600, 800) < 50)
{
 page = 5;
}
}

public void secretmousePress()
{
  if (dist(mouseX, mouseY, 0, 0) < 20)
{
 page = 0;
}
}

public void mousePressedph()
{if (dist(mouseX, mouseY, 850, 850) < 50)
{
 page = 2;
}
}

public void mousePressedtemp()
{if (dist(mouseX, mouseY, 300, 300) < 50)
{
 page = 3;
}
}

public void mousePressedturbidity()
{if (dist(mouseX, mouseY, 1400, 300) < 50)
{
 page = 4;
}
}

public void mousePressedOnPage2()
{if (dist(mouseX, mouseY, 1700, 950) < 80)
{
 page = 5;
}
}

public void mousePressedForBack()
{if (dist(mouseX, mouseY, 1600, 900) < 80)
{
 page = 1;
}
}

public void mousePressedForBackph()
{if (dist(mouseX, mouseY, 700, 950) < 100)
{
 page = 1;
}
}

public void mousePressed()
{

  switch (page) {
    case 0:
      mousePressedForPage1();
      break;
     
    case 1:
      mousePressedForPage();
      secretmousePress();
      break;
      
    case 2:
      mousePressedOnPage2();
      mousePressedForBackph();
      break;
      
    case 3:
      mousePressedOnPage2();
      mousePressedForBackph();
      break;
      
    case 4:
      mousePressedOnPage2();
      mousePressedForBackph();
      break;
      
   case 5:
     mousePressedForBack();
     break;
          
}
}

void animate()
{
 
 PImage[] fish = new PImage[8];
 smooth();
 
 fish[0] = loadImage( "0.gif" );
 fish[1] = loadImage( "1.gif" );
 fish[2] = loadImage( "2.gif" );
 fish[3] = loadImage( "3.gif" );
 fish[4] = loadImage( "4.gif" );
 fish[5] = loadImage( "5.gif" );
 frameRate(10);
 
 image( fish[frameCount%6],-100,0 );
}
void serialEvent(Serial myPort){
  //read the serial buffer
  String myString = myPort.readStringUntil('\n');
  //if(myString!= null){
  //myString = trim(myString);
  int sensors[] = int(split(myString,':'));
  //for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++){
  //  print("Sensor" + sensorNum + ":" + sensors[sensorNum] + "\t");
  //}
  print(myString);
  //print(sensors);
  if(sensors.length>1){
    temp = sensors[1];
    ph = sensors[0];
    x = sensors[2];
  }
  
}

void dataPage()
{
   background(255);
  for(int i=0;i<molecules.length;i++){
    molecules[i].setSensorValue(temp,ph,x);
    molecules[i].display();
    molecules[i].move();
   }
   
   tempDial.displayDial();
   tempDial.setSensorValue(temp);
   phDial.displayDial();
   phDial.setSensorValue(ph);
   xDial.displayDial();
   xDial.setSensorValue(x);
   font = loadFont("HPSimplified-Bold-36.vlw");
  textFont(font);
  if (ph < 6 || ph > 8){
 text("pH CRITICAL!",850,850);
  mousePressedph();
 }
 if (temp < 10 || temp > 36){
 text("TEMPERATURE CRITICAL!",300,300);
 mousePressedtemp();}
 if (x < 700 || x >800){
 text("TURBIDITY CRITICAL!",1400,300);
 mousePressedturbidity();}  
 if ((temp>10 && temp < 36) && (x >700 && x<800) && (ph >6 && ph<8))
 {
   text("All's Well. Go ahead!",1600,900);
 }
 text("Next",1600,800);
}

void remedyPage1()
{
  background(#1987FA);
  textAlign(CENTER);
  PFont mono;
  mono = loadFont("Constantia-Bold-48.vlw");
  textSize(55);
  textFont(mono);
  fill(#BEF3F7);
  text("REMEDIES : pH",1200,150);
  PImage pH;
  pH = loadImage("phval.PNG");
  image(pH,1000,250);
  animate();
}

void pHremedyPage()
{
  background(#1987FA);
  textAlign(CENTER);
  PFont mono;
  mono = loadFont("Constantia-Bold-48.vlw");
  textSize(55);
  textFont(mono);
  fill(#BEF3F7);
  text("REMEDIES : pH",1200,150);
  PImage pH;
  pH = loadImage("phval2.PNG");
  image(pH,1000,250);
  animate();
  text("Next",1700,950);
  text("Back To Status",700,950);
}

void tempremedyPage()
{
  background(#1987FA);
  textAlign(CENTER);
  PFont mono;
  mono = loadFont("Constantia-Bold-48.vlw");
  textSize(55);
  textFont(mono);
  fill(#BEF3F7);
  text("REMEDIES : Temperature",1200,150);
  PImage t;
  t = loadImage("temp3.PNG");
  image(t,900,350);
  animate();
  text("Next",1700,950);
  text("Back To Status",700,950);
}

void turbidityremedyPage()
{
  background(#1987FA);
  textAlign(CENTER);
  PFont mono;
  mono = loadFont("Constantia-Bold-48.vlw");
  textSize(55);
  textFont(mono);
  fill(#BEF3F7);
  text("REMEDIES : Turbidity",1200,150);
  PImage t;
  t = loadImage("turbidity.PNG");
  image(t,900,250);
  animate();
  text("Next",1700,950);
  text("Back To Status",700,950);
}

void goPage()
{
  background(#5AB4CB);
  PFont mono;
  mono = loadFont("SegoeScript-Bold-69.vlw");
  PImage img;
  img = loadImage("pond_pat.jpg");
  image(img,100,100);
  textFont(mono);
  text("HAPPY PONDerING!",1400,250);
  fill(#FFFFFF);
  PFont cambria;
  cambria = loadFont("Constantia-Bold-48.vlw");
  textFont(cambria);
  textSize(35);
  text("All Okay! Pick your fish:",1200,400);
  text("Back To Status",1600,900);
  PFont monosp;
  monosp = loadFont("Monospaced.bold-25.vlw");
  textFont(monosp);
  text("Catla catla",1200,550);
  text("Labeo rohita" , 1300, 600);
  text("Cirrhinus cirrhosis" , 1400 , 650);
  text("Lates calcarifer" , 1200 , 700);
  text("Etroplus suratensis" , 1300 , 750);
  
}
