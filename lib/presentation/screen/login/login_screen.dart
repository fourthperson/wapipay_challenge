import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/use_case/country_get_use_case.dart';
import 'package:wapipay_challenge/main.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/countries/bloc/country_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/countries/country_list.dart';
import 'package:wapipay_challenge/presentation/screen/login/bloc/login_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/login/bloc/login_status.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
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

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;

  bool termsAccepted = false;
  bool privacyAccepted = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          _showErrorDialog(context, strings, true);
        }

        if (state.status == LoginStatus.success && state.authResult != null) {
          final AuthResult? result = state.authResult;
          if (result is SuccessLoginResult) {
            context.router.push(OtpRoute(phone: state.phoneNumber));
          } else if (result is UnregisteredLoginResult) {
            _showErrorDialog(context, strings, false);
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
                                    textInputType: TextInputType.phone,
                                    hint: strings.label_phone_number,
                                    onTextChanged: (p) => context
                                        .read<LoginBloc>()
                                        .add(PhoneChangedEvent(p)),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 8,
                                      ),
                                      child: WPText.medium(
                                        state.selectedCountry.code,
                                      ),
                                    ),
                                  ),
                                  if (phoneController.text.isNotEmpty &&
                                      !state.isPhoneValid)
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
    return Column(
      children: [
        if (state.isPhoneValid) ...[
          _buildCheckbox(
            label: strings.i_accept_the,
            link: strings.terms_of_service,
            value: termsAccepted,
            onChanged: (v) => setState(() => termsAccepted = v!),
          ),
          _buildCheckbox(
            label: strings.i_accept_the,
            link: strings.privacy_policy,
            value: privacyAccepted,
            onChanged: (v) => setState(() => privacyAccepted = v!),
          ),
        ],
        Container(
          color: appBlack,
          padding: const EdgeInsets.all(16),
          child: WPButton.primary(
            strings.label_continue,
            isActive: isFormValid,
            onTap: isFormValid
                ? () => _showConfirmationDialog(context, state, strings)
                : null,
          ),
        ),
      ],
    );
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

  // todo create factories for different WPAlert Types
  void _showErrorDialog(BuildContext context, S strings, bool isError) {
    alertDialog(
      context,
      WPAlert(
        title: isError ? 'An error occurred' : 'Phone Number Not Registered',
        message: isError
            ? "That didn't go as planned. It's on us - please try again in a moment"
            : 'This number does not have an account with us. Please proceed to registration',
        negativeButton: isError ? strings.label_cancel : 'Try another number',
        onPositiveTap: () {
          context.read<LoginBloc>().add(const ConfirmLoginEvent());
        },
        positiveButton: isError
            ? strings.label_try_again
            : strings.label_register,
        icon: Icon(isError ? Icons.info_outline : Icons.error_outline_outlined),
      ),
    );
  }

  Widget _buildCheckbox({
    required String label,
    required String link,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: appLightGreen,
          checkColor: appWhite,
          side: BorderSide(color: appGrey, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        WPText.medium(label),
        WPText.link(link, color: appLightGreen),
      ],
    );
  }
}
