


import 'package:wisefox/Tutor/features/bloc/lessondetails/lessondetails_bloc.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorActiveLessons extends StatefulWidget {
  final int lessonId;
  const TutorActiveLessons({
    super.key,
    required this.lessonId,
  });

  @override
  State<TutorActiveLessons> createState() => _TutorActiveLessonsState();
}

class _TutorActiveLessonsState extends State<TutorActiveLessons> {
  @override
  void initState() {
    super.initState();
    loadSavedTimezone();

    loadSavedTimezone().then((_) {
      // Ensure that _selectedTimeZone has a value before dispatching events
      if (_selectedTimeZone != null && _selectedTimeZone.isNotEmpty) {
        // context.read<ClassesBloc>().add(FetchClassesOngoing(_selectedTimeZone));
        context.read<LessondetailsBloc>().add(
            FetchLessonDetails(widget.lessonId.toString(), _selectedTimeZone));
      } else {
        // Handle the case where the timezone is null or invalid
        print("Timezone is not available");
      }
    });
  }

  String _selectedTimeZone = 'UTC';

  @override
  Future<void> loadSavedTimezone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTimezone = prefs.getString('selected_timezone');
    print("Loaded TimeZone: $savedTimezone"); // Debug print

    setState(() {
      _selectedTimeZone = savedTimezone ?? 'UTC'; // Default value if not set
    });

    if (_selectedTimeZone != 'UTC') {
      context.read<LessondetailsBloc>().add(
          FetchLessonDetails(widget.lessonId.toString(), _selectedTimeZone));
    }
  }

  Future<void> saveTimezone(String timezone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_timezone', timezone);
    print("TimeZone saved: $timezone"); // Debug print
  }

  void _onTimezoneSelected(String newValue) {
    setState(() {
      _selectedTimeZone = newValue;
    });
    saveTimezone(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Lessons",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(theimage.pagebackground),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.lighten),
        )),
        child: BlocBuilder<LessondetailsBloc, LessondetailsState>(
          builder: (context, state) {
            if (state is LessondetailsLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: theColors.primaryColor,
              ));
            } else if (state is LessondetailsLoaded) {
              final lesson = state.lessonData;
              return Column(
                children: [
                  SizedBox(height: w * 0.00),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            dividerColor: Colors.transparent,
                            expansionTileTheme: ExpansionTileThemeData(
                              backgroundColor: Colors.transparent,
                              collapsedBackgroundColor: Colors.transparent,
                            ),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Active Lessons',
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w600),
                            ),
                            initiallyExpanded: true,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: w * 0.03, right: w * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                      bottom: Radius.circular(16.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lesson ID',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.id}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Subject',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.subject}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lesson Type',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.lessonType}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Day',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.date}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Duration',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.lessonDuration} hr',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Student',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.studentNames}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tutor',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.tutorName}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Rate',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '£ ${lesson.tutorRate}.00',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Is Billable?',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.isBillable ? 'Yes' : 'No'}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: lesson.isBillable
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Is Payable',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Color(0xff53545E),
                                            ),
                                          ),
                                          Text(
                                            '${lesson.isPayable ? 'Yes' : 'No'}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: lesson.isPayable
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Verification Status',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.verificationStatus}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            dividerColor: Colors.transparent,
                            expansionTileTheme: ExpansionTileThemeData(
                              backgroundColor: Colors.transparent,
                              collapsedBackgroundColor: Colors.transparent,
                            ),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Scheduled Details',
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w600),
                            ),
                            initiallyExpanded: true,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: w * 0.03, right: w * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                      bottom: Radius.circular(16.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Scheduled by',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.scheduledBy}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Scheduled on',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '08 Jun 2023, 11:47 AM',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Last updated on',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '08 Jun 2023, 11:47 AM',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            dividerColor: Colors.transparent,
                            expansionTileTheme: ExpansionTileThemeData(
                              backgroundColor: Colors.transparent,
                              collapsedBackgroundColor: Colors.transparent,
                            ),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'More Details',
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w600),
                            ),
                            initiallyExpanded: true,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    right: w * 0.03, left: w * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                      bottom: Radius.circular(16.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tutor Joined',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.tutorJoined}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tutor Spend Time',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.tutorSpentTime}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Student Joined',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.studentJoined}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Divider(
                                        color: theColors.divider,
                                        height: w * 0.02,
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Student Spent Time',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xff53545E)),
                                          ),
                                          Text(
                                            '${lesson.studentSpentTime}',
                                            style: TextStyle(
                                                color: Color(0xff53545E),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(w * 0.03),
                                child: Container(
                                  height: w * 0.13,
                                  decoration: BoxDecoration(
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                      bottom: Radius.circular(16.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: w * 0.04,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Lessons Recording',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Color(0xff53545E)),
                                        ),
                                        Container(
                                          width: w * 0.3,
                                          height: w * 0.11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.04),
                                            color: theColors.primaryColor,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.videocam_outlined,
                                                    color: theColors.white,
                                                    size: w * 0.05,
                                                  ),
                                                  Text(
                                                    "Watch",
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: theColors.white),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: w * 0.001,
                                                width: w * 0.15,
                                                color: theColors.white,
                                                margin: EdgeInsets.only(top: 0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
