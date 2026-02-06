import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/user.dart';
import 'package:wapipay_challenge/domain/use_case/user_clear_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/user_get_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserGetUseCase _userGetUseCase;
  final UserClearUseCase _userClearUseCase;

  HomeBloc({
    required UserGetUseCase userGetUseCase,
    required UserClearUseCase userClearUseCase,
  }) : _userGetUseCase = userGetUseCase,
       _userClearUseCase = userClearUseCase,
       super(const HomeState()) {
    on<HomeStartedEvent>(_onHomeStarted);
    on<HomeLogoutEvent>(_onLogoutRequested);
  }

  Future<void> _onHomeStarted(
    HomeStartedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final User? user = await _userGetUseCase.invoke();
      if (user != null) {
        emit(state.copyWith(status: HomeStatus.success, user: user));
      } else {
        emit(state.copyWith(status: HomeStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onLogoutRequested(
    HomeLogoutEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _userClearUseCase.invoke();
    emit(state.copyWith(status: HomeStatus.unauthenticated));
  }
}
