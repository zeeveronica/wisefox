import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

// import 'package:calender_picker/date_picker_widget.dart';
import 'package:wisefox/client/features/bloc/country/country_bloc.dart';
import 'package:wisefox/client/features/bloc/examboard/examboard_bloc.dart';
import 'package:wisefox/client/features/bloc/subject/subject_bloc.dart';
import 'package:wisefox/client/features/bloc/studentadmission/studentadmission_bloc.dart';
import 'package:wisefox/client/features/bloc/filesharing/filesharing_bloc.dart';
import 'package:wisefox/client/features/bloc/sendfiles/send_files_bloc.dart';
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/client/features/bloc/tutorlist/tutorlist_bloc.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/screens/demo_request_page.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
// import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

class StudentAdmission extends StatefulWidget {
  const StudentAdmission({super.key});

  @override
  State<StudentAdmission> createState() => _StudentAdmissionState();
}

class _StudentAdmissionState extends State<StudentAdmission> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _examboardController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _academicYearController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final ScrollController _fileScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();
  String selectedCountryCode = '+91';
  String _attachments = "";
  String? _encodedFile;
  DateTime? _dateOfBirth;
  String? _gender;
  bool _isAcademicDropdownVisible = false;
  bool _isSubjectDropdownVisible = false;
  bool _isCountryDropdownVisible = false;
  bool _isExamBoardDropdownVisible = false;
  int count = 1;
  DateTime? _selectedValue;
  String? _selectedGender;
  String? _selectedAcademicYear;
  String? _selectedSubject;
  String? _selectedExamBoard;

  @override
  void initState() {
    super.initState();
    context.read<AcademicYearBloc>().add(FetchTutorList());
    context.read<FilesharingBloc>().add(FetchFilesharingEvent());
    context.read<DemoRequestBloc>().add(FetchSentedfiles());
    context.read<SubjectBloc>().add(FetchSubjectList());
    context.read<ExamBoardBloc>().add(FetchExamBoardList());
    context.read<CountryBloc>().add(FetchCountryList());
    context.read<DemoRequestBloc>().add(FetchSentedfiles());
    context.read<StudentAdmissionBloc>().emit(StudentAdmissionInitial());
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Get the current scroll position in pixels
    double scrollPosition = _scrollController.position.pixels;

    // Get the maximum scroll extent
    double maxScroll = _scrollController.position.maxScrollExtent;

    // Get the minimum scroll extent
    double minScroll = _scrollController.position.minScrollExtent;

    // Log the current scroll position
    print("Current Scroll Position: $scrollPosition");
    print("Max Scroll Extent: $maxScroll");
    print("Min Scroll Extent: $minScroll");
  }

  Future<void> _selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final fileBytes = File(file.path!).readAsBytesSync();
        final mimeType = _getMimeType(file.name);

        setState(() {
          _attachments = file.name;
          _encodedFile = 'data:$mimeType;base64,${base64Encode(fileBytes)}';
        });

        print("Selected File: $_attachments");
        print("Encoded File: $_encodedFile");
      } else {
        print("No file selected.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getMimeType(String fileName) {
    if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
      return 'image/jpeg';
    } else if (fileName.endsWith('.png')) {
      return 'image/png';
    } else if (fileName.endsWith('.gif')) {
      return 'image/gif';
    } else if (fileName.endsWith('.pdf')) {
      return 'application/pdf';
    } else {
      return 'application/octet-stream'; // Fallback MIME type
    }
  }

  String? _selectedAcademicYearValue;
  String? _selectedAcademicYearLabel;

  void _selectAcademicYear(String value, String label) {
    setState(() {
      _selectedAcademicYearValue = value; // Store the value to be submitted
      _selectedAcademicYearLabel =
          label; // Store the label to show in the TextField
      _academicYearController.text =
          label; // Update the TextField to show the label
      _isAcademicDropdownVisible = false; // Close the dropdown after selection
    });
  }

  String? _selectedSubjectId;
  String? _selectedExamBoardId;

  String? _selectedExamBoardLabel;

  void _selectSubject(
    String value,
    String label,
  ) {
    setState(() {
      _selectedSubjectId = value;
      _selectedSubject = value;
      _subjectController.text = label;
      _isSubjectDropdownVisible = false;
    });
  }

  void _selectExamBoard(
    String value,
    String label,
  ) {
    setState(() {
      _selectedExamBoardId = value;
      _selectedExamBoard = value;
      _examboardController.text = label;
      _isExamBoardDropdownVisible = false;
    });
  }

  //   void _selectCountry(
  //   String value,
  //   String label,
  // ) {
  //   setState(() {
  //     _selectedCountryValue = value;
  //     _selectedCountry = value;
  //     _countryController.text = label;
  //     _isCountryDropdownVisible = false;
  //   });
  // }
  String? _selectedCountry;
  String? _selectedCountryValue;
  String? _selectedCountryLabel;
  void _selectCountry(String value, String label) {
    setState(() {
      _selectedCountryValue = value;
      _selectedCountry = label;
      _countryController.text = label;
      _isCountryDropdownVisible = false;
    });
  }

  // void _selectCountry(String selectedCountry) {
  //   setState(() {
  //     _selectedCountry = selectedCountry;
  //     _countryController.text =
  //         selectedCountry; // Display selected value in TextField
  //     _isCountryDropdownVisible = false; // Hide the dropdown after selection
  //   });
  // }
  // void _selectCountry(String value, String label) {
  //   setState(() {
  //     _selectedCountryValue = value;
  //     _selectedCountry = value;
  //     _selectedAcademicYearLabel =
  //         label; // Store the label to show in the TextField
  //     _academicYearController.text =
  //         label; // Update the TextField to show the label
  //     _isAcademicDropdownVisible = false; // Close the dropdown after selection
  //   });
  // }

  void _toggleAcademicDropdown() {
    setState(() {
      _isAcademicDropdownVisible = !_isAcademicDropdownVisible;
    });
  }

  void _toggleSubjectDropdown() {
    setState(() {
      _isSubjectDropdownVisible = !_isSubjectDropdownVisible;
    });
  }

  void _toggleExamboardDropdown() {
    setState(() {
      _isExamBoardDropdownVisible = !_isExamBoardDropdownVisible;
    });
  }

  void _toggleCountryDropdown() {
    setState(() {
      _isCountryDropdownVisible = !_isCountryDropdownVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar:
          BlocBuilder<StudentAdmissionBloc, StudentAdmissionState>(
        builder: (context, state) {
          if (state is StudentAdmissionLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: theColors.primaryColor,
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: GestureDetector(
              onTap: () {
                _submitStudentAdmission();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theColors.bottomnavColor,
                  borderRadius: BorderRadius.circular(w * 0.07),
                ),
                child: Center(
                  child: Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: theColors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: theColors.white,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Text(
          "Student Admission",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<StudentAdmissionBloc, StudentAdmissionState>(
        builder: (context, state) {
          if (state is StudentAdmissionLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: theColors.primaryColor,
                ),
              ),
            );
          }
          return SafeArea(
            child: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(theimage.pagebackground),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.7),
                    BlendMode.lighten,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _fileScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: w * 0.02),
                          Text(
                            "First Name",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03),
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 11.sp),
                                    hintText: "Enter first name"),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Last Name",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03),
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 11.sp),
                                    hintText: "Enter last name"),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "User Name",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 11.sp),
                                    hintText: "Enter user name"),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Email Id",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 11.sp),
                                    hintText: "Enter first email id"),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Phone number",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          IntlPhoneField(
                            controller: _phoneNumberController,
                            dropdownIconPosition: IconPosition.trailing,
                            showCountryFlag: false,
                            dropdownIcon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color:
                                  Colors.black, // Tint the dropdown icon color
                            ),
                            decoration: InputDecoration(
                              hintText: 'phone number',
                              hintStyle: TextStyle(fontSize: 11.sp),
                              filled: true,
                              fillColor: Colors
                                  .white, // Tint the text field background color
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: w * 0.002, color: Color(0xffF4F4F4)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: w * 0.002, color: Color(0xffF4F4F4)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            initialCountryCode: 'IN', // Default country code
                            dropdownDecoration: BoxDecoration(
                              color: Colors
                                  .white, // Tint the dropdown background color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            dropdownTextStyle: TextStyle(
                              color:
                                  Colors.black, // Tint the dropdown text color
                              fontSize: 14.sp, // Adjust the text size
                            ),
                            onChanged: (phone) {
                              print(phone
                                  .completeNumber); // Handle the phone number with country code
                            },
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Date of birth",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedValue ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: theColors.primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          textStyle: TextStyle(
                                            color: theColors.primaryColor,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                      textTheme: TextTheme(
                                        headlineSmall:
                                            TextStyle(fontSize: 15.sp),
                                        headlineMedium:
                                            TextStyle(fontSize: 15.sp),
                                        headlineLarge:
                                            TextStyle(fontSize: 15.sp),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  _selectedValue = pickedDate;
                                });
                              }
                            },
                            child: Container(
                              height: w * 0.12,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: w * 0.002,
                                  color: Color(0xffF4F4F4),
                                ),
                                borderRadius: BorderRadius.circular(w * 0.03),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: w * 0.03, right: w * 0.04),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _selectedValue != null
                                            ? DateFormat('dd-MM-yyyy').format(
                                                _selectedValue!) // Display in dd-MM-yyyy
                                            : "DD-MM-YYYY",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: w * 0.05,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: w * 0.02),
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.12,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03),
                              child: DropdownButtonFormField<String>(
                                elevation: 0,
                                dropdownColor: theColors.white,
                                value: _selectedGender,
                                iconSize: 0,
                                hint: Text(
                                  "  --select--",
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: w * 0.05,
                                  ),
                                ),
                                items:
                                    ['Male', 'Female', 'Other'].map((gender) {
                                  return DropdownMenuItem<String>(
                                    value: gender,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: w * 0.02),
                                      child: Text(
                                        gender,
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    // Ensure the first letter of the selected gender is capitalized
                                    _selectedGender = newValue != null
                                        ? newValue[0].toUpperCase() +
                                            newValue.substring(1).toLowerCase()
                                        : null;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Academic Year",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          // Variables to store selected value and label

                          Container(
                            width: w * 1,
                            child: GestureDetector(
                              onTap: _toggleAcademicDropdown,
                              child: AbsorbPointer(
                                child: Container(
                                  height: w * 0.12,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: w * 0.002,
                                        color: Color(0xffF4F4F4)),
                                    borderRadius:
                                        BorderRadius.circular(w * 0.03),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: w * 0.006, left: w * 0.03),
                                    child: TextField(
                                      controller: _academicYearController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                        hintText: "Select Academic Year",
                                        hintStyle: TextStyle(fontSize: 10.sp),
                                        border: InputBorder.none,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(w * 0.03),
                                          child:
                                              Icon(Icons.keyboard_arrow_down),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),

// Dropdown Visibility
                          if (_isAcademicDropdownVisible)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF4F4F4)),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: BlocBuilder<AcademicYearBloc,
                                  AcademicYearState>(
                                builder: (context, state) {
                                  if (state is AcademicYearLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is AcademicYearLoaded) {
                                    return Container(
                                      height: w * 0.3,
                                      child: Padding(
                                        padding: EdgeInsets.all(w * 0.01),
                                        child: ScrollbarTheme(
                                          data: ScrollbarThemeData(
                                            thumbColor: MaterialStateProperty
                                                .all(theColors
                                                    .primaryColor), // Set the thumb color
                                            trackColor: MaterialStateProperty
                                                .all(Colors.grey.withOpacity(
                                                    0.3)), // Set the track color
                                            radius: Radius.circular(10),
                                            thickness:
                                                MaterialStateProperty.all(3.0),
                                          ),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            thickness: 3.0,
                                            trackVisibility: true,
                                            radius: Radius.circular(10),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.tutorList.length,
                                              itemBuilder: (context, index) {
                                                final tutor =
                                                    state.tutorList[index];
                                                return ListTile(
                                                  title: Text(
                                                    tutor.label
                                                        .toString(), // Show label in the dropdown
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                  trailing:
                                                      _selectedAcademicYearValue ==
                                                              tutor.value
                                                          ? Icon(Icons.done,
                                                              size: w * 0.04,
                                                              color: theColors
                                                                  .primaryColor)
                                                          : SizedBox.shrink(),
                                                  onTap: () =>
                                                      _selectAcademicYear(
                                                    tutor.value
                                                        .toString(), // Value for submission
                                                    tutor.label
                                                        .toString(), // Label to display
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is AcademicYearError) {
                                    return Center(
                                        child: Text(
                                            'Error loading academic years'));
                                  } else {
                                    return Center(
                                        child: Text(
                                            'No academic years available'));
                                  }
                                },
                              ),
                            ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Country",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            width: w * 1,
                            child: GestureDetector(
                              onTap: _toggleCountryDropdown,
                              child: AbsorbPointer(
                                child: Container(
                                  height: w * 0.12,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: w * 0.002,
                                        color: Color(0xffF4F4F4)),
                                    borderRadius:
                                        BorderRadius.circular(w * 0.03),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: w * 0.006, left: w * 0.03),
                                    child: TextField(
                                      controller: _countryController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                        hintText: "--select--",
                                        hintStyle: TextStyle(fontSize: 10.sp),
                                        border: InputBorder.none,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(w * 0.03),
                                          child:
                                              Icon(Icons.keyboard_arrow_down),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          if (_isCountryDropdownVisible)
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffF4F4F4)),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                child: BlocBuilder<CountryBloc, CountryState>(
                                  builder: (context, state) {
                                    if (state is CountryLoading) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is CountryLoaded) {
                                      return Container(
                                        height: w * 0.3,
                                        child: Padding(
                                          padding: EdgeInsets.all(w * 0.01),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            thickness: 3.0,
                                            radius: Radius.circular(10),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.countries.length,
                                              itemBuilder: (context, index) {
                                                final country =
                                                    state.countries[index];
                                                return ListTile(
                                                  title: Text(
                                                    country.label,
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                  trailing: _selectedCountry ==
                                                          country.label
                                                      ? Icon(Icons.done,
                                                          size: w * 0.04,
                                                          color: theColors
                                                              .primaryColor)
                                                      : SizedBox.shrink(),
                                                  onTap: () {
                                                    _selectCountry(
                                                      country.value
                                                          .toString(), // Ensure this is correct
                                                      country.label,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (state is CountryError) {
                                      return Center(
                                          child: Text(
                                              'Error loading countries: ${state.message}'));
                                    } else {
                                      return Center(
                                          child:
                                              Text('No countries available'));
                                    }
                                  },
                                )),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Subject for Tution",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            // height: w * 0.4,
                            width: w * 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.tabbarclr.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(w * 0.03),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: w * 0.02),
                                  Container(
                                    width: w * 1,
                                    child: GestureDetector(
                                      onTap: _toggleSubjectDropdown,
                                      child: AbsorbPointer(
                                        child: Container(
                                          height: w * 0.12,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: w * 0.002,
                                                color: Color(0xffF4F4F4)),
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: w * 0.006, left: w * 0.03),
                                            child: TextField(
                                              controller: _subjectController,
                                              focusNode: _focusNode,
                                              style: TextStyle(
                                                fontSize: _subjectController
                                                        .text.isNotEmpty
                                                    ? 10.sp
                                                    : 10.sp,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "Select Subject",
                                                hintStyle: TextStyle(
                                                  fontSize: 10
                                                      .sp, // Default hint size
                                                ),
                                                border: InputBorder.none,
                                                suffixIcon: Padding(
                                                  padding:
                                                      EdgeInsets.all(w * 0.03),
                                                  child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: w * 0.05,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: w * 0.02),
                                  if (_isSubjectDropdownVisible)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffF4F4F4)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                      ),
                                      child: BlocBuilder<SubjectBloc,
                                          SubjectState>(
                                        builder: (context, state) {
                                          if (state is SubjectLoading) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state is SubjectLoaded) {
                                            return Container(
                                              height: w * 0.3,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(w * 0.01),
                                                child: ScrollbarTheme(
                                                  data: ScrollbarThemeData(
                                                    thumbColor:
                                                        MaterialStateProperty
                                                            .all(theColors
                                                                .primaryColor), // Set the thumb color
                                                    trackColor:
                                                        MaterialStateProperty
                                                            .all(Colors.grey
                                                                .withOpacity(
                                                                    0.3)), // Set the track color
                                                    radius: Radius.circular(10),
                                                    thickness:
                                                        MaterialStateProperty
                                                            .all(3.0),
                                                  ),
                                                  child: Scrollbar(
                                                    thumbVisibility: true,
                                                    thickness: 3.0,
                                                    trackVisibility: true,
                                                    radius: Radius.circular(10),
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: state
                                                          .subjectList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final subjects = state
                                                            .subjectList[index];
                                                        return ListTile(
                                                          title: Text(
                                                            subjects.label,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                          trailing: _selectedSubject ==
                                                                  subjects.label
                                                              ? Icon(Icons.done,
                                                                  size:
                                                                      w * 0.05,
                                                                  color: theColors
                                                                      .primaryColor)
                                                              : SizedBox
                                                                  .shrink(),
                                                          onTap: () =>
                                                              _selectSubject(
                                                            subjects.value
                                                                .toString(), // Value for submission
                                                            subjects.label
                                                                .toString(), // Label to display
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (state is SubjectError) {
                                            return Center(
                                                child: Text(
                                                    'Error loading tutors: ${state.error}'));
                                          } else {
                                            return Center(
                                                child: Text(
                                                    'No tutors available'));
                                          }
                                        },
                                      ),
                                    ),
                                  SizedBox(height: w * 0.02),
                                  Container(
                                    width: w * 1,
                                    child: GestureDetector(
                                      onTap: _toggleExamboardDropdown,
                                      child: AbsorbPointer(
                                        child: Container(
                                          height: w * 0.12,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: w * 0.002,
                                                color: Color(0xffF4F4F4)),
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: w * 0.006, left: w * 0.03),
                                            child: TextField(
                                              controller: _examboardController,
                                              focusNode: _focusNode,
                                              style: TextStyle(
                                                fontSize: _examboardController
                                                        .text.isNotEmpty
                                                    ? 10.sp
                                                    : 10.sp,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "Select Examboard",
                                                hintStyle: TextStyle(
                                                  fontSize: 10
                                                      .sp, // Default hint size
                                                ),
                                                border: InputBorder.none,
                                                suffixIcon: Padding(
                                                  padding:
                                                      EdgeInsets.all(w * 0.03),
                                                  child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: w * 0.05,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: w * 0.02),
                                  if (_isExamBoardDropdownVisible)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffF4F4F4)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                      ),
                                      child: BlocBuilder<ExamBoardBloc,
                                          ExamBoardState>(
                                        builder: (context, state) {
                                          if (state is ExamBoardLoading) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state is ExamBoardLoaded) {
                                            return Container(
                                              height: w * 0.3,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(w * 0.01),
                                                child: ScrollbarTheme(
                                                  data: ScrollbarThemeData(
                                                    thumbColor:
                                                        MaterialStateProperty
                                                            .all(theColors
                                                                .primaryColor), // Set the thumb color
                                                    trackColor:
                                                        MaterialStateProperty
                                                            .all(Colors.grey
                                                                .withOpacity(
                                                                    0.3)), // Set the track color
                                                    radius: Radius.circular(10),
                                                    thickness:
                                                        MaterialStateProperty
                                                            .all(3.0),
                                                  ),
                                                  child: Scrollbar(
                                                    thumbVisibility: true,
                                                    thickness: 3.0,
                                                    trackVisibility: true,
                                                    radius: Radius.circular(10),
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: state
                                                          .examBoardList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final examboard =
                                                            state.examBoardList[
                                                                index];
                                                        return ListTile(
                                                          title: Text(
                                                            examboard.label,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                          trailing: _selectedExamBoard ==
                                                                  examboard
                                                                      .label
                                                              ? Icon(Icons.done,
                                                                  size:
                                                                      w * 0.05,
                                                                  color: theColors
                                                                      .primaryColor)
                                                              : SizedBox
                                                                  .shrink(),
                                                          onTap: () =>
                                                              _selectExamBoard(
                                                            examboard.value
                                                                .toString(), // Value for submission
                                                            examboard.label
                                                                .toString(), // Label to display
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (state is ExamBoardError) {
                                            return Center(
                                                child: Text(
                                                    'Error loading Examboard: ${state.error}'));
                                          } else {
                                            return Center(
                                                child: Text(
                                                    'No Examboard available'));
                                          }
                                        },
                                      ),
                                    ),
                                  SizedBox(height: w * 0.02),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Student photo",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          GestureDetector(
                            onTap: _selectFile,
                            child: Container(
                              height: w * 0.15,
                              width: w * 1,
                              decoration: BoxDecoration(
                                  color: theColors.tabbarclr.withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(w * 0.03)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _attachments.isNotEmpty
                                      ? Expanded(
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  " ${_attachments}",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showphotoDialog(context);
                                                  },
                                                  child: Container(
                                                    height: w * 0.06,
                                                    width: w * 0.06,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff707070)),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: theColors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons.cloud_upload,
                                              color: Color(0xff707070),
                                              size: w * 0.08,
                                            ),
                                            SizedBox(
                                              width: w * 0.03,
                                            ),
                                            Text(
                                              "Upload Passport Size Photo",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _fileScrollController.dispose();
    _emailController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showphotoDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(),
              ),
            ),
            Center(
              child: AlertDialog(
                title: Column(
                  children: [
                    Text(
                      "Are you sure you want to remove",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "this photo?",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: w * 0.10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                  right: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: theColors.textgrey,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _attachments = "";
                                _encodedFile = "";
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: w * 0.10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Color(0xff1E3A6E),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }

// Ensure this is within the scope of your method where admissionEvent is created
  // void _submitStudentAdmission() {
  //   final DateFormat formatter =
  //       DateFormat('yyyy-MM-dd'); // Corrected to 'yyyy'
  //   String? formattedDateOfBirth =
  //       _dateOfBirth != null ? formatter.format(_dateOfBirth!) : null;

  //   String? mappedGender;

  //   // if (_gender != null && _gender!.isNotEmpty) {
  //   //   switch (_gender!.toLowerCase()) {
  //   //     case 'male':
  //   //       mappedGender = 'Male';
  //   //       break;
  //   //     case 'female':
  //   //       mappedGender = 'Female';
  //   //       break;
  //   //     case 'other':
  //   //       mappedGender = 'Other'; // Handle "Other"
  //   //       break;
  //   //     default:
  //   //       mappedGender = null; // Set to null if unspecified
  //   //       break;
  //   //   }
  //   // } else {
  //   //   mappedGender = null; // Ensure mappedGender is null if _gender is empty
  //   // }

  //   // Log the submission data
  //   log("Submitting student admission with data: "
  //       "First Name: ${_firstNameController.text}, "
  //       "Last Name: ${_lastNameController.text}, "
  //       "Username: ${_usernameController.text}, "
  //       "Email: ${_emailController.text}, "
  //       "Phone Number: ${_phoneNumberController.text}, "
  //       // "Date of Birth: $formattedDateOfBirth, "
  //       // "Gender: ${mappedGender ?? 'Not Specified'}, "
  //       "Syllabus: ${_selectedExamBoard ?? 'Not Specified'}, "
  //       "Year: ${_selectedAcademicYear ?? 'Not Specified'}, "
  //       "Country ID: ${_selectedCountryId?.toString() ?? 'Not Specified'}, "
  //       // "Subjects: ${_selectedSubject != null ? [
  //       //     {'subject': 1, 'examboard': 1}
  //       //   ] : []}, "
  //       "Student Photo: ${_encodedFile ?? 'No Photo'}, ");

  //   // Check required fields
  //   if (_firstNameController.text.isNotEmpty &&
  //       _lastNameController.text.isNotEmpty &&
  //       _usernameController.text.isNotEmpty &&
  //       _emailController.text.isNotEmpty &&
  //       _phoneNumberController.text.isNotEmpty) {
  //     try {
  //       // Prepare the admission event data
  //       final admissionEvent = StudentAdmissionEvent(
  //         firstName: _firstNameController.text,
  //         lastName: _lastNameController.text,
  //         username: _usernameController.text,
  //         email: _emailController.text,
  //         phoneNumber: _phoneNumberController.text,
  //         // dateOfBirth:
  //         //     formattedDateOfBirth ?? '', // Pass an empty string if null
  //         // gender: mappedGender ??
  //         // '',
  //         year: _selectedAcademicYear.toString(),
  //         country: _selectedCountryId ?? 1,
  //         // subjects: _selectedSubject != null
  //         //     ? [
  //         //         {'subject': 1, 'examboard': 1}
  //         //       ]
  //         //     : [],
  //         studentPhoto: _encodedFile ?? '',
  //       );

  //       // Ensure gender is not sent if it's an empty string
  //       // if (admissionEvent.gender.isEmpty) {
  //       //   // This line will throw the "Undefined name 'gender'" error
  //       //   // Change this to a field update directly on the admissionEvent instance
  //       //   // Use gender: mappedGender ?? '', which is already set correctly.
  //       // }

  //       // Dispatch the event

  //       BlocProvider.of<StudentAdmissionBloc>(context).add(admissionEvent);
  //       context.read<DemoRequestBloc>().add(FetchSentedfiles());
  //       Navigator.pop(context);
  //     } catch (e) {
  //       log('Error dispatching SubmitStudentAdmissionEvent: $e');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to submit student admission: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please fill in all required fields'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }
  void _submitStudentAdmission() {
    final DateFormat submissionFormatter = DateFormat('yyyy-MM-dd');
    String? formattedDateOfBirth = _selectedValue != null
        ? submissionFormatter.format(_selectedValue!)
        : null;

    log("Submitting student admission with data: "
        "First Name: ${_firstNameController.text}, "
        "Last Name: ${_lastNameController.text}, "
        "Username: ${_usernameController.text}, "
        "Email: ${_emailController.text}, "
        "Phone Number: ${_phoneNumberController.text}, "
        "Date of Birth: ${formattedDateOfBirth ?? 'Not Specified'}, "
        "Examboard: ${_selectedExamBoardId ?? 'Not Specified'}, "
        "Gender: ${_selectedGender ?? 'Not Specified'}, "
        "Year: ${_selectedAcademicYearValue ?? 'Not Specified'}, "
        "Country ID: ${_selectedCountryValue ?? 'Not Specified'}, "
        "Subject: ${_selectedSubjectId ?? 'Not Specified'}, "
        "Student Photo: ${_encodedFile ?? 'No Photo'}");

    // Validate inputs
    if (_firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        _usernameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _phoneNumberController.text.trim().isNotEmpty &&
        _selectedCountryValue != null &&
        _selectedAcademicYearValue != null &&
        _selectedSubjectId != null &&
        _selectedExamBoardId != null) {
      try {
        // Create the admission event with all necessary data
        final admissionEvent = StudentAdmissionEvent(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          dateOfBirth:
              formattedDateOfBirth ?? '', // Defaults to empty string if null
          year: _selectedAcademicYearValue!,
          country:
              _selectedCountryValue!, // Assumes this is never null due to validation
          subjects: [
            {
              "subject": int.parse(
                  _selectedSubjectId!), // Ensure this is safe due to validation
              "examboard": int.parse(
                  _selectedExamBoardId!), // Ensure this is safe due to validation
            }
          ],
          studentPhoto: _encodedFile ?? '', // Defaults to empty string if null
          gender: _selectedGender ?? '', // Defaults to empty string if null
        );

        // Dispatch the event using the BLoC
        BlocProvider.of<StudentAdmissionBloc>(context).add(admissionEvent);
        Navigator.pop(context);
      } catch (e) {
        log('Error dispatching StudentAdmissionEvent: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit student admission: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Handle case where required fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
