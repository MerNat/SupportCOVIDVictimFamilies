import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/news/viewmodel/news-viewmodel.dart';

class NewsComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsPage();
  }
}

class _NewsPage extends State<NewsComponent> {
  MainModel _model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: GlobalWidgets.getDrawer(context),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          _model = model;
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: GlobalWidgets.getHeight(context) * 0.015,
                vertical: GlobalWidgets.getHeight(context) * 0.05),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          child: Icon(Icons.menu, color: Colors.black),
                          onTap: () => Scaffold.of(context).openDrawer(),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalWidgets.getWidth(context) * 0.045,
                      vertical: GlobalWidgets.getWidth(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        child: Text(
                          'Latest News',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: GlobalWidgets.getWidth(context) * 0.06),
                        ),
                      )
                    ],
                  ),
                ),
                model.getIsNewsFetch
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          child: Align(
                            child: RefreshIndicator(
                                color: Colors.black,
                                child: model.getHasNewsError
                                    ? GlobalWidgets.generateNoInternet(
                                        context, true)
                                    : ListView.builder(
                                        itemCount: model.getNewsData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _generateNewsCard(
                                              model.launchURL,
                                              model.getNewsData[index]);
                                        }),
                                onRefresh: model.fetchNews),
                          ),
                        ),
                      )
                    : Padding(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black.withOpacity(0.8)),
                          strokeWidth: 3,
                        ),
                        padding: EdgeInsets.only(
                            top: GlobalWidgets.getHeight(context) * 0.2),
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _generateNewsCard(Function launchUrl, NewsViewModel _newsInfo) {
    return InkWell(
      onTap: () => launchUrl(_newsInfo.newsUrl),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: GlobalWidgets.getWidth(context) * 0.04),
        child: Container(
          margin:
              EdgeInsets.only(bottom: GlobalWidgets.getWidth(context) * 0.05),
          padding:
              EdgeInsets.only(bottom: GlobalWidgets.getWidth(context) * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 3,
                  offset: Offset(
                    10.0,
                    10.0,
                  ),
                )
              ],
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0)),
                  child: Container(
                    width: GlobalWidgets.getWidth(context),
                    child: Align(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: FadeInImage(
                          image: NetworkImage(_newsInfo.newsUrlToImage),
                          placeholder: AssetImage('assets/img/grey.jpg')),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.005),
                  child: ListTile(
                    onTap: () {},
                    trailing: IconButton(
                        icon: Icon(Icons.arrow_forward), onPressed: () {}),
                    title: Text(
                      '\n${_newsInfo.newsTitle}\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    isThreeLine: true,
                    subtitle: RichText(
                        textWidthBasis: TextWidthBasis.longestLine,
                        text: TextSpan(
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                          children: [
                            TextSpan(text: 'Source  '),
                            TextSpan(
                                text: _newsInfo.newsAuthor,
                                style: TextStyle(
                                    color: Colors.red.withOpacity(0.9),
                                    fontWeight: FontWeight.w500)),
                            TextSpan(text: '\nPublished  '),
                            TextSpan(
                                text: _newsInfo.publishedAt,
                                style: TextStyle(
                                    color: Colors.red.withOpacity(0.9),
                                    fontWeight: FontWeight.w500))
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
