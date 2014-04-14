#Getting what you need out of the xBee API Library for Arduino

Aside: All this code is tested on Series 2 and Pro models of the xBee. With that said understanding this code will allow you to write something very similar if you require the use of Series 1 modules.

Understanding this library was one of the major early challenges for my thesis project. Once I was able to get a handle on the structure of their code it became easy to write code to suit the application rather than the other way around.

The original library was written in 2009 by Andrew Rapp. There have been sporadic updates since then, but in order to get some semblance of an up-to-date version I had to go through a mailing list for the lib. [add link]

Armed with what worked in the latest Arduino IDE I began to explore.

There are two files for the library: XBee.h and XBee.cpp.

Lets take the 'get something together right away' approach to learning this.

If you open the XBee.h file, you will notice a great deal of defined constants. Thankfully they have readable names and some sporadic comments to help us guess our way through this.

If you scroll down to around line 82 you will notice Api Id Constants. These will help us check what kind of **packet** is being sent or received. In my case I wanted to consider two packets in particular. The `ZB_RX_RESPONSE` and the `ZB_IO_SAMPLE_RESPONSE` both deal with received packets of the connected xBee. Note that `ZB` here stands for ZigBee, which is the communication mode of the Series 2 xBee modules.

What do these constants represent? A HEX value that each packet uses to identify its nature to the recipient.

What else can we get from this file? The class structure, around line 151 you will notice the `XBeeResponse` class being declared and it's public methods listed.

If you are new to C++ don't worry, I will describe what this means to us as end users. Public methods are the things we really care about, they are the '_functions_' that we would want to call on in our program.

The public methods directly in the `XBeeResponse` class are a little high level for our purposes. How do we find what we need?

Earlier I mentioned the `ZB_IO_SAMPLE_RESPONSE` constant. If you search the file for that name, you will be drawn to somewhere around line 220. There you can see that we have the  `getZBRxIoSampleResponse` function. Lets click some pieces in:
if you want to read a value of a pin on an external xBee (lets say you are looking to read a temperature sensor attached to it)
you will be looking at an IO Response from that xBee.

The constant mentioned earlier defines how to verify that the packet you currently received is of a specific type, in this case the `ZB_IO_SAMPLE_RESPONSE`. Once this is verified we can call the painfully named `getZBRxIoSampleResponse` function in order to get at the data available within.

Now that we are that far in our thought experiment lets look at how to get to the final stretch. Still in the XBee.h file, lets search for "ZBRxIoSampleResponse" (or `getZBRxIoSampleResponse` without the "get".) This brings us to a class that deals with this type of packet specifically.

To understand the structure of the XBee library better, it is very important that you note that this class is using another via the `: public ZBRxResponse`. This means that the public methods of that class are available to you when you call `getZBRxIoSampleResponse`. This is chained all the way to the first class we looked at: `XBeeResponse`. And you can trace that back by searching backwards for "XBeeResponse."

Now that that is out of the way, lets see packet specific functionality we have exposed to us:

  ```c
  bool containsAnalog();
  bool containsDigital();
  /**
   * Returns true if the pin is enabled
   */
  bool isAnalogEnabled(uint8_t pin);
  /**
   * Returns true if the pin is enabled
   */
  bool isDigitalEnabled(uint8_t pin);
  /**
   * Returns the 10-bit analog reading of the specified pin.
   * Valid pins include ADC:xxx.
   */
  uint16_t getAnalog(uint8_t pin);
  /**
   * Returns true if the specified pin is high/on.
   * Valid pins include DIO:xxx.
   */
  bool isDigitalOn(uint8_t pin);
  ```  

These are very well commented, so with that packet specifically we can quickly check:

- Which pins are enabled /and/ set to analog or digital.
- The data for those pins as stored in the packet.

For the use case of grabbing a sensor value on pin 1 this is all that we need to complete our code. Which brings me to the part I am sure you've all been waiting for.

## The Code


  ```arduino
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
  ```

Tada, if you read the above explanation the meat of the loop there shouldn't be surprising. With that said there are a few lines that are required by the library.

First we include it like any other Arduino library.
Then we create an instance of XBee, allowing us to call it.

The next line is what might be confusing, what we are doing is creating a _form_ for our specific packet to fill (Just instance of the `ZBRxIoSampleResponse` we looked at above!). This is used to store that packet and call the functions I mentioned earlier on it.

In the setup we have a standard Serial begin and then we initialize our xbee passing the library the Serial 'line' we will communicate to it on. (Note that you can use software serial here as well, just begin it and pass it to an xbee)

Then we get to the stuff that actually does our work.
First we want to constantly watch for a packet to come on, so we run the `xbee.readPacket();` function right in the main loop. Following we check if our xBee has received a packet (via the general `xbee.getResponse().isAvailable()`.) Once a packet is confirmed we can look back at our prior reasoning.

Check the ID of the packet, and reference it against the constant we want to look for (in our case `ZB_IO_SAMPLE_RESPONSE`.) Once that is also confirmed we finally know that we have an IO packet from our device!

We call the function we found earlier in order to populate the `ZBioSample` shell:

      xbee.getResponse().getZBRxIoSampleResponse(ZBioSample);

Now you have the latest packet data available to you via `ZBioSample`. With that just use any of the functions you find in the `ZBRxIoSampleResponse` class that we looked at earlier.

In our example we first check if pin one on the xBee is set to analog: `ZBioSample.isAnalogEnabled(1)` if that test passes we grab the data from the pin via `ZBioSample.getAnalog(1);`

## Your Use Case

This is all fine and dandy if all you want to do is what I wanted to do. Which is why I spent all that time at the start showing you a couple of bits from the XBee.h file.

If you look through the defined Api ID constants again, and search for their respective classes you can quickly get your bearings and start dealing with many other types of packets that your xBee can receive. Once you know what type of data you want to grab or send, and have found the class that gets you to that the fastest take a look through the available methods. And don't forget to check the classes that they reference for their methods as well. As an example, lets say I want to also grab the address of the xBee that sent that packet.

If you look through the methods provided by the `ZBRxIoSampleResponse` class you can see that it doesn't appear to contain that method. Now lets look at the class that it is referencing: `ZBRxResponse` (Around line 381)

Note that it has a method `getRemoteAddress16` this can let us do just what we want, and we can still call it on the `ZBioSample` instance we created earlier.

      ZBioSample.getRemoteAddress16();

This will now let us have the 16 bit address of the xBee, which we can use to give some more context to the prior sensor value.

The avid XBee.h explorer has probably also noticed that `ZBRxResponse` is also referencing `RxDataResponse`. If you can't find what you are looking for, just try looking all the way down the rabbit hole!

I hope that this has been at least somewhat informative. I didn't want to just throw a chunk of code out there. Lets call this 'Teaching how to fish and giving you the first catch.'
