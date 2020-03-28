import 'dart:core';

import 'package:flutter/widgets.dart';

class HomeViewModel {}

class CountryViewModel {
  String countryName;
  String countryFlag;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int totalRecovered;

  CountryViewModel(
      {@required this.countryName,
      @required this.countryFlag,
      @required this.newConfirmed,
      @required this.totalConfirmed,
      @required this.newDeaths,
      @required this.totalDeaths,
      @required this.totalRecovered});
}
