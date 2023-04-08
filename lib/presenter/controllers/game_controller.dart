import 'package:flutter/material.dart';

enum CampoEnum {
  cNenhum(''),
  cCirculo('O'),
  cCruz('X');

  const CampoEnum(this.name);
  final String name;
  // String getCampoName(params) {
  //  switch () {
  //
  //  }
  // }
}

class GameController extends ChangeNotifier {
  CampoEnum currentValue = CampoEnum.cNenhum;

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

  void zerarJogo() {
    campo.updateAll((key, value) => value = CampoEnum.cNenhum);
    // for (bool element in campo.values) {
    //   element = false;
    // }
    notifyListeners();
  }

  void setCampo(int key) {
    debugPrint(currentValue.name);
    currentValue = currentValue == CampoEnum.cCirculo ? CampoEnum.cCruz : CampoEnum.cCirculo;
    campo.update(key, (value) => currentValue);
    notifyListeners();
  }

  String getCampo(int key) {
    return campo[key]!.name;
  }
}
