class Gist {
  late String id;
  late String name;

  Gist({required this.id, required this.name});

  Gist.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
  }
}
