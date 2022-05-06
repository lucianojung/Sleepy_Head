import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/models/category.dart';

import '../services/category_provider.dart';

class LearnView extends StatefulWidget {
  Category category;

  LearnView(this.category, {Key? key}) : super(key: key);

  @override
  _LearnViewState createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  var _selectedAnswer;
  var _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            widget.category.categoryName,
            textAlign: TextAlign.center,
          ),
          Text('Select the right Answer'),
          Text('Where can you get the best sleep?'),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16.0),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                OutlinedButton(
                  onPressed: () => setState(() => _selectedAnswer = 'At the Airport'),
                  child: Text('At the Airport'),
                  style: ButtonStyle(
                    backgroundColor: (_selectedAnswer == 'At the Airport')
                        ? MaterialStateProperty.all(Colors.green)
                        : MaterialStateProperty.all(Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => setState(() => _selectedAnswer = 'Near a train station'),
                  child: Text('Near a train station'),
                  style: ButtonStyle(
                    backgroundColor: (_selectedAnswer == 'Near a train station')
                        ? MaterialStateProperty.all(Colors.green)
                        : MaterialStateProperty.all(Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => setState(() => _selectedAnswer = 'In a care home for the elderly'),
                  child: Text('In a care home for the elderly'),
                  style: ButtonStyle(
                    backgroundColor: (_selectedAnswer == 'In a care home for the elderly')
                        ? MaterialStateProperty.all(Colors.green)
                        : MaterialStateProperty.all(Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => setState(() => _selectedAnswer = 'At a party'),
                  child: Text('At a party'),
                  style: ButtonStyle(
                    backgroundColor: (_selectedAnswer == 'At a party')
                        ? MaterialStateProperty.all(Colors.green)
                        : MaterialStateProperty.all(Colors.white),
                  ),
                )
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedContainer(
                width: double.infinity,
                duration: Duration(milliseconds: 100),
                color: Colors.grey,
                child: Text('Congrats! You won 10 Points', textAlign: TextAlign.center,),
                height: _checked ? 75 : 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _selectedAnswer != null ? (() {
                      if (!_checked) {
                        setState(() {
                          _checked = true;
                        });
                      } else {
                        Provider.of<CategoryProvider>(context, listen: false).increaseProgress(widget.category.id);
                        Navigator.of(context).pop();
                      }
                    }) : null,
                    child: Text(_checked ? 'CONTINUE' : 'CHECK')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
