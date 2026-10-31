import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AbsensiInfo {
  final int userId;
  final int id;
  final String title;
  final String body;

  const AbsensiInfo({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor untuk mengonversi Map JSON ke Objek AbsensiInfo
  factory AbsensiInfo.fromJson(Map<String, dynamic> json) {
    return AbsensiInfo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

Future<AbsensiInfo> fetchAbsensiInfo() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  // Mengirim HTTP GET Request ke server
  final response = await http.get(uri);

  // Memeriksa HTTP Status Code (200 = Success)
  if (response.statusCode == 200) {
    final List<dynamic> listJson = jsonDecode(response.body) as List<dynamic>;

    // Ambil item pertama dari list postingan sebagai contoh data
    final Map<String, dynamic> firstItem =
        listJson.first as Map<String, dynamic>;

    return AbsensiInfo.fromJson(firstItem);
  } else {
    throw Exception(
      'Gagal memuat data dari server (Status Code: ${response.statusCode})',
    );
  }
}

class AbsensiInfoCard extends StatelessWidget {
  final AbsensiInfo info;

  const AbsensiInfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Info Absensi (ID: ${info.id})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Text(
              info.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              info.body,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
