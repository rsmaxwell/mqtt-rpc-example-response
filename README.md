# mqtt-rpc-example-response

This project is an java example of a program to respond to requests made using mqtt-rcp, That is a Remote Procedure Call over mqtt (i.e request/response).
This may be useful in the case of a webapp which needs to subscribe to events, and also to handle requests that need a particular  response  

It relies on the following dependencies:

 
```
repositories {
    maven {
        url "https://pluto.rsmaxwell.co.uk/archiva/repository/releases"
    }
}

dependencies {
     ...
    implementation 'com.rsmaxwell.mqtt.rpc:mqtt-rpc-common:+'
    implementation 'com.rsmaxwell.mqtt.rpc:mqtt-rpc-response:+'
}
```
  
  
  
The lastest version can be found at 

```
https://pluto.rsmaxwell.co.uk/archiva/#artifact~releases/com.rsmaxwell.mqtt.rpc/mqtt-rpc-common
```

mqtt expects that a [Mosquitto](https://mosquitto.org/) broker is running to which clients connect and communicate using standard topics

It expects that matching requester programs will send requests and will handle the responses.

This project contains a Responder which handles a number of simple requests and sends responses back their reply topic


### Structure

The main Responder program 

  * loads a map of request handlers keyed on a function string
  * connects to an mqtt broker 
  * sets up a MessageHandler as the callback Adapter
  * subscribes to a topic listens to which requests will be published.
  * waits forever

When a request is published to the request topic, MessageHandler.messageArrived is called which:

  * checks the message has a response topic set in its message properties
  * parses the payload into into a [Request](https://github.com/rsmaxwell/mqtt-rpc-common/blob/main/src/main/java/com/rsmaxwell/mqtt/rpc/common/Request.java) 
  * calls the handler matching the Request.function
  * parses the response returned by the handler into a [Response](https://github.com/rsmaxwell/mqtt-rpc-common/blob/main/src/main/java/com/rsmaxwell/mqtt/rpc/common/Response.java)
  * publishes the response to the response topic    
  
A handler implements the handleRequest method which is given an argument of a map of key/value pairs  

  * gets arguments out of the map
  * processes the arguments in some way to generate a response
  * returns a response which includes:
    - error code (borrowed from http status values)
    - error message (optional)
    - response to the request