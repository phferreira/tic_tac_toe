import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:tic_tac_toe/presenter/pages/main_page.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MainPage(),
      },
      initialRoute: '/',
    );
  }
}
