import 'package:flutter/material.dart';
import '../util/apptext.dart';

class LLMresponse extends StatelessWidget {
  final String text;

  const LLMresponse({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        child: SingleChildScrollView(
          child: Text(
            text,
            style: AppText.llmText,
          ),
        ),
      ),
    );
  }
}
