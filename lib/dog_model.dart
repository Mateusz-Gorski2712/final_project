class DogBreed {
  final int id;
  final String name;
  String imageUrl;

  DogBreed({
    required this.id,
    required this.name,
    this.imageUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory DogBreed.fromMap(Map<dynamic, dynamic> map) {
    return DogBreed(
      id: map['id'] as int,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}