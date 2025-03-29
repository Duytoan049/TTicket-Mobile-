import 'package:ct312h_project/repositories/api_repositories.dart';
import 'package:flutter/material.dart';

import '../model/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _upcomingmovies = [];
  List<Movie> _trendingmovies = [];
  List<Movie> _popualarmovies = [];
  List<Movie> _nowplayingmovies = [];
  MovieDetail? _movieDetail;

  List<Movie> get upcomingMovies => _upcomingmovies;
  List<Movie> get trendingMovies => _trendingmovies;
  List<Movie> get popularMovies => _popualarmovies;
  List<Movie> get nowplayingmovies => _nowplayingmovies;
  MovieDetail? get movieDetail => _movieDetail;

  Future<void> getUpComing() async {
    _upcomingmovies = await ApiRepositories.callApiUpComing();
    notifyListeners();
  }

  Future<void> getTrending(String timeWindow) async {
    _trendingmovies = await ApiRepositories.callApiTredingMovie(timeWindow);
    notifyListeners();
  }

  Future<void> getPopular() async {
    _popualarmovies = await ApiRepositories.callApiPopular();
    notifyListeners();
  }

  Future<void> getnowPlaying(int page) async {
    _nowplayingmovies = await ApiRepositories.callApiNowPlaying(page);
    notifyListeners();
  }

  Future<void> getMovieDetail(int movieId) async {
    _movieDetail = await ApiRepositories.callApiMovieDetail(movieId);
    notifyListeners();
  }
}
