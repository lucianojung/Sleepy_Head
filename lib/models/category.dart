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
            samSzenario: 'Hi there! You know, I sleep my prescribed 15-18 hours every night and still feel unrested. Can you help me with this?',
            samAnswer: 'No problem we will find a solution for you!',
            questions: [
              Question(
                id: 1,
                question: 'What are the different types of sleep stages?',
                answers: ['RAN and Non-RAN', 'REM and Non-REM', 'RUN and Non-RUN', 'RENN and Non-RENN'],
                rightAnswer: 1
              )
            ],
            info: 'Do you know: REM stands for Rapid eye movement...'
          )
        ]
    ),
    Category(
        id: 2,
        categoryName: 'Noises',
    ),
    Category(
        id: 3,
        categoryName: 'Food',
    ),
    Category(
      id: 4,
      categoryName: 'Routine',
    ),
  ];
}
