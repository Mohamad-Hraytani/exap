import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = 'c22af1781c4f82ebbc5c95dc91926d13';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> fetchWeatherData(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/weather?q=$query&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchForecastData(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/forecast?q=$query&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
