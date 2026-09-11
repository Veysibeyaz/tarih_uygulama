import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performans'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Performans paneli yakında burada olacak 📊',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}