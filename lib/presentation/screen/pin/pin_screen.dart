import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/pin/bloc/pin_bloc.dart';
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
          // Reset the field on wrong PIN so they can try again
          pinController.clear();

          // Show error alert or snackbar
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.errorMessage ?? strings.error_occurred),
          //     backgroundColor: appErrorRed,
          //   ),
          // );
        }

        if (state.status == PinStatus.success) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      child: BlocBuilder<PinBloc, PinState>(
        builder: (BuildContext context, PinState state) {
          final bool isLoading = state.status == PinStatus.loading;

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
                                const SizedBox(height: 36),
                                WPPinField(
                                  length: 4,
                                  controller: pinController,
                                  obscureText: true,
                                  onCompleted: (String pin) => context
                                      .read<PinBloc>()
                                      .add(PinSubmittedEvent(pin)),
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
