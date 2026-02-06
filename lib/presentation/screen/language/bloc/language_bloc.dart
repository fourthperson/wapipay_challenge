import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('en'))) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(LanguageState(event.locale));
    });
  }
}
