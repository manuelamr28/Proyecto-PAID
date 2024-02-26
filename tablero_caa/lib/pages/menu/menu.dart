import 'package:flutter/material.dart';
import 'package:tablero_caa/components/app_bar.dart';
import 'package:tablero_caa/components/app_footer.dart';
import 'package:tablero_caa/models/menu.dart';
import 'package:tablero_caa/pages/menu/components/menu_viewer.dart';

class MenuPage extends StatelessWidget {
  final Menu menu;
  const MenuPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    List<Menu> menuList = parseDynamicToMenu();
    return Scaffold(
        appBar: AppBarMain(title: menu.name),
        body: ListView.builder(
          itemCount: menuList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                MenuViewer(
                  menu: menuList[index],
                ),
              ],
            );
          },
        ),
        floatingActionButton:
            const Align(alignment: Alignment.bottomRight, child: AppFooter()));
  }

  List<Menu> parseDynamicToMenu() {
    List<Menu> menuList = (menu.menu)
        .map((menuData) => Menu.fromJson(menuData as Map<String, dynamic>))
        .toList();

    return menuList;
  }
}
