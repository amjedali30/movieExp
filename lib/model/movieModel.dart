class Movie {
  final String title;
  final String year;
  final String poster;
  final String imdbID;

  Movie(
      {required this.title,
      required this.year,
      required this.poster,
      required this.imdbID});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? "Unknown",
      year: json['Year'] ?? "N/A",
      poster: (json['Poster'] != null && json['Poster'] != "N/A")
          ? json['Poster']
          : "assets/image/placeHilderImg.jpeg",
      imdbID: json['imdbID'] ?? "",
    );
  }
}
