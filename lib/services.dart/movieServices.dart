import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movieDetail.dart';
import '../model/movieModel.dart';

class OmdbService {
  final String apiKey = "2baac8ba";

  /// Search movies by query + page
  Future<List<Movie>> searchMovies(String query, int page) async {
    final url = Uri.parse(
        "https://www.omdbapi.com/?apikey=$apiKey&s=$query&page=$page");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["Search"] != null) {
        return List<Movie>.from(
          data["Search"].map((movie) => Movie.fromJson(movie)),
        );
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to fetch movies");
    }
  }

  /// Fetch single movie details by imdbID
  Future<MovieDetail> fetchMovieDetail(String imdbID) async {
    final url = Uri.parse(
        "https://www.omdbapi.com/?apikey=$apiKey&i=$imdbID&plot=full");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MovieDetail.fromJson(data);
    } else {
      throw Exception("Failed to fetch movie detail");
    }
  }
}
