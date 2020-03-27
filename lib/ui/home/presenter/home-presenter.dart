import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/services/covid19api/covid19api.dart';
import 'package:support_covid_victims/ui/home/viewmodel/home-viewmodel.dart';

class _HomeComponentInterface {
  void fetchCountriesSummary() {}
  bool get isCountryFetchDone {}
  bool get isFiltered {}
  void setCountryFetchDone(bool value) {}
  List<CountryViewModel> get getCovidSummaryList {}
  void filterCovidSummaryList(String filterValue) {}
  CountryViewModel getCountrySummary(int index) {}
}

class HomeComponentPresenter extends Model implements _HomeComponentInterface {
  bool _isCountryFetchDone = false;
  Covid19Api _covid19apiService = Covid19Api();
  List<CountryViewModel> _listCountries = [];
  bool _isFiltered = false;
  String _filtrationValue;
  @override
  Future<void> fetchCountriesSummary() async {
    this._isCountryFetchDone = false;
    notifyListeners();
    this._covid19apiService.fetchCounriesSummary().then((value) {
      final List<dynamic> _covidCountries = value['Countries'];
      _covidCountries.forEach((dynamic data) {
        if (data['Country'] != "") {
          CountryViewModel _countrySummary = CountryViewModel(
              countryName: data['Country'],
              slug: data['Slug'],
              newConfirmed: data['NewConfirmed'],
              newDeaths: data['NewDeaths'],
              newRecovered: data['NewRecovered'],
              totalConfirmed: data['TotalConfirmed'],
              totalDeaths: data['TotalDeaths'],
              totalRecovered: data['TotalRecovered']);
          _listCountries.add(_countrySummary);
        }
      });
      this._isCountryFetchDone = true;
      notifyListeners();
    });
  }

  @override
  bool get isCountryFetchDone => this._isCountryFetchDone;

  @override
  void setCountryFetchDone(bool value) {
    this._isCountryFetchDone = value;
  }

  @override
  List<CountryViewModel> get getCovidSummaryList {
    if (this._filtrationValue != null &&
        this._filtrationValue != '' &&
        this._isFiltered) {
      return this._listCountries.where((CountryViewModel _countryModel) {
        if (_countryModel.countryName
            .toLowerCase()
            .contains(this._filtrationValue.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    }
    return List.from(this._listCountries);
  }

  @override
  CountryViewModel getCountrySummary(int index) {
    return _listCountries[index];
  }

  @override
  void filterCovidSummaryList(String filterValue) {
    if (filterValue != null && filterValue != '') {
      this._filtrationValue = filterValue;
      this._isFiltered = true;
      Timer.periodic(Duration(seconds: 1), (t) {
        notifyListeners();
        t.cancel();
      });
    } else {
      this._isFiltered = false;
      Timer.periodic(Duration(seconds: 1), (t) {
        notifyListeners();
        t.cancel();
      });
    }
  }

  @override
  bool get isFiltered => _isFiltered;
}
