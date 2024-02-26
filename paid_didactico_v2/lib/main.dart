import 'package:flutter/material.dart';
import 'package:paid_didactico/app.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GlobalParameters())],
    child: const App(),
  ));
}
