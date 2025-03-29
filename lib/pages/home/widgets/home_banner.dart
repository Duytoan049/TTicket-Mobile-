import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import '../../../provider/movie_provider.dart';
import 'home_movieratingicon.dart';


class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false).getUpComing();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        // Kiểm tra xem có phim nào không
        if (movieProvider.upcomingMovies.isEmpty) {
          return const Center(
            child: Text(
              'Không có dữ liệu phim!',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        final upcomingmovies = movieProvider.upcomingMovies.take(10).toList();

        return FlutterCarousel(
          items: upcomingmovies.map((movie) {
            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/movieDetail',
                      arguments: movie.id,
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: movie.posterPath != null
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: double.infinity, // Chiều rộng bằng với ảnh
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
                    ),
                  ),

                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
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
            );
          }).toList(),
          options: FlutterCarouselOptions(
            enableInfiniteScroll: true,
            viewportFraction: 0.7,
            autoPlay: true,
            showIndicator: false,
            autoPlayAnimationDuration: const Duration(milliseconds: 400),
          ),
        );
      },
    );
  }
}
