import 'package:flutter/material.dart';

class ButtonViewer extends StatelessWidget {
  final String letter;
  final VoidCallback onPressed;
  const ButtonViewer(
      {super.key, required this.onPressed, required this.letter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
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
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Text(
                letter,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25.0),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
