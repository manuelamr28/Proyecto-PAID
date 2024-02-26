class Level {
  late int level;
  late int quantity;
  late int nextLevel;

  Level({required this.level, required this.quantity, required this.nextLevel});

  Level.fromJson(Map<String, dynamic> data) {
    level = data['level'];
    quantity = data['quantity'];
    nextLevel = data['next_level'];
  }
}
