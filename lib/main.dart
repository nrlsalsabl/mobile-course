// ignore_for_file: unused_element, unused_import, unnecessary_import

import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'pages/detail_absensi.dart';
import 'pages/detail_data.dart';
import 'widgets/student_info_card.dart';
import 'widgets/absensi_info_card.dart';
import 'widgets/custom_button.dart';

void main() {
  runApp(const CampusGoApp());
}

class Student {
  final int id;
  final String nim;
  final String name;
  final String major;
  final int semester;
  final String email;
  final int attendance;
  const Student({
    required this.id,
    required this.nim,
    required this.name,
    required this.major,
    required this.semester,
    required this.email,
    required this.attendance,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      nim: json['nim'] as String,
      name: json['name'] as String,
      major: json['major'] as String,
      semester: json['semester'] as int,
      email: json['email'] as String,
      attendance: json['attendance'] as int,
    );
  }
}

Future<List<Student>> loadStudents() async {
  // 1. Membaca file JSON sebagai String
  final jsonString = await rootBundle.loadString('assets/data/students.json');

  // 2. Mengubah String JSON menjadi struktur Dart
  final Map<String, dynamic> decoded =
      jsonDecode(jsonString) as Map<String, dynamic>;

  // 3. Mengambil array students dari JSON
  final List<dynamic> studentList = decoded['students'] as List<dynamic>;

  // 4. Mengubah setiap item menjadi objek Student
  return studentList.map((item) {
    return Student.fromJson(item as Map<String, dynamic>);
  }).toList();
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

  // Menyimpan proses pemuatan data mahasiswa
  late Future<List<Student>> studentsFuture;

  @override
  void initState() {
    super.initState();
    studentsFuture = loadStudents();
    absensiFuture = fetchAbsensiInfo();
  }

  // Memuat ulang data JSON
  void reloadStudents() {
    setState(() {
      studentsFuture = loadStudents();
    });
  }

  late Future<AbsensiInfo> loadStudentsFuture;
  late Future<AbsensiInfo> absensiFuture;

  void reloadAbsensi() {
    setState(() {
      absensiFuture = fetchAbsensiInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CampusGo')),
      body: FutureBuilder<List<Student>>(
        future: studentsFuture,
        builder: (context, snapshot) {
          // 1. LOADING STATE
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. ERROR STATE
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Gagal membaca data mahasiswa.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(label: 'Coba Lagi', onPressed: reloadStudents),
                  ],
                ),
              ),
            );
          }
          // 3. MENGAMBIL DATA
          final students = snapshot.data ?? <Student>[];
          // 4. EMPTY STATE
          if (students.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 56),
                  SizedBox(height: 12),
                  Text('Data mahasiswa kosong'),
                ],
              ),
            );
          }
          return Column(
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
                label: 'Tambah Aktivitas',
                icon: Icons.play_arrow,
                type: CustomButtonType.primary,
                onPressed: () {
                  _incrementCounter();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aktivitas Berhasil Dimulai!'),
                    ),
                  );
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daftar Mahasiswa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return StudentInfoCard(
                      nim: student.nim,
                      name: student.name,
                      major: student.major,
                      semester: student.semester,
                      email: student.email,
                      attendance: student.attendance,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              FutureBuilder<AbsensiInfo>(
                future: absensiFuture,
                builder: (context, snapshot) {
                  // State Loading API
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // State Error API
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            'Gagal memuat API Absensi: ${snapshot.error}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          CustomButton(
                            label: 'Coba Lagi Absensi',
                            onPressed: reloadAbsensi,
                          ),
                        ],
                      ),
                    );
                  }

                  // State Success API
                  if (snapshot.hasData) {
                    return AbsensiInfoCard(info: snapshot.data!);
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
