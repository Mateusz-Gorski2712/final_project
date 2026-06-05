import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'api_service.dart';

void main() {
  runApp(const DogApp());
}

class DogApp extends StatelessWidget {
  const DogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista psów',
      theme: ThemeData(primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF9F9FB),
      ),
      home: const BreedListScreen(),
    );
  }
}

class BreedListScreen extends StatefulWidget {
  const BreedListScreen({super.key});

  @override
  State<BreedListScreen> createState() => _BreedListScreenState();
}

class _BreedListScreenState extends State<BreedListScreen> {
  late Future<List<DogBreed>> _breedsFuture;

  @override
  void initState() {
    super.initState();
    _loadBreeds();
  }

  void _loadBreeds() {
    setState(() {
      _breedsFuture = ApiService.fetchAllBreeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Odkrywaj rasy psów"),
        backgroundColor: const Color(0xFFADEBB3),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadBreeds,
          ),
        ],
      ),
      body: FutureBuilder<List<DogBreed>>(
        future: _breedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFADEBB3)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Wystąpił problem!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString().replaceAll("Exception: ", ""),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFADEBB3)),
                      onPressed: _loadBreeds,
                      child: const Text("Spróbuj ponownie", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          }

          final breeds = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: breeds.length,
            itemBuilder: (context, index) {
              final breed = breeds[index];
              final formattedName = breed.name[0].toUpperCase() + breed.name.substring(1);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFADEBB3),
                    child: Icon(Icons.pets_rounded, color: Colors.white),
                  ),
                  title: Text(formattedName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BreedDetailScreen(breed: breed),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BreedDetailScreen extends StatefulWidget {
  final DogBreed breed;
  const BreedDetailScreen({super.key, required this.breed});

  @override
  State<BreedDetailScreen> createState() => _BreedDetailScreenState();
}


class _BreedDetailScreenState extends State<BreedDetailScreen> {
  late Future<String> _imageFuture;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    setState(() {
      _imageFuture = ApiService.fetchRandomImageForBreed(widget.breed.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleName = widget.breed.name[0].toUpperCase() + widget.breed.name.substring(1);

    return Scaffold(
      appBar: AppBar(title: Text(titleName), backgroundColor: Color(0xFFADEBB3)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder<String>(
            future: _imageFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Color(0xFFADEBB3));
              }

              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.broken_image_rounded, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      "Nie można załadować zdjęcia",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFADEBB3)),
                      onPressed: _loadImage,
                      child: const Text("Odśwież", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                );
              }

              final imageUrl = snapshot.data!;

              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  key: const ValueKey("mock_card"),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "zdjęcie: $titleName",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Dostępne typy tej rasy:",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      if (widget.breed.subBreeds.isEmpty)
                        const Text(
                          "Brak dodatkowych typów",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        )
                      else
                        Text(
                          widget.breed.subBreeds.join(", "),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, color: Color(0xFFADEBB3)),
                        ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _loadImage,
                        icon: const Icon(Icons.refresh_rounded, color: Color(0xFFADEBB3)),
                        label: const Text("Losuj inne zdjęcie", style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}