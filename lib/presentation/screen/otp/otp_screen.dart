import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/app_bar.dart';
import 'package:wapipay_challenge/presentation/widget/loader.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

@RoutePage()
class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.phone, super.key});

  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool loading = false;
  late TextEditingController otpController;
  Timer? _timer;
  int _remaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void startTimer() {
    _canResend = false;
    _remaining = 60;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remaining == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _remaining--;
        });
      }
    });
  }

  Future<void> confirm() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    final PinTheme pinTheme = PinTheme(
      height: 48,
      width: 42,
      textStyle: textStyleBold.copyWith(color: appBlack, fontSize: 16),
    );

    final BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: appInputBackground, width: 2.0),
      borderRadius: BorderRadius.circular(12),
      color: appInputBackground,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: appWhite,
            appBar: WPAppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WPText.bold(strings.enter_otp, fontSize: 34),
                      WPText.regular(
                        strings.enter_otp_rationale(widget.phone),
                        color: appBlack.withValues(alpha: 0.75),
                        fontSize: 18,
                      ),
                      const SizedBox(height: 24),
                      Pinput(
                        length: 6,
                        cursor: Container(
                          color: appLightGreen,
                          width: 1.5,
                          height: 18,
                        ),
                        controller: otpController,
                        textInputAction: TextInputAction.done,
                        animationCurve: Curves.linear,
                        defaultPinTheme: pinTheme.copyWith(
                          decoration: decoration.copyWith(
                            border: Border.all(color: appInputBackground),
                          ),
                        ),
                        focusedPinTheme: pinTheme.copyWith(
                          decoration: decoration.copyWith(
                            border: Border.all(color: appBlack),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      _canResend
                          ? GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                await confirm();
                                startTimer();
                              },
                              child: WPText.link(
                                strings.resend_otp,
                                textAlign: TextAlign.center,
                                color: appBlack,
                              ),
                            )
                          : WPText.bold(
                              strings.resend_otp_timer(_remaining),
                              textAlign: TextAlign.center,
                              color: appBlack.withValues(alpha: 0.5),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (loading) ...[WPLoaderOverlay()],
        ],
      ),
    );
  }
}
