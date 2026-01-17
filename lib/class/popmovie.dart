
class PopMovie {
  int id;
  String title;
  String overview;
  String voteAverage;
  String runtime;
  String release_date;
  String url;
  String homepage;
  List? genres;       

  PopMovie({
    required this.id,    //required itu intinya apakah wajib di isi
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.runtime,
    required this.release_date,
    required this.url,
    required this.homepage,
    this.genres,
  });

  //method ini buat convert dari json array ke object 
  factory PopMovie.fromJson(Map<String, dynamic> json) {
    return PopMovie(
      id: json['movie_id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: json['voteAverage'] != null ? json['voteAverage'].toString() : '0.0',
      runtime: json['runtime'] != null ? json['runtime'].toString() : '0', // Tambahan
      release_date: json['release_date'] as String? ?? '', // Tambahan dengan null safety check
      url: json['url'] as String? ?? '', // Tambahan
      homepage: json['homepage'] as String? ?? '', // Tambahan
      genres: json['genres'],
    );
  }
}


