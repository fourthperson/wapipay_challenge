import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/entity/country.dart';
import 'package:wapipay_challenge/domain/use_case/phone_check_use_case.dart';
import 'package:wapipay_challenge/presentation/util/config.dart';
import 'package:wapipay_challenge/presentation/util/functions.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PhoneCheckUseCase _phoneCheckUseCase;

  LoginBloc({required PhoneCheckUseCase phoneCheckUseCase})
    : _phoneCheckUseCase = phoneCheckUseCase,
      super(LoginState(selectedCountry: Config.defaultCountry)) {
    on<CountryChangedEvent>(_onCountryChanged);
    on<PhoneChangedEvent>(_onPhoneChanged);
    on<ValidateFormEvent>(_onValidateForm);
    on<ConfirmLoginEvent>(_onConfirmLogin);
  }

  void _onCountryChanged(CountryChangedEvent event, Emitter<LoginState> emit) {
    final bool isValid = isPhoneValid(state.phoneNumber, event.country.iso);
    emit(
      state.copyWith(
        selectedCountry: event.country,
        isPhoneValid: isValid,
        status: LoginStatus.initial,
      ),
    );
  }

  void _onPhoneChanged(PhoneChangedEvent event, Emitter<LoginState> emit) {
    final bool isValid = isPhoneValid(event.phone, state.selectedCountry.iso);
    emit(
      state.copyWith(
        phoneNumber: isValid
            ? phoneToE164(event.phone, state.selectedCountry.iso)
            : event.phone,
        isPhoneValid: isValid,
        showError: false,
        status: LoginStatus.initial,
      ),
    );
  }

  void _onValidateForm(ValidateFormEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(showError: true));
  }

  Future<void> _onConfirmLogin(
    ConfirmLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final String formattedPhone = phoneToE164(
      state.phoneNumber,
      state.selectedCountry.iso,
    );

    try {
      final AuthResult result = await _phoneCheckUseCase.invoke(
        phone: formattedPhone,
      );
      if (result is SuccessLoginResult || result is UnregisteredLoginResult) {
        emit(state.copyWith(status: LoginStatus.success, authResult: result));
      } else {
        emit(state.copyWith(status: LoginStatus.failure));
      }
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
