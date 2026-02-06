part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, unauthenticated, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final User? user;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.user,
    this.errorMessage,
  });

  HomeState copyWith({HomeStatus? status, User? user, String? errorMessage}) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
