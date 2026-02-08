import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void bottomSheet(BuildContext context, Widget content) {
  content = SafeArea(child: content);
  const RoundedRectangleBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
  );
  if (Platform.isIOS) {
    showCupertinoModalBottomSheet(
      context: context,
      shape: shape,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black87,
      builder: (_) => content,
    );
  } else {
    showMaterialModalBottomSheet(
      context: context,
      shape: shape,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black87,
      builder: (_) => content,
    );
  }
}

void alertDialog(BuildContext context, Widget content) {
  const RoundedRectangleBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  );
  Alert(
    context: context,
    type: AlertType.none,
    content: content,
    style: AlertStyle(
      isButtonVisible: false,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      overlayColor: Colors.black.withValues(alpha: 0.925),
      animationType: AnimationType.fromTop,
      alertBorder: shape,
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

void launchUrl(String url) async {
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url, mode: LaunchMode.inAppBrowserView);
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint(e.toString());
    }
  }
}
