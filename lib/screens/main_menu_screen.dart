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

  @override
  Widget build(BuildContext context) {
    // List pages dipindahkan ke dalam build agar bisa mengakses setState
    final List<Widget> pages = [
      BerandaFragment(onTabChanged: (index) => setState(() => _currentIndex = index)),
      const ListMovieFragment(),
      const ListCinemaFragment(),
      const ProfilFragment(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F171E),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B1218),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00A294), // Tosca m.tix
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.theaters_outlined), label: 'Cinema'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'My m.tix'),
        ],
      ),
    );
  }
}

// --- Fragment Beranda (Sudah dikembalikan Riwayat Transaksinya) ---
class BerandaFragment extends StatefulWidget {
  final Function(int) onTabChanged;
  
  const BerandaFragment({Key? key, required this.onTabChanged}) : super(key: key);

  @override
  State<BerandaFragment> createState() => _BerandaFragmentState();
}

class _BerandaFragmentState extends State<BerandaFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Text('Go•Tix ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: -1, color: Colors.white)),
            Text('by DNA', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: const [
                Icon(Icons.location_on, size: 16, color: Colors.white),
                SizedBox(width: 4),
                Text('JAKARTA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Utama
            Container(
              margin: const EdgeInsets.all(16),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(image: AssetImage(mockMovies[0].imageAsset), fit: BoxFit.cover),
              ),
            ),
            
            // Menu Ikon Bulat yang bisa diklik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenuIcon(Icons.confirmation_num_outlined, 'Cinema', () => widget.onTabChanged(2)),
                  _buildMenuIcon(Icons.movie_filter_outlined, 'Movies', () => widget.onTabChanged(1)),
                  _buildMenuIcon(Icons.fastfood_outlined, 'm.food', () {}),
                  _buildMenuIcon(Icons.chair_outlined, 'Booking', () {}),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Section: Now Playing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Now playing', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                    child: const Icon(Icons.chat, size: 16, color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
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
                        MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie))
                      ).then((_) => setState(() {})); // Fungsi ini me-refresh halaman setelah checkout
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(movie.imageAsset, fit: BoxFit.cover, width: 160),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // Section: Tiket Saya (Riwayat Transaksi)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('My Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 10),
            riwayatTransaksi.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.receipt_long_outlined, size: 60, color: Colors.grey),
                          SizedBox(height: 10),
                          Text('You have no active orders.', style: TextStyle(color: Colors.grey)),
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
                        color: const Color(0xFF1E272E),
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(trx['image_asset'], width: 50, height: 70, fit: BoxFit.cover),
                          ),
                          title: Text(trx['movie_title'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          subtitle: Text('${trx['jumlah_tiket']} Tiket \nRp ${trx['total_harga']}', style: const TextStyle(color: Colors.grey)),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00A294).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Paid', style: TextStyle(color: Color(0xFF00A294), fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF00A294), width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: const Color(0xFF00A294), size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Movies', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockMovies.length,
        itemBuilder: (context, index) {
          final movie = mockMovies[index];
          return Card(
            color: const Color(0xFF1E272E),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                    child: Image.asset(movie.imageAsset, width: 100, height: 150, fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(movie.genre, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(movie.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(movie.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.white70)),
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Cinema', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockCinemas.length,
        itemBuilder: (context, index) {
          final cinema = mockCinemas[index];
          return Card(
            color: const Color(0xFF1E272E),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CinemaDetailScreen(cinema: cinema))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(cinema.imageAsset, height: 150, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(cinema.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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

// --- Fragment Profil ---
class ProfilFragment extends StatelessWidget {
  const ProfilFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My m.tix', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: const [
          Center(child: Padding(padding: EdgeInsets.only(right: 16.0), child: Text('Version 9.2.0', style: TextStyle(color: Colors.grey)))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: const Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Apoy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 4),
                      Text('+6281234567890', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('m.tix POINT: 0', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                const Icon(Icons.edit, color: Colors.white, size: 20),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E272E), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet_outlined, size: 28, color: Colors.white),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Payment methods', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Manage your cards and e-wallets', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Settings', style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 16),
            _buildListTile(Icons.security, 'Account safety'),
            _buildListTile(Icons.language, 'Language'),
            _buildListTile(Icons.dark_mode_outlined, 'Theme'),
            const SizedBox(height: 24),
            const Text('Others', style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 16),
            _buildListTile(Icons.description_outlined, 'Terms of service'),
            _buildListTile(Icons.help_outline, 'Help center'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                child: const Text('Log Out', style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFF1E272E), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
        ],
      ),
    );
  }
}