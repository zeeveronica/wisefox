import 'package:wisefox/client/features/bloc/country/country_bloc.dart';
import 'package:wisefox/client/features/bloc/subject/subject_bloc.dart';
import 'package:wisefox/client/features/bloc/tutorlist/tutorlist_bloc.dart';
import 'package:wisefox/client/features/model/sentedfile_model.dart';
import 'package:wisefox/client/features/screens/available_tutors.dart';
import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theicons.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Democlassrequirment extends StatefulWidget {
  final StudentListModel details;
  const Democlassrequirment({super.key, required this.details});

  @override
  State<Democlassrequirment> createState() => _DemoclassrequirmentState();
}

class _DemoclassrequirmentState extends State<Democlassrequirment> {
  double _minValue = 10.0;
  double _maxValue = 90.0;
  //add checkbox

//add icon
  bool countryselection = true;
  bool selecticon = true;
  bool yearselecticon = true;
  // bool hoursicon = true;
  bool subjecticon = true;

  String? _selectedCountry;
  bool _isCountryDropdownVisible = false;
  int? _selectedCountryId;
  final TextEditingController _countryController = TextEditingController();
  void _selectCountry(String selectedCountry) {
    setState(() {
      _selectedCountry = selectedCountry;
      _countryController.text =
          selectedCountry; // Display selected value in TextField
      _isCountryDropdownVisible = false; // Hide the dropdown after selection
    });
  }

  void _toggleCountryDropdown() {
    setState(() {
      _isCountryDropdownVisible = !_isCountryDropdownVisible;
    });
  }

  String? _selectedAcademicYear;
  bool _isAcademicDropdownVisible = false;
  final TextEditingController _academicYearController = TextEditingController();
  String? _selectedAcademicYearValue;
  String? _selectedAcademicYearLabel;
  void _toggleAcademicDropdown() {
    setState(() {
      _isAcademicDropdownVisible = !_isAcademicDropdownVisible;
    });
  }

  void _selectAcademicYear(String value, String label) {
    setState(() {
      _selectedAcademicYearValue = value;
      _selectedAcademicYearLabel = label;
      _academicYearController.text = label;
      _isAcademicDropdownVisible = false;
    });
  }

  String? _selectedSubjectId;
  String? _selectedSubject;
  final TextEditingController _subjectController = TextEditingController();
  bool _isSubjectDropdownVisible = false;
  void _toggleSubjectDropdown() {
    setState(() {
      _isSubjectDropdownVisible = !_isSubjectDropdownVisible;
    });
  }

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

