import 'package:flutter/material.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/global_pages/home_page.dart';
import 'package:paid_didactico/models/module.dart';
import 'package:paid_didactico/module_1/module_one_page.dart';
import 'package:paid_didactico/module_2/module_two_page.dart';
import 'package:paid_didactico/module_3/module_three_page.dart';
import 'package:paid_didactico/module_4/module_four_page.dart';
import 'package:paid_didactico/module_5/module_five_page.dart';
import 'package:paid_didactico/module_6/module_six_page.dart';
import 'package:provider/provider.dart';

class ModuleViewer extends StatelessWidget {
  final Module module;
  final int index;

  const ModuleViewer({super.key, required this.module, required this.index});

  @override
  Widget build(BuildContext context) {
    String urlImage =
        context.read<GlobalParameters>().imagesMap[module.image] ??
            "assets/images/nose.png";
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => getPageByIndex(index, module)))
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xFFF2EDDC),
            boxShadow: [
              BoxShadow(
                color: Colors.black, // Color de la sombra
                blurRadius: 10, // Radio de desenfoque
                offset: Offset(0,
                    4), // Desplazamiento (positivo hacia abajo para una sombra inferior)
              ),
            ],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: urlImage.startsWith("assets")
                  ? Image.asset(
                      urlImage, // Ruta de tu imagen
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      urlImage,
                      fit: BoxFit.contain,
                    ),
            ),
            Container(
                height: 60.0,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  module.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight
                        .bold, // Agrega esta línea para hacer el texto negrita
                    color: Color(0xFF1E2622),
                  ),
                )),
          ]),
        ),
      ),
    );
  }

  Widget getPageByIndex(int index, Module module) {
    Widget page = HomePage();

    switch (index) {
      case 0:
        page = Modulo1Page(
          module: module,
        );
        break;
      case 1:
        page = Modulo2Page(
          module: module,
        );
        break;
      case 2:
        page = Modulo3Page(
          module: module,
        );
        break;
      case 3:
        page = const Modulo4Page();
        break;
      case 4:
        page = const Modulo5Page();
        break;
      case 5:
        page = Modulo6Page(
          module: module,
        );
        break;
    }

    return page;
  }
}
