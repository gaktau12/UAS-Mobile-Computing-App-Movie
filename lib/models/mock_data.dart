class Movie {
  final String id;
  final String title;
  final String description;
  final String imageAsset; 
  final double rating;
  final String genre;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.rating,
    required this.genre,
  });
}

class Cinema {
  final String id;
  final String name;
  final String imageAsset; 

  Cinema({required this.id, required this.name, required this.imageAsset});
}

final List<Movie> mockMovies = [
  Movie(
    id: 'm1',
    title: 'Inception',
    description: 'Seorang pencuri yang memasuki mimpi orang lain untuk mencuri rahasia, kini diberi tugas untuk menanamkan ide ke dalam pikiran seorang CEO.',
    imageAsset: 'assets/images/inception.jpg', 
    rating: 8.8,
    genre: 'Sci-Fi, Action',
  ),
  Movie(
    id: 'm2',
    title: 'Interstellar',
    description: 'Sekelompok penjelajah menggunakan wormhole baru untuk melewati batas perjalanan luar angkasa manusia demi mencari planet hunian baru.',
    imageAsset: 'assets/images/interstellar.jpg', 
    rating: 8.6,
    genre: 'Sci-Fi, Drama',
  ),
  Movie(
    id: 'm3',
    title: 'The Dark Knight',
    description: 'Ketika ancaman yang dikenal sebagai Joker muncul, Batman harus menerima ujian psikologis dan fisik terbesar untuk melawan ketidakadilan.',
    imageAsset: 'assets/images/dark_knight.jpg', 
    rating: 9.0,
    genre: 'Action, Crime',
  ),
];

final List<Cinema> mockCinemas = [
  Cinema(id: 'c1', name: 'CGV Grand Indonesia', imageAsset: 'assets/images/cgv.jpg'),
  Cinema(id: 'c2', name: 'XXI Senayan City', imageAsset: 'assets/images/xxi.jpg'),
  Cinema(id: 'c3', name: 'Cinepolis Pejaten Village', imageAsset: 'assets/images/cinepolis.jpg'),
];

// Tempat menyimpan riwayat tiket yang sudah dibeli
final List<Map<String, dynamic>> riwayatTransaksi = [];