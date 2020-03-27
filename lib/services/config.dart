class GlobalURL {
  static const BaseUrl = 'https://api.covid19api.com/';
  static const CountrySummaryUrl = 'https://api.covid19api.com/summary';

  static void globalErrorHandling(error) {
    print(error.toString());
    //TODO: Here i should send the error to a centralized service or as a notification to alert service.
  }
}
