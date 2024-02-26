import 'package:flutter/material.dart';
import 'package:paid_didactico/global_pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAID Didactico',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFE0E0E0),
          primaryColor: const Color(0xFF1E2622)),
      home: HomePage(),
    );
  }
}
