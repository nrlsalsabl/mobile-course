import 'package:flutter/material.dart';

class AbsensiInfoCard extends StatelessWidget {
  const AbsensiInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ====================================================
          // PROFILE ICON
          // ====================================================
          Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              shape: BoxShape.circle,
            ),

            child: Icon(Icons.person, size: 32, color: Colors.indigo.shade700),
          ),

          const SizedBox(width: 16),

          // ====================================================
          // DATA MAHASISWA
          // ====================================================
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Nurul Salsabila',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 4),

                Text(
                  '20260001',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                SizedBox(height: 2),

                Text(
                  'Teknik Informatika',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
