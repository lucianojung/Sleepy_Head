
import 'package:sleepy_head/models/question.dart';

import 'szenario.dart';

class SzenarioHandler {
  Szenario szenario = Szenario();
  List<String> followingSteps = [];
  int currentQuestionIndex = -1;
  int correctAnswers = 0;

  int get wrongAnswers => currentQuestionIndex + 1 - correctAnswers;

  String get celebrationText => 'You gained ${correctAnswers * 10} Points!';

  String get correctAnswerResponse => 'Correct!';
  String get wrongAnswerResponse => 'Not quite!';

  QuestionAndAnswer get currentQuestion => szenario.questions[currentQuestionIndex];

  String get nextRoute => followingSteps[0] == 'Question' ? '/szenarioQuestion' : followingSteps[0] == 'Info' ? '/szenario' : '/szenarioCelebration';

  bool get isInfoStep => followingSteps[0] == 'Info';

  SzenarioHandler({szenario, followingSteps, currentQuestion, correctAnswers}) {
    this.szenario = szenario ?? this.szenario;
    this.followingSteps = followingSteps ?? this.followingSteps;
    this.currentQuestionIndex = currentQuestion ?? this.currentQuestionIndex;
    this.correctAnswers = correctAnswers ?? this.correctAnswers;
  }
}