import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/home/views/home-component.dart';

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
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            primarySwatch: Colors.teal,
            buttonColor: Colors.teal),
        routes: {
          '/': (BuildContext context) => HomeComponent(),
        },
      ),
    );
  }
}
