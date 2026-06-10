import 'package:hive_ce/hive.dart';
import 'dog_model.dart';

class DogLocalDatabase {
  static List<DogBreed> getBreeds() {
    final box = Hive.box("dogs");
    return box.values.map((map) => DogBreed.fromMap(map)).toList();
  }

  static Future<void> saveBreeds(List<DogBreed> breeds) async {
    final box = Hive.box("dogs");
    await box.clear();
    for (var breed in breeds) {
      await box.put(breed.id, breed.toMap());
    }
  }
}