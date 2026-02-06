import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WPAlert extends StatelessWidget {
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (icon != null) ...[icon!, SizedBox(height: 8)],
          WPText.bold(title, textAlign: TextAlign.center, fontSize: 20),
          SizedBox(height: 8),
          WPText.regular(message, textAlign: TextAlign.center),
          SizedBox(height: 16),
          WPButton.primary(
            positiveButton,
            onTap: () {
              context.router.pop();
              onPositiveTap();
            },
          ),
          SizedBox(height: 8),
          WPButton.secondary(
            negativeButton,
            onTap: () {
              context.router.pop();
              onNegativeTap?.call();
            },
          ),
        ],
      ),
    );
  }
}
