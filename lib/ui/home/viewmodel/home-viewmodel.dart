import 'dart:core';

import 'package:flutter/widgets.dart';

class HomeViewModel {}

class CountryViewModel {
  String countryName;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  CountryViewModel(
      {@required this.countryName,
      @required this.slug,
      @required this.newConfirmed,
      @required this.totalConfirmed,
      @required this.newDeaths,
      @required this.totalDeaths,
      @required this.newRecovered,
      @required this.totalRecovered});
}
