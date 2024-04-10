#include "ArduinoGraphics.h"
#include "Arduino_LED_Matrix.h"
#include <DHT.h>
#define DHTPIN A0     // Pin where the DHT11 is connected
#define DHTTYPE DHT11 // Type of DHT sensor

int jobNumber = 0;

// Ruler variables
int trigPin = 2;    // Trigger
int echoPin = 3;    // Echo

ArduinoLEDMatrix matrix;
String number_str;
// End Ruler variables

// T/H Job variables
DHT dht(DHTPIN, DHTTYPE);
// End T/H Job variables

// Additional functions for Jobs
int getDistanceInCM() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  pinMode(echoPin, INPUT);
  long duration = pulseIn(echoPin, HIGH);

  int distanceCM = duration / 58;
  return distanceCM;
}

// End Additional functions for Jobs

// Setup
void setup() {
  Serial.begin(9600);

  // Ruler setup
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  matrix.begin();
  // End Ruler setup

  // T/H Job setup
  dht.begin();
  // End T/H Job setup

  // Tilt Job setup
  pinMode(1, INPUT);
  // End Tilt Job setup
}


// Looking for signal from PIPBOI to determine Job
int lookForJob() {
  if (Serial.available() > 0) {
    int receivedJob = Serial.parseInt();
    return receivedJob;
  } else {
    return 0;
  }
}

// Jobs

// Idle Job
void doIdleJob(){
  matrix.beginDraw();

  matrix.stroke(0xFFFFFFFF);

  matrix.textScrollSpeed(100);
  
  char text[20];

  sprintf(text, "  pipboi  ");

  matrix.textFont(Font_5x7);

  matrix.beginText(0, 1, 0xFFFFFF);

  matrix.println(text);

  matrix.endText(SCROLL_LEFT);

  matrix.endDraw();
}
// End Idle Job

// Ruler Job
void doRulerJob() {
  matrix.beginDraw();

  matrix.stroke(0xFFFFFFFF);

  matrix.textScrollSpeed(100);
  
  number_str = String(getDistanceInCM());

  char text[20];

  sprintf(text, "  %s cm ", number_str.c_str());

  matrix.textFont(Font_5x7);

  matrix.beginText(0, 1, 0xFFFFFF);

  matrix.println(text);

  matrix.endText(SCROLL_LEFT);

  matrix.endDraw();
}
// End Ruler Job

// T/H Job
void doTempHumiJob() {
  matrix.beginDraw();

  matrix.stroke(0xFFFFFFFF);

  matrix.textScrollSpeed(100);

  float temperature = dht.readTemperature(); // Read temperature as Celsius
  float humidity = dht.readHumidity();       // Read humidity as percentage

  // Check if any reads failed and exit early (to try again)
  if (isnan(temperature) || isnan(humidity)) {
    char errorText[] = "Failed to read sensor!";
    matrix.textFont(Font_5x7);
    matrix.beginText(0, 1, 0xFF0000);
    matrix.println(errorText);
    matrix.endText(SCROLL_LEFT);
  } else {
    char text[20];
    sprintf(text, "%.0f°C/%.0f%%", temperature, humidity);

    matrix.textFont(Font_5x7);
    matrix.beginText(0, 1, 0xFFFFFF);
    matrix.println(text);
    matrix.endText(SCROLL_LEFT);
  }

  matrix.endDraw();
}
// End T/H Job

// Tilt Job
int doTiltJob(){
  int value = digitalRead(0);
  return value; // 0 = is facing up, 1 = is facing down
}
// End Tilt Job

// End Jobs

// Main loop
void loop() {
  jobNumber = lookForJob();
  switch (jobNumber)
  {
    case 0:
      doIdleJob();
      break;
    case 1:
      doRulerJob();
      break;
    case 2:
      doTempHumiJob();
      break;
    case 3:
      doTiltJob();
      break;
  }

}
// End Main loop 