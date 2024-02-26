import 'package:flutter/material.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/models/pictogram.dart';
import 'package:provider/provider.dart';

class PictogramViewer extends StatelessWidget {
  final Pictogram pictogram;
  final int index;
  final VoidCallback onPressed;

  const PictogramViewer(
      {super.key,
      required this.pictogram,
      required this.index,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    String urlImage =
        context.read<GlobalParameters>().imagesMap[pictogram.image] ??
            "assets/images/nose.png";
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xFFF2EDDC),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: urlImage.startsWith("assets")
                  ? Image.asset(
                      urlImage,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      urlImage,
                      fit: BoxFit.contain,
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
