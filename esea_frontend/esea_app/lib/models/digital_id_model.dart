class DigitalIdModel {
  final String name;
  final String eseaId;
  final String roll_number;
  final String validity;
  final String photoUrl;

  DigitalIdModel({
    required this.name,
    required this.eseaId,
    required this.roll_number,
    required this.validity,
    required this.photoUrl,
  });

  factory DigitalIdModel.fromJson(Map<String, dynamic> json) {
    return DigitalIdModel(
      name: json["name"],
      eseaId: json["esea_id"],
      roll_number: json["roll_number"],
      validity: json["validity"],
      photoUrl: json["photo_url"],
    );
  }
}
