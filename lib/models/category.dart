import 'package:sleepy_head/models/question.dart';
import 'package:sleepy_head/models/szenario.dart';

class Category {
  var id = -1;
  var categoryName = 'Category';
  List<Szenario> szenarios = [];
  var level = 0;
  var progress = 0.0;

  Category({id, categoryName, level, szenarios, progress}) {
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
        szenarios = List<Szenario>.from(json['szenarios'].map((x) => Szenario.fromJson(x))).toList(),
        progress = json['progress'];

  static List<Category> categories = [
    Category(id: 1, categoryName: 'Light', szenarios: [
      Szenario(
          id: 1,
          difficulty: 0,
          szenarioName: 'Sam Can’t Fall Asleep',
          samSzenario:
              'Hi there! \nI\'m having problems to fall asleep lately. \nCan you help me find a solution.',
          userAnswer: 'No problem we will find a solution for you!',
          questions: [
            QuestionAndAnswer(
                id: 1,
                question: 'What behaviour helps Sam better fall asleep before going to bed?',
                answers: [
                  'Play videogames',
                  'Stop using screens',
                  'Use an extra pillow',
                  'Drink a glas of wine',
                ],
                feedback: [
                  '',
                  '',
                  '',
                  '',
                ],
                rightAnswer: 1)
          ],
          info:
              'Sam should stops using his phone at least 30 mins before bed. \nThis reduces his light exposure and therefore prepare his brain in a naturally way to go to sleep soon. \nDrinking a glas of wine to better fall asleep is unfortunately a myth.'), // Szenario 1 Question 1
    ]),
    Category(id: 2, categoryName: 'Internal clock', szenarios: [
      Szenario(
          id: 2,
          difficulty: 0,
          szenarioName: 'Sam Can’t Fall To Sleep',
          samSzenario:
              'Hi there! Can you help me find an answer? \nWhen I\'m in bed and use my phone I can\'t fall asleep.',
          userAnswer: 'No problem we will find a solution for you!',
          questions: [
            QuestionAndAnswer(
                id: 2,
                question: 'What could Sam do to help himself fall to sleep?',
                answers: [
                  'Go to sleep at the same time and wake up at the same time',
                  'Just go to sleep when he feels like it',
                  'Use blackout blinds and no alarm to wake up',
                ],
                feedback: [
                  'Sleeping at the same time, as well as waking up at the same time, help to maintain a consistent circadian rhythm, our bodies natural sleep/wake clock. This is one of the most fundamental aspects of sleeping well.',
                  'Sleeping at a consistent time, as well as waking up at a consistent time, helps to maintain our bodies natural sleep cycle - known as our circadian rhythm.',
                  'The combination of blackout blinds and no alarm for waking up remove two natural indicators that its time to wake up (ie light and sound). Removing both of these means our bodies can’t develop a natural sleep cycle, which in turns leaves Sam feeling more tired and like he can’t fall to sleep very well.',
                ],
                rightAnswer: 0)
          ],
          info:
              ' Sleeping at a consistent time, as well as waking up at a consistent time, helps to maintain our bodies natural sleep cycle - known as our circadian rhythm.\nAlso napping in general is not advised, as it disrupts your natural sleep cycle.'), // Szenario 1 Question 2
      Szenario(
          id: 3,
          difficulty: 2,
          szenarioName: 'Sam is tired in the morning!',
          samSzenario: 'Hi there! I\'m feeling tired although I slept enough. Can you help me find the reason?',
          userAnswer: 'Yes, I can help you with that!',
          questions: [
            QuestionAndAnswer(
                id: 3,
                question:
                    'One of the following statements is wrong - can you help Sam to find the one thing on this list he should avoid?',
                answers: [
                  'In the first half of the day, Sam should try to get at least 30-40 minutes of direct sunlight to feel more alert.',
                  'Paying attention to the daily light exposure is the only tool available to set Sam\'s internal clock correctly.',
                  'Whenever possible, Sam should try to minimize the time with sunglasses on to accurately convey information about the daytime to the rest of the body.',
                ],
                feedback: [
                  'It is true that direct sunlight in the first hours of the day improves alertness, which has a great influence on the circadian rhythm and the internal clock. At best, this is achieved by spending time outside, and it doesn\'t matter if it\'s cloudy. But even the light exposure through a window already has a great impact on the internal clock, which is why working next to a window can be used when time outside in the first half of the day is not possible. The correct answer would have been b, because in addition to light exposure, diet and other habits, such as alcohol or smoking, also play a role in influencing the circadian rhythm.',
                  'In addition to light exposure, diet and other habits, such as alcohol or smoking, also play a role in influencing the circadian rhythm.',
                  'Wearing sunglasses tends to change the sensitivity of the eye\'s adaptation mechanism, by which you can usually tell what time of day it is. The correct answer would have been b, because in addition to light exposure, diet and other habits, such as alcohol or smoking, also play a role in influencing the circadian rhythm.',
                ],
                rightAnswer: 1)
          ],
          info:
              'In addition to light exposure, diet and other habits, such as alcohol or smoking, also play a role in influencing the circadian rhythm.'), // Szenario 2 Question 1
    ]),
    Category(id: 3, categoryName: 'Routine', szenarios: [
      Szenario(
          id: 4,
          difficulty: 0,
          szenarioName: 'Sam Can’t Fall To Sleep',
          samSzenario:
              'Hi there! Can you help me find an answer? \nWhen I\'m in bed and use my phone I can\'t fall asleep.',
          userAnswer: 'No problem we will find a solution for you!',
          questions: [
            QuestionAndAnswer(
                id: 4,
                question: 'What could Sam do to help himself fall to sleep?',
                answers: [
                  'Create a calming routine before bed and try reading, for example',
                  'Keep playing candy crush as he enjoys it',
                  'Just focus on the morning routine as the evening is not important',
                ],
                feedback: [
                  'Compared to using a phone before bed, which offers light exposure, potential noise and the need of focused attention, creating a calming routine like reading before bed helps to develop healthy sleep hygiene as a result of a consistent and helpful routine.',
                  'Despite the enjoyment, Sam’s brain is experiencing a sense of reward/enjoyment and is less likely to fall to sleep, along with the light exposure and potential sounds. Using a phone in bed before sleep doesn’t help the body to prepare for sleep, rather, signals its a time to be awake. ',
                  'Though of course it is helpful and important to focus on the morning routine, it is also important to consider the evening routine. This way, Sam can develop a well-rounded sleep cycle and decrease feelings of tiredness and easily fall to sleep.',
                ],
                rightAnswer: 0)
          ],
          info:
              'Compared to using a phone before bed, which offers light exposure, potential noise and the need of focused attention, creating a calming routine like reading before bed helps to develop healthy sleep hygiene as a result of a consistent and helpful routine.'), // Szenario 1 Question 3
    ]),
    Category(id: 4, categoryName: 'Drugs', szenarios: [
      Szenario(
          id: 5,
          difficulty: 2,
          szenarioName: 'Sam is tired in the morning!',
          samSzenario:
              'Hi there! I\'m feeling tired although I slept enough. Can you help me find the reason?',
          userAnswer: 'Sure thing!',
          questions: [
            QuestionAndAnswer(
                id: 5,
                question: 'Which statement about the interaction between sleep and caffeine would you consider true?',
                answers: [
                  'Dose and timing of caffeine intake are a key factor. It’s best to allow natural signals to wake up the body by delaying caffeine intake 90 minutes after waking up, and having the last caffeine intake about 8-10 hours before bedtime.',
                  'Drinking coffee or other caffeinated beverages always has a negative effect on sleep and should therefore be avoided as a matter of principle.',
                  'If I can\'t feel the effect of caffeine, then I don\'t have to give it any special consideration and can drink as much coffee as I want. The time of day doesn\'t play a special role either, because coffee doesn\'t make me feel more awake.',
                ],
                feedback: [
                  'By definition, caffeine is a psychoactive stimulant that increases the dopamin (which is associated with wakefulness) and blocks adenosine (which makes Sam sleepier). When Sam comes down from caffeine, he loses its effects. The dopamine drops and the level of the suppressed adenosine rises again. Therefore, Sam should have timing and dosage of caffeine in mind if he wants to improve his sleep quality.',
                  'While it is true that coffee can have a negative impact on Sam\'s good sleep, the dosage and especially the timing of intake are the determining factors in terms of impact on sleep. In terms of sleep improvement, the last intake of caffeine should be about 8-10 hours before the time of going to bed.',
                  'In terms of sleep improvement, the last intake of caffeine should be about 8-10 hours before the time of going to bed. Even if you don\'t consciously feel the effects of late-night caffeine consumption on your sleep, your sleep cycles are disrupted by it - especially deep sleep.',
                ],
                rightAnswer: 0)
          ],
          info:
              'By definition, caffeine is a psychoactive stimulant that increases the dopamin (which is associated with wakefulness) and blocks adenosine (which makes Sam sleepier). When Sam comes down from caffeine, he loses its effects. The dopamine drops and the level of the suppressed adenosine rises again. Therefore, Sam should have timing and dosage of caffeine in mind if he wants to improve his sleep quality.'),
      Szenario(
          id: 6,
          difficulty: 2,
          szenarioName: 'Sam is tired in the morning!',
          samSzenario:
          'Hi there! I\'m feeling tired although I slept enough. Can you help me find the reason?',
          userAnswer: 'That\'s what I\'m here for!',
          questions: [
            QuestionAndAnswer(
                id: 6,
                question: 'When it comes to sleep and alcohol, what of the following statements is true?',
                answers: [
                  'By definition, caffeine is a psychoactive stimulant that increases the dopamin (which is associated with wakefulness) and blocks adenosine (which makes Sam sleepier). When Sam comes down from caffeine, he loses its effects. The dopamine drops and the level of the suppressed adenosine rises again. Therefore, Sam should have timing and dosage of caffeine in mind if he wants to improve his sleep quality.',
                  'If Sam can\'t sleep for a few days in a row, having a nightcap or drink in the evening might help him fall asleep faster. However, he must be careful what kind of drink he chooses and not drink too much of it.',
                  'Sam should not have an alcoholic drink at all if he wants to improve his sleep, because even small amounts of alcohol reduce the quality of sleep.',
                ],
                feedback: [
                  'Alcohol is not a sleep aid, but a sedative. The consumption of alcohol has been linked to poor sleep quality and duration. This means that alcohol actually has negative effects on sleep and is therefore counterproductive. After drinking alcohol, Sam loses consciousness faster, but does not achieve effective and therefore restful sleep. ',
                  'Mistakenly, some people tend to have a "nightcap" or evening drink to help them fall asleep, thereby shutting out their thoughts and worries. Alcohol actually promotes sleep problems because Sam sleeps restlessly and wakes up more often throughout the night. In addition, alcohol is a strong REM-sleep blocker.',
                  'Even low amounts of alcohol decrease the sleep quality by approximately 10% and if Sam would drink more, this number increases up to 40%. ',
                ],
                rightAnswer: 0)
          ],
          info:
          'Even low amounts of alcohol decrease the sleep quality by approximately 10% and if Sam would drink more, this number increases up to 40%. Of course, the timing and dose of drinking play a role, and the exact extent of the reaction is different for each person. Although the degree of impairment varies, clearly no improvement in sleep is achieved by alcohol.'),
    ]),
  ];
}
