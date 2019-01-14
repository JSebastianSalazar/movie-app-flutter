import 'package:movie_app/model/results.model.dart';

class Movie {
  List<Results> _results;
  int _page;
  int _totalResults;
  Dates _dates;
  int _totalPages;

  Movie(
      {List<Results> results,
        int page,
        int totalResults,
        Dates dates,
        int totalPages}) {
    this._results = results;
    this._page = page;
    this._totalResults = totalResults;
    this._dates = dates;
    this._totalPages = totalPages;
  }

  List<Results> get results => _results;
  set results(List<Results> results) => _results = results;
  int get page => _page;
  set page(int page) => _page = page;
  int get totalResults => _totalResults;
  set totalResults(int totalResults) => _totalResults = totalResults;
  Dates get dates => _dates;
  set dates(Dates dates) => _dates = dates;
  int get totalPages => _totalPages;
  set totalPages(int totalPages) => _totalPages = totalPages;

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _results = new List<Results>();
      json['results'].forEach((v) {
        _results.add(new Results.fromJson(v));
      });
    }
    _page = json['page'];
    _totalResults = json['total_results'];
    _dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
    _totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._results != null) {
      data['results'] = this._results.map((v) => v.toJson()).toList();
    }
    data['page'] = this._page;
    data['total_results'] = this._totalResults;
    if (this._dates != null) {
      data['dates'] = this._dates.toJson();
    }
    data['total_pages'] = this._totalPages;
    return data;
  }
}
