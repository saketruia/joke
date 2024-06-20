
import 'joke.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Joke> fetchJoke() async {
    final url = Uri.parse('https://v2.jokeapi.dev/joke/Programming?type=single');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Joke.fromJson(json);
      } else {
        throw Exception('Failed to load joke');
      }
    } catch (e) {
      throw Exception('Failed to load joke: $e');
    }
  }
}
//use of dart:convert library to convert the JSON response to a Map<String, dynamic> object.
//
