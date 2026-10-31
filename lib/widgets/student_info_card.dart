import 'package:flutter/material.dart';

class StudentInfoCard extends StatelessWidget {
  final String nim;
  final String name;
  final String major;
  final int semester;
  final String email;
  final int attendance;

  const StudentInfoCard({
    super.key,
    required this.nim,
    required this.name,
    required this.major,
    required this.semester,
    required this.email,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('NIM: $nim'),
            Text('Program Studi: $major'),
            Text('Semester: $semester'),
            Text('Email: $email'),
            Text('Kehadiran: $attendance%'),
          ],
        ),
      ),
    );
  }
}
