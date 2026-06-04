import 'package:flutter/material.dart';

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
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const BreedListScreen(),
    );
  }
}

class BreedListScreen extends StatelessWidget {
  const BreedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> mockBreeds = ["Wyzel", "Spaniel", "Jamnik", "Labrador"];

    return Scaffold(
      appBar: AppBar(title: const Text("Odkrywaj rasy psów"), backgroundColor: const Color(0xFFADEBB3)),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mockBreeds.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFADEBB3),
                child: Icon(Icons.pets_rounded, color: Colors.white),
              ),
              title: Text(mockBreeds[index], style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BreedDetailScreen(breedName: mockBreeds[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BreedDetailScreen extends StatelessWidget {
  final String breedName;
  const BreedDetailScreen({super.key, required this.breedName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(breedName), backgroundColor: Color(0xFFADEBB3)),
      body: Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            key: const ValueKey("mock_card"),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.image, size: 150, color: Colors.grey),
                const SizedBox(height: 16),
                Text("zdjęcie $breedName"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}