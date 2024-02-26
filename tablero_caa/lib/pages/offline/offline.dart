import 'package:flutter/material.dart';
import 'package:tablero_caa/components/app_bar.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: "Tablero CAA"),
      body: const Center(
          child: Text(
        "Recomendamos conexión a Internet para una experiencia óptima.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 35),
      )),
    );
  }
}
