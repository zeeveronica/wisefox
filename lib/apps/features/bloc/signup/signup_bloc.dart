// signup_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// Include the events and states from the previous file
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

// signup_state.dart
enum SignupStatus { initial, loading, success, error }

class SignupState extends Equatable {
  final int currentTab;
  final SignupStatus status;
  final String? errorMessage;
  final String? successMessage;

  // Common fields
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String status_;
  final String relationshipToStudent;
  final String source;
  final String affiliate;
  final String country;
  final String postCode;
  final String addressLine;
  final String townOrCity;
  final String state;
  final String secondContactName;
  final String secondContactRelationship;
  final String secondContactPhone;
  final String paymentMethod;
  final String paymentGateway;
  final String? clientPhotoPath;

  // Tutor specific fields
  final String? subject;
  final String? experience;
  final String? qualification;
  final String? hourlyRate;
  final String? availability;

  // Affiliate specific fields
  final String? companyName;
  final String? businessType;
  final String? website;
  final String? referralCode;

  const SignupState({
    this.currentTab = 0,
    this.status = SignupStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.email = '',
    this.phoneNumber = '',
    this.status_ = '',
    this.relationshipToStudent = '',
    this.source = '',
    this.affiliate = '',
    this.country = '',
    this.postCode = '',
    this.addressLine = '',
    this.townOrCity = '',
    this.state = '',
    this.secondContactName = '',
    this.secondContactRelationship = '',
    this.secondContactPhone = '',
    this.paymentMethod = '',
    this.paymentGateway = '',
    this.clientPhotoPath,
    this.subject,
    this.experience,
    this.qualification,
    this.hourlyRate,
    this.availability,
    this.companyName,
    this.businessType,
    this.website,
    this.referralCode,
  });

  SignupState copyWith({
    int? currentTab,
    SignupStatus? status,
    String? errorMessage,
    String? successMessage,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? phoneNumber,
    String? status_,
    String? relationshipToStudent,
    String? source,
    String? affiliate,
    String? country,
    String? postCode,
    String? addressLine,
    String? townOrCity,
    String? state,
    String? secondContactName,
    String? secondContactRelationship,
    String? secondContactPhone,
    String? paymentMethod,
    String? paymentGateway,
    String? clientPhotoPath,
    String? subject,
    String? experience,
    String? qualification,
    String? hourlyRate,
    String? availability,
    String? companyName,
    String? businessType,
    String? website,
    String? referralCode,
  }) {
    return SignupState(
      currentTab: currentTab ?? this.currentTab,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status_: status_ ?? this.status_,
      relationshipToStudent: relationshipToStudent ?? this.relationshipToStudent,
      source: source ?? this.source,
      affiliate: affiliate ?? this.affiliate,
      country: country ?? this.country,
      postCode: postCode ?? this.postCode,
      addressLine: addressLine ?? this.addressLine,
      townOrCity: townOrCity ?? this.townOrCity,
      state: state ?? this.state,
      secondContactName: secondContactName ?? this.secondContactName,
      secondContactRelationship: secondContactRelationship ?? this.secondContactRelationship,
      secondContactPhone: secondContactPhone ?? this.secondContactPhone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentGateway: paymentGateway ?? this.paymentGateway,
      clientPhotoPath: clientPhotoPath ?? this.clientPhotoPath,
      subject: subject ?? this.subject,
      experience: experience ?? this.experience,
      qualification: qualification ?? this.qualification,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      availability: availability ?? this.availability,
      companyName: companyName ?? this.companyName,
      businessType: businessType ?? this.businessType,
      website: website ?? this.website,
      referralCode: referralCode ?? this.referralCode,
    );
  }

  @override
  List<Object?> get props => [
    currentTab,
    status,
    errorMessage,
    successMessage,
    firstName,
    lastName,
    userName,
    email,
    phoneNumber,
    status_,
    relationshipToStudent,
    source,
    affiliate,
    country,
    postCode,
    addressLine,
    townOrCity,
    state,
    secondContactName,
    secondContactRelationship,
    secondContactPhone,
    paymentMethod,
    paymentGateway,
    clientPhotoPath,
    subject,
    experience,
    qualification,
    hourlyRate,
    availability,
    companyName,
    businessType,
    website,
    referralCode,
  ];
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final ImagePicker _imagePicker = ImagePicker();

