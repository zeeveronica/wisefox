import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selectcountry_event.dart';
part 'selectcountry_state.dart';

class SelectcountryBloc extends Bloc<SelectcountryEvent, SelectcountryState> {
  SelectcountryBloc() : super(SelectcountryInitial()) {
    on<SelectcountryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
