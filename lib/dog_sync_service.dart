import 'api_service.dart';
import 'dog_local_database.dart';

class DogSyncService {
  static Future<void> loadInitialDataIfNeeded() async {
    final localBreeds = DogLocalDatabase.getBreeds();

    if (localBreeds.isEmpty) {
      try {
        final apiBreeds = await ApiService.fetchAllBreeds();
        await DogLocalDatabase.saveBreeds(apiBreeds);
      } catch (e) {
        print("Błąd synchronizacji: $e");
      }
    }
  }
}