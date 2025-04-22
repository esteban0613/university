import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/university_model.dart';

class UniversityRepository {
  Future<List<UniversityModel>> fetchUniversities() async {
    final url = Uri.parse('https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => UniversityModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar universidades');
    }
  }
}