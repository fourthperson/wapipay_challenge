import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WPSelector extends StatelessWidget {
  final String hint;
  final String? activeValue;
  final void Function()? onTap;

  const WPSelector({
    required this.hint,
    this.activeValue,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(color: appBlack.withValues(alpha: 0.5)),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: .min,
                  children: [
                    WPText.medium(hint),
                    WPText.bold(activeValue ?? '', fontSize: 16),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: appBlack),
            ],
          ),
        ),
      ),
    );
  }
}
