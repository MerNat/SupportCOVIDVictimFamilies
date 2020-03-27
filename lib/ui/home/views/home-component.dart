import 'package:flutter/material.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';

class HomeComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: GlobalWidgets.getHeight(context) * 0.01,
                  vertical: GlobalWidgets.getHeight(context) * 0.03),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          child: InkWell(
                            child: Icon(Icons.menu, color: Colors.black),
                            onTap: (){print('clicked');},
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: GlobalWidgets.getWidth(context) * 0.04),
                      child: Container(
                          padding: EdgeInsets.only(left: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextField(
                            onChanged: (value) {
                              print(value);
                            },
                            decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                fillColor: Colors.grey.withOpacity(0.5),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey)),
                          ))),
                  SizedBox(
                    height: GlobalWidgets.getHeight(context) * 0.03,
                  ),
                ],
              ))),
    );
  }
}
