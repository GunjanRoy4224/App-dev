class ContentModel {
  final String id;
  final String type;
  final String title;
  final String shortDescription;
  final String? imageUrl;
  final String? fileUrl;
  final String? externalLink;
  final String? dateOrDeadline;

  ContentModel({
    required this.id,
    required this.type,
    required this.title,
    required this.shortDescription,
    this.imageUrl,
    this.fileUrl,
    this.externalLink,
    this.dateOrDeadline,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'].toString(),
      type: json['type'],
      title: json['title'],
      shortDescription: json['short_description'],
      imageUrl: json['image_url'],
      fileUrl: json['file_url'],
      externalLink: json['external_link'],
      dateOrDeadline: json['date_or_deadline'],
    );
  }
}
