import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/app_bar.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/keyboard.dart';
import 'package:wapipay_challenge/presentation/widget/loader.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';
import 'package:wapipay_challenge/presentation/widget/text_field.dart';

@RoutePage()
class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  late TextEditingController pinController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: appWhite,
            appBar: WPAppBar(),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          WPText.bold(
                            strings.label_enter_pin,
                            fontSize: 34,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 36),
                          Pinput(
                            controller: pinController,
                            obscureText: true,
                            cursor: Container(
                              color: appLightGreen,
                              width: 1.5,
                              height: 18,
                            ),
                            obscuringWidget: Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                color: appBlack,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            animationCurve: Curves.linear,
                            defaultPinTheme: WPDashedField.pinTheme.copyWith(
                              decoration: WPDashedField.decoration.copyWith(
                                border: Border.all(color: appInputBackground),
                              ),
                            ),
                            focusedPinTheme: WPDashedField.pinTheme.copyWith(
                              decoration: WPDashedField.decoration.copyWith(
                                border: Border.all(color: appBlack),
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                          WPKeyboard(
                            delete: () {
                              if (pinController.text.isNotEmpty) {
                                pinController.text = pinController.text
                                    .substring(
                                      0,
                                      pinController.text.length - 1,
                                    );
                                pinController.selection =
                                    TextSelection.fromPosition(
                                      TextPosition(
                                        offset: pinController.text.length,
                                      ),
                                    );
                              }
                            },
                            controller: pinController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: appBlack,
                    padding: EdgeInsets.all(16),
                    child: WPButton(
                      text: 'Forgot your PIN?',
                      type: WPButtonType.custom,
                      color: appWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (loading) ...[WPLoaderOverlay()],
        ],
      ),
    );
  }
}
