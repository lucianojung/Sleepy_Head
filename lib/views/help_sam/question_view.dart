import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/theme_config.dart';

import '../../models/szenario.dart';
import '../../models/szenario_handler.dart';
import '../../services/category_provider.dart';
import '../../shared/my_material_button.dart';

class SzenarioQuestionView extends StatefulWidget {
  SzenarioHandler szenarioHandler;

  SzenarioQuestionView({required this.szenarioHandler, Key? key}) : super(key: key);

  @override
  _SzenarioQuestionViewState createState() => _SzenarioQuestionViewState();
}

class _SzenarioQuestionViewState extends State<SzenarioQuestionView> {
  var _selectedIndex = -1;
  var _checked = false;

  @override
  Widget build(BuildContext context) {
    var currentQuestion = widget.szenarioHandler.currentQuestion;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.szenarioHandler.szenario.szenarioName,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(currentQuestion.question, style: subheaderStyle, textAlign: TextAlign.left),
                ),
                Expanded(
                  flex: 2,
                  child: GridView.count(
                    childAspectRatio: 16 / 9,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    padding: EdgeInsets.all(16),
                    children: [
                      for (var answer in currentQuestion.answers)
                        MyMaterialButton(
                          text: answer,
                          onPressed: () => setState(() {
                            var index = currentQuestion.answers.indexWhere((element) => element == answer);
                            _selectedIndex = _selectedIndex == index ? -1 : index;
                          }),
                          backgroundColor: (_selectedIndex >= 0 && currentQuestion.answers[_selectedIndex] == answer)
                              ? MaterialStateProperty.all(Colors.green)
                              : MaterialStateProperty.all(Colors.white),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      _checked ? currentQuestion.feedback[_selectedIndex] : '',
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    if (_selectedIndex >= 0)
                      AnimatedContainer(
                        width: double.infinity,
                        duration: const Duration(milliseconds: 100),
                        color: currentQuestion.rightAnswer == _selectedIndex ? Colors.green : Colors.grey,
                        child: Text(
                          currentQuestion.rightAnswer == _selectedIndex ? 'Correct!' : 'Not quite!',
                          textAlign: TextAlign.center,
                          style: textStyle18,
                        ),
                        height: _checked ? 100 : 0,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyMaterialButton(
                        text: _checked ? 'CONTINUE' : 'CHECK',
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        onPressed: () =>
                            _selectedIndex != -1 ? onAnswerClicked(widget.szenarioHandler.szenario, context) : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      var currentQuestion = widget.szenarioHandler.currentQuestion;
      if (_selectedIndex == currentQuestion.rightAnswer) {
        Provider.of<CategoryProvider>(context, listen: false).increaseProgress(szenario.id, isSzenarioId: true);
        widget.szenarioHandler.correctAnswers++;
      }
      widget.szenarioHandler.followingSteps.removeAt(0);
      if (widget.szenarioHandler.followingSteps[0] == 'Question') {
        widget.szenarioHandler.currentQuestionIndex++;
      }
      Navigator.of(context).pushNamed(widget.szenarioHandler.nextRoute, arguments: [widget.szenarioHandler]);
    }
  }
}
