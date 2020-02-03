class Dial {
  //instance variables
  int x;
  int y;
  int d;
  float sensorValue;
  float threshold;
  String text;
  
  //the constructor
  Dial(int x, int y, int d,float threshold, String text){
    this.x = x;
    this.y = y;
    this.d = d;
    this.threshold = threshold;
    this.text = text;
  }
  
  //methods
  
  void setSensorValue(float sensorValue){
     this.sensorValue = sensorValue;    
  }
  
  void displayDial(){
    //drawing an arc
    stroke(147);
    strokeWeight(3);
    fill(255,255,255,0);//set opacity to zero
    arc(this.x, this.y, this.d, this.d, 0, radians(360));
    
    float mappedSensorValue = map(sensorValue, 0, threshold, 0, radians(360));
    
    if(this.sensorValue>=0 && this.sensorValue<(this.threshold*0.33)){
    stroke(#8BFA67);//green
      }
    else if(this.sensorValue>=(this.threshold*0.33) && this.sensorValue<(0.67 * this.threshold)){
    stroke(#F1FF36);//yellow
      }
    else{
    stroke(#FF5A40);//red
      }
      
    strokeWeight(10);
    arc(this.x,this.y,this.d,this.d,0,mappedSensorValue);
  
    fill(100);
    textSize(27);
    text(int(sensorValue),x-11,y-10);
    textSize(19);
    text(text,x-49,y+25);
    
  }
}
