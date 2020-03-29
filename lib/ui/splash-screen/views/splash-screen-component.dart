import 'dart:async';

import 'package:flutter/material.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';

class SplashScreenComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenPage();
  }
}

class _SplashScreenPage extends State<SplashScreenComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 5), (timer) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
      timer.cancel();
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(color: Colors.black),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    radius: GlobalWidgets.getWidth(context) * 0.2,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Support\n',
                              style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      GlobalWidgets.getWidth(context) * 0.05)),
                          TextSpan(
                              text: 'COVID-19\n',
                              style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      GlobalWidgets.getWidth(context) * 0.05)),
                          TextSpan(
                              text: 'Victims',
                              style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      GlobalWidgets.getWidth(context) * 0.05))
                        ])),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.5),
                  child: Text(
                    'One World.    One Fight.',
                    style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        color: Colors.white.withOpacity(0.7),
                        fontSize: GlobalWidgets.getWidth(context) * 0.05),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.8),
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
