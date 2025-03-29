import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../provider/movie_provider.dart';
import '../home/widgets/home_movieratingicon.dart';
import 'widgets/movie_backicon.dart';
import 'widgets/movie_bookingdate.dart';
import '../../repositories/trailer_repositories.dart';
import 'widgets/trailer_player.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/movieDetail';
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String? trailerId; // Lưu trữ trailer ID

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false)
            .getMovieDetail(widget.movieId);
        _fetchTrailer(); // Lấy trailer khi vào trang
      }
    });
  }

  Future<void> _fetchTrailer() async {
    String? fetchedTrailer = await TrailerRepository.getTrailer(widget.movieId);
    if (mounted) {
      setState(() {
        trailerId = fetchedTrailer;
      });
    }
  }

  void _playTrailer() {
    if (trailerId != null) {
      showDialog(
        context: context,
        builder: (context) => TrailerPlayer(trailerId: trailerId!),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Trailer not available")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;

    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        final movie = movieProvider.movieDetail;
        if (movie == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff1A1A1D),
                      Color(0xff131010),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w1066_and_h600_bestv2${movie.backdropPath}',
                          width: widthsize,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Center(
                            child: GestureDetector(
                              onTap: _playTrailer, // Nhấn để mở trailer
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: widthsize * 0.7,
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              Text(
                                'Time: ${movie.runtime} min',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          MovieRatingCircle(rating: movie.voteAverage),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.tealAccent, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ReadMoreText(
                              textAlign: TextAlign.justify,
                              movie.overview,
                              trimLines: 4,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: ' Read more',
                              trimExpandedText: ' Show less',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              moreStyle: const TextStyle(
                                  color: Color(0xffFF6969),
                                  fontWeight: FontWeight.bold),
                              lessStyle: const TextStyle(
                                  color: Color(0xffFF6969),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            movie.genres.map((genre) => genre.name).join(', '),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            'Release Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(movie.releaseDate))}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          BookingDate(movieId: widget.movieId),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              NavBack(),
            ],
          ),
        );
      },
    );
  }
}
