import '../data/sample_components.dart';
import '../models/component_model.dart';

class ApiService {
  Future<List<Component>> fetchComponents() async {
    // Simulasi delay fetch data
    await Future.delayed(const Duration(milliseconds: 300));
    return sampleComponents;
  }

  Future<Component?> getComponentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return sampleComponents.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}
