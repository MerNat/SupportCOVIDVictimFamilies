import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/services/covid19api/covid19api.dart';
import 'package:support_covid_victims/ui/news/viewmodel/news-viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class _NewsInterface {
  void fetchNews() {}
  bool get getIsNewsFetch {}
  bool get getHasNewsError {}
  List<NewsViewModel> get getNewsData {}
  void launchURL(String url) {}
}

class NewsPresenter extends Model implements _NewsInterface {
  bool _isNewsFetched = false;
  bool _hasNewsError = false;
  List<NewsViewModel> _listNewsData = [];
  Covid19Api _covid19apiService = Covid19Api();

  @override
  Future<void> fetchNews() {
    this._isNewsFetched = false;
    this._hasNewsError = false;
    this._listNewsData = [];
    notifyListeners();
    _covid19apiService.fetchNews().then((data) {
      List<dynamic> _newsData = data['articles'];
      _newsData.forEach((data) {
        if (data['author'] != '' &&
            data['author'].toString().length <= 120 &&
            data['author'] != null) {
          String _datePublished = DateFormat('MMMM dd, yyyy hh:mm a')
              .format(DateTime.parse(data['publishedAt']).toLocal())
              .toString();
          NewsViewModel _newsModel = NewsViewModel(
              newsAuthor: data['author'],
              newsTitle: data['title'],
              newsUrl: data['url'],
              newsUrlToImage: data['urlToImage'],
              publishedAt: _datePublished);
          _listNewsData.add(_newsModel);
        }
      });
      this._isNewsFetched = true;
      this._hasNewsError = false;
      notifyListeners();
    }).catchError((_) {
      this._isNewsFetched = true;
      this._hasNewsError = true;
      notifyListeners();
    });
  }

  @override
  bool get getHasNewsError => this._hasNewsError;

  @override
  bool get getIsNewsFetch => this._isNewsFetched;

  @override
  List<NewsViewModel> get getNewsData => this._listNewsData;

  @override
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
