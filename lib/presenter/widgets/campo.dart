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
  late Color _color;
  late Color _textColor;

  @override
  Widget build(BuildContext context) {
    int key = int.parse(widget.key.toString().replaceAll(RegExp(r'\D'), ''));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if ((widget.controller.currentStatus == StatusEnum.sDraw) || (widget.controller.currentStatus == StatusEnum.sNothing)) {
            if (widget.controller.getCampo(key).isEmpty) {
              widget.controller.setCampo(key);
            }
          }
        },
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (BuildContext context, Widget? child) {
            if ((widget.controller.currentStatus != StatusEnum.sDraw) && (widget.controller.currentStatus != StatusEnum.sNothing)) {
              if (widget.controller.fieldsWin.contains(key)) {
                _color = Colors.red;
                _textColor = Colors.white;
              }
            } else {
              _color = Theme.of(context).scaffoldBackgroundColor;
              _textColor = Colors.black;
            }
            return Container(
              width: 50,
              height: 170,
              color: _color,
              child: Center(
                child: Text(
                  widget.controller.getCampo(key),
                  style: TextStyle(
                    fontSize: 64,
                    color: _textColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
