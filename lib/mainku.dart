// // ignore_for_file: unused_element, unused_import, unnecessary_import

// import 'dart:convert';
// import 'package:flutter/services.dart';

// import 'package:flutter/material.dart';

// import 'pages/detail_absensi.dart';
// import 'pages/detail_data.dart';
// import 'widgets/student_info_card.dart';
// import 'widgets/absensi_info_card.dart';
// import 'widgets/custom_button.dart';

// void main() {
//   runApp(const CampusGoApp());
// }

// class Student {
//   final int id;
//   final String nim;
//   final String name;
//   final String major;
//   final int semester;
//   final String email;
//   final int attendance;
//   const Student({
//     required this.id,
//     required this.nim,
//     required this.name,
//     required this.major,
//     required this.semester,
//     required this.email,
//     required this.attendance,
//   });

//   factory Student.fromJson(Map<String, dynamic> json) {
//     return Student(
//       id: json['id'] as int,
//       nim: json['nim'] as String,
//       name: json['name'] as String,
//       major: json['major'] as String,
//       semester: json['semester'] as int,
//       email: json['email'] as String,
//       attendance: json['attendance'] as int,
//     );
//   }
// }

// Future<List<Student>> loadStudents() async {
//   // 1. Membaca file JSON sebagai String
//   final jsonString = await rootBundle.loadString('assets/data/students.json');

//   // 2. Mengubah String JSON menjadi struktur Dart
//   final Map<String, dynamic> decoded =
//       jsonDecode(jsonString) as Map<String, dynamic>;

//   // 3. Mengambil array students dari JSON
//   final List<dynamic> studentList = decoded['students'] as List<dynamic>;

//   // 4. Mengubah setiap item menjadi objek Student
//   return studentList.map((item) {
//     return Student.fromJson(item as Map<String, dynamic>);
//   }).toList();
// }

// class CampusGoApp extends StatelessWidget {
//   const CampusGoApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'CampusGo',
//       home: CampusGoHomePage(),
//     );
//   }
// }

// class CampusGoHomePage extends StatefulWidget {
//   const CampusGoHomePage({super.key});

//   @override
//   State<CampusGoHomePage> createState() => _CampusGoHomePageState();
// }

// class _CampusGoHomePageState extends State<CampusGoHomePage> {
//   // State untuk menyimpan jumlah presensi/aktivitas
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   void _navigateToDetail([BuildContext? context]) {
//     String nim = '1234567890';
//     String name = 'John Doe';

//     // Navigator.push untuk berpindah halaman sambil mengirim data
//     Navigator.push(
//       context ?? this.context,
//       MaterialPageRoute(
//         builder: (context) => DetailData(nama: name, nim: nim),
//       ),
//     );
//   }

//   // Menyimpan proses pemuatan data mahasiswa
//   late Future<List<Student>> studentsFuture;

//   @override
//   void initState() {
//     super.initState();

//     // Membaca data saat halaman pertama kali dibuka
//     studentsFuture = loadStudents();
//   }

//   // Memuat ulang data JSON
//   void reloadStudents() {
//     setState(() {
//       studentsFuture = loadStudents();
//     });
//   }

//   void _navigateToAbsensi([BuildContext? context]) {
//     const nim = '41125';
//     const name = 'Nurul Salsabila';
//     const status = 'Hadir';

//     Navigator.push(
//       context ?? this.context,
//       MaterialPageRoute(
//         builder: (context) =>
//             DetailAbsensi(nama: name, nim: nim, status: status),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('CampusGo')),
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(vertical: 24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.school, size: 80),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'CampusGo',
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('Mobile Academic Information System'),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Total Aktivitas: $_counter',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 CustomButton(
//                   // label: 'Tambah Aktivitas',
//                   label: 'Isi Absensi',
//                   icon: Icons.play_arrow,
//                   type: CustomButtonType.primary,
//                   onPressed: () {
//                     // _incrementCounter();
//                     _navigateToAbsensi(context);
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 CustomButton(
//                   label: 'Lihat Jadwal',
//                   icon: Icons.calendar_today,
//                   type: CustomButtonType.secondary,
//                   onPressed: () {
//                     _navigateToDetail();
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 CustomButton(
//                   label: 'Butuh Bantuan?',
//                   icon: Icons.help_outline,
//                   type: CustomButtonType.tertiary,
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Membuka Pusat Bantuan...')),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 12),

//                 FutureBuilder<List<Student>>(
//                   future: studentsFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       final students = snapshot.data!;
//                       // Assuming you want to display the first student's info
//                       final student = students.first;
//                       return StudentInfoCard(
//                         nim: student.nim,
//                         name: student.name,
//                         major: student.major,
//                         semester: student.semester,
//                         email: student.email,
//                         attendance: student.attendance,
//                       );
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return const CircularProgressIndicator();
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 const AbsensiInfoCard(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
