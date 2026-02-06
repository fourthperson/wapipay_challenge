part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginStatus status;
  final Country selectedCountry;
  final String phoneNumber;
  final bool isPhoneValid;
  final String? errorMessage;
  final AuthResult? authResult;

  const LoginState({
    required this.selectedCountry,
    this.status = LoginStatus.initial,
    this.phoneNumber = '',
    this.isPhoneValid = false,
    this.errorMessage,
    this.authResult,
  });

  LoginState copyWith({
    LoginStatus? status,
    Country? selectedCountry,
    String? phoneNumber,
    bool? isPhoneValid,
    String? errorMessage,
    AuthResult? authResult,
  }) {
    return LoginState(
      status: status ?? this.status,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      errorMessage: errorMessage ?? this.errorMessage,
      authResult: authResult ?? this.authResult,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedCountry,
    phoneNumber,
    isPhoneValid,
    errorMessage,
    authResult,
  ];
}
