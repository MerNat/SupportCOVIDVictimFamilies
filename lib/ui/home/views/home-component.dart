import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/covid-victims/views/covid-victims-component.dart';
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
      _model.setFilterValue('');
      _model.fetchCountriesSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                              hintText: 'Search Country',
                              border: InputBorder.none,
                              fillColor: Colors.grey.withOpacity(0.5),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey)),
                        ))),
                model.isCountryFetchDone
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          child: Align(
                            child: RefreshIndicator(
                                child: model.hasFetchError
                                    ? GlobalWidgets.generateNoInternet(
                                        context, true)
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
        })),
      ),
    );
  }

  Widget _generateListTile(CountryViewModel _countrySummaryModel) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalWidgets.getWidth(context) * 0.04),
      child: Container(
        margin: EdgeInsets.only(bottom: GlobalWidgets.getWidth(context) * 0.05),
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
        child: ListTile(
          onTap: () {
            if (_countrySummaryModel.countryFlag != null) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CovidVictimComponent(
                    isAll: false, singleCountryViewModel: _countrySummaryModel);
              }));
            }
          },
          trailing: _countrySummaryModel.countryFlag == null
              ? null
              : IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
          leading: _countrySummaryModel.countryFlag == null
              ? null
              : CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Image.network(_countrySummaryModel.countryFlag)),
          title: Text(
            _countrySummaryModel.countryName,
            style: TextStyle(
                height: 2.0,
                fontSize: GlobalWidgets.getWidth(context) * 0.04,
                fontWeight: FontWeight.w600),
          ),
          isThreeLine: true,
          subtitle: RichText(
              text: TextSpan(
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
            children: <TextSpan>[
              TextSpan(text: 'Total Confirmed  '),
              TextSpan(
                  text: '${_countrySummaryModel.totalConfirmed}',
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.red.withOpacity(0.9),
                      fontWeight: FontWeight.w500)),
              TextSpan(text: '\nTotal Death  '),
              TextSpan(
                  text: '${_countrySummaryModel.totalDeaths}',
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.red.withOpacity(0.9),
                      fontWeight: FontWeight.w500)),
              _countrySummaryModel.countryFlag == null
                  ? TextSpan()
                  : TextSpan(text: '\nNew Confirmed  '),
              _countrySummaryModel.countryFlag == null
                  ? TextSpan()
                  : TextSpan(
                      text: '${_countrySummaryModel.newConfirmed}',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.red.withOpacity(0.9),
                          fontWeight: FontWeight.w500)),
              _countrySummaryModel.countryFlag == null
                  ? TextSpan()
                  : TextSpan(text: '\nNew Deaths  '),
              _countrySummaryModel.countryFlag == null
                  ? TextSpan()
                  : TextSpan(
                      text: '${_countrySummaryModel.newDeaths}',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.red.withOpacity(0.9),
                          fontWeight: FontWeight.w500)),
              TextSpan(text: '\nTotal Recovered  '),
              TextSpan(
                  text: '${_countrySummaryModel.totalRecovered}',
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.red.withOpacity(0.9),
                      fontWeight: FontWeight.w500))
            ],
          )),
        ),
      ),
    );
  }
}
