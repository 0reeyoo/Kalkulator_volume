import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Mengarah ke menu utama dengan 3 kartu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Volume',
      theme: ThemeData(
        // Menggunakan tema gelap yang konsisten dengan desain ungu
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A148C),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins', // Opsional: jika kamu menambahkan font di pubspec
      ),
      // Langsung arahkan ke HomeScreen sesuai gambar menu utama yang kamu berikan
      home: HomeScreen(), 
    );
  }
}