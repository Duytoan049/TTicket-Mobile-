import 'dart:convert';
import 'package:http/http.dart' as http;

class TrailerRepository {
  static const String apiKey = "0c6ed4bc63db6421085731e4b2b612e0";

  static Future<String?> getTrailer(int movieId) async {
    final String url =
        "https://api.themoviedb.org/3/movie/$movieId/videos?language=en-US&api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data["results"];
      if (results.isNotEmpty) {
        return results.first["key"];
      }
    }
    return null;
  }
}
