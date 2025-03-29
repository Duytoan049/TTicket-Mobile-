import 'package:flutter/material.dart';

class MovieRatingCircle extends StatelessWidget {
  final double rating;

  const MovieRatingCircle({super.key, required this.rating});

  Color _getColor(double rating) {
    if (rating < 4) {
      return const Color(0xffA91D3A); // Đỏ
    } else if (rating < 7) {
      return const Color(0xffF4CE14); // Cam
    } else {
      return const Color(0xff16C47F); // Xanh lá
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              value: rating / 10,
              strokeWidth: 6,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(_getColor(rating)),
            ),
          ),
          Text(
            '${(rating * 10).round()}%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
