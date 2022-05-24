
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import '../theme_config.dart';

Bubble UserBubble(text) {
  return Bubble(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text, style: textStyle18),
      ),
      style: bubbleStyleUser);
}

Bubble SamBubble(text) {
  return Bubble(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text, style: textStyle18),
      ),
      style: bubbleStyleSam);
}


Bubble NarratorBubble(text) {
  return Bubble(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text, style: textStyle18),
      ),
      style: bubbleStyleNarrator);
}


Widget AnswerButton(text, callback) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: textStyle18,
        ),
      ),
      style: buttonStyleUser,
    ),
  );
}