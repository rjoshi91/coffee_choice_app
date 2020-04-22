import 'dart:async';
import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[

          Center(
            child: Container(
              child: FittedBox(
                child: Image.asset(
                  "images/coffeemakingbg.png",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),

          Center(
            child: Container(
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(top: 240.0),
                    child: Container(
                      child: FittedBox(
                        child: Image.asset(
                          "images/espresso.png",
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Coffee Choice App",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "An Coffee Order Prioritizing App",
                softWrap: true,
                style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
