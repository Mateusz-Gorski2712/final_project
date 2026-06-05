class DogBreed {
  final int id;
  final String name;
  final List<String> subBreeds;
  String imageUrl;

  DogBreed({
    required this.id,
    required this.name,
    required this.subBreeds,
    this.imageUrl = '',
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subBreeds': subBreeds,
      'imageUrl': imageUrl,
    };
  }

  factory DogBreed.fromMap(Map<dynamic, dynamic> map) {
    return DogBreed(
      id: map['id'] as int,
      name: map['name'] as String,
      subBreeds: List<String>.from(map['subBreeds'] ?? []),
      imageUrl: map['imageUrl'] as String,
    );
  }
}