part of 'selectcountry_bloc.dart';

abstract class SelectcountryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCountryList extends SelectcountryEvent {}

class SelectCountry extends SelectcountryEvent {
  final String country;

  SelectCountry(this.country);

  @override
  List<Object?> get props => [country];
}
