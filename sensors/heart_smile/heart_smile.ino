#include "Arduino_LED_Matrix/src/Arduino_LED_Matrix.h"


ArduinoLEDMatrix matrix;


void setup() {

  Serial.begin(115200);

  matrix.begin();

}


const uint32_t happy[] = {

    0x19819,

    0x80000001,

    0x81f8000

};

const uint32_t heart[] = {

    0x3184a444,

    0x44042081,

    0x100a0040

};

  

void loop(){

  matrix.loadFrame(happy);

  delay(500);


  matrix.loadFrame(heart);

  delay(500);

}