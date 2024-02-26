import 'package:flutter/material.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/global_pages/finish_module_page.dart';
import 'package:paid_didactico/models/game.dart';
import 'package:paid_didactico/models/module.dart';
import 'package:paid_didactico/models/pictogram.dart';
import 'package:paid_didactico/models/soundpool.dart';
import 'package:paid_didactico/models/tts.dart';
import 'package:paid_didactico/module_2/button_viewer.dart';
import 'package:provider/provider.dart';

class GameViewer extends StatefulWidget {
  final Game game;
  final Module module;
  const GameViewer({super.key, required this.game, required this.module});

  @override
  State<GameViewer> createState() => _GameViewerState();
}

class _GameViewerState extends State<GameViewer> {
  late SoundPool soundPool;
  late Tts tts;
  bool isPlayingGame = false;
  bool playSound = true;
  late Pictogram currentPictogram;
  List<Pictogram> pictogramsToPlay = [];
  late int level = 1;
  late int intent = 0;

  Widget getWidgetPlayGame() {
    String urlImage =
        context.read<GlobalParameters>().imagesMap[widget.module.image] ??
            "assets/images/nose.png";
    double sizeBox = 400.0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            urlImage,
            width: sizeBox,
            height: sizeBox,
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: sizeBox,
            child: Text(
              widget.module.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25.0),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              playGame();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(200.0, 50.0),
            ),
            child: const Text(
              'Iniciar Juego',
              style: TextStyle(
                  color: Color(0xFFD95970),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidgetGame() {
    String urlImage =
        context.read<GlobalParameters>().imagesMap[currentPictogram.image] ??
            "assets/images/nose.png";
    double sizeBox = 400.0;

    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                      child: Text(
                    "Nivel\n $level",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  )),
                ),
                const Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      '¿Por qué vocal empieza?',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(child: Text('$intent')),
                ),
              ],
            )),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Center(
              child: Image.network(
                urlImage,
                width: sizeBox,
                height: sizeBox,
              ),
            )),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: [
                buildListItem(context, 0, "A"),
                const SizedBox(
                  width: 5.0,
                  height: 50.0,
                ),
                buildListItem(context, 1, "E"),
                const SizedBox(
                  width: 5.0,
                  height: 50.0,
                ),
                buildListItem(context, 2, "I"),
                const SizedBox(
                  width: 5.0,
                  height: 50.0,
                ),
                buildListItem(context, 3, "O"),
                const SizedBox(
                  width: 5.0,
                  height: 50.0,
                ),
                buildListItem(context, 4, "U")
              ],
            )),
      ],
    );
  }

  Widget buildListItem(BuildContext context, int index, String letterButton) {
    if (index < 5) {
      return Expanded(
          child: ButtonViewer(
              onPressed: () => handleClick(letterButton),
              letter: letterButton));
    } else {
      return const SizedBox.shrink();
    }
  }

  bool checkStartWithLetter(String letter) {
    return pictogramsToPlay[0]
        .name
        .toLowerCase()
        .startsWith(letter.toLowerCase());
  }

  void handleClick(String letter) async {
    if (checkStartWithLetter(letter)) {
      pictogramsToPlay.removeAt(0);
      if (pictogramsToPlay.isEmpty) {
        upIntent();
        soundPool.playSoundCorrect();
      } else {
        soundPool.playSoundSelect();
      }
    } else {
      soundPool.playSoundError();
      await Future.delayed(const Duration(seconds: 2));
      playCurrentPictogram();
    }
  }

  void upLevel() async {
    int nextLevel = level + 1;
    if (nextLevel <= widget.game.levels.length) {
      widget.game.currentlevelUp(nextLevel);

      String msg =
          "Completaste el nivel $level, felicitaciones! Ahora únicamente se presentará la imagen y debes escoger la vocal.";

      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        level = widget.game.currentLevel.level;
        soundPool.playSoundLevelUp();
        executeGame();
      });
      await Future.delayed(const Duration(seconds: 1));
      tts.speak(msg);
      intent = 0;

      await Future.delayed(const Duration(seconds: 10));
    } else {
      playSound = false;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FinishModulePage()));
    }
  }

  void upIntent() {
    setState(() {
      intent++;
    });
    if (intent >= widget.game.currentLevel.nextLevel) {
      upLevel();
    } else {
      executeGame();
    }
  }

  void playGame() async {
    executeGame();
    setState(() {
      isPlayingGame = !isPlayingGame;
    });
    await Future.delayed(const Duration(seconds: 3));
  }

  void executeGame() {
    if (pictogramsToPlay.isEmpty) {
      pictogramsToPlay = widget.game.getPictogramsByQuantity();
      currentPictogram = pictogramsToPlay.first;
      playCurrentPictogram();
    }
  }

  void playCurrentPictogram() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Pictogram> copyList = List.from(pictogramsToPlay);
    if (playSound && level == 1) {
      for (Pictogram pictogram in copyList) {
        tts.speak(pictogram.say ?? pictogram.name);
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    soundPool = context.read<GlobalParameters>().soundPool;
    tts = context.read<GlobalParameters>().ttsService;

    return isPlayingGame ? getWidgetGame() : getWidgetPlayGame();
  }
}
