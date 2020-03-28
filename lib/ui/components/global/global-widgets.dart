import 'package:flutter/material.dart';

class GlobalWidgets {
  static Widget getSpinner() {
    return CircularProgressIndicator();
  }

  static double getHeight(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
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
                  child: ListTile(
                    title: Text(
                      'Latest News',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    onTap: () => Navigator.pushNamed(context, 'news'),
                  ),
                ),
              ),
              Material(
                color: Colors.black,
                child: InkWell(
                  child: ListTile(
                    title: Text(
                      'COVID-19 Victims Support',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    onTap: () => {},
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

  static Widget generateNoInternet(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: GlobalWidgets.getHeight(context) * 0.15),
                child: Icon(
                  Icons.portable_wifi_off,
                  color: Colors.grey.withOpacity(1),
                  size: GlobalWidgets.getWidth(context) * 0.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'No Internet',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(1),
                      fontSize: GlobalWidgets.getWidth(context) * 0.06),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
