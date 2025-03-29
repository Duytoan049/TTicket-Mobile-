// import 'package:flutter/material.dart';

// import '../pages/home/home_page.dart';
// import '../pages/movies/movie_listmovies.dart';
// import '../pages/profile/profile_profilepage.dart';
// import '../pages/ticket/ticket_page.dart';

// class MenuNav extends StatefulWidget {
//   const MenuNav({super.key});

//   @override
//   State<MenuNav> createState() => _MenuNavState();
// }

// class _MenuNavState extends State<MenuNav> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const HomePage(),
//     const ListMoviePage(),
//     const TicketPage(),
//     const ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Color(0xffFF6969), // Màu icon & text khi được chọn
//         unselectedItemColor: Colors.white, // Màu icon & text khi chưa được chọn
//         backgroundColor: Color(0xff131010), // Màu nền của BottomNavigationBar
//         showUnselectedLabels: true, // Hiển thị label của item chưa được chọn
//         type: BottomNavigationBarType.fixed, // Giữ màu nền khi có 4 items trở lên
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.movie),
//             label: 'Movies',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.confirmation_number),
//             label: 'Ticket',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';
import '../pages/movies/movie_listmovies.dart';
import '../pages/profile/profile_profilepage.dart';
import '../pages/ticket/ticket_page.dart';

class MenuNav extends StatefulWidget {
  const MenuNav({super.key});

  @override
  State<MenuNav> createState() => _MenuNavState();
}

class _MenuNavState extends State<MenuNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ListMoviePage(),
    const TicketPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xffFF6969),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xff131010),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
