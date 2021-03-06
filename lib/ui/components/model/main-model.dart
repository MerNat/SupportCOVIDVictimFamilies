import 'package:scoped_model/scoped_model.dart';
import 'package:support_covid_victims/ui/covid-victims/presenter/covid-vcitims-presenter.dart';
import 'package:support_covid_victims/ui/home/presenter/home-presenter.dart';
import 'package:support_covid_victims/ui/news/presenter/news-presenter.dart';

class MainModel extends Model
    with HomeComponentPresenter, NewsPresenter, CovidVictimsPresenter {}
