import 'package:flutter/material.dart';

class DetailAbsensi extends StatefulWidget {
  final String nama;
  final String nim;
  final String status;

  const DetailAbsensi({
    super.key,
    required this.nama,
    required this.nim,
    required this.status,
  });

  @override
  State<DetailAbsensi> createState() => _DetailAbsensiState();
}

class _DetailAbsensiState extends State<DetailAbsensi> {
  final List<String> _statusOptions = ['Hadir', 'Izin', 'Sakit', 'Alpa'];

  late final TextEditingController _namaController;
  late final TextEditingController _nimController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _nimController = TextEditingController(text: widget.nim);
    _status = _getInitialStatus(widget.status);
  }

  String _getInitialStatus(String currentStatus) {
    for (final option in _statusOptions) {
      if (currentStatus.toLowerCase().contains(option.toLowerCase())) {
        return option;
      }
    }
    return _statusOptions.first;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  void _submitAbsensi() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data absensi berhasil disubmit.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Absensi')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'NIM'),
              ),
              TextField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'NIM'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status Kehadiran',
                ),
                items: _statusOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (newStatus) {
                  if (newStatus == null) return;

                  setState(() {
                    _status = newStatus;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitAbsensi,
                  child: const Text('Submit Absensi'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
