class PersonMovie{
  int id;
  String name;
  String character;

  PersonMovie({
    required this.id,
    required this.name,
    required this.character
  });

  //method ini buat convert dari json array ke object
  factory PersonMovie.fromJson(Map<String, dynamic> json){
    return PersonMovie(
      id: json['person_id'] as int,
      name: json['person_name'] as String,
      character: json['character_name'] as String,
    );
  }
}