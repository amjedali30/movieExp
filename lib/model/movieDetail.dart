class MovieDetail {
  final String title;
  final String year;
  final String plot;
  final String poster;
  final String genre;
  final String runtime;
  final String language;
  final String rated;
  final String actors;

  MovieDetail({
    required this.title,
    required this.year,
    required this.plot,
    required this.poster,
    required this.genre,
    required this.runtime,
    required this.language,
    required this.rated,
    required this.actors,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      title: json['Title'] ?? "Unknown",
      year: json['Year'] ?? "N/A",
      plot: json['Plot'] ?? "No description available",
      poster: (json['Poster'] != null && json['Poster'] != "N/A")
          ? json['Poster']
          : "assets/image/placeHilderImg.jpeg",
      genre: json['Genre'] ?? "Unknown",
      runtime: json['Runtime'] ?? "N/A",
      language: json['Language'] ?? "N/A",
      rated: json['Rated'] ?? "N/A",
      actors: json['Actors'] ?? "N/A",
    );
  }
}
