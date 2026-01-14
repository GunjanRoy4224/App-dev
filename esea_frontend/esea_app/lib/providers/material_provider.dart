import 'package:flutter/foundation.dart';
import '../models/course_material_model.dart';
import '../services/course_material_service.dart';

class MaterialProvider with ChangeNotifier {
  final CourseMaterialService _service = CourseMaterialService();

  List<CourseMaterial> _materials = [];
  bool _isLoading = false;
  String? _error;

  List<CourseMaterial> get materials => _materials;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMaterials() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _materials = await _service.fetchAllCourses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
