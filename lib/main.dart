import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/about/views/about-component.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/covid-victims/views/covid-victims-component.dart';
import 'package:support_covid_victims/ui/home/views/home-component.dart';
import 'package:support_covid_victims/ui/news/views/news-component.dart';
import 'package:support_covid_victims/ui/splash-screen/views/splash-screen-component.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  MainModel _model = MainModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const MaterialColor _white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFFFFFFFF),
        100: const Color(0xFFFFFFFF),
        200: const Color(0xFFFFFFFF),
        300: const Color(0xFFFFFFFF),
        400: const Color(0xFFFFFFFF),
        500: const Color(0xFFFFFFFF),
        600: const Color(0xFFFFFFFF),
        700: const Color(0xFFFFFFFF),
        800: const Color(0xFFFFFFFF),
        900: const Color(0xFFFFFFFF),
      },
    );
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Support COVID Victims',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            primarySwatch: _white,
            primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
            buttonColor: Colors.teal),
        routes: {
          '/': (BuildContext context) => SplashScreenComponent(),
          'home': (BuildContext context) => HomeComponent(),
          'news': (BuildContext context) => NewsComponent(),
          'covid-victims': (BuildContext context) => CovidVictimComponent(),
          'about': (BuildContext context) => AboutComponent()
        },
      ),
    );
  }
}
