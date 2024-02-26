import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablero_caa/components/app_bar.dart';
import 'package:tablero_caa/components/app_footer.dart';
import 'package:tablero_caa/models/global_parameters.dart';
import 'package:tablero_caa/pages/home/services/data_manager.dart';
import 'package:tablero_caa/pages/menu/components/menu_viewer.dart';
import 'package:tablero_caa/pages/offline/offline.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DataManager manager = DataManager();
    return Scaffold(
        appBar: AppBarMain(title: "Tablero CAA"),
        body: FutureBuilder(
          future: manager.getData(),
          builder: (context, result) {
            if (result.hasData) {
              bool status = result.data?.version == "online" ? true : false;
              if (!status) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const OfflinePage()),
                );
              } else {
                context.read<GlobalParameters>().setOnlineStatus(status);
                var menuList = result.data?.menu;
                var creditList = result.data?.credits;
                Map<String, String> imagesMap =
                    result.data?.images as Map<String, String>;

                if (creditList != null) {
                  context.read<GlobalParameters>().setCredistList(creditList);
                  context.read<GlobalParameters>().setMapImages(imagesMap);
                }
                if (menuList != null) {
                  return Column(
                    children: [
                      const Text(
                        'Tablero de comunicación aumentativa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: menuList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MenuViewer(menu: menuList[index]);
                              }))
                    ],
                  );
                }
              }
            } else if (result.hasError) {
              return Center(
                child: Text("Error: ${result.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton:
            const Align(alignment: Alignment.bottomRight, child: AppFooter()));
  }
}
