import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Include all necessary imports from the BLoC file
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisefox/apps/login.dart';

// Events
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

// States
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
    currentTab, status, errorMessage, successMessage, firstName, lastName,
    userName, email, phoneNumber, status_, relationshipToStudent, source,
    affiliate, country, postCode, addressLine, townOrCity, state,
    secondContactName, secondContactRelationship, secondContactPhone,
    paymentMethod, paymentGateway, clientPhotoPath, subject, experience,
    qualification, hourlyRate, availability, companyName, businessType,
    website, referralCode,
  ];
}

// BLoC
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
      await Future.delayed(const Duration(seconds: 2));
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
      add(FormFieldChanged('error', 'Failed to take photo'));
    }
  }
}

// Main Page Widget
class SignupPageBloc extends StatelessWidget {
  const SignupPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const primaryColor = Color(0xFF2222AE);
  static const lightBlue = Color(0xFF7DD3FC);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: const Text(
              "Register Account",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/common/images/background1.png',
                    fit: BoxFit.cover,
                    color: Colors.white.withOpacity(0.7),
                    colorBlendMode: BlendMode.lighten,
                  ),
                ),
                Column(
                  children: [
                    _buildHeader(w),
                    _buildTabBar(w),
                    SizedBox(height: w * 0.03),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildClientFormTab(context, w),
                          _buildTutorFormTab(context, w),
                          _buildAffiliateFormTab(context, w),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double w) {
    return Padding(
      padding: EdgeInsets.all(w * 0.05),
      child: Column(
        children: [
          Container(
            height: w * 0.12,
            width: w * 0.4,
            child: Image.asset('assets/common/images/logo.png'),
          ),
          SizedBox(height: w * 0.05),
          FittedBox(
            child: Text(
              "Register your Account",
              maxLines: 1,
              style: TextStyle(
                fontSize: 17.sp,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: w * 0.02),
          Text(
            "Welcome! please enter your details",
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(double w) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(w * 0.09)),
        color: const Color(0xffE7ECF8).withOpacity(0.5), // TabBar background color
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(w * 0.09)),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: const Color(0xFF6B7280),
        tabs: [
          _buildTabItem("Client"),
          _buildTabItem("Tutor"),
          _buildTabItem("Affiliate"),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildClientFormTab(BuildContext context, double w) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(w * 0.05),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage ?? 'Success')),
            );
          } else if (state.status == SignupStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error')),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildSectionHeader("Basic Details", w),
              _buildBasicDetailsForm(context, w),
              SizedBox(height: w * 0.05),
              _buildSectionHeader("Address Info", w),
              _buildAddressForm(context, w),
              SizedBox(height: w * 0.05),
              _buildSectionHeader("Second Contact", w),
              _buildSecondContactForm(context, w),
              SizedBox(height: w * 0.05),
              _buildSectionHeader("Payment Info", w),
              _buildPaymentForm(context, w),
              SizedBox(height: w * 0.05),
              _buildSectionHeader("Client Photo", w),
              _buildPhotoUpload(context, w),
              SizedBox(height: w * 0.05),
              _buildSubmitButton(context, state, w, "Register Client"),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTutorFormTab(BuildContext context, double w) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(w * 0.05),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage ?? 'Success')),
            );
          } else if (state.status == SignupStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error')),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildSectionHeader("Coming Soon", w),
              // _buildSectionHeader("Basic Details", w),
              // _buildBasicDetailsForm(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSectionHeader("Professional Info", w),
              // _buildTutorProfessionalForm(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSectionHeader("Address Info", w),
              // _buildAddressForm(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSectionHeader("Tutor Photo", w),
              // _buildPhotoUpload(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSubmitButton(context, state, w, "Register Tutor"),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAffiliateFormTab(BuildContext context, double w) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(w * 0.05),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage ?? 'Success')),
            );
          } else if (state.status == SignupStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error')),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildSectionHeader("Coming Soon", w),
              // _buildSectionHeader("Basic Details", w),
              // _buildBasicDetailsForm(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSectionHeader("Business Info", w),
              // _buildAffiliateProfessionalForm(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSectionHeader("Address Info", w),
              // _buildAddressForm(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSectionHeader("Company Logo", w),
              // _buildPhotoUpload(context, w),
              // SizedBox(height: w * 0.05),
              // _buildSubmitButton(context, state, w, "Register Affiliate"),
            ],
          );
        },
      ),
    );
  }

