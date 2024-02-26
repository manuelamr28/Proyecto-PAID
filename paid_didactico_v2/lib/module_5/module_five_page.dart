import 'package:flutter/material.dart';
import 'package:paid_didactico/components/app_bar.dart';

class Modulo5Page extends StatelessWidget {
  const Modulo5Page({super.key});

  @override
  Widget build(BuildContext context) {
    Navigator.pop(context);
    return Scaffold(
      appBar: AppBarMain(title: "Modulo 5"),
      body: const Center(
        child: Text("Hola mundo"),
      ),
    );
  }
}
