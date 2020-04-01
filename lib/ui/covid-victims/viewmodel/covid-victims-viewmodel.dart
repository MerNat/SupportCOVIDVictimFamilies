import 'package:flutter/material.dart';
import 'package:support_covid_victims/ui/home/viewmodel/home-viewmodel.dart';

class CovidVictimViewModel {
  CountryViewModel countryViewModel;
  int countryId;
  String victimName;
  String victimFundUrl;

  CovidVictimViewModel(
      {@required this.countryViewModel,
      @required this.victimName,
      @required this.countryId,
      @required this.victimFundUrl});
}
