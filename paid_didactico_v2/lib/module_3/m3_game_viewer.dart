import 'package:flutter/material.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/global_pages/finish_module_page.dart';
import 'package:paid_didactico/models/game.dart';
import 'package:paid_didactico/models/module.dart';
import 'package:paid_didactico/models/pictogram.dart';
import 'package:paid_didactico/models/soundpool.dart';
import 'package:paid_didactico/models/tts.dart';
import 'package:paid_didactico/module_1/pictogram_viewer.dart';
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
  late int level = 1;
  late int intent = 0;
  late Pictogram currentPictogram;
  bool isPlayingGame = false;
  bool playSound = true;
  List<Pictogram> pictogramsToPlay = [];

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
    String urlImage = context
            .read<GlobalParameters>()
            .imagesMap[currentPictogram.question?.imageQuestion] ??
        "assets/images/nose.png";
    double sizeBox = 500.0;

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
                      '¿Quien...?',
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
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              urlImage,
              width: sizeBox,
              height: sizeBox,
            )),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                itemCount: (widget.game.pictograms.length / 3).ceil(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      buildListItem(context, index * 3),
                      const SizedBox(
                        width: 16.0,
                        height: 16.0,
                      ),
                      buildListItem(context, index * 3 + 1),
                      const SizedBox(
                        width: 16.0,
                        height: 16.0,
                      ),
                      buildListItem(context, index * 3 + 2)
                    ],
                  );
                })),
      ],
    );
  }

  Widget buildListItem(BuildContext context, int index) {
    if (index < widget.game.pictograms.length) {
      return Expanded(
          child: PictogramViewer(
              pictogram: widget.game.pictograms[index],
              index: index,
              onPressed: () => handleClick(
                    widget.game.pictograms[index],
                  )));
    } else {
      return const SizedBox.shrink();
    }
  }

  void handleClick(Pictogram pictogram) async {
    if (pictogramsToPlay[0] == pictogram) {
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

  void upLevel() async {
    playSound = false;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FinishModulePage()));
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
    if (playSound) {
      for (Pictogram pictogram in copyList) {
        tts.speak(pictogram.question?.sayQuestion ?? pictogram.name);
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
