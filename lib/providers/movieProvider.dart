import 'package:flutter/material.dart';
import 'package:movie_explorer/model/movieDetail.dart';
import '../model/movieModel.dart';
import '../services.dart/movieServices.dart';

class MovieProvider with ChangeNotifier {
  final OmdbService _service = OmdbService();

  List<Movie> _trending = [];
  bool _loading = false;
  MovieDetail? _details;

  List<Movie> get trending => _trending;
  bool get loading => _loading;
  MovieDetail? get details => _details;

  Future<void> fetchTrending() async {
    _loading = true;
    notifyListeners();

    try {
      final results = await _service.searchMovies("avengers", 1);
      _trending = results;
      notifyListeners();
    } catch (e) {
      _trending = [];
    }

    _loading = false;
    notifyListeners();
  }

  Future<MovieDetail?> fetchMovieDetail(String imdbID) async {
    _loading = true;
    notifyListeners();

    try {
      final results = await _service.fetchMovieDetail(imdbID);
      _details = results;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      return null;
    }
  }
}
