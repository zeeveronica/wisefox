import 'dart:math';

import 'package:wisefox/client/features/bloc/studentlesson/studentlesson_bloc.dart';
import 'package:wisefox/client/features/screens/class_details.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/studentclassdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class StudentClassesPage extends StatefulWidget {
  const StudentClassesPage({super.key});

  @override
  State<StudentClassesPage> createState() => _StudentClassesPageState();
}

class _StudentClassesPageState extends State<StudentClassesPage> {
  final List<DateTime> dates =
      List.generate(07, (index) => DateTime.now().add(Duration(days: index)));
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    context.read<StudentLessonBloc>().add(FetchStudentLessons('upcoming'));

    selectedDate = DateTime.now();
  }

  bool isSameDay(DateTime lessonDate, DateTime selectedDate) {
    return lessonDate.year == selectedDate.year &&
        lessonDate.month == selectedDate.month &&
        lessonDate.day == selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    String selectedDateText = selectedDate != null
        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
        : todayDate;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "On Going Classes",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              Stack(
                children: [
                  Container(
                    height: w * 0.43,
                    width: w * 1,
                  ),
                  Positioned(
                    top: w * 0.07,
                    child: Container(
                      height: w * 0.32,
                      width: w * 0.94,
                      decoration: BoxDecoration(
                          color: theColors.classclr,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(w * 0.03),
                            bottomLeft: Radius.circular(w * 0.03),
                            bottomRight: Radius.circular(w * 0.03),
                          ),
                          border: Border.all(
                              width: w * 0.003, color: theColors.classbrdrclr)),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: w * 0.03,
                          top: w * 0.03,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: w * 0.04,
                                ),
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(theimage.profilepc),
                                ),
                                Text(
                                  "  Tutor: Reshma Nair",
                                  style: TextStyle(fontSize: 11.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: w * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      // width: w * 0.37,
                                      // height: w * 0.07,
                                      decoration: BoxDecoration(
                                          color: theColors.white,
                                          border: Border.all(
                                              color: Color(0xff9C5633),
                                              width: w * 0.001),
                                          borderRadius:
                                              BorderRadius.circular(w * 0.05)),
                                      child: Padding(
                                        padding: EdgeInsets.all(w * 0.005),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: w * 0.003,
                                                  left: w * 0.01),
                                              child: Icon(
                                                Icons.access_time_outlined,
                                                size: w * 0.03,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w * 0.01,
                                                  right: w * 0.01),
                                              child: Text(
                                                "10:00 AM - 11:00 AM",
                                                style:
                                                    TextStyle(fontSize: 8.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "  Duration: 1 hr",
                                      style: TextStyle(fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: w * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        // width: w * 0.24,
                                        // height: w * 0.07,
                                        decoration: BoxDecoration(
                                            color: theColors.white,
                                            border: Border.all(
                                                color: Color(0xffDDDDDD)),
                                            borderRadius: BorderRadius.circular(
                                                w * 0.05)),
                                        child: Padding(
                                          padding: EdgeInsets.all(w * 0.003),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: w * 0.002,
                                              ),
                                              Center(
                                                child: Container(
                                                  height: w * 0.04,
                                                  width: w * 0.04,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            w * 0.09),
                                                    color: Color(0x2000A276),
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      height: w * 0.025,
                                                      width: w * 0.025,
                                                      child: Image.asset(
                                                        "assets/client/images/Group 7965.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              Text(
                                                "Join Now",
                                                style:
                                                    TextStyle(fontSize: 8.sp),
                                              ),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // top: w * 0.01,
                    child: ClipPath(
                      child: Container(
                        height: w * 0.0736,
                        width: w * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w * 0.15),
                            topRight: Radius.circular(w * 0.15),
                          ),
                          color: theColors.classclr,
                          border: Border(
                              top: BorderSide(
                                  width: w * 0.003,
                                  color: theColors.classbrdrclr),
                              left: BorderSide(
                                  width: w * 0.003,
                                  color: theColors.classbrdrclr),
                              right: BorderSide(
                                  width: w * 0.003,
                                  color: theColors.classbrdrclr)),
                        ),
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.only(top: w * 0.014),
                            child: Text(
                              "Mathematics",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 09.sp, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        Divider(thickness: w * 0.003, color: Color(0xffE8E8E8)),
                  ),
                  Container(
                    height: w * 0.02,
                    width: w * 0.09,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE8E8E8)),
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                    child: Divider(
                      indent: w * 0.03,
                      endIndent: w * 0.03,
                      color: Color(0xffE8E8E8),
                    ),
                  ),
                  Expanded(
                    child:
                        Divider(thickness: w * 0.003, color: Color(0xffE8E8E8)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming Lessons",
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: w * 0.08,
                    width: w * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.02),
                      color: theColors.tabbarclr.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Container(
                        height: w * 0.035,
                        width: w * 0.035,
                        child: SvgPicture.asset(
                          "assets/client/icons/more.svg",
                          color: Color(0xff707070),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 6,
                ),
                height: w * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    DateTime date = dates[index];
                    bool isSelected = selectedDate != null &&
                        selectedDate!.year == date.year &&
                        selectedDate!.month == date.month &&
                        selectedDate!.day == date.day;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate =
                              dates[index]; // Use 'index' instead of 'i'
                          context
                              .read<StudentLessonBloc>()
                              .add(SetStudentSelectedDate(dates[index]));
                        });
                      },
                      child: Container(
                        width: w * 0.13,
                        height: w * 0.3,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.08),
                          color: isSelected
                              ? Color(0xffE1E1FF)
                              : Colors.transparent,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('EEE').format(date),
                                    style: TextStyle(
                                      color: isSelected
                                          ? theColors.primaryColor
                                          : Colors.black,
                                      fontSize: 10.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    DateFormat('dd').format(date),
                                    style: TextStyle(
                                      color: isSelected
                                          ? theColors.primaryColor
                                          : Colors.black,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                bottom: w * 0.013,
                                left: (w * 0.106 - w * 0.016) / 2,
                                child: Container(
                                  height: w * 0.016,
                                  width: w * 0.016,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              // Text(
              //   todayDate,
              //   style: TextStyle(fontSize: 11.sp),
              // ),
              Text(
                selectedDate != null &&
                        DateFormat('MMMM d, yyyy').format(selectedDate!) ==
                            todayDate
                    ? "Today"
                    : selectedDateText,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              BlocBuilder<StudentLessonBloc, StudentLessonState>(
                builder: (context, state) {
                  if (state is StudentLessonLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: theColors.primaryColor));
                  } else if (state is StudentLessonLoaded) {
                    final filteredLessons =
                        state.studentlessons.where((lesson) {
                      DateTime lessonDate = DateTime.parse(lesson.date);
                      return isSameDay(lessonDate, selectedDate!);
                    }).toList();

                    String lessonCountText =
                        "${filteredLessons.length} Classes Available";

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the lesson count text
                        Text(
                          lessonCountText,
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: w * 0.06),
                        if (filteredLessons.isEmpty)
                          Center(
                            child: Text(
                              'There is no class on the selected date.',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredLessons.length,
                          padding: EdgeInsets.only(top: w * 0.04),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final lesson = filteredLessons[index];
                            return Align(
                              heightFactor: 0.68,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentClassDetails(
                                        startTime: lesson.time,
                                        lessonid: lesson.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: w * 0.43,
                                      width: w * 1,
                                    ),
                                    Positioned(
                                      top: w * 0.07,
                                      child: Container(
                                        height: w * 0.32,
                                        width: w * 0.94,
                                        decoration: BoxDecoration(
                                          color: theColors.classclr,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(w * 0.03),
                                            bottomLeft:
                                                Radius.circular(w * 0.03),
                                            bottomRight:
                                                Radius.circular(w * 0.03),
                                          ),
                                          border: Border.all(
                                            width: w * 0.003,
                                            color: theColors.classbrdrclr,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: w * 0.03,
                                            top: w * 0.03,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: w * 0.04),
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        theimage.profilepc),
                                                  ),
                                                  Text(
                                                    "  Tutor: ${lesson.tutorName}",
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: w * 0.02),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              theColors.white,
                                                          border: Border.all(
                                                            color: Color(
                                                                0xff9C5633),
                                                            width: w * 0.001,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      w * 0.05),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  w * 0.005),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom:
                                                                      w * 0.003,
                                                                  left:
                                                                      w * 0.01,
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .access_time_outlined,
                                                                  size:
                                                                      w * 0.03,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      w * 0.01,
                                                                  right:
                                                                      w * 0.01,
                                                                ),
                                                                child: Text(
                                                                  "${lesson.time}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          8.sp),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "  Duration: ${lesson.lessonDuration} hr",
                                                        style: TextStyle(
                                                            fontSize: 9.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: w * 0.02),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              theColors.white,
                                                          border: Border.all(
                                                            color: Color(
                                                                0xffDDDDDD),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      w * 0.05),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: w * 0.005,
                                                            horizontal:
                                                                w * 0.01,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      w * 0.04,
                                                                  width:
                                                                      w * 0.04,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(w *
                                                                            0.09),
                                                                    color: Color(
                                                                        0x20F94246),
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      size: w *
                                                                          0.03,
                                                                      Icons
                                                                          .close_rounded,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      w * 0.02),
                                                              Text(
                                                                "cancel",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8.sp),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      w * 0.01),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        height: w * 0.0735,
                                        width: w * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(w * 0.15),
                                            topRight: Radius.circular(w * 0.15),
                                          ),
                                          color: theColors.classclr,
                                          border: Border(
                                            top: BorderSide(
                                                width: w * 0.003,
                                                color: theColors.classbrdrclr),
                                            left: BorderSide(
                                                width: w * 0.003,
                                                color: theColors.classbrdrclr),
                                            right: BorderSide(
                                                width: w * 0.003,
                                                color: theColors.classbrdrclr),
                                          ),
                                        ),
                                        child: FittedBox(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: w * 0.014,
                                              left: w * 0.01,
                                              right: w * 0.01,
                                            ),
                                            child: Text(
                                              lesson.subject,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 09.sp,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is StudentLessonError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Center(child: Text('No data'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
