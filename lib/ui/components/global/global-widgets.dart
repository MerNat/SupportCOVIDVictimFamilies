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

  static Container getDrawer(BuildContext context) {
    return Container(
      width: GlobalWidgets.getWidth(context) * 0.8,
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.white.withOpacity(0.3),
                automaticallyImplyLeading: false,
                title: Text('Menu'),
              ),
              Material(
                color: Colors.black,
                child: InkWell(
                  // splashColor: Colors.yellow,
                  child: ListTile(
                    title: Text(
                      'Show By Country',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/'),
                  ),
                ),
              ),
              Material(
                color: Colors.black,
                child: InkWell(
                  // Stack: Colors.yellow,
                  child: ListTile(
                    title: Text(
                      'Latest News',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    onTap: () => Navigator.pushNamed(context, 'news'),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Made With  ',
                    style: TextStyle(color: Colors.white.withOpacity(0.4))),
                WidgetSpan(
                    child: Icon(
                  Icons.favorite,
                  color: Colors.red.withOpacity(0.8),
                  size: GlobalWidgets.getWidth(context) * 0.04,
                )),
                TextSpan(
                    text: '  By Meron',
                    style: TextStyle(color: Colors.white.withOpacity(0.4))),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
