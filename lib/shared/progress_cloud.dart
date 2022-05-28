import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/models/category.dart';
import 'package:sleepy_head/models/szenario_handler.dart';
import 'package:sleepy_head/services/category_provider.dart';

import '../theme_config.dart';

class ProgressCloud extends StatefulWidget {
  Category category;

  ProgressCloud(this.category, {Key? key}) : super(key: key);

  @override
  _ProgressCloudState createState() => _ProgressCloudState();
}

class _ProgressCloudState extends State<ProgressCloud> {
  var showInfos = false;

  @override
  Widget build(BuildContext context) {
    var category = widget.category;
    var szenarios = Provider.of<CategoryProvider>(context, listen: false).getSzenariosByCategory(category);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (() {
                var szenario = szenarios[Random().nextInt(szenarios.length)];
                List<String> followingSteps = ['Start'];
                followingSteps.addAll(List<String>.generate(szenario.questions.length, (_) => 'Question'));
                followingSteps.addAll(['Info', 'Celebrate']);
                var szenarioHandler = SzenarioHandler(szenario: szenario, followingSteps: followingSteps);
                Navigator.of(context).pushNamed(
                    '/szenario', arguments: [szenarioHandler]);
              }),
              child: TweenAnimationBuilder(
                  tween: Tween(begin: category.progress - 0.1, end: category.progress),
                  duration: Duration(seconds: (category.progress != 0 && category.progress != 1) ? 1 : 0),
                  builder: (context, value, child) {
                    return SizedBox(
                      width: 400,
                      height: 100,
                      child: Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [value as double, value],
                                      colors: getColors(category.level))
                                  .createShader(rect);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/images/cloud.png"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Text(
            category.categoryName,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  List<Color> getColors(level) {
    switch (level) {
      case (0):
        return [cloudColors[400]!, cloudColors[500]!];
      case (1):
        return [cloudColors[300]!, cloudColors[400]!];
      case (2):
        return [cloudColors[200]!, cloudColors[300]!];
      case (3):
        return [cloudColors[100]!, cloudColors[200]!];
      case (4):
        return [cloudColors[50]!, cloudColors[100]!];
      default:
        return [cloudColors[50]!, cloudColors[50]!];
    }
  }
}
