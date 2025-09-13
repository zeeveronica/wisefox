import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/country_model.dart';
import 'package:wisefox/client/features/repos/country_repos.dart';
import 'package:equatable/equatable.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;

  CountryBloc(this.countryRepository) : super(CountryInitial()) {
    on<FetchCountryList>((event, emit) async {
      emit(CountryLoading());
      try {
        final countries = await countryRepository
            .fetchCountryList(); // Fetch country list from the repository
        emit(CountryLoaded(countries));
      } catch (error) {
        emit(CountryError(error.toString()));
      }
    });
  }

  // Direct method to fetch the country list
  Future<List<CountryModel>> fetchCountryListDirectly() async {
    try {
      final countries = await countryRepository.fetchCountryList();
      return countries;
    } catch (error) {
      throw Exception("Failed to fetch country list: $error");
    }
  }
}
