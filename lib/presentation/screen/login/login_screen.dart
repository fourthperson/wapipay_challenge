import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/use_case/country_get_use_case.dart';
import 'package:wapipay_challenge/main.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/country/bloc/country_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/country/country_list.dart';
import 'package:wapipay_challenge/presentation/screen/login/bloc/login_bloc.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/util/config.dart';
import 'package:wapipay_challenge/presentation/util/functions.dart';
import 'package:wapipay_challenge/presentation/widget/alert_dialog.dart';
import 'package:wapipay_challenge/presentation/widget/app_bar.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/loader.dart';
import 'package:wapipay_challenge/presentation/widget/selector.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';
import 'package:wapipay_challenge/presentation/widget/text_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController phoneController;
  late AnimationController shakeController;

  bool termsAccepted = false;
  bool privacyAccepted = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    if (shakeController.isAnimating || shakeController.value != 0) {
      shakeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          alertDialog(
            context,
            WPAlert.error(
              context: context,
              title: strings.title_an_error_occurred,
              message: strings.an_error_cooured_rationale,
              onRetry: () =>
                  context.read<LoginBloc>().add(const ConfirmLoginEvent()),
            ),
          );
        }

        if (state.status == LoginStatus.success && state.authResult != null) {
          final AuthResult? result = state.authResult;
          if (result is SuccessLoginResult) {
            context.router.push(OtpRoute(phone: state.phoneNumber));
          } else if (result is UnregisteredLoginResult) {
            alertDialog(
              context,
              WPAlert.error(
                context: context,
                title: strings.error_phone_number_not_registered,
                message: strings.phone_number_unregistered_rationale,
                onRetry: () =>
                    context.read<LoginBloc>().add(const ConfirmLoginEvent()),
              ),
            );
          }
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, LoginState state) {
          final bool isFormValid =
              state.isPhoneValid && termsAccepted && privacyAccepted;

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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  WPText.bold(
                                    strings.welcome_back,
                                    fontSize: 34,
                                  ),
                                  WPText.regular(
                                    strings.enter_phone_number_rationale,
                                    color: appBlack.withValues(alpha: 0.75),
                                    fontSize: 18,
                                  ),
                                  const SizedBox(height: 24),
                                  WPSelector(
                                    hint: strings.label_select_country,
                                    activeValue: state.selectedCountry.name,
                                    onTap: () => _countryPicker(context),
                                  ),
                                  const SizedBox(height: 16),
                                  WPTextField(
                                    controller: phoneController,
                                    isLastInputInForm: true,
                                    errored:
                                        state.showError && !state.isPhoneValid,
                                    textInputType: TextInputType.phone,
                                    hint: strings.label_phone_number,
                                    onTextChanged: (String p) => context
                                        .read<LoginBloc>()
                                        .add(PhoneChangedEvent(p)),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 8,
                                      ),
                                      child: WPText.medium(
                                        state.selectedCountry.code,
                                        color:
                                            state.showError &&
                                                !state.isPhoneValid
                                            ? appErrorRed
                                            : appBlack,
                                      ),
                                    ),
                                  ),
                                  if (state.showError && !state.isPhoneValid)
                                    WPText.medium(
                                      strings.validation_invalid_phone,
                                      color: appErrorRed,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        _buildFooter(context, state, isFormValid, strings),
                      ],
                    ),
                  ),
                ),
                if (state.status == LoginStatus.loading)
                  const WPLoaderOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _countryPicker(BuildContext context) {
    bottomSheet(
      context,
      BlocProvider(
        create: (_) =>
            CountryBloc(countryGetUseCase: locator<CountryGetUseCase>()),
        child: CountryList(
          onCountrySelected: (c) =>
              context.read<LoginBloc>().add(CountryChangedEvent(c)),
          selected: context.read<LoginBloc>().state.selectedCountry,
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    LoginState state,
    bool isFormValid,
    S strings,
  ) {
    final bool hasMinimumLength = state.phoneNumber.length >= 8;
    final bool showCheckboxes = state.isPhoneValid && !state.showError;

    return Column(
      children: [
        if (showCheckboxes) ...[
          ShakeX(
            manualTrigger: true,
            controller: (AnimationController c) => shakeController = c,
            child: Column(
              children: [
                _checkBox(
                  label: strings.i_accept_the,
                  link: strings.terms_of_service,
                  value: termsAccepted,
                  onChanged: (v) => setState(() => termsAccepted = v!),
                  onLinkTap: () => launchUrl(Config.termsOfServiceUrl),
                ),
                _checkBox(
                  label: strings.i_accept_the,
                  link: strings.privacy_policy,
                  value: privacyAccepted,
                  onChanged: (v) => setState(() => privacyAccepted = v!),
                  onLinkTap: () => launchUrl(Config.privacyPolicyUrl),
                ),
              ],
            ),
          ),
        ],
        Container(
          color: appBlack,
          padding: const EdgeInsets.all(16),
          child: WPButton.primary(
            strings.label_continue,
            isActive: hasMinimumLength || isFormValid,
            onTap: hasMinimumLength || isFormValid
                ? () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _handleContinueTap(context, state, strings, isFormValid);
                  }
                : null,
          ),
        ),
      ],
    );
  }

  void _handleContinueTap(
    BuildContext context,
    LoginState state,
    S strings,
    bool isFormValid,
  ) {
    if (!state.isPhoneValid) {
      // trigger phone validation, will show invalid if it is
      context.read<LoginBloc>().add(const ValidateFormEvent());
    } else if (!isFormValid) {
      // phone valid, terms & privacy not checked
      shakeController.forward(from: 0.0);
    } else {
      // everything is alright
      _showConfirmationDialog(context, state, strings);
    }
  }

  void _showConfirmationDialog(
    BuildContext context,
    LoginState state,
    S strings,
  ) {
    alertDialog(
      context,
      WPAlert(
        title: state.phoneNumber,
        message: strings.number_confirmation_rationale,
        negativeButton: strings.label_go_back,
        onPositiveTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<LoginBloc>().add(const ConfirmLoginEvent());
        },
        positiveButton: strings.label_confirm,
      ),
    );
  }

  Widget _checkBox({
    required String label,
    required String link,
    required bool value,
    required VoidCallback onLinkTap,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: appLightGreen,
          checkColor: appWhite,
          visualDensity: VisualDensity.compact,
          side: BorderSide(color: appGrey, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        GestureDetector(
          onTap: () => onChanged.call(!value),
          child: WPText.medium(label),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onLinkTap(),
          child: WPText.link(link, color: appLightGreen),
        ),
      ],
    );
  }
}
