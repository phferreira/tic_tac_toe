import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

enum CampoEnum {
  cNenhum(''),
  cCirculo('O'),
  cCruz('X');

  const CampoEnum(this.name);
  final String name;
}

enum StatusEnum {
  sNothing,
  sDraw,
  sCrossWin,
  sCircleWin,
}

class GameController extends ChangeNotifier {
  CampoEnum currentValue = CampoEnum.cNenhum;
  StatusEnum currentStatus = StatusEnum.sNothing;
  final List<int> fieldsWin = [];
  final database = FirebaseDatabase.instance.ref();

  final Map<int, CampoEnum> campo = {
    1: CampoEnum.cNenhum,
    2: CampoEnum.cNenhum,
    3: CampoEnum.cNenhum,
    4: CampoEnum.cNenhum,
    5: CampoEnum.cNenhum,
    6: CampoEnum.cNenhum,
    7: CampoEnum.cNenhum,
    8: CampoEnum.cNenhum,
    9: CampoEnum.cNenhum,
  };

  void getDados() {
    database.child('campo').child('currentStatus').onValue.listen((event) {
      currentStatus = StatusEnum.values[int.parse(event.snapshot.value.toString())];
      if (currentStatus == StatusEnum.sNothing) {
        fieldsWin.clear();
      }
      verifyStatusGame();
      notifyListeners();
    });
    database.child('campo').child('currentValue').onValue.listen((event) {
      currentValue = event.snapshot.value.toString() == CampoEnum.cCirculo.name ? CampoEnum.cCruz : CampoEnum.cCirculo;
      verifyStatusGame();
      notifyListeners();
    });
    database.child('campo').child('campos').onValue.listen((event) {
      for (var value in event.snapshot.children) {
        if (value.value.toString() == 'X') {
          campo[int.parse(value.key.toString())] = CampoEnum.cCruz;
        } else if (value.value.toString() == 'O') {
          campo[int.parse(value.key.toString())] = CampoEnum.cCirculo;
        } else {
          campo[int.parse(value.key.toString())] = CampoEnum.cNenhum;
        }
      }
      verifyStatusGame();
      notifyListeners();
    });
  }

  void zerarJogo() {
    campo.updateAll((key, value) {
      return value = CampoEnum.cNenhum;
    });

    database.child('campo').child('campos').set('');
    database.child('campo').child('currentStatus').set(StatusEnum.sNothing.index);
  }

  void setCampo(int key) async {
    campo.update(key, (value) => currentValue);
    database.child('campo').child('campos').child('$key').set(currentValue.name);
    database.child('campo').child('currentValue').set(currentValue.name);
  }

  String getCampo(int key) {
    return campo[key]!.name;
  }

  bool condiction(int a, int b, int c) {
    final List first = [
      campo[a],
      campo[b],
      campo[c],
    ];

    if (first.every((element) => element == CampoEnum.cCirculo)) {
      database.child('campo').child('currentStatus').set(StatusEnum.sCircleWin.index);
      fieldsWin.addAll([a, b, c]);
      return true;
    }
    if (first.every((element) => element == CampoEnum.cCruz)) {
      database.child('campo').child('currentStatus').set(StatusEnum.sCrossWin.index);
      fieldsWin.addAll([a, b, c]);
      return true;
    }
    return false;
  }

  void verifyStatusGame() {
    condiction(1, 2, 3);
    condiction(4, 5, 6);
    condiction(7, 8, 9);
    condiction(1, 5, 9);
    condiction(3, 5, 7);
    condiction(1, 4, 7);
    condiction(2, 5, 8);
    condiction(3, 6, 9);
  }
}
