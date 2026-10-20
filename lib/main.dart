import 'package:flutter/material.dart';

import 'pages/detail_absensi.dart';
import 'pages/detail_data.dart';
import 'widgets/student_info_card.dart';
import 'widgets/absensi_info_card.dart';
import 'widgets/custom_button.dart';

void main() {
  runApp(const CampusGoApp());
}

class CampusGoApp extends StatelessWidget {
  const CampusGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusGo',
      home: CampusGoHomePage(),
    );
  }
}

class CampusGoHomePage extends StatefulWidget {
  const CampusGoHomePage({super.key});

  @override
  State<CampusGoHomePage> createState() => _CampusGoHomePageState();
}

class _CampusGoHomePageState extends State<CampusGoHomePage> {
  // State untuk menyimpan jumlah presensi/aktivitas
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToDetail([BuildContext? context]) {
    String nim = '1234567890';
    String name = 'John Doe';

    // Navigator.push untuk berpindah halaman sambil mengirim data
    Navigator.push(
      context ?? this.context,
      MaterialPageRoute(
        builder: (context) => DetailData(nama: name, nim: nim),
      ),
    );
  }

  void _navigateToAbsensi([BuildContext? context]) {
    const nim = '41125';
    const name = 'Nurul Salsabila';
    const status = 'Hadir';

    Navigator.push(
      context ?? this.context,
      MaterialPageRoute(
        builder: (context) =>
            DetailAbsensi(nama: name, nim: nim, status: status),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('CampusGo')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, size: 80),
                const SizedBox(height: 16),
                const Text(
                  'CampusGo',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Mobile Academic Information System'),
                const SizedBox(height: 8),
                Text(
                  'Total Aktivitas: $_counter',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  // label: 'Tambah Aktivitas',
                  label: 'Isi Absensi',
                  icon: Icons.play_arrow,
                  type: CustomButtonType.primary,
                  onPressed: () {
                    // _incrementCounter();
                    _navigateToAbsensi(context);
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Lihat Jadwal',
                  icon: Icons.calendar_today,
                  type: CustomButtonType.secondary,
                  onPressed: () {
                    _navigateToDetail();
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  label: 'Butuh Bantuan?',
                  icon: Icons.help_outline,
                  type: CustomButtonType.tertiary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Membuka Pusat Bantuan...')),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const StudentInfoCard(),
                const SizedBox(height: 12),
                const AbsensiInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
