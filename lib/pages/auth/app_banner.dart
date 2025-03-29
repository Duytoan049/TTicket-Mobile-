import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Để Row không chiếm toàn bộ chiều rộng
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/icon.png',
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
        Text(
          'TT Ticket',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Anton',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
