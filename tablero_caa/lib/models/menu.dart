class Menu {
  late String name;
  late String say;
  late String image;
  late List<dynamic> menu;

  Menu() {
    name = "";
  }

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    say = json['say'];
    image = json['image'];
    menu = json['menu'];
  }
}
