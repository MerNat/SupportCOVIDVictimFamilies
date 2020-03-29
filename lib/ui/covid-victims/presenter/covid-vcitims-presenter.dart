import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/services/covid19api/covid19api.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/covid-victims/viewmodel/covid-victims-viewmodel.dart';
import 'package:support_covid_victims/ui/home/viewmodel/home-viewmodel.dart';

class _CovidVictimsInterface {
  void fetchAllCovidVictims(MainModel model, bool isAll, int countryId) {}
  bool get hasCovidVictimsError {}
  bool get hasCovidVictimsLoaded {}
  List<CovidVictimViewModel> get getCovidVictimsList {}
}

class CovidVictimsPresenter extends Model implements _CovidVictimsInterface {
  bool _hasCovidVictimsError = false;
  bool _hasCovidVictimsLoaded = false;
  Covid19Api _covid19apiService = Covid19Api();
  List<CovidVictimViewModel> _listCovidVictims = List<CovidVictimViewModel>();

  @override
  Future<void> fetchAllCovidVictims(
      MainModel model, bool isAll, int countryId) {
    this._hasCovidVictimsError = false;
    this._hasCovidVictimsLoaded = false;
    this._listCovidVictims = List<CovidVictimViewModel>();
    notifyListeners();
    this._covid19apiService.fetchCovidVictimsList().then((data) async {
      await model.refreshList();
      final Map<String, dynamic> _covidVictimsData = data;
      if (_covidVictimsData.length == 0) {
        this._hasCovidVictimsLoaded = true;
        this._hasCovidVictimsError = false;
        notifyListeners();
        return;
      }
      _covidVictimsData.forEach((_, dynamic data) async {
        try {
          if (isAll) {
          CountryViewModel _theCountryModel =
              await model.getCountryViewModelByCountryId(data['country_id']);
          CovidVictimViewModel _theCovidModel = CovidVictimViewModel(
              countryViewModel: _theCountryModel,
              countryId: data['country_id'],
              victimFundUrl: data['victim_url'],
              victimName: data['victim_name']);
          this._listCovidVictims.add(_theCovidModel);

          } else {
            if (data['country_id'] == countryId) {
              print('im the same');
              CountryViewModel _theCountryModel = await model
                  .getCountryViewModelByCountryId(data['country_id']);
              CovidVictimViewModel _theCovidModel = CovidVictimViewModel(
                  countryViewModel: _theCountryModel,
                  countryId: data['country_id'],
                  victimFundUrl: data['victim_url'],
                  victimName: data['victim_name']);
              _listCovidVictims.add(_theCovidModel);
            }
          }
        } catch (_) {}
      });
      this._hasCovidVictimsLoaded = true;
      this._hasCovidVictimsError = false;
      notifyListeners();
      return;
    }).catchError((err) {
      print(err);
      this._hasCovidVictimsError = true;
      this._hasCovidVictimsLoaded = true;
      notifyListeners();
      return;
    });
  }

  @override
  bool get hasCovidVictimsError => this._hasCovidVictimsError;

  @override
  bool get hasCovidVictimsLoaded => this._hasCovidVictimsLoaded;

  @override
  List<CovidVictimViewModel> get getCovidVictimsList => this._listCovidVictims;
}
