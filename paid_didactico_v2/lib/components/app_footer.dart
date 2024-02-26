import 'package:flutter/material.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF1E2622),
      onPressed: () {
        context.read<GlobalParameters>().changeStatusTts();
        bool state = context.read<GlobalParameters>().enabledTts;
        Fluttertoast.showToast(
            msg: "Voz ${state ? " Activada" : " Desactivada"}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      child: const Icon(Icons.volume_up),
    );
  }
}
