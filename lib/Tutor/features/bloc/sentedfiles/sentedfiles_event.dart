part of 'sentedfiles_bloc.dart';

abstract class DemoRequestEvent extends Equatable {
  const DemoRequestEvent();

  @override
  List<Object?> get props => [];
}

class FetchSentedfiles extends DemoRequestEvent {
  const FetchSentedfiles();

  @override
  List<Object?> get props => [];
}

class DeleteSentedfile extends DemoRequestEvent {
  final int fileId;

  const DeleteSentedfile(this.fileId);

  @override
  List<Object?> get props => [fileId];
}

class Fetchsearch extends DemoRequestEvent {
  //global search
  final String? searchQuery;

  Fetchsearch({this.searchQuery});
}
