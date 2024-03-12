void setup() {
  // Initialize serial communication
  Serial.begin(9600);
  
  // Set digital pin 0 as input
  pinMode(1, INPUT);
}

void loop() {
  // Read the value from digital pin 0
  int value = digitalRead(0);
  
  // Print the value to the serial monitor
  Serial.println(value);
  
  // Delay for a short period to avoid flooding the serial monitor
  delay(100);
}