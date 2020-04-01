import 'package:flutter/material.dart';

class GlobalWidgets {
  static Widget getSpinner() {
    return CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.8)));
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
                backgroundColor: Colors.white.withOpacity(0.15),
                automaticallyImplyLeading: false,
                title: Text(
                  'Pages',
                  style: TextStyle(
                      fontSize: GlobalWidgets.getWidth(context) * 0.04,
                      color: Colors.white.withOpacity(0.3)),
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
                    onTap: () => Navigator.pushNamed(context, 'covid-victims'),
                  ),
                ),
              ),
              Material(
                color: Colors.black,
                child: InkWell(
                  child: ListTile(
                    title: Text(
                      'Show By Country',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    onTap: () => Navigator.pushNamed(context, 'home'),
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
                      'Contact and About',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                    onTap: () => Navigator.pushNamed(context, 'about'),
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
                    style: TextStyle(color: Colors.white.withOpacity(0.2))),
                TextSpan(
                    text: 'Hope',
                    style: TextStyle(color: Colors.white.withOpacity(0.2))),
                TextSpan(
                    text: '  By Meron',
                    style: TextStyle(color: Colors.white.withOpacity(0.2))),
              ]),
            ),
          )
        ],
      ),
    );
  }

  static Widget generateNoInternet(BuildContext context, bool isInternet) {
    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: GlobalWidgets.getHeight(context) * 0.15),
                child: Icon(
                  isInternet ? Icons.portable_wifi_off : Icons.cloud_off,
                  color: Colors.grey.withOpacity(1),
                  size: GlobalWidgets.getWidth(context) * 0.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  isInternet ? 'No Internet' : 'No Data Yet',
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
