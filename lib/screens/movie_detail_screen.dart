import 'package:flutter/material.dart';
import '../models/mock_data.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  void _tampilkanBottomSheetTransaksi(BuildContext context) {
    int jumlahTiket = 1;
    final int hargaPerTiket = 50000; 

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Detail Pemesanan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(movie.imageAsset, width: 70, height: 100, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(movie.genre, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                            const SizedBox(height: 12),
                            Text('Rp $hargaPerTiket / tiket', style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 40, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jumlah Tiket', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (jumlahTiket > 1) {
                                setModalState(() => jumlahTiket--);
                              }
                            },
                            icon: Icon(Icons.remove_circle_outline, color: jumlahTiket > 1 ? Colors.blueAccent : Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('$jumlahTiket', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          IconButton(
                            onPressed: () {
                              if (jumlahTiket < 10) { 
                                setModalState(() => jumlahTiket++);
                              }
                            },
                            icon: const Icon(Icons.add_circle_outline, color: Colors.blueAccent),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          'Rp ${jumlahTiket * hargaPerTiket}', 
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => Navigator.pop(context), 
                          child: const Text('Batal', style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          onPressed: () {
                            riwayatTransaksi.add({
                              'movie_title': movie.title,
                              'jumlah_tiket': jumlahTiket,
                              'total_harga': jumlahTiket * hargaPerTiket,
                              'image_asset': movie.imageAsset,
                            });

                            Navigator.pop(context); 

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check_circle, color: Colors.green, size: 80),
                                      const SizedBox(height: 16),
                                      const Text('Pembayaran Berhasil!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      Text('Kamu membeli $jumlahTiket tiket ${movie.title}.', textAlign: TextAlign.center),
                                      const SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context); 
                                            Navigator.pop(context); 
                                          },
                                          child: const Text('Cek Tiket di Beranda', style: TextStyle(color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                            );
                          },
                          child: const Text('Bayar', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableCinemas = mockCinemas.take(5).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title, style: const TextStyle(color: Colors.white, shadows: [Shadow(color: Colors.black87, blurRadius: 10)])),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(movie.imageAsset, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(movie.genre, style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)), 
                        backgroundColor: Colors.blue[50],
                        side: BorderSide.none,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 28),
                          const SizedBox(width: 6),
                          Text('${movie.rating} / 10', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Sinopsis', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    movie.description,
                    style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 28),
                  const Text('Tersedia di Bioskop:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...availableCinemas.map((cinema) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.theaters, color: Colors.blueAccent),
                          ),
                          title: Text(cinema.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ),
                      )),
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () => _tampilkanBottomSheetTransaksi(context),
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Beli Tiket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        icon: const Icon(Icons.local_activity, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}