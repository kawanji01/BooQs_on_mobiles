import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:flutter/material.dart';

class SentenceItemTTSButton extends StatelessWidget {
  const SentenceItemTTSButton({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
    final String originalPlainText =
        Sanitizer.removeDiQtLink(sentence.original);

    return Container(
      margin: const EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      child: TtsButton(
        speechText: originalPlainText,
        langNumber: sentence.langNumberOfOriginal,
      ),
    );
  }
}
