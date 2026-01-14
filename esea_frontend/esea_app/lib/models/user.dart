import 'dart:convert';

class User {
  final String id;
  final String name;
  final String rollNumber;
  final String eseaId;
  final String department;
  final String year;
  final String? photoUrl;

  User({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.eseaId,
    required this.department,
    required this.year,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      rollNumber: json['roll_number'] ?? '',
      eseaId: json['esea_id'] ?? '',
      department: json['department'] ?? '',
      year: json['year'] ?? '',
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'roll_number': rollNumber,
      'esea_id': eseaId,
      'department': department,
      'year': year,
      'photo_url': photoUrl,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  factory User.fromJsonString(String str) =>
      User.fromJson(jsonDecode(str));

  // ================== UI ADAPTER GETTERS ==================

  String get fullName => name;

  String get memberId => rollNumber;

  String get displayYear => year;

  String get validUntil => "2025"; // contract-safe

  String get initials {
    if (name.isEmpty) return 'S';
    return name.toUpperCase();
  }
}
