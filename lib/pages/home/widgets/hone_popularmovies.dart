import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/movie.dart';
import '../../../provider/movie_provider.dart';
import 'home_movieratingicon.dart';

class HomePopularMovies extends StatefulWidget {
  const HomePopularMovies({super.key});

  @override
  State<HomePopularMovies> createState() => _HomePopularMoviesState();
}

class _HomePopularMoviesState extends State<HomePopularMovies> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false).getPopular();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    // final popularmovies = Provider.of<MovieProvider>(context).popularMovies.take(10).toList();
    final popularmovies = Provider.of<MovieProvider>(context).popularMovies.where((movie) => movie.posterPath != null).toList();


    return SizedBox(
      width: widthSize,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Recommended',
                  style: TextStyle(color: Color(0xffFF6969), fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularmovies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: popularmovies[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/movieDetail',
                        arguments: movie.id,
                      );
                    },
                    child: Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 130,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      MovieRatingCircle(rating: movie.voteAverage),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: Text(
                movie.title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
