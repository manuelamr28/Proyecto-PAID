import 'package:flutter/material.dart';
import 'package:paid_didactico/components/app_bar.dart';
import 'package:paid_didactico/models/game.dart';
import 'package:paid_didactico/models/module.dart';
import 'package:paid_didactico/module_6/m6_game_viewer.dart';
import 'package:paid_didactico/services/data_manager.dart';

// ignore: must_be_immutable
class Modulo6Page extends StatelessWidget {
  late Module module;
  late Game game;
  Modulo6Page({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    DataManager manager =
        DataManager(gistId: module.gist.id, key: module.gist.name);

    return Scaffold(
        appBar: AppBarMain(title: module.name),
        body: FutureBuilder(
            future: manager.getData(),
            builder: (context, result) {
              if (result.hasData) {
                if (result.data != null) {
                  game = Game.fromJson(result.data as Map<String, dynamic>);
                  return GameViewer(
                    game: game,
                    module: module,
                  );
                }
              } else if (result.hasError) {
                return Center(
                  child: Text("Error: ${result.error}"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
