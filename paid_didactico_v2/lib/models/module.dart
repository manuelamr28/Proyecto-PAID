import 'package:paid_didactico/models/gist.dart';

class Module {
  late String name;
  late Gist gist;
  late String image;
  late String description;

  Module.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gist = Gist.fromJson(json['gist']);
    image = json['image'];
    description = json['description'];
  }
}
