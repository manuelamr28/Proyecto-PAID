import 'package:flutter/material.dart';
import 'pages/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tablero CAA',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFE0E0E0),
          primaryColor: const Color(0xFF1E2622)),
      home: const HomePage(),
    );
  }
}
