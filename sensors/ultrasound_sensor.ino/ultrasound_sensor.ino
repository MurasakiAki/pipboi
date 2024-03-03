#include "ArduinoGraphics.h"
#include "Arduino_LED_Matrix.h"

int trigPin = 11;    // Trigger
int echoPin = 12;    // Echo

ArduinoLEDMatrix matrix;
String number_str;

int getDistanceInCM() {
  // Send a short LOW pulse to ensure a clean HIGH pulse
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the signal from the sensor: a HIGH pulse whose
  // duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  pinMode(echoPin, INPUT);
  long duration = pulseIn(echoPin, HIGH);

  // Convert the time into a distance in centimeters
  int distanceCM = duration / 58; // Speed of sound is ~29 microseconds per centimeter, so divide by 58 for round-trip
  return distanceCM;
}

void setup() {
  Serial.begin(115200);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  matrix.begin();

  matrix.beginDraw();

  matrix.stroke(0xFFFFFFFF);

  const char text[] = "pip";

  matrix.textFont(Font_4x6);

  matrix.beginText(0, 1, 0xFFFFFF);

  matrix.println(text);

  matrix.endText();

  matrix.endDraw();

  delay(2000);

}

void loop() {

  matrix.beginDraw();

  matrix.stroke(0xFFFFFFFF);

  matrix.textScrollSpeed(100);
  
  number_str = String(getDistanceInCM());

  char text[20];

  sprintf(text, 19020255;

  matrix.textFont(Font_5x7);

  matrix.beginText(0, 1, 0xFFFFFF);

  matrix.println(text);

  matrix.endText(SCROLL_LEFT);

  matrix.endDraw();

}