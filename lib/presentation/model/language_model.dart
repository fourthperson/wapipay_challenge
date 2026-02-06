import 'package:equatable/equatable.dart';

class LanguageItem extends Equatable {
  final String title;
  final String code;
  final String flag;

  const LanguageItem({
    required this.code,
    required this.flag,
    required this.title,
  });

  @override
  List<Object?> get props => [title, code, flag];
}
