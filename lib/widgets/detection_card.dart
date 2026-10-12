import 'package:flutter/material.dart';
import '../models/component_model.dart';

class DetectionCard extends StatelessWidget {
  final Component component;
  final VoidCallback? onTap;
  final VoidCallback? onARPressed;

  const DetectionCard({
    super.key,
    required this.component,
    this.onTap,
    this.onARPressed,
  });

  Color _getStatusColor() {
    switch (component.healthStatus) {
      case ComponentHealth.good:
        return const Color(0xFF10B981); // Emerald
      case ComponentHealth.warning:
        return const Color(0xFFF59E0B); // Amber
      case ComponentHealth.damaged:
        return const Color(0xFFEF4444); // Crimson
    }
  }

  IconData _getStatusIcon() {
    switch (component.healthStatus) {
      case ComponentHealth.good:
        return Icons.check_circle_rounded;
      case ComponentHealth.warning:
        return Icons.warning_amber_rounded;
      case ComponentHealth.damaged:
        return Icons.error_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: category & status badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        component.category,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_getStatusIcon(), size: 14, color: statusColor),
                          const SizedBox(width: 4),
                          Text(
                            component.healthStatusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Component Name
                Text(
                  component.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Issue / Status snippet
                Text(
                  component.issueDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 14),

                // Divider
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                const SizedBox(height: 12),

                // Footer stats and action
                Row(
                  children: [
                    // Temp stat
                    Row(
                      children: [
                        const Icon(Icons.thermostat_rounded, size: 16, color: Color(0xFF38BDF8)),
                        const SizedBox(width: 4),
                        Text(
                          '${component.temperature}°C',
                          style: const TextStyle(
                            color: Color(0xFFE2E8F0),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Usage hours
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 16, color: Color(0xFFA78BFA)),
                        const SizedBox(width: 4),
                        Text(
                          '${component.usageHours} Jam',
                          style: const TextStyle(
                            color: Color(0xFFE2E8F0),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // AR inspection quick button
                    if (onARPressed != null)
                      ElevatedButton.icon(
                        onPressed: onARPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0284C7),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.view_in_ar_rounded, size: 16),
                        label: const Text(
                          'Cek AR',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
