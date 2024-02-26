import 'package:flutter/material.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/models/game.dart';
import 'package:paid_didactico/models/module.dart';
import 'package:paid_didactico/models/pictogram.dart';
import 'package:paid_didactico/models/soundpool.dart';
import 'package:paid_didactico/models/tts.dart';
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

  void playGame() async {
    setState(() {
      isPlayingGame = !isPlayingGame;
    });
    await Future.delayed(const Duration(seconds: 3));
    executeGame();
  }

  void executeGame() {
    // if (pictogramsToPlay.isEmpty) {
    //   pictogramsToPlay = widget.game.getPictogramsByQuantity();
    //   playCurrentPictogram();
    // }
  }

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

  @override
  Widget build(BuildContext context) {
    soundPool = context.read<GlobalParameters>().soundPool;
    tts = context.read<GlobalParameters>().ttsService;

    return isPlayingGame ? const Text("play game") : getWidgetPlayGame();
  }
}
