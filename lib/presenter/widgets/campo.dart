import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presenter/controllers/game_controller.dart';

class Campo extends StatefulWidget {
  // final String letter;
  // final String Function(String args) onTap;
  final GameController controller;

  const Campo({super.key, required this.controller});

  @override
  State<Campo> createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  // bool _print = false;

  @override
  Widget build(BuildContext context) {
    bool print = false;
    int key = int.parse(widget.key.toString().replaceAll(RegExp(r'\D'), ''));

    return GestureDetector(
      onTap: () {
        if (!print) {
          widget.controller.setCampo(key);
          print = true;
        }
      },
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: 100,
            height: 200,
            color: Colors.red,
            child: Center(
              child: Text(
                widget.controller.getCampo(key),
                style: const TextStyle(fontSize: 64),
              ),
            ),
          );
        },
      ),
      // child: _print
      //     ? Text(
      //         _letter,
      //         style: const TextStyle(fontSize: 64),
      //       )
      //     : null),
      // ),
    );
  }
}
