import 'package:flutter/material.dart';
import 'package:sleepy_head/models/category.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (() => Navigator.of(context).pushNamed('/learn', arguments: category)),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  List<Color> getColors(level) {
    switch (level) {
      case (0):
        return [Colors.blue[700]!, Colors.blue[900]!];
      case (1):
        return [Colors.blue, Colors.blue[700]!];
      case (2):
        return [Colors.blue[300]!, Colors.blue];
      case (3):
        return [Colors.blue[100]!, Colors.blue[300]!];
      case (4):
        return [Colors.blue[50]!, Colors.blue[100]!];
      default:
        return [Colors.blue[50]!, Colors.blue[50]!];
    }
  }
}
