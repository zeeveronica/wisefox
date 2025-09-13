// signup_event.dart
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabChanged extends SignupEvent {
  final int tabIndex;
  TabChanged(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class FormFieldChanged extends SignupEvent {
  final String fieldName;
  final dynamic value;
  FormFieldChanged(this.fieldName, this.value);

  @override
  List<Object?> get props => [fieldName, value];
}

class ImageSelected extends SignupEvent {
  final String imagePath;
  ImageSelected(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class SubmitForm extends SignupEvent {}

class ResetForm extends SignupEvent {}