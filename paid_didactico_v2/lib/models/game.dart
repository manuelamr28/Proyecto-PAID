import 'dart:math';

import 'package:paid_didactico/models/level.dart';
import 'package:paid_didactico/models/pictogram.dart';

class Game {
  late String name;
  late List<Level> levels;
  late List<Pictogram> pictograms;
  late Level currentLevel;

  Game.fromJson(Map<String, dynamic> data) {
    List<Level> levelList = (data['level_settings'] as List<dynamic>)
        .map((level) => Level.fromJson(level as Map<String, dynamic>))
        .toList();

    List<Pictogram> pictogramList = (data['pictograms'] as List<dynamic>)
        .map((pictogram) =>
            Pictogram.fromJson(pictogram as Map<String, dynamic>))
        .toList();

    levels = levelList;
    pictograms = pictogramList;
    currentLevel = levels.where((lev) => lev.level == 1).first;
  }

  List<Pictogram> getPictogramsByQuantity() {
    int quantity = currentLevel.quantity;
    if (quantity >= pictograms.length) {
      return List.from(pictograms);
    }

    List<Pictogram> listaAleatoria = [];
    List<Pictogram> copiaListaCompleta = List.from(pictograms);

    for (int i = 0; i < quantity; i++) {
      int indiceAleatorio = Random().nextInt(copiaListaCompleta.length);
      listaAleatoria.add(copiaListaCompleta.removeAt(indiceAleatorio));
    }

    return listaAleatoria;
  }

  void currentlevelUp(int level) {
    currentLevel = levels.where((lev) => lev.level == level).first;
  }
}
