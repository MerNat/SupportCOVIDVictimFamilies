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

  Future<dynamic> fetchTotalSummary() {
    return http
        .get(GlobalURL.AllSummaryUrl)
        .timeout(Duration(seconds: 5))
        .then((http.Response response) {
      return json.decode(response.body);
    }).catchError((error) {
      GlobalURL.globalErrorHandling(error);
      return error;
    });
  }

  Future<dynamic> fetchCovidVictimsList() {
    return http
        .get(GlobalURL.BaseFirebaseUrl)
        .timeout(Duration(seconds: 5))
        .then((http.Response response) {
      if (response.body == 'null') {
        return Map<String, dynamic>();
      }
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
