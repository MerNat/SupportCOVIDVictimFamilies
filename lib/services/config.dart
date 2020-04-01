class GlobalURL {
  static const BaseUrl = 'https://corona.lmao.ninja/';
  static const BaseNewsUrl = 'https://newsapi.org/v2/';
  static const BaseFirebaseUrl = 'https://support-covid-19-victims.firebaseio.com/victims.json';
  static const NewsMediaUrl = GlobalURL.BaseNewsUrl +
      'top-headlines?q=COVID&language=en&sortBy=publishedAt&apiKey=f3af85dcab554af4a6083367043d6509&pageSize=100&page=1';
  static const AllSummaryUrl = GlobalURL.BaseUrl + 'all';
  static const CountrySummaryUrl = GlobalURL.BaseUrl + 'countries?sort=country';

  static void globalErrorHandling(error) {
    // print(error.toString());
  }
}
