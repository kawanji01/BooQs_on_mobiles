import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingReviewNotification extends ConsumerWidget {
  const AnswerSettingReviewNotification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ドロップダウンボタンの生成
    Widget buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<int>(
          value: ref.watch(reviewNotificationTimerProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            ref.read(reviewNotificationTimerProvider.notifier).state =
                newValue!;
          },
          items: <int>[
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
          ].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(AnswerSettingHelper.reviewNotificationTimer(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    Widget reviewNotificationEnabled() {
      return SwitchListTile(
        title: Text(t.answerSettings.review_notification_enabled,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text(t.answerSettings.review_notification_enabled_description),
        value: ref.watch(reviewNotificationEnabledProvider),
        onChanged: (bool value) {
          ref.read(reviewNotificationEnabledProvider.notifier).state = value;
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [reviewNotificationEnabled(), buildDropDown()],
    );
  }
}
