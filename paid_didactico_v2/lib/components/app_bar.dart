import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paid_didactico/global_pages/credit_page.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final colors = [0xFFD95970];

  AppBarMain({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 25.0, color: obtenerColorAleatorio()),
      ),
      backgroundColor: const Color(0xFF1E2622),
      actions: [
        IconButton(
          onPressed: () {
            if (title != "Creditos") {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CreditPage()));
            }
          },
          icon: const Icon(Icons.info_outline),
          tooltip: "Creditos",
        )
      ],
    );
  }

  Color obtenerColorAleatorio() {
    final random = Random();
    int colorHex = colors[random.nextInt(colors.length)];
    return Color(colorHex);
  }
}
