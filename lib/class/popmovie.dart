
class PopMovie {
  int id;
  String title;
  String overview;
  String voteAverage;

  PopMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
  });

  //method ini buat convert dari json array ke object 
  factory PopMovie.fromJson(Map<String, dynamic> json){
    return PopMovie(
      id: json['movie_id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: json['voteAverage'] != null ? json['voteAverage'].toString(): '0.0'
    ); 
  }
}


