import 'package:flutter/material.dart';

class GlobalWidgets {
  static Widget getSpinner() {
    return CircularProgressIndicator();
  }

  static double getHeight(BuildContext context) {
    // final Orientation deviceOrientation = MediaQuery.of(context).orientation;
    final double deviceHeight = MediaQuery.of(context).size.height;
    // final double setWidth = deviceOrientation == Orientation.landscape
    //     ? deviceWidth * 0.6
    //     : deviceWidth * 1.0;
    return deviceHeight;
  }

  static double getWidth(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth;
  }
}
