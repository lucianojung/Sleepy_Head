import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/category_provider.dart';
import '../../shared/progress_cloud.dart';

class HelpSamView extends StatefulWidget {
  HelpSamView({Key? key}) : super(key: key);

  @override
  _HelpSamViewState createState() => _HelpSamViewState();
}

class _HelpSamViewState extends State<HelpSamView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<CategoryProvider>(
        builder: (context, data, _) => ListView.builder(
          itemCount: data.categories.length,
          itemBuilder: (context, index) {
            var category = data.categories[data.categories.length - index - 1];
            return ProgressCloud(category);
          },
        ),
      ),
    );
  }
}