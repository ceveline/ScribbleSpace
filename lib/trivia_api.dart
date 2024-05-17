import 'dart:convert';
import 'package:http/http.dart' as http;

class TriviaApi {
  final String baseUrl;

  TriviaApi({required this.baseUrl});

  Future<List<dynamic>> fetchTriviaQuestions({
    required String category,
    required int limit,
    required String difficulty,
  }) async {
    final String url = '$baseUrl?limit=$limit&categories=$category&difficulties=$difficulty';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load trivia questions');
    }
  }
}