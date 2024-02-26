import 'package:flutter/material.dart';
import 'package:paid_didactico/components/app_bar.dart';
import 'package:paid_didactico/components/global_parameters.dart';
import 'package:paid_didactico/components/module_viewer.dart';
import 'package:paid_didactico/global_pages/offline_page.dart';
import 'package:paid_didactico/models/constants.dart';
import 'package:paid_didactico/models/data_paid.dart';
import 'package:paid_didactico/models/module.dart';
import 'package:paid_didactico/services/data_manager.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  late DataPaid? dataPaid;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DataManager manager =
        DataManager(gistId: Paid.home.id, key: Paid.home.name);

    return Scaffold(
        appBar: AppBarMain(title: "PAID Didactico"),
        body: FutureBuilder(
          future: manager.getData(),
          builder: (context, result) {
            if (result.hasData) {
              bool status = result.data?.isNotEmpty ?? false;
              if (!status) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const OfflinePage()),
                );
              }
              Map<String, dynamic> data = result.data ?? {};
              dataPaid = DataPaid.fromJson(data);

              if (dataPaid!.credits.isNotEmpty) {
                context
                    .read<GlobalParameters>()
                    .setCredistList(dataPaid!.credits);
              }
              if (dataPaid!.images.isNotEmpty) {
                context.read<GlobalParameters>().setMapImages(dataPaid!.images);
              }

              return Center(
                  child: ModuleListBuilder(moduleList: dataPaid!.modules));
            } else if (result.hasError) {
              return Center(
                child: Text("Error: ${result.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class ModuleListBuilder extends StatelessWidget {
  final List<Module> moduleList;

  const ModuleListBuilder({super.key, required this.moduleList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: (moduleList.length / 2).ceil(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              buildListItem(context, index * 2),
              const SizedBox(
                width: 16.0,
                height: 220.0,
              ),
              buildListItem(context, index * 2 + 1)
            ],
          );
        });
  }

  Widget buildListItem(BuildContext context, int index) {
    if (index < moduleList.length) {
      return Expanded(
          child: ModuleViewer(
        module: moduleList[index],
        index: index,
      ));
    } else {
      return const SizedBox
          .shrink(); // O cualquier widget de relleno que desees
    }
  }
}
