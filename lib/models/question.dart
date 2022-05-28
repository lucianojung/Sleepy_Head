class QuestionAndAnswer {
  var id = -1;
  var question = '';
  List<String> answers = [];
  List<String> feedback = [];
  var rightAnswer = -1;

  QuestionAndAnswer({id, question, answers, feedback, rightAnswer}){
    this.id = id ?? this.id;
    this.question = question ?? this.question;
    this.answers = answers ?? this.answers;
    this.feedback = feedback ?? this.feedback;
    this.rightAnswer = rightAnswer ?? this.rightAnswer;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'answers': answers,
    'feedback': feedback,
    'rightAnswer': rightAnswer,
  };

  QuestionAndAnswer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        question = json['question'] as String,
        answers = List<String>.from(json['answers']),
        feedback = List<String>.from(json['feedback']),
        rightAnswer = json['rightAnswer'] as int
  ;
}
