class PersonMovie{
  int id;
  String name;

  PersonMovie({
    required this.id,
    required this.name,
  });

  //method ini buat convert dari json array ke object
  factory PersonMovie.fromJson(Map<String, dynamic> json){
    return PersonMovie(
      id: json['person_id'] as int,
      name: json['person_name'] as String
    );
  }
}