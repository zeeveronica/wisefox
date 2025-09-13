// signup_state.dart
import 'package:equatable/equatable.dart';

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