import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/cancellation.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class PurchaseCancellationButton extends ConsumerWidget {
  const PurchaseCancellationButton({super.key, required this.entitlementInfo});
  final EntitlementInfo entitlementInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    if (user.premium == false) return Container();

    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          // 解約理由を送信済みなら端末の支払い設定に飛ばす。
          if (user.appCancelReportSent) {
            WebPageLauncher.openCancellationPage(entitlementInfo);
          } else {
            // 解約理由を送信していないなら、解約理由を書き込むページに遷移
            UserCancellationPage.push(context, entitlementInfo);
          }
        },
        child: Text(
          t.cancellation.cancel_subscription,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
