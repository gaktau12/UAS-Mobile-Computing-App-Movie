import 'package:flutter/material.dart';
import '../models/mock_data.dart';
import 'login_screen.dart';
import 'movie_detail_screen.dart';
import 'cinema_detail_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BerandaFragment(),
    const ListMovieFragment(),
    const ListCinemaFragment(),
    const ProfilFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
          BottomNavigationBarItem(icon: Icon(Icons.theaters), label: 'Cinema'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// --- Fragment Beranda ---
class BerandaFragment extends StatefulWidget {
  const BerandaFragment({Key? key}) : super(key: key);

  @override
  State<BerandaFragment> createState() => _BerandaFragmentState();
}

class _BerandaFragmentState extends State<BerandaFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Hi, Movie Mania! 👋', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Sedang Hangat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockMovies.length,
                itemBuilder: (context, index) {
                  final movie = mockMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
                      ).then((_) => setState(() {})); 
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(movie.imageAsset),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          movie.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Tiket Saya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            riwayatTransaksi.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.local_activity_outlined, size: 60, color: Colors.grey),
                          SizedBox(height: 10),
                          Text('Belum ada tiket yang dibeli.', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: riwayatTransaksi.length,
                    itemBuilder: (context, index) {
                      final trx = riwayatTransaksi[riwayatTransaksi.length - 1 - index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(trx['image_asset'], width: 50, height: 70, fit: BoxFit.cover),
                          ),
                          title: Text(trx['movie_title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${trx['jumlah_tiket']} Tiket \nRp ${trx['total_harga']}'),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Lunas', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// --- Fragment List Movie ---
class ListMovieFragment extends StatelessWidget {
  const ListMovieFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Sedang Tayang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockMovies.length,
        itemBuilder: (context, index) {
          final movie = mockMovies[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                    child: Image.asset(
                      movie.imageAsset,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(movie.genre, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(movie.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- Fragment List Cinema ---
class ListCinemaFragment extends StatelessWidget {
  const ListCinemaFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Daftar Bioskop', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockCinemas.length,
        itemBuilder: (context, index) {
          final cinema = mockCinemas[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CinemaDetailScreen(cinema: cinema)),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      cinema.imageAsset,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(cinema.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfilFragment extends StatelessWidget {
  const ProfilFragment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}