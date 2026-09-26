import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ARMaintenanceApp());
}

class ARMaintenanceApp extends StatelessWidget {
  const ARMaintenanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Maintenance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: const HomeScreen(),
    );
  }
}
