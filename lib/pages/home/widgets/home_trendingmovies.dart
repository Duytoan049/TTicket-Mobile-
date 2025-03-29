import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/movie.dart';
import '../../../provider/movie_provider.dart';
import 'home_movieratingicon.dart';

class HomeTrendingMovies extends StatefulWidget {
  const HomeTrendingMovies({super.key});

  @override
  State<HomeTrendingMovies> createState() => _HomeTrendingMoviesState();
}

class _HomeTrendingMoviesState extends State<HomeTrendingMovies> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false).getTrending(selectedFilter);
      }
    });
  }

  String selectedFilter = "day";

  void _changeFilter(String filter) {
    if (selectedFilter == filter) return; // Tránh gọi lại nếu không thay đổi

    setState(() {
      selectedFilter = filter;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false).getTrending(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widthSize = constraints.maxWidth;
        final trendingmovies = Provider.of<MovieProvider>(context).trendingMovies.toList();

        return SizedBox(
          width: widthSize,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top movies',
                      style: TextStyle(color: Color(0xffFF6969), fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _changeFilter("day"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedFilter == "day" ? Color(0xffFF6969) : Colors.transparent,
                            side: BorderSide(color: selectedFilter == "day" ? Colors.transparent : Color(0xffFF6969)), // Viền xám khi chưa chọn
                            minimumSize: const Size(0, 25),
                          ),
                          child: const Text(
                            "Today",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _changeFilter("week"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedFilter == "week" ? Color(0xffFF6969) : Colors.transparent,
                            side: BorderSide(color: selectedFilter == "week" ? Colors.transparent : Color(0xffFF6969)),
                            minimumSize: const Size(0, 25),
                          ),
                          child: const Text(
                            "This Week",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingmovies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: trendingmovies[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/movieDetail',
                arguments: movie.id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  movie.backdropPath != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                          width: widthsize - 70,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: widthsize - 70,
                          height: 150, // Đặt chiều cao phù hợp
                          color: Colors.grey[300], // Nền màu xám nhạt
                          alignment: Alignment.center,
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7), // Màu đỏ có độ trong suốt
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(15), // Bo góc dưới
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: (widthsize - 70) * 2 / 3,
                                    child: Text(
                                      movie.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(DateTime.parse(movie.releaseDate)),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              MovieRatingCircle(rating: movie.voteAverage),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
