import 'package:flutter/material.dart';
import '../data/sample_components.dart';
import '../models/component_model.dart';
import '../widgets/detection_card.dart';
import 'ar_scan_screen.dart';
import 'component_detail_screen.dart';
import 'maintenance_screen.dart';
import 'scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B111E),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeDashboard(context),
          const MaintenanceScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: const Color(0xFF0284C7).withValues(alpha: 0.3),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined, color: Color(0xFF94A3B8)),
              selectedIcon: Icon(Icons.dashboard_rounded, color: Color(0xFF38BDF8)),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.build_outlined, color: Color(0xFF94A3B8)),
              selectedIcon: Icon(Icons.build_rounded, color: Color(0xFF38BDF8)),
              label: 'Panduan SOP',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScannerScreen()),
          );
        },
        backgroundColor: const Color(0xFF00F2FE),
        foregroundColor: const Color(0xFF0B111E),
        elevation: 6,
        icon: const Icon(Icons.qr_code_scanner_rounded, size: 22),
        label: const Text(
          'Pindai AI',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHomeDashboard(BuildContext context) {
    final damagedCount = sampleComponents.where((c) => c.healthStatus == ComponentHealth.damaged).length;
    final warningCount = sampleComponents.where((c) => c.healthStatus == ComponentHealth.warning).length;
    final goodCount = sampleComponents.where((c) => c.healthStatus == ComponentHealth.good).length;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // App Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'SISTEM MONITORING HARDWARE',
                            style: TextStyle(
                              color: Color(0xFF38BDF8),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'AR Diagnostic Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF1E293B),
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.help_outline_rounded, color: Colors.white70, size: 20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: const Color(0xFF1E293B),
                            title: const Text('Tentang Aplikasi', style: TextStyle(color: Colors.white)),
                            content: const Text(
                              'Aplikasi AR & AI Deteksi Kerusakan Komponen PC menggunakan model Computer Vision YOLOv8 dan visualisasi ARCore.',
                              style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13.5),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Tutup', style: TextStyle(color: Color(0xFF38BDF8))),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hero Quick Action Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0369A1), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0284C7).withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt_rounded, color: Color(0xFFFBBF24), size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Fitur Cepat',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'v1.0.0',
                        style: TextStyle(color: Colors.white60, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Periksa Kondisi & Kerusakan Komponen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Identifikasi kerusakan fisik kapasitor, fan, dan pin memori secara akurat.',
                    style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 13),
                  ),
                  const SizedBox(height: 16),

                  // Action Buttons in banner
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ScannerScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0B111E),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.camera_alt_rounded, size: 16),
                          label: const Text(
                            'Scan AI',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ARScanScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white60),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.view_in_ar_rounded, size: 16),
                          label: const Text(
                            'Mode AR',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Overview Statistics
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildStatCard('Komponen Normal', '$goodCount', const Color(0xFF10B981)),
                  const SizedBox(width: 10),
                  _buildStatCard('Perlu Perhatian', '$warningCount', const Color(0xFFF59E0B)),
                  const SizedBox(width: 10),
                  _buildStatCard('Komponen Rusak', '$damagedCount', const Color(0xFFEF4444)),
                ],
              ),
            ),
          ),

          // Title section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Hardware Terpantau',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '5 Unit',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          // List of component cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final comp = sampleComponents[index];
                return DetectionCard(
                  component: comp,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ComponentDetailScreen(component: comp),
                      ),
                    );
                  },
                  onARPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ARScanScreen()),
                    );
                  },
                );
              },
              childCount: sampleComponents.length,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF131D2E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
