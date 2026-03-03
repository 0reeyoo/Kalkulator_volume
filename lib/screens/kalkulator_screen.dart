import 'package:flutter/material.dart';
import '../widgets/kubus_form.dart';
import '../widgets/tabung_form.dart';
import '../widgets/kerucut_form.dart';

class KalkulatorScreen extends StatelessWidget {
  final String jenis;

  const KalkulatorScreen({super.key, required this.jenis});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: Text('Kalkulator $jenis'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A148C), Color(0xFF21004D)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120), 
              _buildForm(),
              const SizedBox(height: 50),
              const Text(
                'π (pi) = 3.14159...',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    // SEMUA KATA 'const' DI DEPAN NAMA FORM TELAH DIHAPUS
    // Ini dilakukan karena Form memiliki Controller dan Lottie yang dinamis
    if (jenis == 'Kubus') {
      return KubusForm(); 
    } else if (jenis == 'Tabung') {
      return TabungForm(); // Perbaikan: Hapus 'const'
    } else if (jenis == 'Kerucut') {
      return KerucutForm(); // Perbaikan: Hapus 'const'
    } else {
      return const SizedBox();
    }
  }
}