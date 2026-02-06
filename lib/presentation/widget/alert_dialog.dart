import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WPAlert extends StatelessWidget {
  factory WPAlert.error({
    required BuildContext context,
    required String message,
    required VoidCallback onRetry,
    String? title,
    String? positiveButtonLabel,
    String? negativeButtonLabel,
    VoidCallback? onCancel,
  }) {
    final S strings = S.of(context);
    return WPAlert(
      title: title ?? strings.label_try_again,
      message: message,
      icon: Icon(Icons.error_outline, color: Colors.red, size: 48),
      positiveButton: positiveButtonLabel ?? strings.label_try_again,
      onPositiveTap: onRetry,
      negativeButton: negativeButtonLabel ?? strings.label_cancel,
      onNegativeTap: onCancel,
    );
  }

  factory WPAlert.confirm({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String? confirmLabel,
    String? cancelLabel,
  }) {
    final S strings = S.of(context);
    return WPAlert(
      title: title,
      message: message,
      icon: Icon(Icons.help_outline, color: appLightGreen, size: 48),
      positiveButton: confirmLabel ?? strings.label_confirm,
      onPositiveTap: onConfirm,
      negativeButton: cancelLabel ?? strings.label_cancel,
      onNegativeTap: () {},
    );
  }

  const WPAlert({
    required this.title,
    required this.message,
    required this.negativeButton,
    required this.onPositiveTap,
    required this.positiveButton,
    this.onNegativeTap,
    this.icon,
    super.key,
  });

  final Icon? icon;
  final String title;
  final String message;
  final String positiveButton;
  final String negativeButton;
  final VoidCallback onPositiveTap;
  final VoidCallback? onNegativeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton.filled(
                onPressed: () => context.router.pop(),
                icon: Icon(Icons.close_outlined, size: 18),
                color: appBlack,
                style: IconButton.styleFrom(
                  backgroundColor: appGrey,
                  fixedSize: const Size(24, 24),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          if (icon != null) ...[icon!, const SizedBox(height: 16)],
          WPText.bold(title, textAlign: TextAlign.center, fontSize: 20),
          const SizedBox(height: 12),
          WPText.regular(message, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          WPButton.primary(
            positiveButton,
            onTap: () {
              Navigator.of(context).pop();
              onPositiveTap();
            },
          ),
          const SizedBox(height: 8),
          WPButton.secondary(
            negativeButton,
            onTap: () {
              Navigator.pop(context);
              onNegativeTap?.call();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
