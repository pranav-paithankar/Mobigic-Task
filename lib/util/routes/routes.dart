import 'package:flutter/material.dart';
import 'package:mobigic_task/util/routes/routes_name.dart';
import 'package:mobigic_task/view/grid_screen.dart';
import 'package:mobigic_task/view/splash_screen.dart';
import '../../view/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.grid:
        return MaterialPageRoute(
            builder: (BuildContext context) => const GridScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
