import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class LanguageButton extends StatelessWidget {
  final void Function()? onTap;

  const LanguageButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: appWhite,
          borderRadius: BorderRadius.circular(48),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.translate_outlined, color: appDarkGreen),
              SizedBox(width: 4),
              WPText.medium(strings.label_language_english),
            ],
          ),
        ),
      ),
    );
  }
}