  SignupBloc() : super(const SignupState()) {
    on<TabChanged>(_onTabChanged);
    on<FormFieldChanged>(_onFormFieldChanged);
    on<ImageSelected>(_onImageSelected);
    on<SubmitForm>(_onSubmitForm);
    on<ResetForm>(_onResetForm);
  }

  void _onTabChanged(TabChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(currentTab: event.tabIndex));
  }

  void _onFormFieldChanged(FormFieldChanged event, Emitter<SignupState> emit) {
    switch (event.fieldName) {
      case 'firstName':
        emit(state.copyWith(firstName: event.value));
        break;
      case 'lastName':
        emit(state.copyWith(lastName: event.value));
        break;
      case 'userName':
        emit(state.copyWith(userName: event.value));
        break;
      case 'email':
        emit(state.copyWith(email: event.value));
        break;
      case 'phoneNumber':
        emit(state.copyWith(phoneNumber: event.value));
        break;
      case 'status':
        emit(state.copyWith(status_: event.value));
        break;
      case 'relationshipToStudent':
        emit(state.copyWith(relationshipToStudent: event.value));
        break;
      case 'source':
        emit(state.copyWith(source: event.value));
        break;
      case 'affiliate':
        emit(state.copyWith(affiliate: event.value));
        break;
      case 'country':
        emit(state.copyWith(country: event.value));
        break;
      case 'postCode':
        emit(state.copyWith(postCode: event.value));
        break;
      case 'addressLine':
        emit(state.copyWith(addressLine: event.value));
        break;
      case 'townOrCity':
        emit(state.copyWith(townOrCity: event.value));
        break;
      case 'state':
        emit(state.copyWith(state: event.value));
        break;
      case 'secondContactName':
        emit(state.copyWith(secondContactName: event.value));
        break;
      case 'secondContactRelationship':
        emit(state.copyWith(secondContactRelationship: event.value));
        break;
      case 'secondContactPhone':
        emit(state.copyWith(secondContactPhone: event.value));
        break;
      case 'paymentMethod':
        emit(state.copyWith(paymentMethod: event.value));
        break;
      case 'paymentGateway':
        emit(state.copyWith(paymentGateway: event.value));
        break;
    // Tutor fields
      case 'subject':
        emit(state.copyWith(subject: event.value));
        break;
      case 'experience':
        emit(state.copyWith(experience: event.value));
        break;
      case 'qualification':
        emit(state.copyWith(qualification: event.value));
        break;
      case 'hourlyRate':
        emit(state.copyWith(hourlyRate: event.value));
        break;
      case 'availability':
        emit(state.copyWith(availability: event.value));
        break;
    // Affiliate fields
      case 'companyName':
        emit(state.copyWith(companyName: event.value));
        break;
      case 'businessType':
        emit(state.copyWith(businessType: event.value));
        break;
      case 'website':
        emit(state.copyWith(website: event.value));
        break;
      case 'referralCode':
        emit(state.copyWith(referralCode: event.value));
        break;
    }
  }

  void _onImageSelected(ImageSelected event, Emitter<SignupState> emit) {
    emit(state.copyWith(clientPhotoPath: event.imagePath));
  }

  Future<void> _onSubmitForm(SubmitForm event, Emitter<SignupState> emit) async {
    emit(state.copyWith(status: SignupStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Add your API logic here
      // For now, we'll just simulate success
      emit(state.copyWith(
        status: SignupStatus.success,
        successMessage: 'Registration successful!',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SignupStatus.error,
        errorMessage: 'Registration failed: ${e.toString()}',
      ));
    }
  }

  void _onResetForm(ResetForm event, Emitter<SignupState> emit) {
    emit(const SignupState());
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        add(ImageSelected(image.path));
      }
    } catch (e) {
      // Handle image picking error
      add(FormFieldChanged('error', 'Failed to pick image'));
    }
  }

  Future<void> takePhoto() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        add(ImageSelected(image.path));
      }
    } catch (e) {
      // Handle camera error
      add(FormFieldChanged('error', 'Failed to take photo'));
    }
  }
}