part of 'country_bloc.dart';

sealed class CountriesEvent extends Equatable {}

class LoadCountriesEvent extends CountriesEvent {
  @override
  List<Object?> get props => [];
}

class FilterCountriesEvent extends CountriesEvent {
  final String query;

  FilterCountriesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
