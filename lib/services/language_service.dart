import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:langexchange/models/languages_level_model.dart';

class LanguageService {
  Future<List<Language>> fetchLanguages() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    if (response.statusCode == 200) {
      List<dynamic> languagesJson = json.decode(response.body);
      return languagesJson.map((json) => Language.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load languages');
    }
  }
}
