import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/home/viewmodel/home-viewmodel.dart';

class HomeComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomeComponent> {
  MainModel _model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.fetchCountriesSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: GlobalWidgets.getDrawer(context),
      ),
      body: SafeArea(child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        _model = model;
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: GlobalWidgets.getHeight(context) * 0.01,
              vertical: GlobalWidgets.getHeight(context) * 0.03),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(GlobalWidgets.getWidth(context) * 0.04),
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
                      horizontal: GlobalWidgets.getWidth(context) * 0.04),
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: GlobalWidgets.getHeight(context) * 0.04),
                      padding: EdgeInsets.only(left: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextField(
                        onChanged: (value) {
                          model.filterCovidSummaryList(value);
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.5),
                            prefixIcon: Icon(Icons.search, color: Colors.grey)),
                      ))),
              model.isCountryFetchDone
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            FocusScope.of(context).requestFocus(FocusNode()),
                        child: Align(
                          child: RefreshIndicator(
                              child: model.hasFetchError
                                  ? _generateNoInternet()
                                  : ListView.builder(
                                      itemCount:
                                          model.getCovidSummaryList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _generateListTile(
                                            model.getCovidSummaryList[index]);
                                      }),
                              onRefresh: model.fetchCountriesSummary),
                        ),
                      ),
                    )
                  : Padding(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                      padding: EdgeInsets.only(
                          top: GlobalWidgets.getHeight(context) * 0.2),
                    ),
            ],
          ),
        );
      })),
    );
  }

  Widget _generateNoInternet() {
    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: GlobalWidgets.getHeight(context) * 0.15),
                child: Icon(
                  Icons.portable_wifi_off,
                  color: Colors.grey.withOpacity(1),
                  size: GlobalWidgets.getWidth(context) * 0.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'No Internet',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(1),
                      fontSize: GlobalWidgets.getWidth(context) * 0.06),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _generateListTile(CountryViewModel _countrySummaryModel) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalWidgets.getWidth(context) * 0.04),
      child: Container(
        margin: EdgeInsets.only(bottom: GlobalWidgets.getWidth(context) * 0.05),
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
        child: ListTile(
          onTap: () {},
          trailing:
              IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
          // leading: FlutterLogo(size: GlobalWidgets.getWidth(context) * 0.1),
          leading: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              child: Image.network(_countrySummaryModel.countryFlag)),
          title: Text(_countrySummaryModel.countryName),
          isThreeLine: true,
          subtitle: RichText(
              text: TextSpan(
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
            children: <TextSpan>[
              TextSpan(text: 'Total Confirmed  '),
              TextSpan(
                  text: '${_countrySummaryModel.totalConfirmed}',
                  style: TextStyle(
                      color: Colors.red.withOpacity(0.9),
                      fontWeight: FontWeight.w500)),
              TextSpan(text: '\nTotal Death  '),
              TextSpan(
                  text: '${_countrySummaryModel.totalDeaths}',
                  style: TextStyle(
                      color: Colors.red.withOpacity(0.9),
                      fontWeight: FontWeight.w500))
            ],
          )),
          // dense: true,
        ),
      ),
    );
  }
}
