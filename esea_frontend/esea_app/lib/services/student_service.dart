import 'dart:convert';
import '../models/profile_model.dart';
import '../models/digital_id_model.dart';
import 'api_client.dart';

class StudentService {
  static Future<ProfileModel> profile() async {
    final res = await ApiClient.get("/student/profile");
    return ProfileModel.fromJson(jsonDecode(res.body));
  }

  static Future<DigitalIdModel> digitalId() async {
    final res = await ApiClient.get("/student/digital-id");
    return DigitalIdModel.fromJson(jsonDecode(res.body));
  }
}
