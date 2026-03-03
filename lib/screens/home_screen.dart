import 'package:flutter/material.dart';
import 'kalkulator_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Ditambahkan key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
            ),
          ),
          child: Column(
          children: [
            const SizedBox(height: 80),
            const Icon(Icons.calculate, color: Colors.orangeAccent, size: 50),
            const Text(
              'Kalkulator Volume',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                'Hitung volume kubus, tabung, dan kerucut dengan mudah!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.fromLTRB(25,25,25,50),
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                childAspectRatio: 0.8, // make cells a bit taller to avoid overflow
                children: [
                  _buildMenuCard(context, 'Kubus', 'assets/kubus.png'),
                  _buildMenuCard(context, 'Tabung', 'assets/tabung.png'),
                  _buildMenuCard(context, 'Kerucut', 'assets/kerucut.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildMenuCard(BuildContext context, String title, String assetPath) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KalkulatorScreen(jenis: title)),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge, // ensure children don't paint outside bounds
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1), // Perbaikan withOpacity
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // circle background with image inside
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(assetPath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}