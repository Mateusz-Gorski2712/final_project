import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dog_model.dart';

class ApiService {
  static const String baseUrl = "https://dog.ceo/api";

  static Future<List<DogBreed>> fetchAllBreeds() async {
    final response = await http.get(Uri.parse("$baseUrl/breeds/list/all")).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> breedsMap = data['message'];

      return breedsMap.keys.map((breedName) {
        return DogBreed(
          id: Random().nextInt(1000000),
          name: breedName,
        );
      }).toList();
    } else {
      throw Exception("Nie udało się pobrać ras psów (Kod: ${response.statusCode})");
    }
  }

  static Future<String> fetchRandomImageForBreed(String breedName) async {
    final response = await http.get(Uri.parse("$baseUrl/breed/$breedName/images/random")).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['message'] as String;
    } else {
      throw Exception("Nie udało się pobrać zdjęcia dla rasy: $breedName");
    }
  }
}