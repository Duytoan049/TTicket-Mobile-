import 'package:ct312h_project/repositories/ticket_provider.dart';
import 'package:ct312h_project/shared/menubar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import thư viện này
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:ct312h_project/pages/auth/auth_manager.dart';
import 'package:ct312h_project/pages/auth/auth_screen.dart';
import 'package:ct312h_project/pages/movies/movie_moviedetail.dart';
import 'provider/movie_provider.dart';
import 'pages/home/home_page.dart';
import 'pages/movies/movie_listmovies.dart';
import 'pages/profile/profile_profilepage.dart';
import 'pages/ticket/ticket_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Widget được khởi tạo trước
  await dotenv.load();

  // Ẩn thanh trạng thái và thanh điều hướng
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthManager()),
        ChangeNotifierProvider(create: (ctx) => MovieProvider()),
        ChangeNotifierProvider(create: (ctx) => TicketProvider()),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TT Movie',
            home: FutureBuilder(
              future: authManager.tryAutoLogin(),
              builder: (ctx, snapshot) {
                print("Snapshot state: ${snapshot.connectionState}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SafeArea(
                    child: Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                print("User is logged in: ${authManager.isAuth}");

                return authManager.isAuth ? const SafeArea(child: MenuNav()) : const SafeArea(child: LoginPage());
              },
            ),



            routes: {
              HomePage.routeName: (ctx) => const SafeArea(child: HomePage()),
              ListMoviePage.routeName: (ctx) => const SafeArea(child: ListMoviePage()),
              TicketPage.routeName: (ctx) => const SafeArea(child: TicketPage()),
              ProfilePage.routeName: (ctx) => const SafeArea(child: ProfilePage()),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/movieDetail') {
                final movieId = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (ctx) => SafeArea(child: MovieDetailPage(movieId: movieId)),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
