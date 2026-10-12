enum ComponentHealth { good, warning, damaged }

class Component {
  final String id;
  final String name;
  final String category;
  final String modelAssetPath;
  final String description;
  final ComponentHealth healthStatus;
  final String issueDescription;
  final List<String> maintenanceSteps;
  final double temperature; // °C
  final int usageHours;

  Component({
    required this.id,
    required this.name,
    this.category = 'Hardware',
    required this.modelAssetPath,
    this.description = '',
    this.healthStatus = ComponentHealth.good,
    this.issueDescription = 'Kondisi komponen normal dan siap beroperasi.',
    this.maintenanceSteps = const [],
    this.temperature = 42.0,
    this.usageHours = 120,
  });

  String get healthStatusText {
    switch (healthStatus) {
      case ComponentHealth.good:
        return 'Normal / Sehat';
      case ComponentHealth.warning:
        return 'Perlu Perhatian';
      case ComponentHealth.damaged:
        return 'Komponen Rusak';
    }
  }
}
