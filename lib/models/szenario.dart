import 'package:sleepy_head/models/question.dart';

import 'dart:convert' as convert;

class Szenario {
  var id = -1;
  var szenarioName = 'Szenario';
  var samSzenario = '';
  var samAnswer = '';
  List<Question> questions = [];
  var difficulty = 0;
  var info = '';

  Szenario({id, szenarioName, samSzenario, samAnswer, questions, difficulty, info}){
    this.id = id ?? this.id;
    this.szenarioName = szenarioName ?? this.szenarioName;
    this.samSzenario = samSzenario ?? this.samSzenario;
    this.samAnswer = samAnswer ?? this.samAnswer;
    this.questions = questions ?? this.questions;
    this.difficulty = difficulty ?? this.difficulty;
    this.info = info ?? this.info;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'szenarioName': szenarioName,
    'samSzenario': samSzenario,
    'samAnswer': samAnswer,
    'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
    'difficulty': difficulty,
    'info': info,
  };

  Szenario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        szenarioName = json['szenarioName'],
        samSzenario = json['samSzenario'],
        samAnswer = json['samAnswer'],
        questions = List<Question>.from(json['questions'].map((x) => Question.fromJson(x))).toList(),
        difficulty = json['difficulty'],
        info = json['info']
  ;
}
