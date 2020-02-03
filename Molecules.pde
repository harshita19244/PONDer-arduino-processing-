class Molecules{
  float x;
  float y;
  float tempValue;
  float phValue;
  float xValue;
  color c;
  float d;
  
  //constructor
  Molecules(float d) {
    this.x = random(width);
    this.y = random(height);
    this. c = color(0,0,255,60);
    this.d = d;
  }
  
  //methods
  
  void setSensorValue(float tempValue, float phValue, float xValue){
    this.tempValue = tempValue;
    this.phValue = phValue;
    this.xValue = xValue;
  }
  
  
  void display(){
    float mappedColor = map(this.phValue,0,90,0,255);//color change with change in humidity
    this.c = color(mappedColor,0,255,60);
    noStroke();
    fill(c);
    ellipse(this.x, this.y, this.d, this.d);
  }
  
  void move(){
    float intensity = map(this.tempValue,0,50,1,15);
    this.x = this.x + random(-intensity,intensity);
    this.y = this.y + random(-intensity,intensity);
    
    this.x = constrain(this.x,0,width+10);
    this.y = constrain(this.y,0,height+10);
  }
}
