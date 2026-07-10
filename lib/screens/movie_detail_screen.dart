import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/mock_data.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int _selectedDateIndex = 0;
  bool _isScheduleTab = true;

  void _tampilkanBottomSheetTransaksi(BuildContext context, Cinema cinema, String jamTayang) {
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
                        child: Image.asset(widget.movie.imageAsset, width: 70, height: 100, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.movie.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 4),
                            Text('${cinema.name} • $jamTayang', style: const TextStyle(color: Colors.grey, fontSize: 13)),
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
                              'movie_title': widget.movie.title,
                              'jumlah_tiket': jumlahTiket,
                              'total_harga': jumlahTiket * hargaPerTiket,
                              'image_asset': widget.movie.imageAsset,
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Pembayaran Berhasil!', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: const Color(0xFF00A294),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    final availableCinemas = mockCinemas.take(5).toList();
    final DateTime today = DateTime.now();
    final List<DateTime> dates = List.generate(7, (index) => today.add(Duration(days: index)));

    return Scaffold(
      backgroundColor: const Color(0xFF0F171E),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 380,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(widget.movie.imageAsset), fit: BoxFit.cover),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withOpacity(0.3), const Color(0xFF0F171E)],
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: const [
                                  Icon(Icons.location_on, size: 16, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text('JAKARTA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(widget.movie.imageAsset, width: 110, height: 160, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.movie.title.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 8),
                            Text(widget.movie.genre, style: const TextStyle(color: Colors.grey, fontSize: 14)),
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
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isScheduleTab = true),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _isScheduleTab ? Colors.white : Colors.grey)),
                        const SizedBox(height: 8),
                        if (_isScheduleTab) Container(height: 2, width: 80, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () => setState(() => _isScheduleTab = false),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: !_isScheduleTab ? Colors.white : Colors.grey)),
                        const SizedBox(height: 8),
                        if (!_isScheduleTab) Container(height: 2, width: 60, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, height: 1, thickness: 0.5),
            const SizedBox(height: 20),
            if (_isScheduleTab) ...[
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    final date = dates[index];
                    final bool isSelected = _selectedDateIndex == index;
                    String dayName = index == 0 ? 'Today' : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
                    
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey), shape: BoxShape.circle),
                      child: const Icon(Icons.tune, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: const Text('Cinema XXI', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: availableCinemas.length,
                itemBuilder: (context, index) {
                  final cinema = availableCinemas[index];
                  final double distance = 8.43 + (index * 2.1); 
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ExpansionTile(
                          backgroundColor: const Color(0xFF1E272E),
                          collapsedBackgroundColor: const Color(0xFF1E272E),
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          title: Row(
                            children: [
                              Text(cinema.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                              const SizedBox(width: 8),
                              Text('(${distance.toStringAsFixed(2)} km)', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFF00A294)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(Icons.info_outline, color: Color(0xFF00A294), size: 16),
                                    label: const Text('Cinema info', style: TextStyle(color: Color(0xFF00A294))),
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
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      _buildTimeSlot(context, cinema, '12:15'),
                                      _buildTimeSlot(context, cinema, '14:30'),
                                      _buildTimeSlot(context, cinema, '16:45'),
                                    ],
                                  )
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
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.movie.description,
                  style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.white70),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {bool isWarning = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 14),
          if (isWarning) const SizedBox(width: 4),
          Text(text, style: TextStyle(color: isWarning ? Colors.amber : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(BuildContext context, Cinema cinema, String time) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 80) / 2, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A294),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () => _tampilkanBottomSheetTransaksi(context, cinema, time),
        child: Text(time, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}