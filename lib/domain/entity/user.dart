import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String phone;
  final String name;
  final String otp;
  final String pin;

  const User({
    required this.id,
    required this.phone,
    required this.name,
    required this.otp,
    required this.pin,
  });

  @override
  List<Object?> get props => [id, phone, name, otp, pin];
}
