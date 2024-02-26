import 'package:flutter/material.dart';
import 'package:tablero_caa/app.dart';
import 'package:provider/provider.dart';
import 'package:tablero_caa/models/global_parameters.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GlobalParameters())],
      child: const App(),
    ),
  );
}
