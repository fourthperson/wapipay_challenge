part of 'country_bloc.dart';

sealed class CountriesState extends Equatable {
  const CountriesState();
}

class CountriesLoadingState extends CountriesState {
  @override
  List<Object?> get props => [];
}

class CountriesLoadedState extends CountriesState {
  final List<Country> allCountries;
  final List<Country> filteredCountries;
  final String query;

  const CountriesLoadedState({
    required this.allCountries,
    required this.filteredCountries,
    this.query = '',
  });

  @override
  List<Object?> get props => [allCountries, filteredCountries, query];
}

class CountriesErrorState extends CountriesState {
  @override
  List<Object?> get props => [];
}
