import 'package:flutter/material.dart';

class DetailData extends StatelessWidget {
  // Properti untuk menerima data dari halaman sebelumnya
  final String nama;
  final String nim;

  const DetailData({super.key, required this.nama, required this.nim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Presensi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bukti Presensi Berhasil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: const Text('Nama Mahasiswa'),
                      subtitle: Text(nama),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.badge, color: Colors.blue),
                      title: const Text('NIM'),
                      subtitle: Text(nim),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text('Status'),
                      subtitle: Text('Hadir - Tepat Waktu'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Button Kembali ke Halaman Sebelumnya (Navigator.pop)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigator.pop digunakan untuk kembali/menutup halaman saat ini
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Form'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
