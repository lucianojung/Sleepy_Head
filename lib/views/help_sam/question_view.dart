import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/szenario.dart';
import '../../services/category_provider.dart';
import '../../shared/my_material_button.dart';

class SzenarioQuestionView extends StatefulWidget {
  Szenario szenario;

  SzenarioQuestionView({required this.szenario, Key? key}) : super(key: key);

  @override
  _SzenarioQuestionViewState createState() => _SzenarioQuestionViewState();
}

class _SzenarioQuestionViewState extends State<SzenarioQuestionView> {
  var _selectedAnswer;
  var _checked = false;

  @override
  Widget build(BuildContext context) {
    var szenario = widget.szenario;
    return Scaffold(
      body: Center(
        child: Container(
          width: 600,
          child: Column(
            children: [
              Text(
                szenario.szenarioName,
                textAlign: TextAlign.center,
              ),
              Text('Select the right Answer'),
              Text('Where can you get the best sleep?'),
              Container(
                child: Expanded(
                  child: GridView.count(
                    childAspectRatio: 16 / 9,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      for (var answer in szenario.questions[Random().nextInt(szenario.questions.length)].answers)
                        MyMaterialButton(
                          text: answer,
                          onPressed: () => setState(() => _selectedAnswer = answer),
                          backgroundColor: (_selectedAnswer == answer)
                              ? MaterialStateProperty.all(Colors.green)
                              : MaterialStateProperty.all(Colors.white),
                        ),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AnimatedContainer(
                    width: double.infinity,
                    duration: Duration(milliseconds: 100),
                    color: Colors.grey,
                    child: Text(
                      _selectedAnswer == szenario.questions[0].answers[szenario.questions[0].rightAnswer] ? 'Congrats! You won 10 Points' : 'That wasn\'t correct. You\'ll get it next time',
                      textAlign: TextAlign.center,
                    ),
                    height: _checked ? 100 : 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyMaterialButton(
                      text: _checked ? 'CONTINUE' : 'CHECK',
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      onPressed: () => _selectedAnswer != null
                          ? onAnswerClicked(szenario, context)
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAnswerClicked(Szenario szenario, context) {
      if (!_checked) {
        setState(() {
          _checked = true;
        });
      } else {
        if (_selectedAnswer == szenario.questions[0].answers[szenario.questions[0].rightAnswer]) {
          Provider.of<CategoryProvider>(context, listen: false)
              .increaseProgress(szenario.id, isSzenarioId: true);
        }
        Navigator.of(context).pushNamed('/szenario', arguments: [szenario, true]);
      }
  }
}
