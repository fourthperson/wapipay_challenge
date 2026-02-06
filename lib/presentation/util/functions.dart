import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';

void bottomSheet(BuildContext context, Widget content) {
  content = Material(child: content);
  if (Platform.isIOS) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => content,
    );
  } else {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => content,
    );
  }
}

void alertDialog(BuildContext context, Widget content) {
  Alert(
    context: context,
    type: AlertType.none,
    content: content,
    closeIcon: Icon(Icons.close_outlined, color: appBlack),
    style: AlertStyle(
      isButtonVisible: false,
      isOverlayTapDismiss: false,
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 250),
      buttonAreaPadding: const EdgeInsets.all(0.0),
    ),
  ).show();
}

bool isPhoneValid(String phone, String iso) {
  if (phone.isEmpty) return false;
  try {
    final PhoneNumber p = PhoneNumber.parse(
      phone,
      callerCountry: IsoCode.fromJson(iso),
    );
    return p.isValid(type: PhoneNumberType.mobile);
  } catch (e) {
    return false;
  }
}

String phoneToE164(String phone, String iso) {
  try {
    final PhoneNumber p = PhoneNumber.parse(
      phone,
      callerCountry: IsoCode.fromJson(iso),
    );
    return p.international;
  } catch (e) {
    return phone;
  }
}
