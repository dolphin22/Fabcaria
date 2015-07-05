#include <SoftwareSerial.h>

SoftwareSerial rfidSerial(2,3);
char rfidBuffer[80];

int readRFID(int readch, char *buffer, int len)
{
  static int pos = 0;
  int rpos;

  if (readch > 0) {
    switch (readch) {
      case 0x03: // Return on EOF
        rpos = pos;
        pos = 0;  // Reset position index ready for next time
        return rpos;
      default:
        if (pos < len-1) {
          buffer[pos++] = readch;
          buffer[pos] = 0;
        }
    }
  }
  return -1;
}

void setup() {
  // put your setup code here, to run once:
  rfidSerial.begin(9600);
  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (readRFID(rfidSerial.read(), rfidBuffer, 80) > 0) {
    delay(500);
    Serial.print(&rfidBuffer[1]); // ignore the 1st character, it is useless anyway
    Serial.print(" ");
    Serial.println(analogRead(A0));
  }
}
