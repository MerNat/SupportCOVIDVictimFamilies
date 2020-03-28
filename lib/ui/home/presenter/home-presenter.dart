import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/services/covid19api/covid19api.dart';
import 'package:support_covid_victims/ui/home/viewmodel/home-viewmodel.dart';

class _HomeComponentInterface {
  void fetchCountriesSummary() {}
  bool get isCountryFetchDone {}
  bool get isFiltered {}
  bool get hasFetchError {}
  void setCountryFetchDone(bool value) {}
  List<CountryViewModel> get getCovidSummaryList {}
  void filterCovidSummaryList(String filterValue) {}
  void setFilterValue(String value){}
  CountryViewModel getCountrySummary(int index) {}
}

class HomeComponentPresenter extends Model implements _HomeComponentInterface {
  bool _isCountryFetchDone = false;
  Covid19Api _covid19apiService = Covid19Api();
  List<CountryViewModel> _listCountries = [];
  bool _isFiltered = false;
  bool _hasError = false;
  String _filtrationValue;
  @override
  Future<void> fetchCountriesSummary() async {
    this._isCountryFetchDone = false;
    this._hasError = false;
    this._listCountries = [];
    notifyListeners();
    this._covid19apiService.fetchTotalSummary().then((totalSummary) {
      CountryViewModel _totalSummary = CountryViewModel(
          countryFlag: null,
          countryName: 'Current Summary',
          totalConfirmed: totalSummary['cases'],
          newConfirmed: null,
          newDeaths: null,
          totalDeaths: totalSummary['deaths'],
          totalRecovered: totalSummary['recovered']);
      this._covid19apiService.fetchCounriesSummary().then((value) {
        final List<dynamic> _covidCountries = value;
        _covidCountries.forEach((dynamic data) {
          CountryViewModel _countrySummary = CountryViewModel(
              countryName: data['country'],
              countryFlag: data['countryInfo']['flag'],
              countryId: data['countryInfo']['_id'],
              newConfirmed: data['todayCases'],
              newDeaths: data['todayDeaths'],
              totalConfirmed: data['cases'],
              totalDeaths: data['deaths'],
              totalRecovered: data['recovered']);
          _listCountries.add(_countrySummary);
        });
        _listCountries.add(_totalSummary);
        this._isCountryFetchDone = true;
        notifyListeners();
      }).catchError((_) {
        _isCountryFetchDone = true;
        _hasError = true;
        notifyListeners();
      });
    }).catchError((_) {
      this._isCountryFetchDone = true;
      this._hasError = true;
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
      return this
          ._listCountries
          .reversed
          .where((CountryViewModel _countryModel) {
        if (_countryModel.countryName
            .toLowerCase()
            .contains(this._filtrationValue.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    }
    return List.from(this._listCountries.reversed);
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

  @override
  bool get hasFetchError => this._hasError;

  @override
  void setFilterValue(String value) {
    this._filtrationValue = value;
  }
}
