import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/movie.dart';
import '../../provider/movie_provider.dart';
import '../home/widgets/home_movieratingicon.dart';

class ListMoviePage extends StatefulWidget {
  static const routeName = '/movies';
  const ListMoviePage({super.key});

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  int _currentPage = 1; // Trang hiện tại
  final ScrollController _scrollController = ScrollController();
  bool _showPagination = false; // Ẩn nút chuyển trang ban đầu
  String _searchQuery = "";


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false).getnowPlaying(_currentPage);
      }
    });

    // Lắng nghe sự kiện cuộn để hiển thị hoặc ẩn nút chuyển trang
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
        if (!_showPagination) {
          setState(() {
            _showPagination = true;
          });
        }
      } else {
        if (_showPagination) {
          setState(() {
            _showPagination = false;
          });
        }
      }
    });
  }

  void _changePage(int step) {
    final newPage = _currentPage + step;
    if (newPage >= 1 && newPage <= 5) {
      setState(() {
        _currentPage = newPage;
      });

      Provider.of<MovieProvider>(context, listen: false).getnowPlaying(_currentPage);

      // Cuộn lên đầu danh sách khi đổi trang
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase(); // Lưu từ khóa tìm kiếm
    });
  }

  @override
  Widget build(BuildContext context) {
    final listmovies = Provider.of<MovieProvider>(context).nowplayingmovies.toList();
    final filteredMovies = listmovies.where((movie) {
      return movie.title.toLowerCase().contains(_searchQuery);
    }).toList();


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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search movies...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: _onSearchChanged, // Gọi hàm khi nhập
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50) {
                      if (!_showPagination) {
                        setState(() {
                          _showPagination = true;
                        });
                      }
                    } else {
                      if (_showPagination) {
                        setState(() {
                          _showPagination = false;
                        });
                      }
                    }
                    return true;
                  },
                  child: filteredMovies.isEmpty
                      ? Center(
                          child: Text(
                            "Không tìm thấy phim nào",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: filteredMovies.length, // Đúng danh sách đã lọc
                          physics: const BouncingScrollPhysics(),
                          
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: MovieCard2(movie: filteredMovies[index]),
                              
                            );
                          },
                        ),

                ),
              ),

              // Nút chuyển trang chỉ hiển thị khi _showPagination == true
              if (_showPagination)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _currentPage > 1 ? () => _changePage(-1) : null,
                      icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFF885B)),
                    ),
                    Text(
                      '$_currentPage / 5',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _currentPage < 5 ? () => _changePage(1) : null,
                      icon: const Icon(Icons.arrow_forward_ios, color: Color(0xffFF885B)),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieCard2 extends StatelessWidget {
  final Movie movie;
  const MovieCard2({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/movieDetail',
          arguments: movie.id,
        );
      },
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff151515),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 236, 230, 228).withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: movie.posterPath != null && movie.posterPath!.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 130,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 130,
                          height: 180,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Center(
                            child: Text(
                              'No Image',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Color(0xffFF6969),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      movie.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
