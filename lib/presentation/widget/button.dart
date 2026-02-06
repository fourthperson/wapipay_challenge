import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

enum WPButtonType { primary, secondary, custom }

class WPButton extends StatelessWidget {
  const WPButton.primary(
    this.text, {
    super.key,
    this.color,
    this.textColor,
    this.onTap,
    this.isActive = true,
  }) : type = WPButtonType.primary;

  const WPButton.secondary(
    this.text, {
    super.key,
    this.color,
    this.textColor,
    this.onTap,
    this.isActive = true,
  }) : type = WPButtonType.secondary;

  final String text;
  final WPButtonType type;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final bool isActive;

  const WPButton({
    required this.text,
    required this.type,
    this.onTap,
    this.color,
    this.textColor,
    this.isActive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSecondary = type == WPButtonType.secondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: BoxBorder.all(
            width: 2,
            color: isSecondary
                ? appBlack
                : isActive
                ? appLightGreen
                : appDarkGreen,
          ),
          color: isSecondary
              ? Colors.transparent
              : isActive
              ? appLightGreen
              : appDarkGreen,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: WPText.regular(
              text,
              color: isSecondary ? appBlack : appWhite,
            ),
          ),
        ),
      ),
    );
  }
}
