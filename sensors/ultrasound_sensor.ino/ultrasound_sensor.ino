#include "ArduinoGraphics.h"
#include "Arduino_LED_Matrix.h"

int trigPin = 2;    // Trigger
int echoPin = 3;    // Echo

ArduinoLEDMatrix matrix;
String number_str;

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

  sprintf(text, "  "+number_str+"cm ");

  matrix.textFont(Font_5x7);

  matrix.beginText(0, 1, 0xFFFFFF);

  matrix.println(text);

  matrix.endText(SCROLL_LEFT);

  matrix.endDraw();

}