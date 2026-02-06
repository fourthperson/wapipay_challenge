import 'package:equatable/equatable.dart';

class WelcomeItem extends Equatable {
  final String title;
  final String subtitle;

  const WelcomeItem({required this.title, required this.subtitle});

  @override
  List<Object?> get props => [title, subtitle];
}
