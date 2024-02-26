import 'package:flutter/material.dart';
import 'package:paid_didactico/components/app_bar.dart';

class Modulo4Page extends StatelessWidget {
  const Modulo4Page({super.key});

  @override
  Widget build(BuildContext context) {
    Navigator.pop(context);
    return Scaffold(
      appBar: AppBarMain(title: "Modulo 4"),
      body: const Center(
        child: Text("Hola mundo"),
      ),
    );
  }
}
