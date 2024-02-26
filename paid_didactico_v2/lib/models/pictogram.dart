import 'package:paid_didactico/models/question.dart';

class Pictogram {
  late String name;
  late String image;
  late String? say;
  late Question? question;

  Pictogram.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    image = data['image'];
    say = data['say'];

    if (data['question'] != null) {
      question = Question.fromJson(data['question']);
    }
  }
}
