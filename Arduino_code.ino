//Credits -
//ph code-https://wiki.dfrobot.com/PH_meter_SKU__SEN0161_
//temp probe code- https://create.arduino.cc/projecthub/iotboys/how-to-use-ds18b20-water-proof-temperature-sensor-2adecc
//turbidity sensor code - https://wiki.dfrobot.com/Turbidity_sensor_SKU__SEN0189

#define SensorPin A1            //pH meter Analog output to Arduino Analog Input 0
#define Offset 0.00            //deviation compensate
#define LED 13
#define samplingInterval 20
#define printInterval 800
#define ArrayLenth  40    //times of collection
int pHArray[ArrayLenth];   //Store the average value of the sensor feedback
int pHArrayIndex=0;
int led1 = 7;
int led2 = 10;
int led3 = 9;
//int led4 = A3;
//temp sensor
#include <OneWire.h>
#include <DallasTemperature.h>
#define ONE_WIRE_BUS 8

OneWire oneWire(ONE_WIRE_BUS);

DallasTemperature sensors(&oneWire);
float Celcius=0;
//LED display
#include <LiquidCrystal.h> 
int Contrast=120;
 LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
 
void setup(void)
{
  pinMode(LED,OUTPUT);
  Serial.begin(9600);
//  Serial.println("pH meter experiment!");    //Test the serial monitor
  pinMode (led1, OUTPUT);
  pinMode (led2, OUTPUT);
  pinMode (led3, OUTPUT);
//  temp sensor
  sensors.begin();
  pinMode(8, OUTPUT);
  analogWrite(8, 0);
//  Led display
{
    analogWrite(6,Contrast);
     lcd.begin(16, 2);
  }
  {
   lcd.setCursor(0, 0);
   lcd.print("PONDer Welcomes");
   lcd.setCursor(0, 1);
   lcd.print("You");
  }
  delay(2000);
  lcd.clear();
//  digitalWrite(led4, HIGH);
}
void loop(void)
{
  static unsigned long samplingTime = millis();
  static unsigned long printTime = millis();
// static unsigned long printTime = 0;
  static float pHValue,voltage;
  if(millis()-samplingTime > samplingInterval)
  {
      pHArray[pHArrayIndex++]=analogRead(SensorPin);
      if(pHArrayIndex==ArrayLenth)pHArrayIndex=0;
      voltage = avergearray(pHArray, ArrayLenth)*5.0/1024;
      pHValue = 3.5*voltage+Offset;
      samplingTime=millis();
  }
  if(millis() - printTime > printInterval)   //Every 800 milliseconds, print a numerical, convert the state of the LED indicator
  {
//    Serial.print("Voltage:");
//        Serial.print(voltage,2);
//        Serial.print("    pH value: ");
    Serial.print(pHValue,0);
    Serial.print(":");
//    delay(500);
//        digitalWrite(LED,digitalRead(LED)^1);
//        printTime=millis();
          printTime = 100; 
  }
  if ((pHValue >6.0) && (pHValue < 9.0)){
    digitalWrite(led1, HIGH); 
  } else{
   digitalWrite(led1,LOW);  
  }
//  temp sensor
  sensors.requestTemperatures(); 
  Celcius=sensors.getTempCByIndex(0);
  
//  Serial.print(" C  ");
  Serial.print(Celcius, 0);
  Serial.print(":");
//  delay(800);
  if ((Celcius> 10) && (Celcius<36)){
    digitalWrite(led2, HIGH);
  } else{
    digitalWrite(led2, LOW);
  }
//  turbidity sensor
  int sensorValue = analogRead(A2);// read the input on analog pin 0:
  float voltage2 = sensorValue * (5.0 / 1024.0); // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V):
//  Serial.print("Turbidity");
  float val = map(voltage2, 0,5,3000,0);
  float cm_data = map(val, 0,3000,150,0);
  float val2 = map(sensorValue, 600, 800, 0,10);
//  Serial.print(voltage2);
//  Serial.print(val2);
//  Serial.print(cm_data, 0); 
  Serial.print(sensorValue); // print out the value you read:
  Serial.println(":");
//  delay(800);
  if ((sensorValue > 700) && (sensorValue<800)){
    digitalWrite(led3, HIGH); 
  } else {
    digitalWrite(led3, LOW);
  }
  if (((pHValue >6) && (pHValue < 9)) && ((Celcius > 10) && (Celcius<36)) && ((sensorValue > 700) && (sensorValue<800))){
     lcd.setCursor(0, 0);
     lcd.print("HAPPY");
     lcd.setCursor(0, 1);
     lcd.print("PONDering");
     delay(1000);
     lcd.clear();
  }
  else{
//    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("ALERT");
    lcd.setCursor(0, 1);
    lcd.print("");
    delay(1000);
    lcd.clear();
  }
}
double avergearray(int* arr, int number){
  int i;
  int max,min;
  double avg;
  long amount=0;
  if(number<=0){
    Serial.println("Error number for the array to avraging!/n");
    return 0;
  }
  if(number<5){   //less than 5, calculated directly statistics
    for(i=0;i<number;i++){
      amount+=arr[i];
    }
    avg = amount/number;
    return avg;
  }else{
    if(arr[0]<arr[1]){
      min = arr[0];max=arr[1];
    }
    else{
      min=arr[1];max=arr[0];
    }
    for(i=2;i<number;i++){
      if(arr[i]<min){
        amount+=min;        //arr<min
        min=arr[i];
      }else {
        if(arr[i]>max){
          amount+=max;    //arr>max
          max=arr[i];
        }else{
          amount+=arr[i]; //min<=arr<=max
        }
      }//if
    }//for
    avg = (double)amount/(number-2);
  }//if
  return avg;
}
