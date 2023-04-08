import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presenter/controllers/game_controller.dart';

import 'presenter/widgets/campo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // String printLetter(String args) {
    //   controller.setCampo(int.parse(args));
    //
    //   return ;
    //   // return args;
    // }
    final GameController controller = GameController();

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide.none,
              ),
              children: [
                TableRow(
                  children: [
                    Campo(key: const Key('1'), controller: controller),
                    Campo(key: const Key('2'), controller: controller),
                    Campo(key: const Key('3'), controller: controller),
                  ],
                ),
                TableRow(
                  children: [
                    Campo(key: const Key('4'), controller: controller),
                    Campo(key: const Key('5'), controller: controller),
                    Campo(key: const Key('6'), controller: controller),
                  ],
                ),
                TableRow(
                  children: [
                    Campo(key: const Key('7'), controller: controller),
                    Campo(key: const Key('8'), controller: controller),
                    Campo(key: const Key('9'), controller: controller),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}