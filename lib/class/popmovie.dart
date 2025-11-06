
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
}

// factory PopMovie.fromJson(Map<String, dynamic> json){
//   return PopMovie(
//     id: json['id'] as int,
//     title: json['title'] as String,
//     overview: json['overview'] as String,
//     voteAverage: json['vote_average'] != null ? json['vote_average'].toString() : '0.0',
//   );
// }