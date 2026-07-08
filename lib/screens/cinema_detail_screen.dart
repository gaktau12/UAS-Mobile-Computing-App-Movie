import 'package:flutter/material.dart';
import 'dart:math';
import '../models/mock_data.dart';

class CinemaDetailScreen extends StatelessWidget {
  final Cinema cinema;

  // Menerima data melalui Constructor Parameter (Navigator arguments)
  const CinemaDetailScreen({Key? key, required this.cinema}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List movie random 3 atau 5 
    final randomMovies = (mockMovies.toList()..shuffle(Random())).take(3).toList();

    return Scaffold(
      appBar: AppBar(title: Text(cinema.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cinema.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Sedang Tayang (Random 3):', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: randomMovies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie_filter),
                    title: Text(randomMovies[index].title),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}