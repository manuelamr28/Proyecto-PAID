import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paid_didactico/models/credit.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/models/tts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditViewer extends StatelessWidget {
  final Credit credit;
  CreditViewer({super.key, required this.credit});
  final Tts ttsService = Tts();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (context.read<GlobalParameters>().enabledTts)
          {ttsService.speak(credit.say)}
      },
      onDoubleTap: () {
        final Uri toLaunch = Uri.parse(credit.url);
        _launchInBrowser(toLaunch);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 140.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xFFF2EDDC),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Center(
                child: getImageWidget(context),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      credit.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        credit.message,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageWidget(BuildContext context) {
    const size = 110.0;
    String url = context.read<GlobalParameters>().imagesMap[credit.image] ??
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('No se puede abrir $url');
    }
  }
}
