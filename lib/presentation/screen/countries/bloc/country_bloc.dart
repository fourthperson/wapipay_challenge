import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/country.dart';
import 'package:wapipay_challenge/domain/use_case/country_get_use_case.dart';

part 'country_state.dart';

part 'country_event.dart';

class CountryBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountryGetUseCase _getUseCase;

  CountryBloc({required CountryGetUseCase countryGetUseCase})
    : _getUseCase = countryGetUseCase,
      super(CountriesLoadingState()) {
    on<LoadCountriesEvent>(_load);
    on<FilterCountriesEvent>(_filter);
  }

  void _load(LoadCountriesEvent event, Emitter<CountriesState> emit) async {
    emit(CountriesLoadingState());

    final List<Country>? countries = await _getUseCase.invoke();

    emit(
      countries == null
          ? CountriesErrorState()
          : CountriesLoadedState(
              allCountries: countries,
              filteredCountries: countries,
            ),
    );
  }

  void _filter(FilterCountriesEvent event, Emitter<CountriesState> emit) {
    if (state is! CountriesLoadedState) return;

    final CountriesLoadedState currentState = state as CountriesLoadedState;
    final String query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      emit(
        CountriesLoadedState(
          allCountries: currentState.allCountries,
          filteredCountries: currentState.allCountries,
        ),
      );
    } else {
      final List<Country> filtered = currentState.allCountries
          .where((Country c) {
            return c.name.toLowerCase().contains(query) ||
                c.code.toLowerCase().contains(query) ||
                c.iso.toLowerCase().contains(query);
          })
          .toList(growable: false);

      emit(
        CountriesLoadedState(
          allCountries: currentState.allCountries,
          filteredCountries: filtered,
          query: event.query,
        ),
      );
    }
  }
}
