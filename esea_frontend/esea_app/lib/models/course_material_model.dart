class CourseMaterial {
  final String courseCode;
  final String courseTitle;
  final String? instructor;
  final List<ResourceItem> lectures;
  final List<ResourceItem> resources;
  final List<ResourceItem> pyqs;

  CourseMaterial({
    required this.courseCode,
    required this.courseTitle,
    this.instructor,
    required this.lectures,
    required this.resources,
    required this.pyqs,
  });

  factory CourseMaterial.fromJson(Map<String, dynamic> json) {
    final materials = json['materials'] as Map<String, dynamic>? ?? {};

    return CourseMaterial(
      courseCode: json['course_code'] ?? '',
      courseTitle: json['course_title'] ?? '',
      instructor: json['instructor'], // nullable

      lectures: (materials['lectures'] as List? ?? [])
          .map((e) => ResourceItem.fromJson(e))
          .toList(),

      resources: (materials['resources'] as List? ?? [])
          .map((e) => ResourceItem.fromJson(e))
          .toList(),

      pyqs: (materials['pyqs'] as List? ?? [])
          .map((e) => ResourceItem.fromJson(e))
          .toList(),
    );
  }
}

class ResourceItem {
  final String title;
  final String link;

  ResourceItem({
    required this.title,
    required this.link,
  });

  factory ResourceItem.fromJson(Map<String, dynamic> json) {
    return ResourceItem(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
    );
  }
}