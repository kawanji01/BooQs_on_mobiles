import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/components/quiz/explanation/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationOpenButton extends ConsumerWidget {
  const QuizExplanationOpenButton({super.key, required this.answerNotification});
  final AnswerNotification answerNotification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      child: Text(t.answer.view_explanation,
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
      onPressed: () {
        // 解説モーダル内の辞書リンクで遷移後のページでも解答インタラクションが表示されてしまうので、
        // bottomSheetを表示するときにインタラクションも消しておく
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          // 丸める
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          // showModalBottomSheetで表示される中身
          builder: (context) => QuizExplanationScreen(
            answerNotification: answerNotification,
          ),
        );
      },
    );
  }
}
