import 'dart:math';
import 'package:flutter/material.dart';

class TabungForm extends StatefulWidget {
  const TabungForm({super.key});

  @override
  State<TabungForm> createState() => _TabungFormState();
}

class _TabungFormState extends State<TabungForm> {
  final _rController = TextEditingController();
  final _tController = TextEditingController();
  double? _hasil;
  String? _caraHasil;

  // List untuk menyimpan riwayat perhitungan
  final List<Map<String, String>> _riwayat = [];

  void _hitung() {
    double r = double.tryParse(_rController.text) ?? 0;
    double t = double.tryParse(_tController.text) ?? 0;

    if (r > 0 && t > 0) {
      setState(() {
        // Rumus Volume Tabung: π * r² * t
        _hasil = pi * pow(r, 2) * t;

        // buat penjelasan langkah perhitungan
        _caraHasil =
            "V = π × r² × t\n"
            "   = 3.14 × ${r.toStringAsFixed(2)}² × ${t.toStringAsFixed(2)}\n"
            "   = ${_hasil!.toStringAsFixed(2)} cm³";

        // Menambahkan ke daftar riwayat (urutan terbaru di atas)
        _riwayat.insert(0, {
          'jari': r.toString(),
          'tinggi': t.toString(),
          'hasil': _hasil!.toStringAsFixed(2),
          'cara': _caraHasil ?? '',
          'waktu': "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        });
      });
    }
  }

  void _hapusRiwayat() {
    setState(() {
      _riwayat.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card Tabung dengan Keterangan Detail
          _buildHeaderCard(
            assetPath: 'assets/tabung.png',
            title: 'Volume Tabung',
            formula: 'V = π × r² × t',
            keterangan: 'r = jari-jari alas, t = tinggi tabung, π = 3.14',
            caraKerja: 'Tabung memiliki alas berbentuk lingkaran. Volume didapat dengan mengalikan luas alas (π × r²) dengan tinggi tabung (t).',
            circleColor: Colors.cyan.shade600,
          ),
          const SizedBox(height: 25),

          // Input Jari-jari
          const Text(
            'Jari-jari Alas (r)', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
          ),
          _buildTextField(_rController, 'Masukkan jari-jari'),

          // Input Tinggi
          const Text(
            'Tinggi Tabung (t)', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
          ),
          _buildTextField(_tController, 'Masukkan tinggi'),
          
          const SizedBox(height: 20),

          // Tombol Hitung
          _buildCalculateButton(),

          // Hasil Perhitungan
          if (_hasil != null) _buildResultDisplay(),

          // Bagian Riwayat Perhitungan
          _buildHistorySection(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard({
    required String assetPath,
    required String title,
    required String formula,
    required String keterangan,
    required String caraKerja,
    required Color circleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 55, width: 55,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: circleColor.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.circle_outlined, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                title, 
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Kotak Rumus & Detail Deskripsi
          Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Rumus
                const Row(
                  children: [
                    Icon(Icons.straighten, color: Colors.cyanAccent, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Rumus:', 
                      style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  formula, 
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.2)
                ),
                
                const SizedBox(height: 15),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),

                // Keterangan Variabel
                Text(
                  'Keterangan: $keterangan', 
                  style: const TextStyle(color: Colors.white70, fontSize: 13)
                ),
                
                const SizedBox(height: 15),

                // Cara Kerja
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.cyanAccent, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cara Kerja: $caraKerja', 
                        style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    if (_riwayat.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Riwayat Perhitungan",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextButton.icon(
              onPressed: _hapusRiwayat,
              icon: const Icon(Icons.delete_sweep, color: Colors.cyanAccent, size: 20),
              label: const Text("Hapus", style: TextStyle(color: Colors.cyanAccent)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _riwayat.length,
          itemBuilder: (context, index) {
            final item = _riwayat[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.history, color: Colors.cyanAccent, size: 18),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "r: ${item['jari']} cm | t: ${item['tinggi']} cm",
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Volume: ${item['hasil']} cm³",
                          style: const TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 16
                          ),
                        ),
                        if (item.containsKey('cara') && item['cara']!.isNotEmpty)
                          Text(
                            item['cara']!,
                            style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.3),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    item['waktu']!, 
                    style: const TextStyle(color: Colors.white38, fontSize: 11)
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          suffixIcon: const Padding(
            padding: EdgeInsets.all(15),
            child: Text('cm', style: TextStyle(color: Colors.white54)),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 5,
        ),
        onPressed: _hitung,
        child: const Text('HITUNG VOLUME', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.cyan.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hasil Perhitungan:', style: TextStyle(color: Colors.cyanAccent, fontSize: 14)),
          const SizedBox(height: 5),
          Text('${_hasil!.toStringAsFixed(2)} cm³', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          if (_caraHasil != null) ...[
            const SizedBox(height: 12),
            Text('Langkah Perhitungan:', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 4),
            Text(
              _caraHasil!,
              style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.3),
            ),
          ],
        ],
      ),
    );
  }
}