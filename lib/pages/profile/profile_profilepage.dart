import 'package:ct312h_project/pages/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthManager>(context).user;

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
                  Color(0xff131010)
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  user?.username ?? 'User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.email ?? 'Unknown User', // Hiển thị email người dùng
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff00FF9C)),
                    ),
                    const SizedBox(height: 100),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthManager>(context, listen: false).logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC73659),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Logout', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
