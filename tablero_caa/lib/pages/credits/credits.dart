import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablero_caa/components/app_bar.dart';
import 'package:tablero_caa/components/app_footer.dart';
import 'package:tablero_caa/models/global_parameters.dart';
import 'package:tablero_caa/pages/credits/components/credit_viewer.dart';

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
        floatingActionButton:
            const Align(alignment: Alignment.bottomRight, child: AppFooter()));
  }
}
