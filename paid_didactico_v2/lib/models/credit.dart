class Credit {
  late String name;
  late String say;
  late String image;
  late String message;
  late String url;

  Credit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    say = json['say'];
    image = json['image'];
    message = json['message'];
    url = json['url'];
  }
}
