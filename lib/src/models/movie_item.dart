class MovieItem {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;
  final String releaseDate;

  MovieItem.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        overview = parsedJson['overview'],
        posterPath = parsedJson['poster_path'],
        backdropPath = parsedJson['backdrop_path'],
        popularity = parsedJson['popularity'].toDouble(),
        voteAverage = parsedJson['vote_average'].toDouble(),
        voteCount = parsedJson['vote_count'],
        genres = _convertGenres(parsedJson['genre_ids']),
        releaseDate = parsedJson['release_date'];

  static List<String> _convertGenres(List<dynamic> val) {
    return val.map((genreId) => _genresCodes[genreId.toInt()]).toList();
  }

  static Map<int, String> _genresCodes = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
  };
}
