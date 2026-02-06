import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/model/welcome_item.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WelcomePagerItem extends StatelessWidget {
  final WelcomeItem item;

  const WelcomePagerItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WPText.bold(item.title, fontSize: 36, textAlign: TextAlign.center),
        SizedBox(height: 8),
        WPText.regular(
          item.subtitle,
          fontSize: 16,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
