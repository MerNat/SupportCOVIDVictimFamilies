import 'package:flutter/material.dart';

class NewsViewModel {
  String newsAuthor;
  String newsTitle;
  String newsUrl;
  String newsUrlToImage;
  String publishedAt;

  NewsViewModel(
      {@required this.newsAuthor,
      @required this.newsTitle,
      @required this.publishedAt,
      @required this.newsUrl,
      @required this.newsUrlToImage});
}
