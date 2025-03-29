import 'package:dio/dio.dart';
import '../model/movie.dart';

class ApiRepositories {
  static const String apiKey = '0c6ed4bc63db6421085731e4b2b612e0';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String lang = 'en-US';

  static Future<List<Movie>> callApiUpComing() async {
    try {
      final dio = Dio();
      final res = await dio.get(
        '$baseUrl/movie/upcoming?language=$lang&api_key=$apiKey',
      );

      if (res.statusCode == 200) {
        final data = res.data;
        // print("API Response: $data"); // Debug dữ liệu nhận về
        List<Movie> movies = (data['results'] as List).map((movieJson) => Movie.fromMap(movieJson)).toList();
        return movies;
      } else {
        // print("Failed to load movies. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      // print("Error fetching movies: $e");
      return [];
    }
  }

  static Future<List<Movie>> callApiTredingMovie(String timeWindow) async {
    try {
      final dio = Dio();
      final res = await dio.get(
        '$baseUrl/trending/movie/$timeWindow?language=$lang&api_key=$apiKey',
      );

      if (res.statusCode == 200) {
        final data = res.data;
        // print("API Response: $data"); // Debug dữ liệu nhận về
        List<Movie> movies = (data['results'] as List).map((movieJson) => Movie.fromMap(movieJson)).toList();
        return movies;
      } else {
        // print("Failed to load movies. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      // print("Error fetching movies: $e");
      return [];
    }
  }

  static Future<List<Movie>> callApiPopular() async {
    try {
      final dio = Dio();
      final res = await dio.get(
        '$baseUrl/movie/popular?language=$lang&api_key=$apiKey',
      );

      if (res.statusCode == 200) {
        final data = res.data;
        // print("API Response: $data"); // Debug dữ liệu nhận về
        List<Movie> movies = (data['results'] as List).map((movieJson) => Movie.fromMap(movieJson)).toList();
        return movies;
      } else {
        // print("Failed to load movies. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      // print("Error fetching movies: $e");
      return [];
    }
  }

  static Future<MovieDetail?> callApiMovieDetail(int movieId) async {
    try {
      final dio = Dio();
      final res = await dio.get(
        '$baseUrl/movie/$movieId?language=$lang&api_key=$apiKey',
      );

      if (res.statusCode == 200) {
        final data = res.data;
        return MovieDetail.fromMap(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>> callApiNowPlaying(int page) async {
    try {
      final dio = Dio();
      final res = await dio.get(
        '$baseUrl/movie/now_playing?language=$lang&page=$page&api_key=$apiKey',
      );

      if (res.statusCode == 200) {
        final data = res.data;
        // print("API Response: $data"); // Debug dữ liệu nhận về
        List<Movie> movies = (data['results'] as List).map((movieJson) => Movie.fromMap(movieJson)).toList();
        return movies;
      } else {
        // print("Failed to load movies. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      // print("Error fetching movies: $e");
      return [];
    }
  }
}
