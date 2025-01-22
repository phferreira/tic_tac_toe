import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/firebase_options.dart';
import 'package:tic_tac_toe/presenter/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';

late final SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUrlStrategy(PathUrlStrategy());

  sharedPreferences = await SharedPreferences.getInstance();

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
