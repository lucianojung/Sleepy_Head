import 'package:sleepy_head/models/question.dart';
import 'package:sleepy_head/models/szenario.dart';

import 'dart:convert' as convert;

class Category {
  var id = -1;
  var categoryName = 'Category';
  List<Szenario> szenarios = [];
  var level = 0;
  var progress = 0.0;

  Category({id, categoryName, level, szenarios, progress}){
    this.id = id ?? this.id;
    this.categoryName = categoryName ?? this.categoryName;
    this.level = level ?? this.level;
    this.szenarios = szenarios ?? this.szenarios;
    this.progress = progress ?? this.progress;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': categoryName,
    'level': level,
    'szenarios': List<dynamic>.from(szenarios.map((x) => x.toJson())),
    'progress': progress,
  };

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryName = json['categoryName'],
        level = json['level'],
        szenarios = List<Szenario>.from(json['szenarios'].map((x)=> Szenario.fromJson(x))).toList(),
        progress = json['progress']
  ;

  static List<Category> categories = [
    Category(
        id: 1,
        categoryName: 'Light',
        szenarios: [
          Szenario(
            id: 1,
            difficulty: 0,
            szenarioName: 'Fast, Faster, Rapid',
            samSzenario: 'Hi there! Can you help me find an answer? \nWhen I\'m in bed and use my phone I can\'t fall asleep.',
            userAnswer: 'No problem we will find a solution for you!',
            questions: [
              Question(
                id: 1,
                question: 'Why should Sam put his screens away at bedtime?',
                answers: ['Because Sam is not allowed to have fun', 'Because he could go blind', 'Blue light emitted from screens negatively impacts the production of melatonin, the body\'s natural sleep-inducing hormone, thereby disrupts Sams sleep', 'because Sam might become nightmares'],
                rightAnswer: 2
              )
            ],
            info: 'Do you know: In the first half of the day, get at least 30-40 minutes of direct sunlight to feel more alert. This can even be achieved by working next to a window with natural light coming through.'
          )
        ]
    ),
    // Category(
    //     id: 2,
    //     categoryName: 'Noises',
    // ),
    // Category(
    //     id: 3,
    //     categoryName: 'Food',
    // ),
    // Category(
    //   id: 4,
    //   categoryName: 'Routine',
    // ),
  ];
}
