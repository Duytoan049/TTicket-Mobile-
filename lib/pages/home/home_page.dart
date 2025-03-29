import 'package:flutter/material.dart';
import 'widgets/home_banner.dart';
import 'widgets/home_trendingmovies.dart';
import 'widgets/hone_popularmovies.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1A1A1D),
        title: const Text(
          'Welcome to TT Cinema!',
          style: TextStyle(
            color: Color(0xffFF6969),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff1A1A1D),
                  Color(0xff131010),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: const Column(
              children: [
                HomeBanner(),
                HomeTrendingMovies(),
                HomePopularMovies(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
