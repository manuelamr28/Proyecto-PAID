import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paid_didactico/components/app_bar.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/models/soundpool.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FinishModulePage extends StatelessWidget {
  late SoundPool soundPool;
  FinishModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    String urlImage = "https://api.arasaac.org/v1/pictograms/16649";
    double sizeBox = 400.0;
    soundPool = context.read<GlobalParameters>().soundPool;
    Future.delayed(const Duration(seconds: 15), () {
      goToHome(context);
    });
    soundPool.playSoundFinal();
    return Scaffold(
      appBar: AppBarMain(title: ''),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              urlImage,
              width: sizeBox,
              height: sizeBox,
            ),
            const SizedBox(height: 20.0),
            const Text(
              '¡Felicitaciones por completar el módulo!',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => goToHome(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(200.0, 50.0),
              ),
              child: const Text(
                'Volver al Menú Inicial',
                style: TextStyle(
                    color: Color(0xFFD95970),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.pop(context);
  }
}
