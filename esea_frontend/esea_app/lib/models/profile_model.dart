class ProfileModel {
  final String name;
  final String rollNumber;
  final String eseaId;
  final String department;
  final String year;


  ProfileModel({
    required this.name,
    required this.rollNumber,
    required this.eseaId,
    required this.department,
    required this.year,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"],
      rollNumber: json["roll_number"],
      eseaId: json["esea_id"],
      department: json["department"],
      year: json["year"],
    );
  }
}
