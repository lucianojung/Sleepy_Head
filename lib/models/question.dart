class Question {
  var id = -1;
  var question = '';
  List<String> answers = [];
  var rightAnswer = -1;

  Question({id, question, answers, rightAnswer}){
    this.id = id ?? this.id;
    this.question = question ?? this.question;
    this.answers = answers ?? this.answers;
    this.rightAnswer = rightAnswer ?? this.rightAnswer;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'answers': answers,
    'rightAnswer': rightAnswer,
  };

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        question = json['question'] as String,
        answers = List<String>.from(json['answers']),
        rightAnswer = json['rightAnswer'] as int
  ;
}
