#include <XBee.h>

  XBee xbee = XBee();
  ZBRxIoSampleResponse ZBioSample = ZBRxIoSampleResponse();

  void setup() {
      Serial.begin(9600);
      xbee.begin(Serial);
  }

  void loop() {

    xbee.readPacket();

    if (xbee.getResponse().isAvailable()) {
      if (xbee.getResponse().getApiId() == ZB_IO_SAMPLE_RESPONSE) {

        xbee.getResponse().getZBRxIoSampleResponse(ZBioSample);

        if (ZBioSample.isAnalogEnabled(1)) {
          int data = ZBioSample.getAnalog(1);
          // now you have the pin data!
        }
      }
    }
  }