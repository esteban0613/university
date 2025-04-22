import 'dart:io';

class UniversityModel {
  final String name;
  final String country;
  final List<String> webPages;
  final List<String> domains;
  int? students;
  File? image; 

  UniversityModel({
    required this.name,
    required this.country,
    required this.webPages,
    required this.domains,
    this.students,
    this.image,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] ?? 'Sin nombre',
      country: json['country'] ?? 'Desconocido',
      webPages: List<String>.from(json['web_pages'] ?? []),
      domains: List<String>.from(json['domains'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'web_pages': webPages,
      'domains': domains,
    };
  }
}
