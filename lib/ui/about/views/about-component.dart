import 'package:flutter/material.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';

class AboutComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: GlobalWidgets.getDrawer(context),
          body: Container(
            margin: EdgeInsets.symmetric(
                horizontal: GlobalWidgets.getHeight(context) * 0.015,
                vertical: GlobalWidgets.getHeight(context) * 0.05),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, -1),
                  child: Padding(
                    padding:
                        EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          child: InkWell(
                            child: Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () => Navigator.pop(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
                  child: Align(
                    alignment: Alignment(0, -0.3),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'This application was created so that it may help people ' +
                                'who seek financial support due to the COVID pandemic outbreak. ' +
                                'It will be able to share  their fundraising/donation link across the world.\n\n\n\n',
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalWidgets.getWidth(context) * 0.05)),
                        TextSpan(
                            text:
                                'Please contact me through twitter to post your fundraising link to the application.',
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalWidgets.getWidth(context) * 0.045))
                      ]),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
                  child: Align(
                    alignment: Alignment(-1, 0.5),
                    child: InkWell(
                      onTap: () => {},
                      child: RichText(
                        // textDirection: TextDirection.rtl,
                        text: TextSpan(children: [
                          TextSpan(
                              text: '@MeronHayle',
                              style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  color: Color.fromRGBO(0, 170, 238, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                      GlobalWidgets.getWidth(context) * 0.04))
                        ]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
                  child: Align(
                    alignment: Alignment(-1, 1),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                'Credits goes to NovelCOVID API and Newsapi.Org',
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                color: Colors.black.withOpacity(0.3),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalWidgets.getWidth(context) * 0.03)),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
