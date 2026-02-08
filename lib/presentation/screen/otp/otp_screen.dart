import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/otp/bloc/otp_bloc.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/util/functions.dart';
import 'package:wapipay_challenge/presentation/widget/alert_dialog.dart';
import 'package:wapipay_challenge/presentation/widget/app_bar.dart';
import 'package:wapipay_challenge/presentation/widget/loader.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';
import 'package:wapipay_challenge/presentation/widget/text_field.dart';

@RoutePage()
class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.phone, super.key});

  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> confirm() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return BlocListener<OtpBloc, OtpState>(
      listener: (BuildContext context, OtpState state) {
        if (state.status == OtpStatus.failure) {
          otpController.clear();
          alertDialog(
            context,
            WPAlert.error(
              context: context,
              title: strings.title_an_error_occurred,
              message: strings.an_error_cooured_rationale,
              onRetry: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<OtpBloc>().add(
                  OtpVerifySubmittedEvent(
                    phone: widget.phone,
                    otp: otpController.text.trim(),
                  ),
                );
              },
            ),
          );
        }

        if (state.status == OtpStatus.success &&
            state.otpResult is SuccessfulOtpResult) {
          context.router.replace(const PinRoute());
        }
      },
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (BuildContext context, OtpState state) {
          final bool incorrect = state.otpResult is IncorrectOtpResult;

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
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    WPPinField(
                                      length: 6,
                                      controller: otpController,
                                      forceErrorState: incorrect,
                                      onChanged: (s) {
                                        if (incorrect) {
                                          context.read<OtpBloc>().add(
                                            const OtpInputChangedEvent(),
                                          );
                                        }
                                      },
                                      onCompleted: (pin) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        context.read<OtpBloc>().add(
                                          OtpVerifySubmittedEvent(
                                            phone: widget.phone,
                                            otp: pin,
                                          ),
                                        );
                                      },
                                    ),
                                    if (incorrect) ...[
                                      const SizedBox(height: 8),
                                      WPText.medium(
                                        strings.validation_invalid_otp,
                                        color: appErrorRed,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),
                            state.status == OtpStatus.loading
                                ? WPLoader(
                                    size: 24,
                                    thickness: 3,
                                    color: appBlack,
                                  )
                                : state.canResend
                                ? GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => context.read<OtpBloc>().add(
                                      OtpResendRequestedEvent(
                                        phone: widget.phone,
                                      ),
                                    ),
                                    child: WPText.link(
                                      strings.resend_otp,
                                      textAlign: TextAlign.center,
                                      color: appBlack,
                                    ),
                                  )
                                : WPText.bold(
                                    strings.resend_otp_timer(
                                      state.remainingTime,
                                    ),
                                    textAlign: TextAlign.center,
                                    color: appBlack.withValues(alpha: 0.5),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
