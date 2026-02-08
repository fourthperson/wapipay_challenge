import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/pin/bloc/pin_bloc.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/util/functions.dart';
import 'package:wapipay_challenge/presentation/widget/alert_dialog.dart';
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

    return BlocListener<PinBloc, PinState>(
      listener: (BuildContext context, PinState state) {
        if (state.status == PinStatus.failure) {
          pinController.clear();
          alertDialog(
            context,
            WPAlert.error(
              context: context,
              title: strings.title_an_error_occurred,
              message: strings.an_error_cooured_rationale,
              onRetry: () => context.read<PinBloc>().add(
                PinSubmittedEvent(pinController.text.trim()),
              ),
            ),
          );
        }

        if (state.status == PinStatus.temporarilyLocked) {
          pinController.clear();
          alertDialog(
            context,
            WPAlert.error(
              context: context,
              title: strings.title_temporarily_locked,
              message: strings.too_many_failed_pin_attempts,
              positiveButtonLabel: strings.label_back_to_login,
              negativeButtonLabel: strings.label_contact_support,
              onRetry: () => context.router.replaceAll([
                const WelcomeRoute(),
                const LoginRoute(),
              ]),
            ),
          );
        }

        if (state.status == PinStatus.success) {
          context.router.replaceAll([const HomeRoute()]);
        } else if (state.status == PinStatus.incorrect) {
          pinController.clear();
        }
      },
      child: BlocBuilder<PinBloc, PinState>(
        builder: (BuildContext context, PinState state) {
          final bool isLoading = state.status == PinStatus.loading;
          final bool incorrect = state.status == PinStatus.incorrect;
          final bool isLocked = state.status == PinStatus.temporarilyLocked;

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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                WPText.bold(
                                  strings.label_enter_pin,
                                  fontSize: 34,
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                WPPinField(
                                  length: 4,
                                  controller: pinController,
                                  obscureText: true,
                                  forceErrorState: incorrect,
                                  onCompleted: (String pin) => context
                                      .read<PinBloc>()
                                      .add(PinSubmittedEvent(pin)),
                                ),
                                if (incorrect || isLocked) ...[
                                  SizedBox(height: 8),
                                  WPText.medium(
                                    isLocked
                                        ? strings.too_many_failed_pin_attempts
                                        : strings.incorrect_pin_attempt(
                                            3 - state.attempts,
                                          ),
                                    color: appErrorRed,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                const Spacer(),
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
                        SizedBox(height: 16),
                        Container(
                          color: appBlack,
                          padding: const EdgeInsets.all(16),
                          child: WPButton(
                            text: strings.label_forgot_pin,
                            type: WPButtonType.custom,
                            color: appWhite,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLoading) const WPLoaderOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}
