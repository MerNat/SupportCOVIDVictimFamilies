import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/components/global/global-widgets.dart';
import 'package:support_covid_victims/ui/components/model/main-model.dart';
import 'package:support_covid_victims/ui/covid-victims/viewmodel/covid-victims-viewmodel.dart';
import 'package:support_covid_victims/ui/home/viewmodel/home-viewmodel.dart';

class CovidVictimComponent extends StatefulWidget {
  final bool isAll;
  final CountryViewModel singleCountryViewModel;

  CovidVictimComponent({this.isAll = true, this.singleCountryViewModel = null});
  @override
  State<StatefulWidget> createState() {
    return _CovidVictimsPage();
  }
}

class _CovidVictimsPage extends State<CovidVictimComponent> {
  MainModel _model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isAll) {
        _model.fetchAllCovidVictims(_model, true, null);
        return;
      }
      _model.fetchAllCovidVictims(
          _model, false, widget.singleCountryViewModel.countryId);
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
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalWidgets.getWidth(context) * 0.02,
                      vertical: GlobalWidgets.getWidth(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          child: widget.isAll
                              ? Icon(Icons.menu, color: Colors.black)
                              : Icon(Icons.arrow_back, color: Colors.black),
                          onTap: () {
                            if (widget.isAll) {
                              Scaffold.of(context).openDrawer();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    widget.isAll
                        ? 'COVID Victims Seeking Support'
                        : '${widget.singleCountryViewModel.countryName} COVID Victims Seeking Support',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: !widget.isAll
                            ? GlobalWidgets.getWidth(context) * 0.045
                            : GlobalWidgets.getWidth(context) * 0.045),
                  ),
                ),
                model.hasCovidVictimsLoaded
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          child: Align(
                            child: RefreshIndicator(
                                child: model.hasCovidVictimsError
                                    ? GlobalWidgets.generateNoInternet(
                                        context, true)
                                    : model.getCovidVictimsList.length > 0
                                        ? ListView.builder(
                                            itemCount: model
                                                .getCovidVictimsList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _generateListTile(
                                                  model.getCovidVictimsList[
                                                      index],
                                                  model.launchURL);
                                            })
                                        : GlobalWidgets.generateNoInternet(
                                            context, false),
                                onRefresh: () => widget.isAll
                                    ? model.fetchAllCovidVictims(
                                        model, true, null)
                                    : model.fetchAllCovidVictims(
                                        model,
                                        false,
                                        widget
                                            .singleCountryViewModel.countryId)),
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

  Widget _generateListTile(
      CovidVictimViewModel _singleCovidVictim, Function urlLanucher) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalWidgets.getWidth(context) * 0.04),
      child: Container(
        padding:
            EdgeInsets.only(bottom: GlobalWidgets.getWidth(context) * 0.02),
        margin: EdgeInsets.only(bottom: GlobalWidgets.getWidth(context) * 0.04),
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
            urlLanucher(_singleCovidVictim.victimFundUrl);
          },
          trailing: _singleCovidVictim.countryViewModel.countryFlag == null
              ? null
              : IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
          leading: _singleCovidVictim.countryViewModel.countryFlag == null
              ? null
              : CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Image.network(
                      _singleCovidVictim.countryViewModel.countryFlag)),
          title: Text(
            _singleCovidVictim.countryViewModel.countryName,
            style: TextStyle(
                height: 2.0,
                fontSize: GlobalWidgets.getWidth(context) * 0.04,
                fontWeight: FontWeight.w600),
          ),
          isThreeLine: true,
          subtitle: RichText(
              text: TextSpan(
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
            children: [
              TextSpan(text: 'Name  '),
              TextSpan(
                  text: '${_singleCovidVictim.victimName}',
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.red.withOpacity(0.9),
                      fontWeight: FontWeight.w500)),
            ],
          )),
        ),
      ),
    );
  }
}
