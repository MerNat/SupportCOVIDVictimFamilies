import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';

class Covid19Api {
  Future<dynamic> fetchCounriesSummary() {
    return http
        .get(GlobalURL.CountrySummaryUrl)
        .timeout(Duration(seconds: 5))
        .then((http.Response response) {
      return json.decode(response.body);
    }).catchError((error) {
      GlobalURL.globalErrorHandling(error);
      return error;
    });
  }

  Future<dynamic> fetchNews() {
    return http
        .get(GlobalURL.NewsMediaUrl)
        .timeout(Duration(seconds: 5))
        .then((http.Response response) {
      return json.decode(response.body);
    }).catchError((error) {
      GlobalURL.globalErrorHandling(error);
      return error;
    });
  }
}
