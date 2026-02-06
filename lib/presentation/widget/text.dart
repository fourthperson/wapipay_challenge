import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';

final TextStyle textStyleLight = TextStyle(
  fontFamily: 'Halenoir',
  fontWeight: FontWeight.w300,
);
final TextStyle textStyleRegular = TextStyle(
  fontFamily: 'Halenoir',
  fontWeight: FontWeight.w400,
);
final TextStyle textStyleMedium = TextStyle(
  fontFamily: 'Halenoir',
  fontWeight: FontWeight.w500,
);
final TextStyle textStyleBold = TextStyle(
  fontFamily: 'Halenoir',
  fontWeight: FontWeight.bold,
);
final TextStyle textStyleBlack = TextStyle(
  fontFamily: 'Halenoir',
  fontWeight: FontWeight.w900,
);

enum WPTextType { normal, url }

class WPText extends StatelessWidget {
  WPText.light(
    this.text, {
    this.color,
    this.fontSize,
    super.key,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : style = textStyleLight,
       type = WPTextType.normal;

  WPText.regular(
    this.text, {
    this.color,
    this.fontSize,
    super.key,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : style = textStyleRegular,
       type = WPTextType.normal;

  WPText.medium(
    this.text, {
    this.color,
    this.fontSize,
    super.key,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : style = textStyleMedium,
       type = WPTextType.normal;

  WPText.bold(
    this.text, {
    this.color,
    this.fontSize,
    super.key,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : style = textStyleBold,
       type = WPTextType.normal;

  WPText.link(
    this.text, {
    this.color,
    this.fontSize,
    super.key,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : style = textStyleBold,
       type = WPTextType.url;

  const WPText(
    this.text, {
    required this.style,
    this.color,
    this.fontSize,
    super.key,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.type = WPTextType.normal,
  });

  final String text;
  final TextStyle style;
  final WPTextType type;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final bool isLink = type == WPTextType.url;

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: style.copyWith(
        fontSize: fontSize ?? style.fontSize ?? 14,
        decoration: isLink ? TextDecoration.underline : null,
        color: isLink ? color ?? appLinkGreen : color,
      ),
    );
  }
}
