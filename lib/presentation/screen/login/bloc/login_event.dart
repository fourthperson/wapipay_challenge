part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class CountryChangedEvent extends LoginEvent {
  final Country country;

  const CountryChangedEvent(this.country);

  @override
  List<Object?> get props => [country];
}

class PhoneChangedEvent extends LoginEvent {
  final String phone;

  const PhoneChangedEvent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class ConfirmLoginEvent extends LoginEvent {
  const ConfirmLoginEvent();
}
