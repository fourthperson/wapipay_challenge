import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String code;
  final String iso;
  final String name;
  final String flag;

  const Country({
    required this.iso,
    required this.flag,
    required this.code,
    required this.name,
  });

  @override
  List<Object?> get props => [code, iso, name, flag];
}
