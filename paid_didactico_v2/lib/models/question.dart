class Question {
  late String? imageQuestion;
  late String? sayQuestion;

  Question.fromJson(Map<String, dynamic> data) {
    imageQuestion = data['image_question'];
    sayQuestion = data['say_question'];
  }
}
