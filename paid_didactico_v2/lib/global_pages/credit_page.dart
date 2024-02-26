import 'package:flutter/material.dart';
import 'package:paid_didactico/components/app_bar.dart';
import 'package:paid_didactico/components/credit_viewer.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:provider/provider.dart';

class CreditPage extends StatelessWidget {
  const CreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final credits = context.watch<GlobalParameters>().credits;
    return Scaffold(
      appBar: AppBarMain(title: "Creditos"),
      body: Center(
        child: ListView.builder(
          itemCount: credits.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                CreditViewer(
                  credit: credits[index],
                ),
              ],
            );
          },
          itemExtent: 160.0,
        ),
      ),
    );
  }
}
