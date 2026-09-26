/// Status kondisi komponen mesin.
enum ComponentStatus { normal, warning, damaged }

/// Satu langkah dalam panduan perbaikan/maintenance.
class MaintenanceStep {
  final String title;
  final String description;

  const MaintenanceStep({
    required this.title,
    required this.description,
  });

  factory MaintenanceStep.fromJson(Map<String, dynamic> json) {
    return MaintenanceStep(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}

/// Representasi satu komponen mesin yang bisa dikenali/ditandai di AR.
class Component {
  final String id;
  final String name;
  final ComponentStatus status;
  final String description;
  final String modelAssetPath;
  final List<MaintenanceStep> maintenanceSteps;

  const Component({
    required this.id,
    required this.name,
    required this.status,
    required this.description,
    required this.modelAssetPath,
    required this.maintenanceSteps,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    // Helper untuk mengubah string status kembali ke enum
    ComponentStatus parseStatus(String statusStr) {
      switch (statusStr.toLowerCase()) {
        case 'normal':
          return ComponentStatus.normal;
        case 'warning':
          return ComponentStatus.warning;
        case 'damaged':
          return ComponentStatus.damaged;
        default:
          return ComponentStatus.normal;
      }
    }

    var stepsJson = json['maintenanceSteps'] as List? ?? [];
    List<MaintenanceStep> stepsList = stepsJson
        .map((stepJson) => MaintenanceStep.fromJson(stepJson))
        .toList();

    return Component(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      status: parseStatus(json['status'] ?? 'normal'),
      description: json['description'] ?? '',
      modelAssetPath: json['modelAssetPath'] ?? '',
      maintenanceSteps: stepsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.name,
      'description': description,
      'modelAssetPath': modelAssetPath,
      'maintenanceSteps': maintenanceSteps.map((s) => s.toJson()).toList(),
    };
  }
}
