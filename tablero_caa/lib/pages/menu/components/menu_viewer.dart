import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablero_caa/models/global_parameters.dart';
import 'package:tablero_caa/models/menu.dart';
import 'package:tablero_caa/models/tts.dart';
import 'package:tablero_caa/pages/menu/menu.dart';

class MenuViewer extends StatelessWidget {
  final Menu menu;
  MenuViewer({super.key, required this.menu});
  final Tts ttsService = Tts();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (context.read<GlobalParameters>().enabledTts)
          {ttsService.speak(menu.say)},
        if (menu.menu.isNotEmpty)
          {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MenuPage(menu: menu)))
          }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 140,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xFFF2EDDC),
            boxShadow: [
              BoxShadow(
                color: Colors.black, // Color de la sombra
                blurRadius: 10, // Radio de desenfoque
                offset: Offset(0,
                    4), // Desplazamiento (positivo hacia abajo para una sombra inferior)
              ),
            ],
          ),
          child: Row(
            children: [
              Center(
                child: getImageWidget(context),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                menu.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageWidget(BuildContext context) {
    const size = 110.0;
    String url = context.read<GlobalParameters>().imagesMap[menu.image] ??
        "assets/images/nose.png";
    String urlOffLine = "assets/images/offline.png";
    bool isConnect = context.read<GlobalParameters>().isOnline;

    if (url.startsWith("#")) {
      int color = int.parse(url.replaceAll("#", "0xFF"));
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: size,
          width: size,
          child: Container(
              decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: BorderRadius.circular(15))),
        ),
      );
    } else if (url.toLowerCase().startsWith("http")) {
      Widget image = isConnect
          ? Image.network(
              url,
              fit: BoxFit.contain,
            )
          : Image.asset(
              urlOffLine,
              fit: BoxFit.contain,
            );
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: size,
          width: size,
          child: image,
        ),
      );
    } else if (url.endsWith("nose.png")) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: size,
          width: size,
          child: Image.asset(
            url,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: size,
        width: size,
        child: Image.memory(
          base64Decode(
            url,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