// Remove the old form methods and replace with the new ones

  Widget _buildClientForm(BuildContext context, double w) {
    return Column(
      children: [
        _buildSectionHeader("Basic Details", w),
        _buildBasicDetailsForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Address Info", w),
        _buildAddressForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Second Contact", w),
        _buildSecondContactForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Payment Info", w),
        _buildPaymentForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Client Photo", w),
        _buildPhotoUpload(context, w),
      ],
    );
  }

  Widget _buildTutorForm(BuildContext context, double w) {
    return Column(
      children: [
        _buildSectionHeader("Basic Details", w),
        _buildBasicDetailsForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Professional Info", w),
        _buildTutorProfessionalForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Address Info", w),
        _buildAddressForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Tutor Photo", w),
        _buildPhotoUpload(context, w),
      ],
    );
  }

  Widget _buildAffiliateForm(BuildContext context, double w) {
    return Column(
      children: [
        _buildSectionHeader("Basic Details", w),
        _buildBasicDetailsForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Business Info", w),
        _buildAffiliateProfessionalForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Address Info", w),
        _buildAddressForm(context, w),
        SizedBox(height: w * 0.05),
        _buildSectionHeader("Company Logo", w),
        _buildPhotoUpload(context, w),
      ],
    );
  }

  Widget _buildSectionHeader(String title, double w) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.04,
        vertical: w * 0.03,
      ),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(w * 0.02),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBasicDetailsForm(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Wrap(
          spacing: 16.0, // Horizontal spacing between fields
          runSpacing: 16.0, // Vertical spacing between rows
          children: [
            SizedBox(height: w * 0.03),

            _buildTextField(
              context,
              "First Name*",
              state.firstName,
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('firstName', value)),
            ),
            _buildTextField(
              context,
              "Last Name*",
              state.lastName,
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('lastName', value)),
            ),
            _buildTextField(
              context,
              "User Name*",
              state.userName,
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('userName', value)),
            ),
            _buildTextField(
              context,
              "Email*",
              state.email,
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('email', value)),
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextField(
              context,
              "Phone Number*",
              state.phoneNumber,
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('phoneNumber', value)),
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: w * 0.03),

            _buildDropdownField(
              context,
              "Status*",
              state.status_,
              ["Lead", "Prospect"],
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('status_', value)),
            ),
            _buildDropdownField(
              context,
              "Relationship to Student*",
              state.relationshipToStudent,
              ["Father", "Mother"],
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('relationshipToStudent', value)),
            ),
            _buildDropdownField(
              context,
              "Source",
              state.source,
              ["Source 1"],
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('source', value)),
            ),
            _buildDropdownField(
              context,
              "Affiliate",
              state.affiliate,
              ["Affiliate 1"],
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('affiliate', value)),
            ),
          ],
        );
      },
    );
  }


  Widget _buildTutorProfessionalForm(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: w * 0.03),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context,
                    "Subject*",
                    state.subject ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('subject', value)),
                  ),
                ),

                Expanded(
                  child: _buildTextField(
                    context,
                    "Experience (Years)*",
                    state.experience ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('experience', value)),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.03),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context,
                    "Qualification*",
                    state.qualification ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('qualification', value)),
                  ),
                ),

                Expanded(
                  child: _buildTextField(
                    context,
                    "Hourly Rate*",
                    state.hourlyRate ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('hourlyRate', value)),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.03),
            _buildTextField(
              context,
              "Availability*",
              state.availability ?? '',
                  (value) => context.read<SignupBloc>().add(FormFieldChanged('availability', value)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAffiliateProfessionalForm(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: w * 0.03),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context,
                    "Company Name*",
                    state.companyName ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('companyName', value)),
                  ),
                ),

                Expanded(
                  child: _buildTextField(
                    context,
                    "Business Type*",
                    state.businessType ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('businessType', value)),
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.03),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context,
                    "Website",
                    state.website ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('website', value)),
                    keyboardType: TextInputType.url,
                  ),
                ),

                Expanded(
                  child: _buildTextField(
                    context,
                    "Referral Code",
                    state.referralCode ?? '',
                        (value) => context.read<SignupBloc>().add(FormFieldChanged('referralCode', value)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Fixed _buildAddressForm - NO Expanded widgets needed
  Widget _buildAddressForm(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        // Check if device is tablet (width > 600)
        bool isTablet = MediaQuery.of(context).size.width > 600;

        if (isTablet) {
          // Tablet layout - 2 fields per row
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: w * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      context,
                      "Country",
                      state.country,
                      ["United Kingdom"],
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('country', value)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Post Code",
                      state.postCode,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('postCode', value)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: w * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Address Line",
                      state.addressLine,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('addressLine', value)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Town or City",
                      state.townOrCity,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('townOrCity', value)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: w * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      "State",
                      state.state,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('state', value)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(child: SizedBox()), // Empty space for odd number of fields
                ],
              ),
            ],
          );
        } else {
          // Mobile layout - 1 field per row
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: w * 0.03),
              _buildSearchField(
                context,
                "Country",
                state.country,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('country', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Post Code",
                state.postCode,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('postCode', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Address Line",
                state.addressLine,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('addressLine', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Town or City",
                state.townOrCity,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('townOrCity', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "State",
                state.state,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('state', value)),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildSecondContactForm(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        // Check if device is tablet (width > 600)
        bool isTablet = MediaQuery.of(context).size.width > 600;

        if (isTablet) {
          // Tablet layout - 2 fields per row
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: w * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Name",
                      state.secondContactName,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('secondContactName', value)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Relationship",
                      state.secondContactRelationship,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('secondContactRelationship', value)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: w * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Phone Number",
                      state.secondContactPhone,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('secondContactPhone', value)),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(child: SizedBox()), // Empty space since we have odd number of fields
                ],
              ),
            ],
          );
        } else {
          // Mobile layout - 1 field per row
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Name",
                state.secondContactName,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('secondContactName', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Relationship",
                state.secondContactRelationship,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('secondContactRelationship', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Phone Number",
                state.secondContactPhone,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('secondContactPhone', value)),
                keyboardType: TextInputType.phone,
              ),
            ],
          );
        }
      },
    );
  }

  // Fixed _buildPaymentForm - Responsive layout
  Widget _buildPaymentForm(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        // Check if device is tablet (width > 600)
        bool isTablet = MediaQuery.of(context).size.width > 600;

        if (isTablet) {
          // Tablet layout - 2 fields per row
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: w * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      context,
                      "Payment Methods*",
                      state.paymentMethod,
                      ["Manual", "GoCardless"],
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('paymentMethod', value)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      context,
                      "Select Payment Gateway",
                      state.paymentGateway,
                          (value) => context.read<SignupBloc>().add(FormFieldChanged('paymentGateway', value)),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          // Mobile layout - 1 field per row
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: w * 0.03),
              _buildDropdownField(
                context,
                "Payment Methods*",
                state.paymentMethod,
                ["GoCardless", "Credit Card", "Bank Transfer", "PayPal"],
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('paymentMethod', value)),
              ),
              SizedBox(height: w * 0.03),
              _buildTextField(
                context,
                "Select Payment Gateway",
                state.paymentGateway,
                    (value) => context.read<SignupBloc>().add(FormFieldChanged('paymentGateway', value)),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildPhotoUpload(BuildContext context, double w) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: w * 0.03),
          child: Column(
            children: [
              if (state.clientPhotoPath != null)
                Container(
                  height: w * 0.4,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(w * 0.02),
                    child: Image.file(
                      File(state.clientPhotoPath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: w * 0.03),
              Row(
                children: [
                  Expanded(
                    child: _buildPhotoButton(
                      context,
                      "Take Photo",
                      Icons.camera_alt,
                          () => context.read<SignupBloc>().takePhoto(),
                      w,
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: _buildPhotoButton(
                      context,
                      "Choose from Gallery",
                      Icons.photo_library,
                          () => context.read<SignupBloc>().pickImage(),
                      w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhotoButton(
      BuildContext context,
      String text,
      IconData icon,
      VoidCallback onPressed,
      double w,
      ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: w * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(w * 0.02),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: primaryColor, size: w * 0.04),
            SizedBox(width: w * 0.02),
            Text(
              text,
              style: TextStyle(
                color: primaryColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context,
      String label,
      String value,
      Function(String) onChanged, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    bool isTablet = MediaQuery.of(context).size.width > 600;

    // Split the label into text and asterisk
    final hasAsterisk = label.endsWith('*');
    final labelText = hasAsterisk ? label.substring(0, label.length - 1) : label;

    return SizedBox(
      width: isTablet
          ? (MediaQuery.of(context).size.width - 48) / 2 - 8
          : MediaQuery.of(context).size.width - 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: labelText,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              children: hasAsterisk
                  ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ]
                  : [],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
          TextFormField(
            initialValue: value,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                borderSide: const BorderSide(color: primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.width * 0.025,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 10.sp),
          ),
        ],
      ),
    );
  }


  // Method to build a single text field
  // Widget _buildTextField(
  //     BuildContext context,
  //     String label,
  //     String value,
  //     Function(String) onChanged, {
  //       TextInputType keyboardType = TextInputType.text,
  //     }) {
  //   // Check if device is tablet (width > 600)
  //   bool isTablet = MediaQuery.of(context).size.width > 600;
  //
  //   return SizedBox(
  //     width: isTablet
  //         ? (MediaQuery.of(context).size.width - 48) / 2 - 8 // 2 fields per row on tablet
  //         : MediaQuery.of(context).size.width - 32, // 1 field per row on mobile
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 10.sp,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.grey[700],
  //           ),
  //         ),
  //         SizedBox(height: MediaQuery.of(context).size.width * 0.01),
  //         TextFormField(
  //           initialValue: value,
  //           keyboardType: keyboardType,
  //           onChanged: onChanged,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
  //               borderSide: BorderSide(color: Colors.grey[300]!),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
  //               borderSide: BorderSide(color: Colors.grey[300]!),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
  //               borderSide: const BorderSide(color: primaryColor),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(
  //               horizontal: MediaQuery.of(context).size.width * 0.03,
  //               vertical: MediaQuery.of(context).size.width * 0.025,
  //             ),
  //             filled: true,
  //             fillColor: Colors.white,
  //           ),
  //           style: TextStyle(fontSize: 10.sp),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildDropdownField(
  //     BuildContext context,
  //     String label,
  //     String value,
  //     List<String> options,
  //     Function(String?) onChanged,
  //     ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 10.sp,
  //           fontWeight: FontWeight.w500,
  //           color: Colors.grey[700],
  //         ),
  //       ),
  //       SizedBox(height: MediaQuery.of(context).size.width * 0.01),
  //       DropdownButtonFormField<String>(
  //         value: value.isEmpty ? null : value,
  //         onChanged: onChanged,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
  //             borderSide: BorderSide(color: Colors.grey[300]!),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
  //             borderSide: BorderSide(color: Colors.grey[300]!),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
  //             borderSide: const BorderSide(color: primaryColor),
  //           ),
  //           contentPadding: EdgeInsets.symmetric(
  //             horizontal: MediaQuery.of(context).size.width * 0.03,
  //             vertical: MediaQuery.of(context).size.width * 0.025,
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //           hintText: "Select...",
  //         ),
  //         items: options.map((String option) {
  //           return DropdownMenuItem<String>(
  //             value: option,
  //             child: Text(
  //               option,
  //               style: TextStyle(fontSize: 10.sp),
  //             ),
  //           );
  //         }).toList(),
  //         style: TextStyle(fontSize: 10.sp, color: Colors.black),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildDropdownField(
      BuildContext context,
      String label,
      String value,
      List<String> options,
      Function(String?) onChanged,
      ) {
    // Check if the label ends with '*'
    final hasAsterisk = label.endsWith('*');
    final labelText = hasAsterisk ? label.substring(0, label.length - 1) : label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            children: hasAsterisk
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ]
                : [],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.01),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              borderSide: const BorderSide(color: primaryColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.width * 0.025,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Select...",
            hintStyle: TextStyle(
              fontSize: 10.sp, // Set your desired font size here
              color: Colors.grey[500], // Optional: set hint color
            ),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: TextStyle(fontSize: 10.sp),
              ),
            );
          }).toList(),
          style: TextStyle(fontSize: 10.sp, color: Colors.black),
        ),
      ],
    );
  }


  Widget _buildSearchField(
      BuildContext context,
      String label,
      String value,
      Function(String) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.01),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              borderSide: const BorderSide(color: primaryColor),
            ),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
              size: MediaQuery.of(context).size.width * 0.04,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.width * 0.025,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Please Search Here",
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 9.sp,
            ),
          ),
          style: TextStyle(fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, SignupState state, double w, String buttonText) {
    return Column(
      children: [
        GestureDetector(
          onTap: state.status == SignupStatus.loading
              ? null
              : () => context.read<SignupBloc>().add(SubmitForm()),
          child: Container(
            height: w * 0.15,
            width: w,
            decoration: BoxDecoration(
              color: state.status == SignupStatus.loading
                  ? primaryColor.withOpacity(0.6)
                  : primaryColor,
              borderRadius: BorderRadius.circular(w * 0.03),
            ),
            child: Center(
              child: state.status == SignupStatus.loading
                  ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: w * 0.02),
                  SvgPicture.asset(
                    'assets/common/icons/rightarrow.svg',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: w * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: w * 0.03,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to login page
                Navigator.push(context, MaterialPageRoute(builder: (context) => UnifiedLoginPage()));
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}