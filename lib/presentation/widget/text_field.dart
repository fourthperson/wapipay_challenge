import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WPTextField extends StatelessWidget {
  const WPTextField({
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hint,
    this.obscureCharacter,
    this.digitsOnly = false,
    this.isLastInputInForm = false,
    this.centerText = false,
    this.enabled = true,
    this.obscureText = false,
    this.multiline = false,
    this.errored = false,
    this.borderRadius = 12,
    this.textInputType = TextInputType.text,
    this.onTextChanged,
    super.key,
  });

  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final bool digitsOnly;
  final bool isLastInputInForm;
  final bool centerText;
  final bool enabled;
  final bool obscureText;
  final bool multiline;
  final bool errored;
  final double borderRadius;
  final String? obscureCharacter;
  final TextInputType textInputType;
  final void Function(String s)? onTextChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      obscureText: obscureText,
      maxLines: multiline ? null : 1,
      obscuringCharacter: obscureCharacter ?? '*',
      cursorColor: appLightGreen,
      onChanged: onTextChanged,
      style: WPText.textStyleMedium.copyWith(
        color: errored ? appErrorRed : appBlack,
      ),
      textInputAction: isLastInputInForm
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: textInputType,
      inputFormatters: digitsOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        prefixIconConstraints: const BoxConstraints(),
        prefixIcon: prefixIcon != null
            ? Container(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [prefixIcon!],
                ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 1.25,
        ),
        suffixIcon: suffixIcon,
        fillColor: errored
            ? appErrorRed.withValues(alpha: 0.5)
            : appInputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: errored ? appErrorRed.withValues(alpha: 0.5) : appBlack,
          ),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 2, color: appErrorRed),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 2, color: appErrorRed),
          gapPadding: 0,
        ),
        hintText: hint,
        hintStyle: hint == null
            ? null
            : WPText.textStyleRegular.copyWith(
                color: Colors.grey,
                fontSize: 14,
              ),
      ),
    );
  }
}

class WPPinField extends StatelessWidget {
  const WPPinField({
    required this.controller,
    required this.length,
    this.onCompleted,
    this.onChanged,
    this.forceErrorState = false,
    this.obscureText = false,
    super.key,
  });

  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool forceErrorState;
  final bool obscureText;

  static final PinTheme pinTheme = PinTheme(
    height: 48,
    width: 42,
    textStyle: WPText.textStyleBold.copyWith(color: appBlack, fontSize: 16),
  );

  static final BoxDecoration decoration = BoxDecoration(
    border: Border.all(color: appInputBackground, width: 2.0),
    borderRadius: BorderRadius.circular(12),
    color: appInputBackground,
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: length,
      controller: controller,
      obscureText: obscureText,
      forceErrorState: forceErrorState,
      onCompleted: onCompleted,
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      animationCurve: Curves.linear,

      cursor: Container(
        color: forceErrorState ? appErrorRed : appLightGreen,
        width: 1.5,
        height: 18,
      ),

      obscuringWidget: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          color: forceErrorState ? appErrorRed : appBlack,
          shape: BoxShape.circle,
        ),
      ),

      defaultPinTheme: pinTheme.copyWith(
        decoration: decoration.copyWith(
          border: Border.all(color: appInputBackground),
        ),
      ),
      focusedPinTheme: pinTheme.copyWith(
        decoration: decoration.copyWith(border: Border.all(color: appBlack)),
      ),
      errorPinTheme: pinTheme.copyWith(
        decoration: decoration.copyWith(
          border: Border.all(color: appInputErrorBackground),
          color: appInputErrorBackground,
        ),
      ),
      errorTextStyle: WPText.textStyleBold.copyWith(
        color: appErrorRed,
        fontSize: 16,
      ),
    );
  }
}
