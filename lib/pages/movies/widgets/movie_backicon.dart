import 'package:flutter/material.dart';

class NavBack extends StatelessWidget {
  const NavBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, color: Color(0xff00FF9C), size: 30),
      ),
    );
  }
}
