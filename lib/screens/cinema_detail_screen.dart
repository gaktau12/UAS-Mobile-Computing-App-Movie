import 'package:flutter/material.dart';
import 'dart:math';
import '../models/mock_data.dart';

class CinemaDetailScreen extends StatefulWidget {
  final Cinema cinema;

  // Menerima data melalui Constructor Parameter (Navigator arguments)
  const CinemaDetailScreen({Key? key, required this.cinema}) : super(key: key);

  @override
  State<CinemaDetailScreen> createState() => _CinemaDetailScreenState();
}

class _CinemaDetailScreenState extends State<CinemaDetailScreen> {
  int _selectedDateIndex = 0;
  late List<Movie> _randomMovies;

  @override
  void initState() {
    super.initState();
    // Mengambil 3 film random dan dikunci di initState agar tidak berubah saat ganti tanggal
    _randomMovies = (mockMovies.toList()..shuffle(Random())).take(3).toList();
  }

  // Fungsi Transaksi Bottom Sheet yang terhubung dengan Beranda
  void _tampilkanBottomSheetTransaksi(BuildContext context, Movie movie, String jamTayang) {
    int jumlahTiket = 1;
    final int hargaPerTiket = 50000;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E272E),
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
                      decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Detail Pemesanan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
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
                            Text(movie.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 4),
                            Text('${widget.cinema.name} • $jamTayang', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                            const SizedBox(height: 12),
                            Text('Rp $hargaPerTiket / tiket', style: const TextStyle(color: Color(0xFF00A294), fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 40, thickness: 1, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jumlah Tiket', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (jumlahTiket > 1) setModalState(() => jumlahTiket--);
                            },
                            icon: Icon(Icons.remove_circle_outline, color: jumlahTiket > 1 ? const Color(0xFF00A294) : Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F171E),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('$jumlahTiket', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          IconButton(
                            onPressed: () {
                              if (jumlahTiket < 10) setModalState(() => jumlahTiket++);
                            },
                            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF00A294)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F171E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00A294).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(
                          'Rp ${jumlahTiket * hargaPerTiket}', 
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00A294)),
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
                            side: const BorderSide(color: Color(0xFF00A294)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => Navigator.pop(context), 
                          child: const Text('Batal', style: TextStyle(fontSize: 16, color: Color(0xFF00A294), fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A294),
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
                            _showSuccessDialog();
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E272E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF00A294), size: 80),
              const SizedBox(height: 16),
              const Text('Pembayaran Berhasil!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A294),
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
  }

  @override
  Widget build(BuildContext context) {
    // Generate 7 hari ke depan untuk tab tanggal
    final DateTime today = DateTime.now();
    final List<DateTime> dates = List.generate(7, (index) => today.add(Duration(days: index)));

    return Scaffold(
      backgroundColor: const Color(0xFF0F171E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: Text(widget.cinema.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 56.0, bottom: 8.0),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF00A294)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                ),
                onPressed: () {},
                icon: const Icon(Icons.info_outline, color: Color(0xFF00A294), size: 16),
                label: const Text('Cinema info', style: TextStyle(color: Color(0xFF00A294), fontSize: 12)),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // Horizontal Date Selector
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final date = dates[index];
                  final bool isSelected = _selectedDateIndex == index;
                  const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  String dayName = index == 0 ? 'Today' : dayNames[date.weekday - 1];
                  
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDateIndex = index),
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF00A294) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(dayName, style: TextStyle(color: isSelected ? Colors.black : Colors.grey, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(date.day.toString().padLeft(2, '0'), style: TextStyle(color: isSelected ? Colors.black : Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            
            // Filter Row (Cinema XXI)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Text('Cinema XXI', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Movie List menggunakan ExpansionTile
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _randomMovies.length,
              itemBuilder: (context, index) {
                final movie = _randomMovies[index];
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Theme(
                    // Menghilangkan garis pembatas default ExpansionTile
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.all(12),
                        childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                        backgroundColor: const Color(0xFF1E272E),
                        collapsedBackgroundColor: const Color(0xFF1E272E),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(movie.imageAsset, width: 80, height: 110, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(movie.title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text(movie.genre, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      _buildTag('1h 56m'),
                                      const SizedBox(width: 8),
                                      _buildTag('13+', isWarning: true),
                                      const SizedBox(width: 8),
                                      _buildTag('2D'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        children: [
                          // Tampilan saat di-expand (Jadwal Tayang)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF00A294)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.info_outline, color: Color(0xFF00A294), size: 16),
                              label: const Text('Movie info', style: TextStyle(color: Color(0xFF00A294), fontSize: 12)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Reguler 2D', style: TextStyle(color: Colors.grey, fontSize: 14)),
                              Text('Rp50.000', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildTimeSlot(context, movie, '12:45'),
                                _buildTimeSlot(context, movie, '14:10'),
                                _buildTimeSlot(context, movie, '16:25'),
                              ],
                            ),
                          )
                        ],
                      ),
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

  // Helper untuk Tag (1h 56m, 13+, 2D)
  Widget _buildTag(String text, {bool isWarning = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 12),
          if (isWarning) const SizedBox(width: 2),
          Text(text, style: TextStyle(color: isWarning ? Colors.amber : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper untuk Tombol Jam Tayang
  Widget _buildTimeSlot(BuildContext context, Movie movie, String time) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 80) / 2, // Layout 2 kolom untuk jam
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A294),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () => _tampilkanBottomSheetTransaksi(context, movie, time),
        child: Text(time, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}