  @override
  void initState() {
    // TODO: implement initState
    context.read<CountryBloc>().add(FetchCountryList());
    context.read<AcademicYearBloc>().add(FetchTutorList());
    context.read<SubjectBloc>().add(FetchSubjectList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AvailableTutors(),
              ));
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: w * 0.03, right: w * 0.03, bottom: w * 0.02),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theColors.bottomnavColor,
              borderRadius: BorderRadius.circular(w * 0.07),
            ),
            child: Center(
              child: Text(
                "Find Tutors",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: theColors.white),
              ),
            ),
          ),
        ),
      ),
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
          "Demo Class Requirement",
          style: TextStyle(color: theColors.white, fontSize: 15.sp),
        ),
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            theicons.questionmark,
            color: theColors.white,
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              children: [
                SizedBox(
                  height: w * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE7ECF8).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(w * 0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: w * 0.02),
                          leading: CircleAvatar(
                            radius: w * 0.08,
                            backgroundImage: NetworkImage(widget
                                .details.studentPhoto), // Load image from URL
                            backgroundColor: Colors.grey[200],
                          ),
                          title: Text(
                            widget.details.fullName,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: w * 0.05,
                                width: w * 0.22,
                                decoration: BoxDecoration(
                                  color: theColors.white,
                                  borderRadius: BorderRadius.circular(w * 0.03),
                                  border: Border.all(
                                    width: w * 0.001,
                                    color: Color(0xffEAEAEA),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        widget.details.activeChoices,
                                        // Conditional text
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: widget.details.activeChoices ==
                                                  'Active'
                                              ? Colors.green
                                              : theColors.textgrey,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: w * 0.04,
                                        color: Color(0xff707070),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: w * 0.03),
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: w * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filters"),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        "assets/client/icons/refresh.svg",
                        width: w * 0.04,
                        height: w * 0.04,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: w * 0.04,
                ),
                Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                    expansionTileTheme: ExpansionTileThemeData(
                      backgroundColor: Colors.transparent,
                      collapsedBackgroundColor: Colors.transparent,
                    ),
                  ),
                  child: Container(
                    width: w * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.03),
                      color: theColors.tabbarclr.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        ExpansionTile(
                          trailing: countryselection
                              ? Icon(Icons.add, size: w * 0.05)
                              : Icon(Icons.minimize, size: w * 0.05),
                          title: Text(
                            'Country',
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            _selectedCountry.toString(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              countryselection = !expanded;
                            });
                          },
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theColors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0),
                                    bottom: Radius.circular(16.0),
                                  ),
                                ),
                                padding: EdgeInsets.all(0.0),
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
                                                  title: Text(country.label,
                                                      style: TextStyle(
                                                          fontSize: 10.sp)),
                                                  trailing: _selectedCountry ==
                                                          country.label
                                                      ? Icon(Icons.done,
                                                          size: w * 0.04,
                                                          color: theColors
                                                              .primaryColor)
                                                      : SizedBox.shrink(),
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedCountry = country
                                                          .label; // Store the selected label
                                                      _selectedCountryId = country
                                                          .value; // Store the corresponding value
                                                      _countryController.text =
                                                          country
                                                              .label; // Set the text field
                                                      _isCountryDropdownVisible =
                                                          false; // Close the dropdown
                                                    });
                                                    // Close the ExpansionTile
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.02,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Divider(
                              color: theColors.divider, height: w * 0.001),
                        ),
                        ExpansionTile(
                          trailing: yearselecticon
                              ? Icon(Icons.add, size: w * 0.05)
                              : Icon(Icons.minimize, size: w * 0.05),
                          title: Text(
                            "Year",
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            _selectedAcademicYearLabel.toString(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              yearselecticon = !expanded;
                            });
                          },
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theColors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0),
                                    bottom: Radius.circular(16.0),
                                  ),
                                ),
                                padding: EdgeInsets.all(0.0),
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
                                                  MaterialStateProperty.all(
                                                      3.0),
                                            ),
                                            child: Scrollbar(
                                              thumbVisibility: true,
                                              thickness: 3.0,
                                              trackVisibility: true,
                                              radius: Radius.circular(10),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    state.tutorList.length,
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
                                                        _selectedAcademicYearLabel ==
                                                                tutor.label
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
                            ),
                            SizedBox(
                              height: w * 0.02,
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Divider(
                              color: theColors.divider, height: w * 0.001),
                        ),
                        ExpansionTile(
                          trailing: subjecticon
                              ? Icon(Icons.add, size: w * 0.05)
                              : Icon(Icons.minimize, size: w * 0.05),
                          title: Text(
                            "Subject",
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            _selectedAcademicYearLabel.toString(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              subjecticon = !expanded;
                            });
                          },
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theColors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0),
                                    bottom: Radius.circular(16.0),
                                  ),
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: BlocBuilder<SubjectBloc, SubjectState>(
                                  builder: (context, state) {
                                    if (state is SubjectLoading) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is SubjectLoaded) {
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
                                                  MaterialStateProperty.all(
                                                      3.0),
                                            ),
                                            child: Scrollbar(
                                              thumbVisibility: true,
                                              thickness: 3.0,
                                              trackVisibility: true,
                                              radius: Radius.circular(10),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    state.subjectList.length,
                                                itemBuilder: (context, index) {
                                                  final subjects =
                                                      state.subjectList[index];
                                                  return ListTile(
                                                    title: Text(
                                                      subjects.label
                                                          .toString(), // Show label in the dropdown
                                                      style: TextStyle(
                                                          fontSize: 10.sp),
                                                    ),
                                                    trailing: _selectedSubject ==
                                                            subjects.label
                                                        ? Icon(Icons.done,
                                                            size: w * 0.04,
                                                            color: theColors
                                                                .primaryColor)
                                                        : SizedBox.shrink(),
                                                    onTap: () => _selectSubject(
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
                            ),
                            SizedBox(
                              height: w * 0.02,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dayCheckbox(String day, bool isChecked, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: isChecked,
          activeColor: theColors.white,
          checkColor: theColors.primaryColor,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(
            width: 1.0,
            color: theColors.classbrdrclr,
          ),
        ),
        Text(
          day, // Display shortened day text
          style: TextStyle(fontSize: 11.sp, color: Color(0xff53545E)),
        ),
      ],
    );
  }
}
