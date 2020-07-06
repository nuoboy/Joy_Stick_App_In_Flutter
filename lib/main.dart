import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}
bool forward = false;
bool backward = false;
bool left = false;
bool right = false;

String control = "nothing";
bool value = false;
String Connection_Status = "Not Connected";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  server_function() async {
    try {
      print("ssssssssssssssssssssss");
      var server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
      value = true;
      Connection_Status = "Connected";
      setState(() {});
      await for (var req in server) {
        req.response.headers.contentType = ContentType.text;
        req.response.write("$control");
        control = "nothing";
        req.response.close();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: (value)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: HoldDetector(
                              onHold: () {
                                control = "right";
                                setState(() {});
                              },
                              holdTimeout: Duration(milliseconds: 1),
                              child: FlatButton(
                                splashColor: Colors.deepOrange,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 10, color: Colors.deepOrange)),
                                color: Colors.black,
                                onPressed: () {
                                  control = "right";
                                  setState(() {});
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: HoldDetector(
                              onHold: () {
                                control = "left";
                                setState(() {});
                              },
                              holdTimeout: Duration(milliseconds: 1),
                              child: FlatButton(
                                splashColor: Colors.green,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 10, color: Colors.blueAccent)),
                                color: Colors.black,
                                onPressed: () {
                                  control = "left";
                                  setState(() {});
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(

                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Center(
                                child: FlatButton(
                                  onPressed: (){
                                    control="esc";
                                    setState(() {

                                    });
                                  },
                                  padding: EdgeInsets.all(15),
                                  shape: CircleBorder(side: BorderSide(color: Colors.green,width: 3),),
                                  child: Center(child: Text("esc",style: GoogleFonts.oxygen(textStyle: TextStyle(fontSize: 20,color: Colors.white)),)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.cyan, width: 5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          width: 192 * 1.5,
                          height: 108 * 1.5,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              control = "M " + details.delta.dx.toString() + " " + details.delta.dy.toString()+ " " + details.delta.distance.toString();
                            },
                          ),
                        ),

                      ],
                    ),
                    Container(
                      width: 200.0,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: HoldDetector(
                              onHold: () {
                                control = "forward";
                                setState(() {});
                              },
                              holdTimeout: Duration(milliseconds: 1),
                              child: FlatButton(
                                splashColor: Colors.purple,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 10, color: Colors.purple)),
                                color: Colors.black,
                                onPressed: () {
                                  control = "forward";
                                  setState(() {});
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: HoldDetector(
                              onHold: () {
                                control = "backward";
                                setState(() {});
                              },
                              holdTimeout: Duration(milliseconds: 1),
                              child: FlatButton(
                                splashColor: Colors.amber,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 10, color: Colors.amber)),
                                color: Colors.black,
                                onPressed: () {
                                  control = "backward";
                                  setState(() {});
                                },
                                child: Center(
                                  child: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        color: Colors.black,
                        child: Text("$Connection_Status"),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.black,
                      splashColor: Colors.purple,
                      padding: EdgeInsets.all(45),
                      shape: CircleBorder(
                          side: BorderSide(width: 5, color: Colors.purple)),
                      child: Text(
                        "Connect",
                        style: GoogleFonts.oxygen(
                            textStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                      ),
                      onPressed: server_function,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
