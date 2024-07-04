# mqtt-rpc-example-response

This project is an java example of a program to respond to requests made using mqtt-rcp, That is a Remote Procedure Call over mqtt (i.e request/response).
This may be useful in the case of a webapp which needs to subscribe to events, and also to handle requests that need a particular  response  

It relies on the following dependencies:

    implementation 'com.rsmaxwell.mqtt.rpc:mqtt-rpc-common:0.0.1.5'
    implementation 'com.rsmaxwell.mqtt.rpc:mqtt-rpc-response:0.0.1.5'
  
which are available at the maven repository:

    https://pluto.rsmaxwell.co.uk/archiva/repository/releases
  
mqtt expects that a mosquitto broker is running to which clients connect and communicate using standard topics

This project implements a couple of requester programs which make simple requests using mqtt-rpc

It expects that a matching responder program is also running to listen for requests and respond with a suitable reply.


### Structure

The main Responder program 

  * loads a map of request handlers keyed on a function string
  * connects to an mqtt broker 
  * sets up a MessageHandler as the callback Adapter
  * subscribes to a topic listens to which requests will be published.
  * waits forever

When a request is published to the request topic, Messagehandler.messageArrived is called which:

  * checks the message has a response topic set in its message properties
  * parses the payload into into a Request 
  * calls the handler matching the Request.function
  * parses the response returned by the handler into a Response 
  * publishes the response to the response topic    
  
A handler implements the handleRequest method which is given an argument of a map of key/value pairs  

  * gets arguments out of the map
  * processes the arguments in some way to generate a response
  * returns a response which includes:
    - error code (borrowed from http status values)
    - error message (optional)
    - response to the request